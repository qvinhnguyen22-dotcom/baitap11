package vn.iotstar.entity;

import javax.persistence.*;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "books")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Book_24133074 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer bookid;

    private Integer isbn;

    @Column(length = 200, columnDefinition = "NVARCHAR(200)")
    private String title;

    @Column(length = 100, columnDefinition = "NVARCHAR(100)")
    private String publisher;

    @Column(precision = 12, scale = 2)
    private BigDecimal price;

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "publish_date")
    private LocalDate publishDate;

    @Column(name = "cover_image", length = 100)
    private String coverImage;

    private Integer quantity;

    @ManyToMany
    @JoinTable(
        name = "book_author",
        joinColumns = @JoinColumn(name = "bookid"),
        inverseJoinColumns = @JoinColumn(name = "author_id")
    )
    private List<Author_24133074> authors;

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Rating_24133074> ratings;
}
