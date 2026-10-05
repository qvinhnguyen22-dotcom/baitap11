package vn.iotstar.entity;

import javax.persistence.*;
import lombok.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order_24133074 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User_24133074 user;

    @Column(name = "order_date", nullable = false)
    private LocalDateTime orderDate;

    @Column(name = "receiver_name", length = 100, columnDefinition = "NVARCHAR(100)")
    private String receiverName;

    @Column(name = "receiver_phone", length = 20)
    private String receiverPhone;

    @Column(name = "receiver_address", length = 255, columnDefinition = "NVARCHAR(255)")
    private String receiverAddress;

    @Column(name = "notes", length = 500, columnDefinition = "NVARCHAR(500)")
    private String notes;

    @Column(name = "payment_method", length = 50, columnDefinition = "NVARCHAR(50)")
    private String paymentMethod; // "COD" / "Thanh toán khi nhận hàng"

    @Column(name = "status", length = 50, columnDefinition = "NVARCHAR(50)")
    private String status; // 8 trạng thái

    @Column(name = "total_amount", precision = 12, scale = 2)
    private BigDecimal totalAmount;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    @Builder.Default
    private List<OrderDetail_24133074> orderDetails = new ArrayList<>();

    public Integer getOrderId() {
        return id;
    }

    public String getStatusBadgeClass() {
        return OrderStatus_24133074.getBadgeClass(this.status);
    }

    public String getStatusIcon() {
        return OrderStatus_24133074.getIcon(this.status);
    }

    public boolean isCanCancel() {
        return OrderStatus_24133074.NEW.equalsIgnoreCase(this.status);
    }

    public int getTotalItemsCount() {
        if (orderDetails == null || orderDetails.isEmpty()) {
            return 0;
        }
        int total = 0;
        for (OrderDetail_24133074 detail : orderDetails) {
            total += (detail.getQuantity() != null ? detail.getQuantity() : 0);
        }
        return total;
    }
}
