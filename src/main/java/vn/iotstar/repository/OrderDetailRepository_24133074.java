package vn.iotstar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.iotstar.entity.OrderDetail_24133074;
import vn.iotstar.entity.Order_24133074;

import java.util.List;

public interface OrderDetailRepository_24133074 extends JpaRepository<OrderDetail_24133074, Integer> {
    List<OrderDetail_24133074> findByOrder(Order_24133074 order);
}
