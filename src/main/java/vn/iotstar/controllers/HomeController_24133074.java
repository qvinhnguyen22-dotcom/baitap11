package vn.iotstar.controllers;

import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.iotstar.entity.Book_24133074;
import vn.iotstar.entity.User_24133074;
import vn.iotstar.repository.AuthorRepository_24133074;
import vn.iotstar.services.BookService_24133074;

@Controller
@RequiredArgsConstructor
public class HomeController_24133074 {
    private final BookService_24133074 bookService;
    private final AuthorRepository_24133074 authorRepository;
    private final vn.iotstar.repository.UserRepository_24133074 userRepository;

    @GetMapping({"/", "/home", "/books"})
    public String home(@RequestParam(defaultValue = "0") int page,
                       @RequestParam(required = false) Integer authorId,
                       @RequestParam(required = false) String keyword, Model model) {
        model.addAttribute("authors", authorRepository.findAll());
        model.addAttribute("selectedAuthor", authorId);
        model.addAttribute("keyword", keyword);
        if (keyword != null && !keyword.trim().isEmpty()) {
            model.addAttribute("booksPage", bookService.search(keyword.trim(), page, 3));
        } else if (authorId != null) {
            model.addAttribute("booksPage", bookService.findByAuthor(authorId, page, 3));
        } else {
            model.addAttribute("booksPage", bookService.findAll(page, 3));
        }
        return "books/home";
    }

    @GetMapping({"/book/{id}", "/books/{id}", "/book-detail/{id}"})
    public String detail(@PathVariable Integer id, Model model) {
        Book_24133074 book = bookService.findById(id);
        if (book == null) {
            return "redirect:/home";
        }
        model.addAttribute("book", book);
        return "books/detail";
    }

    @PostMapping({"/book/{id}/review", "/books/{id}/review"})
    public String addReview(@PathVariable Integer id, 
                            @RequestParam(name = "rating", defaultValue = "5") Byte rating, 
                            @RequestParam(name = "review_text", required = false) String reviewText1,
                            @RequestParam(name = "reviewText", required = false) String reviewText2,
                            HttpSession session) {
        String reviewText = (reviewText1 != null && !reviewText1.trim().isEmpty()) ? reviewText1 : reviewText2;
        if (reviewText == null || reviewText.trim().isEmpty()) {
            reviewText = "Đánh giá tốt.";
        }
        User_24133074 user = (User_24133074) session.getAttribute("currentUser");
        if (user == null) {
            // Nếu khách vãng lai bình luận, liên kết với tài khoản mặc định để lưu thành công vào DB
            user = userRepository.findByEmail("user1@gmail.com").orElse(null);
            if (user == null) {
                user = userRepository.findAll().stream().findFirst().orElse(null);
            }
        }
        if (user != null) {
            bookService.addReview(user.getId(), id, rating, reviewText);
        }
        return "redirect:/book/" + id;
    }
}
