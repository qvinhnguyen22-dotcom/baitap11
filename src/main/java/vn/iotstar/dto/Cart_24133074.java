package vn.iotstar.dto;

import lombok.Data;
import vn.iotstar.entity.Book_24133074;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

@Data
public class Cart_24133074 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Map<Integer, CartItem_24133074> items = new LinkedHashMap<>();

    public Collection<CartItem_24133074> getItems() {
        return items.values();
    }

    /**
     * Thêm sách vào giỏ hàng với số lượng chỉ định.
     * @param book Sách cần thêm
     * @param quantity Số lượng muốn thêm
     * @return Thông báo kết quả (thành công hoặc cảnh báo vượt tồn kho)
     */
    public String addItem(Book_24133074 book, int quantity) {
        if (book == null || book.getBookid() == null) {
            return "Sách không tồn tại!";
        }
        int availableStock = book.getQuantity() != null ? book.getQuantity() : 0;
        if (availableStock <= 0) {
            return "Sách \"" + book.getTitle() + "\" hiện tại đã hết hàng!";
        }

        if (quantity <= 0) {
            quantity = 1;
        }

        CartItem_24133074 item = items.get(book.getBookid());
        if (item != null) {
            int newQuantity = item.getQuantity() + quantity;
            item.setStockQuantity(availableStock);
            if (newQuantity > availableStock) {
                item.setQuantity(availableStock);
                return "Đã đạt số lượng tối đa (" + availableStock + " cuốn) hiện có trong kho!";
            } else {
                item.setQuantity(newQuantity);
                return "Đã cập nhật số lượng trong giỏ hàng thành công!";
            }
        } else {
            if (quantity > availableStock) {
                quantity = availableStock;
            }
            item = CartItem_24133074.builder()
                    .bookId(book.getBookid())
                    .isbn(book.getIsbn())
                    .title(book.getTitle())
                    .coverImage(book.getCoverImage())
                    .price(book.getPrice())
                    .quantity(quantity)
                    .stockQuantity(availableStock)
                    .build();
            items.put(book.getBookid(), item);
            return "Đã thêm sách \"" + book.getTitle() + "\" vào giỏ hàng!";
        }
    }

    /**
     * Thay đổi số lượng sản phẩm trong giỏ trong giới hạn tồn kho.
     * @param bookId ID sách
     * @param quantity Số lượng mới
     * @param maxStock Số lượng tồn kho hiện tại
     * @return Thông báo kết quả
     */
    public String updateQuantity(Integer bookId, int quantity, int maxStock) {
        CartItem_24133074 item = items.get(bookId);
        if (item == null) {
            return "Sản phẩm không có trong giỏ hàng!";
        }

        if (quantity <= 0) {
            items.remove(bookId);
            return "Đã xóa sản phẩm khỏi giỏ hàng!";
        }

        item.setStockQuantity(maxStock);
        if (quantity > maxStock) {
            item.setQuantity(maxStock);
            return "Số lượng yêu cầu vượt quá tồn kho. Đã điều chỉnh về tối đa " + maxStock + " cuốn!";
        }

        item.setQuantity(quantity);
        return "Cập nhật số lượng thành công!";
    }

    public void removeItem(Integer bookId) {
        if (bookId != null) {
            items.remove(bookId);
        }
    }

    public void clear() {
        items.clear();
    }

    public int getTotalQuantity() {
        int total = 0;
        for (CartItem_24133074 item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    public BigDecimal getTotalAmount() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem_24133074 item : items.values()) {
            total = total.add(item.getTotalPrice());
        }
        return total;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}
