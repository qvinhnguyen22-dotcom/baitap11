package vn.iotstar.entity;

import javax.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class User_24133074 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 50, nullable = false, unique = true)
    private String email;

    @Column(length = 50, columnDefinition = "NVARCHAR(50)")
    private String fullname;

    private Integer phone;

    @Column(length = 32)
    private String passwd;

    private LocalDateTime signup_date;
    private LocalDateTime last_login;

    @Column(name = "is_admin")
    private Boolean isAdmin;

    @Column(name = "otp_code")
    private String otpCode;

    @Column(name = "is_verified")
    private Boolean isVerified;

    public Boolean getIsAdmin() {
        return isAdmin;
    }

    public boolean isAdmin() {
        return Boolean.TRUE.equals(isAdmin);
    }

    public Boolean getIsVerified() {
        return isVerified;
    }

    public boolean isVerified() {
        return Boolean.TRUE.equals(isVerified);
    }
}
