package servlet;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.EmailUtil;

import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String step = request.getParameter("step");
        HttpSession session = request.getSession();

        // Xử lý resend code
        if ("resend".equals(step)) {
            String email = (String) session.getAttribute("resetEmail");

            if (email == null) {
                response.sendRedirect("forgot-password");
                return;
            }

            // Tạo mã mới
            String newCode = String.valueOf((int) (Math.random() * 900000) + 100000);
            session.setAttribute("resetCode", newCode);

            try {
                EmailUtil.sendEmail(email, "Your new verification code is: " + newCode);
                request.getRequestDispatcher("/WEB-INF/views/verifyReset.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to resend verification code!");
                request.getRequestDispatcher("/WEB-INF/views/verifyReset.jsp").forward(request, response);
            }
            return;
        }

        // Mặc định hiển thị trang nhập email
        request.getRequestDispatcher("/WEB-INF/views/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String step = request.getParameter("step");
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();

        try {
            // Gửi mã xác thực
            if ("send".equals(step)) {
                String email = request.getParameter("email");

                // Kiểm tra email có tồn tại không
                if (!dao.checkUserOrEmailExists(email)) {
                    request.setAttribute("error", "Email does not exist!");
                    request.getRequestDispatcher("/WEB-INF/views/forgotPassword.jsp").forward(request, response);
                    return;
                }

                // Tạo mã xác thực ngẫu nhiên
                String code = String.valueOf((int) (Math.random() * 900000) + 100000);

                // Lưu tạm thông tin vào session
                session.setAttribute("resetEmail", email);
                session.setAttribute("resetCode", code);

                // Gửi mail xác thực
                try {
                    EmailUtil.sendEmail(email, "Your password verification code is: " + code);
                    request.getRequestDispatcher("/WEB-INF/views/verifyReset.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to send email. Please try again.");
                    request.getRequestDispatcher("/WEB-INF/views/forgotPassword.jsp").forward(request, response);
                }

                // Xác minh mã
            } else if ("verify".equals(step)) {
                String codeInput = request.getParameter("code");
                String codeSession = (String) session.getAttribute("resetCode");

                if (codeSession != null && codeSession.equals(codeInput)) {
                    // Mã đúng → chuyển sang trang nhập mật khẩu mới
                    request.getRequestDispatcher("/WEB-INF/views/newPassword.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Incorrect verification code!");
                    request.getRequestDispatcher("/WEB-INF/views/verifyReset.jsp").forward(request, response);
                }

                // Cập nhật mật khẩu mới
            } else if ("change".equals(step)) {
                String newPassword = request.getParameter("newPassword");
                String email = (String) session.getAttribute("resetEmail");

                if (email == null) {
                    response.sendRedirect("forgot-password");
                    return;
                }

                dao.updatePasswordByEmail(email, newPassword);

                // Xoá session
                session.removeAttribute("resetEmail");
                session.removeAttribute("resetCode");

                request.getRequestDispatcher("/WEB-INF/views/resetSuccess.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred!");
            request.getRequestDispatcher("/WEB-INF/views/forgotPassword.jsp").forward(request, response);
        }
    }
}