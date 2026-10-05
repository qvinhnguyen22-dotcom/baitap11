package vn.iotstar.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItem_24133074 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer bookId;
    private Integer isbn;
    private String title;
    private String coverImage;
    private BigDecimal price;
    private int quantity;
    private int stockQuantity;

    public BigDecimal getTotalPrice() {
        if (price == null) {
            return BigDecimal.ZERO;
        }
        return price.multiply(BigDecimal.valueOf(quantity));
    }
}
