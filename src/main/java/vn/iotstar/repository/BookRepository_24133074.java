package vn.iotstar.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.iotstar.entity.Book_24133074;

public interface BookRepository_24133074 extends JpaRepository<Book_24133074, Integer> {
    Page<Book_24133074> findByAuthorsAuthorId(Integer authorId, Pageable pageable);
    Page<Book_24133074> findByTitleContainingIgnoreCase(String keyword, Pageable pageable);
}
