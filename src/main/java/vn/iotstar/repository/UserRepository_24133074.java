package vn.iotstar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.iotstar.entity.User_24133074;
import java.util.Optional;

public interface UserRepository_24133074 extends JpaRepository<User_24133074, Integer> {
    Optional<User_24133074> findByEmail(String email);
}
