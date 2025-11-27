package com.programmize.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "LearningEnrollmentServlet", urlPatterns = {"/enroll"})
public class LearningEnrollmentServlet extends HttpServlet {

    // Server-side price map to prevent client-side price tampering
    private static final Map<String, Double> COURSE_PRICES = new HashMap<>();

    static {
        COURSE_PRICES.put("web-dev", 299.00);
        COURSE_PRICES.put("data-sci", 249.00);
        COURSE_PRICES.put("ml-ai", 299.00);
        COURSE_PRICES.put("app-dev", 249.00);
        COURSE_PRICES.put("python", 99.00);
        COURSE_PRICES.put("ui-ux", 149.00);
        COURSE_PRICES.put("cybersec", 299.00);
        COURSE_PRICES.put("cloud", 249.00);
        COURSE_PRICES.put("devops", 279.00);
        COURSE_PRICES.put("blockchain", 199.00);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the JSP located under WEB-INF
        request.getRequestDispatcher("/WEB-INF/views/learning-enrollment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Retrieve Form Data
            // Note: You must add 'name' attributes to your JSP inputs for these to work!
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            String courseId = request.getParameter("course");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String paymentMethod = request.getParameter("pm"); // card, momo, zalopay, bank
            String stripeToken = request.getParameter("stripeToken"); // For card payments

            // 2. Validate Data
            if (firstName == null || email == null || courseId == null) {
                request.setAttribute("errorMessage", "Missing required fields.");
                request.getRequestDispatcher("/WEB-INF/views/learning-enrollment.jsp").forward(request, response);
                return;
            }

            // 3. Validate Price (Security)
            if (!COURSE_PRICES.containsKey(courseId)) {
                request.setAttribute("errorMessage", "Invalid course selected.");
                request.getRequestDispatcher("/WEB-INF/views/learning-enrollment.jsp").forward(request, response);
                return;
            }
            double expectedPrice = COURSE_PRICES.get(courseId);

            // 4. Handle Dates
            LocalDate start = LocalDate.parse(startDateStr);
            LocalDate end = LocalDate.parse(endDateStr);
            if (end.isBefore(start)) {
                request.setAttribute("errorMessage", "End date cannot be before start date.");
                request.getRequestDispatcher("/WEB-INF/views/learning-enrollment.jsp").forward(request, response);
                return;
            }

            // 5. Process Payment
            boolean paymentSuccess = processPayment(paymentMethod, expectedPrice, stripeToken);

            if (paymentSuccess) {
                // Success: Redirect to a success page or show success message
                // In a real app, save to Database here
                request.setAttribute("successMessage", "Enrollment successful for " + firstName + " in " + courseId + "!");
                request.getRequestDispatcher("/WEB-INF/views/learning-enrollment.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Payment processing failed.");
                request.getRequestDispatcher("/WEB-INF/views/learning-enrollment.jsp").forward(request, response);
            }

        } catch (DateTimeParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid date format.");
            request.getRequestDispatcher("/WEB-INF/views/learning-enrollment.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An internal error occurred.");
            request.getRequestDispatcher("/WEB-INF/views/learning-enrollment.jsp").forward(request, response);
        }
    }

    private boolean processPayment(String method, double amount, String token) {
        // Mock payment logic
        System.out.println("Processing " + method + " payment of $" + amount);

        if ("card".equals(method)) {
            if (token == null || token.isEmpty()) {
                System.out.println("Error: Missing Stripe Token");
                return false;
            }
            // In a real app, use Stripe API here with the token
            System.out.println("Stripe Token received: " + token);
            return true;
        }

        // For Manual payments (MoMo, Zalo, Bank), assume pending success logic
        return true;
    }
}