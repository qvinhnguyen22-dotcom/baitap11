package vn.iotstar.controllers;

import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.entity.User_24133074;
import vn.iotstar.services.UserService_24133074;

@Controller
@RequiredArgsConstructor
public class AuthController_24133074 {
    private final UserService_24133074 userService;

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        User_24133074 user = (User_24133074) session.getAttribute("currentUser");
        if (user != null) {
            if (Boolean.TRUE.equals(user.getIsAdmin())) {
                return "redirect:/admin/books";
            }
            return "redirect:/home";
        }
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        User_24133074 user = userService.login(email, password);
        if (user != null) {
            session.setAttribute("currentUser", user);
            if (Boolean.TRUE.equals(user.getIsAdmin())) {
                return "redirect:/admin/books";
            }
            return "redirect:/home";
        }
        model.addAttribute("error", "Email hoặc mật khẩu không chính xác!");
        return "auth/login";
    }

    @GetMapping("/register")
    public String registerPage(HttpSession session, Model model) {
        User_24133074 user = (User_24133074) session.getAttribute("currentUser");
        if (user != null) {
            return "redirect:/home";
        }
        model.addAttribute("user", new User_24133074());
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User_24133074 user, Model model) {
        userService.register(user);
        model.addAttribute("email", user.getEmail());
        return "auth/verify";
    }

    @PostMapping("/verify-otp")
    public String verify(@RequestParam String email, @RequestParam String otp, Model model) {
        if (userService.verifyOTP(email, otp)) {
            return "redirect:/login";
        }
        model.addAttribute("error", "OTP Sai!");
        model.addAttribute("email", email);
        return "auth/verify";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
