package vn.iotstar.services.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.iotstar.dto.CartItem_24133074;
import vn.iotstar.dto.Cart_24133074;
import vn.iotstar.entity.*;
import vn.iotstar.repository.BookRepository_24133074;
import vn.iotstar.repository.OrderRepository_24133074;
import vn.iotstar.services.OrderService_24133074;

import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl_24133074 implements OrderService_24133074 {
    private final OrderRepository_24133074 orderRepository;
    private final BookRepository_24133074 bookRepository;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Order_24133074 placeOrder(User_24133074 user,
                                      Cart_24133074 cart,
                                      String receiverName,
                                      String receiverPhone,
                                      String receiverAddress,
                                      String notes,
                                      String paymentMethod) throws Exception {
        if (user == null) {
            throw new IllegalArgumentException("Vui lòng đăng nhập trước khi thanh toán đơn hàng!");
        }
        if (cart == null || cart.isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng của bạn đang trống!");
        }

        // 1. Kiểm tra tồn kho trước khi đặt hàng
        Map<Book_24133074, Integer> booksToUpdate = new HashMap<>();
        for (CartItem_24133074 item : cart.getItems()) {
            Book_24133074 book = bookRepository.findById(item.getBookId()).orElse(null);
            if (book == null) {
                throw new IllegalArgumentException("Sách \"" + item.getTitle() + "\" không còn tồn tại trên hệ thống!");
            }
            int stock = (book.getQuantity() != null) ? book.getQuantity() : 0;
            if (stock < item.getQuantity()) {
                throw new IllegalArgumentException("Sách \"" + book.getTitle() + "\" không đủ số lượng trong kho! (Còn " + stock + " cuốn, yêu cầu " + item.getQuantity() + " cuốn).");
            }
            booksToUpdate.put(book, item.getQuantity());
        }

        // 2. Trừ số lượng tồn kho
        for (Map.Entry<Book_24133074, Integer> entry : booksToUpdate.entrySet()) {
            Book_24133074 b = entry.getKey();
            b.setQuantity(b.getQuantity() - entry.getValue());
            bookRepository.save(b);
        }

        // 3. Khởi tạo đơn hàng với trạng thái ban đầu "Đơn hàng mới"
        Order_24133074 order = Order_24133074.builder()
                .user(user)
                .orderDate(LocalDateTime.now())
                .receiverName(receiverName)
                .receiverPhone(receiverPhone)
                .receiverAddress(receiverAddress)
                .notes(notes)
                .paymentMethod((paymentMethod != null && !paymentMethod.trim().isEmpty()) ? paymentMethod : "COD")
                .status(OrderStatus_24133074.NEW)
                .totalAmount(cart.getTotalAmount())
                .orderDetails(new ArrayList<>())
                .build();

        // 4. Tạo chi tiết đơn hàng (OrderDetail)
        for (CartItem_24133074 item : cart.getItems()) {
            Book_24133074 book = bookRepository.findById(item.getBookId()).orElse(null);
            OrderDetail_24133074 detail = OrderDetail_24133074.builder()
                    .order(order)
                    .book(book)
                    .quantity(item.getQuantity())
                    .price(item.getPrice())
                    .build();
            order.getOrderDetails().add(detail);
        }

        return orderRepository.save(order);
    }

    @Override
    public List<Order_24133074> getOrders(User_24133074 user, String status) {
        if (user == null) {
            return Collections.emptyList();
        }
        if (status == null || status.trim().isEmpty() || "all".equalsIgnoreCase(status.trim()) || "Tất cả".equalsIgnoreCase(status.trim())) {
            return orderRepository.findByUserOrderByOrderDateDesc(user);
        }
        String cleanStatus = status.trim();
        // Hỗ trợ cả trường hợp gõ "vận chuyện" lẫn "vận chuyển"
        if ("vận chuyện".equalsIgnoreCase(cleanStatus) || "Vận chuyện".equalsIgnoreCase(cleanStatus)) {
            List<Order_24133074> list = orderRepository.findByUserAndStatusOrderByOrderDateDesc(user, OrderStatus_24133074.SHIPPING);
            if (list.isEmpty()) {
                list = orderRepository.findByUserAndStatusOrderByOrderDateDesc(user, "vận chuyện");
            }
            return list;
        }
        return orderRepository.findByUserAndStatusOrderByOrderDateDesc(user, cleanStatus);
    }

    @Override
    public Order_24133074 getOrderById(Integer orderId, User_24133074 user) {
        if (orderId == null || user == null) {
            return null;
        }
        if (Boolean.TRUE.equals(user.getIsAdmin())) {
            return orderRepository.findById(orderId).orElse(null);
        }
        return orderRepository.findByIdAndUser(orderId, user).orElse(null);
    }

    @Override
    public Map<String, Long> getStatusCounts(User_24133074 user) {
        Map<String, Long> counts = new LinkedHashMap<>();
        if (user == null) {
            return counts;
        }
        counts.put("all", orderRepository.countByUser(user));
        for (String status : OrderStatus_24133074.ALL_STATUSES) {
            long count = orderRepository.countByUserAndStatus(user, status);
            // Nếu là vận chuyển, kiểm tra thêm nếu có record nào lưu là 'vận chuyện'
            if (OrderStatus_24133074.SHIPPING.equals(status)) {
                count += orderRepository.countByUserAndStatus(user, "vận chuyện");
            }
            counts.put(status, count);
        }
        return counts;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean cancelOrder(Integer orderId, User_24133074 user) throws Exception {
        Order_24133074 order = getOrderById(orderId, user);
        if (order == null) {
            throw new IllegalArgumentException("Không tìm thấy đơn hàng!");
        }
        if (!order.isCanCancel()) {
            throw new IllegalStateException("Đơn hàng chỉ có thể hủy khi đang ở trạng thái \"Đơn hàng mới\"!");
        }

        // Hoàn lại số lượng sách vào kho
        if (order.getOrderDetails() != null) {
            for (OrderDetail_24133074 detail : order.getOrderDetails()) {
                Book_24133074 book = detail.getBook();
                if (book != null && detail.getQuantity() != null) {
                    book.setQuantity(book.getQuantity() + detail.getQuantity());
                    bookRepository.save(book);
                }
            }
        }

        order.setStatus(OrderStatus_24133074.CANCELLED);
        orderRepository.save(order);
        return true;
    }
}
