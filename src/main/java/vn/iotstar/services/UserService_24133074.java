package vn.iotstar.services;

import vn.iotstar.entity.User_24133074;

public interface UserService_24133074 {
    User_24133074 register(User_24133074 user);
    boolean verifyOTP(String email, String otp);
    User_24133074 login(String email, String password);
}
