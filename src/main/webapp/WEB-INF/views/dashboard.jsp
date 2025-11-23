<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Programmize Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <style>
        /* ==== SIDEBAR BASE ==== */
        .sidebar {
            width: 260px;
            background: #111;
            color: white;
            height: 100vh;
            transition: width 0.25s ease;
            overflow: hidden;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
            padding-top: 5px;
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 10px 15px 20px;
            margin-bottom: 5px;
            border-bottom: 1px solid #333;
        }

        .sidebar button#toggleSidebar {
            color: white;
            background: transparent;
            border: none;
            font-size: 1.25rem;
            padding: 5px;
        }

        .sidebar .nav-link {
            padding: 10px 20px;
        }


        /* ==== SIDEBAR COLLAPSED ==== */
        .sidebar.collapsed {
            width: 72px;
        }

        .sidebar.collapsed .label {
            opacity: 0;
            width: 0;
            overflow: hidden;
        }

        .sidebar.collapsed .sidebar-title {
            opacity: 0;
            width: 0;
            overflow: hidden;
            flex-grow: 0;
        }

        .sidebar.collapsed .sidebar-header {
            justify-content: center;
            padding-left: 0;
        }

        .sidebar .nav-link i {
            width: 24px;
            text-align: center;
        }

        /* ==== CONTENT SHIFT ==== */
        .content {
            margin-left: 260px;
            transition: margin-left 0.25s ease;
        }

        .content.expanded {
            margin-left: 72px;
        }

        /* Topbar shift */
        .topbar {
            margin-left: 260px;
            transition: margin-left 0.25s ease;
            position: sticky;
            top: 0;
            z-index: 999;
        }

        .topbar.expanded {
            margin-left: 72px;
        }
    </style>
</head>

<body>

<div>

    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h3 class="sidebar-title label mb-0">Programmize</h3>
            <button id="toggleSidebar" class="btn">
                <i class="fa fa-bars" id="toggleIcon"></i>
            </button>
        </div>

        <ul class="nav flex-column px-0">
            <li class="nav-item">
                <a href="#" class="nav-link text-white">
                    <i class="fa fa-chart-line me-2"></i> <span class="label">Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link text-white">
                    <i class="fa fa-users me-2"></i> <span class="label">Users</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link text-white">
                    <i class="fa fa-book me-2"></i> <span class="label">Courses</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link text-white">
                    <i class="fa fa-tags me-2"></i> <span class="label">Categories</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link text-white">
                    <i class="fa fa-clipboard-list me-2"></i> <span class="label">Enrollments</span>
                </a>
            </li>
        </ul>
    </div>

    <nav class="navbar navbar-light bg-white shadow-sm px-4 topbar" id="topbar">

        <form class="d-none d-md-flex me-auto">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search for..." aria-label="Search">
                <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
            </div>
        </form>

        <div class="d-flex align-items-center ms-auto">

            <div class="dropdown me-3">
                <button class="btn btn-white position-relative" data-bs-toggle="dropdown">
                    <i class="fa fa-bell"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            3
                            <span class="visually-hidden">unread messages</span>
                        </span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#">New user registered</a></li>
                    <li><a class="dropdown-item" href="#">Course 'JS' updated</a></li>
                </ul>
            </div>

            <div class="dropdown me-4">
                <button class="btn btn-white position-relative" data-bs-toggle="dropdown">
                    <i class="fa fa-envelope"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning">
                            1
                            <span class="visually-hidden">unread messages</span>
                        </span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#">Support message received</a></li>
                </ul>
            </div>

            <div class="dropdown">
                <button class="btn btn-white d-flex align-items-center" data-bs-toggle="dropdown">
                    <img src="/assets/img/admin-avatar.png" class="rounded-circle me-2" width="35" height="35" alt="Admin Avatar">
                    <span>Admin</span>
                    <i class="fa fa-caret-down ms-2"></i>
                </button>

                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#"><i class="fa fa-user me-2"></i> Profile</a></li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li><a class="dropdown-item text-danger" href="#"><i class="fa fa-sign-out-alt me-2"></i> Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="content p-4" id="content">
        <h2 class="fw-bold mb-4">Dashboard</h2>

        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card text-white bg-primary shadow-sm">
                    <div class="card-body">
                        <h5>Total Users</h5>
                        <h3>
                            <%
                                int totalUsers = 1245;
                                out.print(totalUsers);
                            %>
                        </h3>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card text-white bg-success shadow-sm">
                    <div class="card-body">
                        <h5>Courses</h5>
                        <h3>48</h3>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card text-white bg-warning shadow-sm">
                    <div class="card-body">
                        <h5>Enrollments</h5>
                        <h3>3,562</h3>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm mt-4">
            <div class="card-header fw-bold">Latest Activities</div>
            <div class="card-body">
                <p>Recent user sign-ups and course completions will be listed here.</p>
            </div>
        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    const topbar = document.getElementById('topbar');
    const toggleBtn = document.getElementById('toggleSidebar');

    toggleBtn.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        content.classList.toggle('expanded');
        topbar.classList.toggle('expanded');
    });
</script>

</body>

</html>