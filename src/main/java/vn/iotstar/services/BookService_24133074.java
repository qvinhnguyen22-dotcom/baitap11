package vn.iotstar.services;

import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;
import vn.iotstar.entity.Book_24133074;

public interface BookService_24133074 {
    Page<Book_24133074> findAll(int page, int size);
    Page<Book_24133074> findByAuthor(Integer authorId, int page, int size);
    Page<Book_24133074> search(String keyword, int page, int size);
    Book_24133074 findById(Integer id);
    Book_24133074 save(Book_24133074 book, MultipartFile file);
    void delete(Integer id);
    void addReview(Integer userId, Integer bookId, Byte rating, String reviewText);
}
