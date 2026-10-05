package vn.iotstar.services.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import vn.iotstar.entity.User_24133074;
import vn.iotstar.repository.UserRepository_24133074;
import vn.iotstar.services.UserService_24133074;

import java.time.LocalDateTime;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class UserServiceImpl_24133074 implements UserService_24133074 {
    private final UserRepository_24133074 userRepository;
    private final JavaMailSender mailSender;

    @Override
    public User_24133074 register(User_24133074 user) {
        String otp = String.format("%06d", new Random().nextInt(900000) + 100000);
        user.setOtpCode(otp);
        user.setIsVerified(false);
        user.setSignup_date(LocalDateTime.now());
        user.setIsAdmin(false);

        User_24133074 savedUser = userRepository.save(user);
        
        try {
            SimpleMailMessage mail = new SimpleMailMessage();
            mail.setTo(user.getEmail());
            mail.setSubject("Mã OTP Xác Nhận Đăng Ký");
            mail.setText("Mã OTP của bạn là: " + otp);
            mailSender.send(mail);
        } catch (Exception e) {
            System.err.println("Gửi mail thất bại: " + e.getMessage());
        }

        return savedUser;
    }

    @Override
    public boolean verifyOTP(String email, String otp) {
        return userRepository.findByEmail(email).map(user -> {
            if (otp.equals(user.getOtpCode())) {
                user.setIsVerified(true);
                user.setOtpCode(null);
                userRepository.save(user);
                return true;
            }
            return false;
        }).orElse(false);
    }

    @Override
    public User_24133074 login(String email, String password) {
        return userRepository.findByEmail(email)
                .filter(u -> u.getPasswd().equals(password) && Boolean.TRUE.equals(u.getIsVerified()))
                .map(u -> {
                    u.setLast_login(LocalDateTime.now());
                    return userRepository.save(u);
                }).orElse(null);
    }
}
