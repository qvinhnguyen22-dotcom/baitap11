package vn.iotstar.entity;

import javax.persistence.*;
import lombok.*;

@Entity
@Table(name = "rating")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Rating_24133074 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "userid")
    private User_24133074 user;

    @ManyToOne
    @JoinColumn(name = "bookid")
    private Book_24133074 book;

    private Byte rating;

    @Column(name = "review_text", columnDefinition = "NVARCHAR(MAX)")
    private String reviewText;
}
