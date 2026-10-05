package vn.iotstar.services;

import vn.iotstar.dto.Cart_24133074;
import vn.iotstar.entity.Order_24133074;
import vn.iotstar.entity.User_24133074;

import java.util.List;
import java.util.Map;

public interface OrderService_24133074 {
    Order_24133074 placeOrder(User_24133074 user,
                              Cart_24133074 cart,
                              String receiverName,
                              String receiverPhone,
                              String receiverAddress,
                              String notes,
                              String paymentMethod) throws Exception;

    List<Order_24133074> getOrders(User_24133074 user, String status);

    Order_24133074 getOrderById(Integer orderId, User_24133074 user);

    Map<String, Long> getStatusCounts(User_24133074 user);

    boolean cancelOrder(Integer orderId, User_24133074 user) throws Exception;
}
