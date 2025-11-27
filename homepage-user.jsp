<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Programmize - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/style.css">
</head>

<body>

<!-- Include Header -->
<%
    // TEMPORARY: This line simulates a logged-in user
    session.setAttribute("username","");
%>

<%@ page session="true" %>
<jsp:include page="../views/header.jsp" />

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
<jsp:include page="../views/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>