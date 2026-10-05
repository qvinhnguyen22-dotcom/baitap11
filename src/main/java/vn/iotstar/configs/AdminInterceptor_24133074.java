package vn.iotstar.configs;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import vn.iotstar.entity.User_24133074;

@Component
public class AdminInterceptor_24133074 implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User_24133074 user = (User_24133074) session.getAttribute("currentUser");
        if (user == null || !Boolean.TRUE.equals(user.getIsAdmin())) {
            response.sendRedirect("/login");
            return false;
        }
        return true;
    }
}
