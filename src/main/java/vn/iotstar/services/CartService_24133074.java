package vn.iotstar.services;

import javax.servlet.http.HttpSession;
import vn.iotstar.dto.Cart_24133074;

public interface CartService_24133074 {
    Cart_24133074 getCart(HttpSession session);
    String addToCart(HttpSession session, Integer bookId, int quantity);
    String updateQuantity(HttpSession session, Integer bookId, int quantity);
    void removeItem(HttpSession session, Integer bookId);
    void clearCart(HttpSession session);
}
