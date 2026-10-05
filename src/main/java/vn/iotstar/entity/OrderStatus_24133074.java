package vn.iotstar.entity;

import java.util.Arrays;
import java.util.List;

public class OrderStatus_24133074 {
    public static final String NEW = "Đơn hàng mới";
    public static final String CONFIRMED = "Đã xác nhận";
    public static final String PREPARING = "Chuẩn bị hàng";
    public static final String SHIPPING = "Vận chuyển";
    public static final String DELIVERING = "Giao hàng";
    public static final String DELIVERED = "Đã giao";
    public static final String CANCELLED = "Đơn hàng hủy";
    public static final String RETURNED = "Đơn hàng hoàn";

    public static final List<String> ALL_STATUSES = Arrays.asList(
            NEW,
            CONFIRMED,
            PREPARING,
            SHIPPING,
            DELIVERING,
            DELIVERED,
            CANCELLED,
            RETURNED
    );

    public static String getBadgeClass(String status) {
        if (status == null) return "bg-secondary";
        switch (status) {
            case NEW:
                return "bg-primary";
            case CONFIRMED:
                return "bg-info text-dark";
            case PREPARING:
                return "bg-warning text-dark";
            case SHIPPING:
            case "vận chuyện":
            case "Vận chuyện":
                return "bg-secondary";
            case DELIVERING:
                return "bg-indigo text-white";
            case DELIVERED:
                return "bg-success";
            case CANCELLED:
                return "bg-danger";
            case RETURNED:
                return "bg-dark";
            default:
                return "bg-secondary";
        }
    }

    public static String getIcon(String status) {
        if (status == null) return "bi-box";
        switch (status) {
            case NEW:
                return "bi-file-earmark-plus";
            case CONFIRMED:
                return "bi-check2-circle";
            case PREPARING:
                return "bi-box-seam";
            case SHIPPING:
            case "vận chuyện":
            case "Vận chuyện":
                return "bi-truck";
            case DELIVERING:
                return "bi-bicycle";
            case DELIVERED:
                return "bi-bag-check";
            case CANCELLED:
                return "bi-x-circle";
            case RETURNED:
                return "bi-arrow-counterclockwise";
            default:
                return "bi-box";
        }
    }
}
