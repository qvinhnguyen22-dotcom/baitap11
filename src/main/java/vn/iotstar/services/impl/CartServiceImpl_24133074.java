package vn.iotstar.services.impl;

import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import vn.iotstar.dto.Cart_24133074;
import vn.iotstar.entity.Book_24133074;
import vn.iotstar.repository.BookRepository_24133074;
import vn.iotstar.services.CartService_24133074;

@Service
@RequiredArgsConstructor
public class CartServiceImpl_24133074 implements CartService_24133074 {
    private final BookRepository_24133074 bookRepository;
    private static final String CART_SESSION_KEY = "cart";

    @Override
    public Cart_24133074 getCart(HttpSession session) {
        Cart_24133074 cart = (Cart_24133074) session.getAttribute(CART_SESSION_KEY);
        if (cart == null) {
            cart = new Cart_24133074();
            session.setAttribute(CART_SESSION_KEY, cart);
        }
        return cart;
    }

    @Override
    public String addToCart(HttpSession session, Integer bookId, int quantity) {
        Cart_24133074 cart = getCart(session);
        Book_24133074 book = bookRepository.findById(bookId).orElse(null);
        if (book == null) {
            return "Không tìm thấy cuốn sách yêu cầu!";
        }
        String msg = cart.addItem(book, quantity);
        session.setAttribute(CART_SESSION_KEY, cart);
        return msg;
    }

    @Override
    public String updateQuantity(HttpSession session, Integer bookId, int quantity) {
        Cart_24133074 cart = getCart(session);
        Book_24133074 book = bookRepository.findById(bookId).orElse(null);
        if (book == null) {
            cart.removeItem(bookId);
            return "Sách không còn tồn tại trên hệ thống!";
        }
        int maxStock = (book.getQuantity() != null) ? book.getQuantity() : 0;
        String msg = cart.updateQuantity(bookId, quantity, maxStock);
        session.setAttribute(CART_SESSION_KEY, cart);
        return msg;
    }

    @Override
    public void removeItem(HttpSession session, Integer bookId) {
        Cart_24133074 cart = getCart(session);
        cart.removeItem(bookId);
        session.setAttribute(CART_SESSION_KEY, cart);
    }

    @Override
    public void clearCart(HttpSession session) {
        Cart_24133074 cart = getCart(session);
        cart.clear();
        session.setAttribute(CART_SESSION_KEY, cart);
    }
}
