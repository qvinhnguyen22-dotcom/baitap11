package vn.iotstar.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.iotstar.entity.Book_24133074;
import vn.iotstar.services.BookService_24133074;

@Controller
@RequestMapping("/admin/books")
@RequiredArgsConstructor
public class AdminBookController_24133074 {
    private final BookService_24133074 bookService;
    private final vn.iotstar.repository.AuthorRepository_24133074 authorRepository;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("booksPage", bookService.findAll(page, 5));
        return "books/admin_list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("book", new Book_24133074());
        model.addAttribute("authors", authorRepository.findAll());
        return "books/admin_form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute Book_24133074 book, @RequestParam(value = "file", required = false) MultipartFile file) {
        bookService.save(book, file);
        return "redirect:/admin/books";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        model.addAttribute("book", bookService.findById(id));
        model.addAttribute("authors", authorRepository.findAll());
        return "books/admin_form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        bookService.delete(id);
        return "redirect:/admin/books";
    }
}
