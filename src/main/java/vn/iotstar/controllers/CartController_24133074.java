package vn.iotstar.controllers;

import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.dto.Cart_24133074;
import vn.iotstar.services.CartService_24133074;

@Controller
@RequiredArgsConstructor
public class CartController_24133074 {
    private final CartService_24133074 cartService;

    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        Cart_24133074 cart = cartService.getCart(session);
        model.addAttribute("cart", cart);
        return "cart/index";
    }

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam Integer bookId,
                            @RequestParam(defaultValue = "1") int quantity,
                            @RequestParam(required = false) String returnUrl,
                            @RequestParam(required = false) String action,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        String msg = cartService.addToCart(session, bookId, quantity);
        redirectAttributes.addFlashAttribute("cartMessage", msg);

        // Nếu người dùng chọn "Mua ngay"
        if ("buyNow".equalsIgnoreCase(action)) {
            return "redirect:/checkout";
        }

        if (returnUrl != null && !returnUrl.trim().isEmpty()) {
            return "redirect:" + returnUrl;
        }
        return "redirect:/cart";
    }

    @PostMapping("/cart/update")
    public String updateQuantity(@RequestParam Integer bookId,
                                 @RequestParam int quantity,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        String msg = cartService.updateQuantity(session, bookId, quantity);
        redirectAttributes.addFlashAttribute("cartMessage", msg);
        return "redirect:/cart";
    }

    @GetMapping("/cart/remove/{bookId}")
    public String removeItem(@PathVariable Integer bookId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        cartService.removeItem(session, bookId);
        redirectAttributes.addFlashAttribute("cartMessage", "Đã xóa sản phẩm khỏi giỏ hàng!");
        return "redirect:/cart";
    }

    @GetMapping("/cart/clear")
    public String clearCart(HttpSession session,
                            RedirectAttributes redirectAttributes) {
        cartService.clearCart(session);
        redirectAttributes.addFlashAttribute("cartMessage", "Đã dọn sạch giỏ hàng!");
        return "redirect:/cart";
    }
}
