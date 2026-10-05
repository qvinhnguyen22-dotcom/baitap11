package vn.iotstar.services.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.iotstar.entity.Book_24133074;
import vn.iotstar.entity.Rating_24133074;
import vn.iotstar.repository.BookRepository_24133074;
import vn.iotstar.repository.RatingRepository_24133074;
import vn.iotstar.repository.UserRepository_24133074;
import vn.iotstar.services.BookService_24133074;

import java.io.IOException;
import java.nio.file.*;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class BookServiceImpl_24133074 implements BookService_24133074 {
    private final BookRepository_24133074 bookRepository;
    private final RatingRepository_24133074 ratingRepository;
    private final UserRepository_24133074 userRepository;
    private final Path uploadDir = Paths.get("uploads/covers");

    @Override
    public Page<Book_24133074> findAll(int page, int size) {
        return bookRepository.findAll(PageRequest.of(page, size));
    }

    @Override
    public Page<Book_24133074> findByAuthor(Integer authorId, int page, int size) {
        return bookRepository.findByAuthorsAuthorId(authorId, PageRequest.of(page, size));
    }

    @Override
    public Page<Book_24133074> search(String keyword, int page, int size) {
        return bookRepository.findByTitleContainingIgnoreCase(keyword, PageRequest.of(page, size));
    }

    @Override
    public Book_24133074 findById(Integer id) {
        return bookRepository.findById(id).orElse(null);
    }

    @Override
    public Book_24133074 save(Book_24133074 book, MultipartFile file) {
        String uploadedFileName = null;
        if (file != null && !file.isEmpty()) {
            try {
                Files.createDirectories(uploadDir);
                uploadedFileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                Files.copy(file.getInputStream(), uploadDir.resolve(uploadedFileName), StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        if (book.getBookid() != null) {
            Book_24133074 existing = bookRepository.findById(book.getBookid()).orElse(null);
            if (existing != null) {
                existing.setTitle(book.getTitle());
                existing.setIsbn(book.getIsbn());
                existing.setPublisher(book.getPublisher());
                existing.setPrice(book.getPrice());
                existing.setQuantity(book.getQuantity());
                existing.setDescription(book.getDescription());
                existing.setPublishDate(book.getPublishDate());
                if (book.getAuthors() != null) {
                    existing.setAuthors(book.getAuthors());
                }
                if (uploadedFileName != null) {
                    existing.setCoverImage(uploadedFileName);
                } else if (book.getCoverImage() != null && !book.getCoverImage().trim().isEmpty()) {
                    existing.setCoverImage(book.getCoverImage());
                }
                return bookRepository.save(existing);
            }
        }

        if (uploadedFileName != null) {
            book.setCoverImage(uploadedFileName);
        }
        return bookRepository.save(book);
    }

    @Override
    public void delete(Integer id) {
        Book_24133074 book = bookRepository.findById(id).orElse(null);
        if (book != null) {
            if (book.getAuthors() != null) {
                book.getAuthors().clear();
            }
            if (book.getRatings() != null) {
                book.getRatings().clear();
            }
            bookRepository.delete(book);
        }
    }

    @Override
    public void addReview(Integer userId, Integer bookId, Byte rating, String reviewText) {
        Rating_24133074 r = Rating_24133074.builder()
                .user(userRepository.findById(userId).orElse(null))
                .book(bookRepository.findById(bookId).orElse(null))
                .rating(rating)
                .reviewText(reviewText)
                .build();
        ratingRepository.save(r);
    }
}
