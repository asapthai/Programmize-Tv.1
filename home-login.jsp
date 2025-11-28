<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Programmize - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
        }

        /* Navbar */
        .navbar {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 28px;
            color: #007bff !important;
        }

        .nav-link {
            color: #333 !important;
            font-weight: 500;
            margin-left: 15px;
        }

        .nav-link:hover {
            color: #007bff !important;
        }

        /* Section */
        .section-title {
            text-align: center;
            font-weight: 700;
            color: whitesmoke;
            margin-top: 60px;
            margin-bottom: 30px;
        }

        /* Courses Section */
        .courses-section {
            background: linear-gradient(135deg, #637ea8 0%, #2c4c8a 50%, #102a54 100%);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            padding: 40px;
            margin: 20px auto;
            max-width: 900px;
            text-align: center;
            color: white;
        }

        .courses-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 40px;
        }

        .course-column {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        /* Background course card */
        .course-item {
            position: relative;
            height: 160px;
            display: flex;
            align-items: flex-end;
            padding: 20px;
            font-size: 20px;
            font-weight: 700;
            color: white;
            border-radius: 12px;
            background-size: cover;
            background-position: center;
            overflow: hidden;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .course-item::after {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.35);
            border-radius: 12px;
            transition: 0.3s ease;
        }

        .course-item span {
            position: relative;
            z-index: 2;
        }

        .course-item:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        .course-item:hover::after {
            background: rgba(0, 0, 0, 0.45);
        }

        /* Background images */
        .webdev { background-image: url('<%= request.getContextPath() %>/assets/img/home/WebDevelopment.png'); }
        .datascience { background-image: url('<%= request.getContextPath() %>/assets/img/home/DataScience.png'); }
        .machinelearning { background-image: url('<%= request.getContextPath() %>/assets/img/home/MachineLearning.png'); }
        .appdev { background-image: url('<%= request.getContextPath() %>/assets/img/home/AppDevelopment.png'); }
        .python { background-image: url('<%= request.getContextPath() %>/assets/img/home/PythonProgramming.png'); }
        .uiux { background-image: url('<%= request.getContextPath() %>/assets/img/home/UIUXDesign.png'); }
        .cyber { background-image: url('<%= request.getContextPath() %>/assets/img/home/Cybersecurity.png'); }
        .cloud { background-image: url('<%= request.getContextPath() %>/assets/img/home/CloudComputing.png'); }

        /* Contact section */
        .contact-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            text-align: left;
            margin-top: 20px;
        }

        .social-item,
        .contact-item {
            font-size: 18px;
            margin-bottom: 10px;
        }

        /* Footer */
        footer {
            background-color: #0a2259;
            color: white;
            padding: 40px 0;
            margin-top: 80px;
        }

        footer p {
            margin: 0 0 20px 0;
            color: #ddd;
            text-align: center;
        }

        .footer-container {
            display: flex;
            justify-content: center;
            gap: 80px;
            text-align: left;
            flex-wrap: wrap;
        }

        .footer-column {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .footer-column strong {
            font-size: 18px;
        }

        .contact-item, .social-item {
            color: #ddd;
        }
        .user-dashboard .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            height: 100%;
        }

        .user-dashboard .card:hover {
            transform: translateY(-5px);
        }

        .user-dashboard .card-title {
            color: #2c4c8a;
            font-weight: 600;
        }

        .user-dashboard .card-text {
            color: #666;
            margin-bottom: 20px;
        }
        .input-field {
            width: 100%;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            border: 1px solid #e5e7eb;
            outline: none;
            transition: all 0.2s;
        }

        .input-field:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 2px #bfdbfe;
        }
        .card {
            background-color: white;
            padding: 1.5rem;
            border-radius: 0.75rem;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            border: 1px solid #f3f4f6;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: whitesmoke;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .badge {
            background-color: #dbeafe;
            padding: 0.25rem 0.75rem;
            border-radius: 0.25rem;
            font-size: 1.125rem;
        }

        .user-badge {
            background-color: #ecfeff;
            border-left: 4px solid #06b6d4;
            padding: 0.75rem;
            margin-bottom: 1.25rem;
            color: #0e7490;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
        }

        .pm-option {
            cursor: pointer;
            border: 1px solid #e5e7eb;
            border-radius: 0.25rem;
            padding: 0.75rem;
            text-align: center;
            transition: background-color 0.2s;
        }
    </style>
</head>
<body>
<!-- Include Header -->
<%
    // TEMPORARY: This line simulates a logged-in user
    session.setAttribute("username","");
%>
<%@ page session="true" %>
<jsp:include page="../views/include/header.jsp" />

<main>
    <!-- Courses Section -->
    <section class="courses-section">
        <div class="container">
            <h1 class="section-title">Highlighted Courses</h1>

            <div class="courses-grid">
                <div class="course-column">
                    <div class="course-item webdev"><span>Web Development</span></div>
                    <div class="course-item datascience"><span>Data Science</span></div>
                    <div class="course-item machinelearning"><span>Machine Learning</span></div>
                    <div class="course-item appdev"><span>App Development</span></div>
                </div>

                <div class="course-column">
                    <div class="course-item python"><span>Python Programming</span></div>
                    <div class="course-item uiux"><span>UI/UX Design</span></div>
                    <div class="course-item cyber"><span>Cybersecurity</span></div>
                    <div class="course-item cloud"><span>Cloud Computing</span></div>
                </div>
            </div>
        </div>
    </section>
</main>
<!-- Footer -->
<jsp:include page="../views/include/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>