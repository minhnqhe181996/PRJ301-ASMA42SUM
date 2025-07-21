<%-- 
    Document   : re_password
    Created on : Mar 9, 2025, 5:10:57 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required Meta Tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Document Title, Description, and Author -->
        <title>Console - Free Bootstrap Admin Template</title>
        <meta name="description" content="Console is a Free Bootstrap Admin Template.">
        <meta name="author" content="BootstrapBrain">

        <!-- Favicon and Touch Icons -->
        <link rel="icon" type="image/png" sizes="512x512" href="./assets/favicon/favicon-512x512.png">

        <!-- Google Fonts Files -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- CSS Files -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./assets/css/console-bsb.css">

        <!-- BSB Head -->
    </head>
    <body>

        <!-- Main -->
        <main id="main">

            <!-- Password Reset 13 - Bootstrap Brain Component -->
            <section class="bg-light py-3 py-md-5 min-vh-100 d-flex justify-content-center align-items-center">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
                            <div class="card border border-light-subtle rounded-3 shadow-sm">
                                <div class="card-body p-3 p-md-4 p-xl-5">
                                    <div class="text-center mb-3">
                                        <h2>Quên mật khẩu?</h2>
                                    </div>

                                    <form action="ForgotPassword" method="post">
                                        <div class="row gy-2 overflow-hidden">
                                            <div class="col-12">
                                                <div class="form-floating">
                                                    <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required>
                                                    <label for="email" class="form-label">Email</label>
                                                </div>
                                                <!-- Hiển thị thông báo lỗi nếu có -->
                                                <% if(request.getAttribute("error") != null) { %>
                                                <div class="alert alert-danger mt-2">
                                                    <%= request.getAttribute("error") %>
                                                </div>
                                                <% } %>
                                            </div>
                                            <div class="col-12">
                                                <div class="d-grid my-3">
                                                    <button class="btn btn-primary btn-lg" type="submit">Đặt lại mật khẩu</button>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="d-flex gap-2 justify-content-between">
                                                    <a href="Login" class="link-primary text-decoration-none">Login</a>
                                                    <a href="Signup" class="link-primary text-decoration-none">Signup</a>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>

        <!-- BSB Body End -->
    </body>

</html>