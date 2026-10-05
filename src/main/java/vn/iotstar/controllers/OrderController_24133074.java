package vn.iotstar.controllers;

import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.dto.Cart_24133074;
import vn.iotstar.entity.OrderStatus_24133074;
import vn.iotstar.entity.Order_24133074;
import vn.iotstar.entity.User_24133074;
import vn.iotstar.services.CartService_24133074;
import vn.iotstar.services.OrderService_24133074;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class OrderController_24133074 {
    private final OrderService_24133074 orderService;
    private final CartService_24133074 cartService;

    // ==========================================
    // 1. THANH TOÁN ĐƠN HÀNG BẰNG COD
    // ==========================================

    @GetMapping("/checkout")
    public String checkoutPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User_24133074 currentUser = (User_24133074) session.getAttribute("currentUser");
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập trước khi tiến hành thanh toán!");
            return "redirect:/login";
        }

        Cart_24133074 cart = cartService.getCart(session);
        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("cartMessage", "Giỏ hàng của bạn đang trống! Hãy thêm sách vào giỏ hàng trước.");
            return "redirect:/cart";
        }

        model.addAttribute("cart", cart);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("receiverName", currentUser.getFullname());
        model.addAttribute("receiverPhone", currentUser.getPhone() != null ? String.valueOf(currentUser.getPhone()) : "");
        model.addAttribute("paymentMethod", "COD");
        return "orders/checkout";
    }

    @PostMapping("/checkout/place-order")
    public String placeOrder(@RequestParam String receiverName,
                             @RequestParam String receiverPhone,
                             @RequestParam String receiverAddress,
                             @RequestParam(required = false) String notes,
                             @RequestParam(defaultValue = "COD") String paymentMethod,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User_24133074 currentUser = (User_24133074) session.getAttribute("currentUser");
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Phiên đăng nhập đã hết hạn! Vui lòng đăng nhập lại.");
            return "redirect:/login";
        }

        Cart_24133074 cart = cartService.getCart(session);
        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("cartMessage", "Giỏ hàng đang trống!");
            return "redirect:/cart";
        }

        try {
            Order_24133074 order = orderService.placeOrder(
                    currentUser,
                    cart,
                    receiverName,
                    receiverPhone,
                    receiverAddress,
                    notes,
                    paymentMethod
            );

            // Đặt hàng thành công -> Xóa giỏ hàng
            cartService.clearCart(session);

            redirectAttributes.addFlashAttribute("successMessage", "Đặt hàng thành công! Đơn hàng của bạn đang được xử lý.");
            return "redirect:/order/success/" + order.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/checkout";
        }
    }

    @GetMapping("/order/success/{id}")
    public String orderSuccess(@PathVariable Integer id, HttpSession session, Model model) {
        User_24133074 currentUser = (User_24133074) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }
        Order_24133074 order = orderService.getOrderById(id, currentUser);
        if (order == null) {
            return "redirect:/orders";
        }
        model.addAttribute("order", order);
        return "orders/success";
    }

    // ==========================================
    // 2. LỊCH SỬ ĐẶT HÀNG LỌC THEO TRẠNG THÁI
    // ==========================================

    @GetMapping({"/orders", "/orders/history", "/user/orders"})
    public String orderHistory(@RequestParam(required = false) String status,
                               HttpSession session,
                               Model model,
                               RedirectAttributes redirectAttributes) {
        User_24133074 currentUser = (User_24133074) session.getAttribute("currentUser");
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem lịch sử đơn hàng!");
            return "redirect:/login";
        }

        List<Order_24133074> orders = orderService.getOrders(currentUser, status);
        Map<String, Long> statusCounts = orderService.getStatusCounts(currentUser);

        model.addAttribute("orders", orders);
        model.addAttribute("selectedStatus", (status != null && !status.trim().isEmpty()) ? status.trim() : "all");
        model.addAttribute("statusCounts", statusCounts);
        model.addAttribute("allStatuses", OrderStatus_24133074.ALL_STATUSES);

        return "orders/history";
    }

    @GetMapping("/orders/{id}")
    public String orderDetail(@PathVariable Integer id,
                              HttpSession session,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        User_24133074 currentUser = (User_24133074) session.getAttribute("currentUser");
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem chi tiết đơn hàng!");
            return "redirect:/login";
        }

        Order_24133074 order = orderService.getOrderById(id, currentUser);
        if (order == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn hàng yêu cầu!");
            return "redirect:/orders";
        }

        model.addAttribute("order", order);
        return "orders/detail";
    }

    @PostMapping("/orders/{id}/cancel")
    public String cancelOrder(@PathVariable Integer id,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        User_24133074 currentUser = (User_24133074) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        try {
            orderService.cancelOrder(id, currentUser);
            redirectAttributes.addFlashAttribute("successMessage", "Đã hủy đơn hàng #" + id + " thành công! Số lượng sản phẩm đã được hoàn lại kho.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/orders/" + id;
    }
}
