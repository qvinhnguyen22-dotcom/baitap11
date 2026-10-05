package vn.iotstar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.iotstar.entity.Order_24133074;
import vn.iotstar.entity.User_24133074;

import java.util.List;
import java.util.Optional;

public interface OrderRepository_24133074 extends JpaRepository<Order_24133074, Integer> {
    List<Order_24133074> findByUserOrderByOrderDateDesc(User_24133074 user);
    List<Order_24133074> findByUserAndStatusOrderByOrderDateDesc(User_24133074 user, String status);
    Optional<Order_24133074> findByIdAndUser(Integer id, User_24133074 user);
    long countByUser(User_24133074 user);
    long countByUserAndStatus(User_24133074 user, String status);
}
