package vn.iotstar.entity;

import javax.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "author")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Author_24133074 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "author_id")
    private Integer authorId;

    @Column(name = "author_name", length = 100, columnDefinition = "NVARCHAR(100)")
    private String authorName;

    @org.springframework.format.annotation.DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @ManyToMany(mappedBy = "authors")
    private List<Book_24133074> books;
}
