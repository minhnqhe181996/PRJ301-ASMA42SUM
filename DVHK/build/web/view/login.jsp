<%-- 
    Document   : login
    Created on : Mar 4, 2025, 3:34:44 PM
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
        <title>Login</title>
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
        <div>


            <main id="main">

                <!-- Login 13 - Bootstrap Brain Component -->
                <section class="bg-light py-3 py-md-5 min-vh-100 d-flex justify-content-center align-items-center">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
                                <div class="card border border-light-subtle rounded-3 shadow-sm">
                                    <div class="card-body p-3 p-md-4 p-xl-5">
                                        <div class="text-center mb-3">
                                            <a href="#" class="fs-4 fw-bold text-dark text-decoration-none">
                                                Login
                                            </a>
                                        </div>

                                        <h2 class="fs-6 fw-normal text-center text-secondary mb-4">Sign in to your account</h2>
                                        <form action="Login" method="post">
                                            <div class="row gy-2 overflow-hidden">
                                                <% String name=(String) request.getAttribute("name"); %>
                                                
                                                <div class="col-12">
                                                    <div class="form-floating mb-3">
                                                        <% if(name != null){%>
                                                        <input type="text" class="form-control" name="userid" id="text" placeholder="UserID" value="<%= name%>" required>
                                                        <label for="text" class="form-label">UserID</label>
                                                        <%} else {%>
                                                        <input type="text" class="form-control" name="userid" id="text" placeholder="UserID" required>
                                                        <label for="text" class="form-label">UserID</label>
                                                        <%}%>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <div class="form-floating mb-3">
                                                        <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
                                                        <label for="password" class="form-label">Password</label>
                                                    </div>
                                                </div>

                                                

                                                <div class="col-12">
                                                    <div class="d-flex gap-2 justify-content-between">
                                                        <a href="Identify?action=repass" class="link-primary text-decoration-none">Forgot password?</a>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="d-grid my-3">
                                                        <button class="btn btn-primary btn-lg" type="submit">Log in</button>
                                                    </div>
                                                </div>
                                                
                                                <div class="col-12">
                                                    <p class="m-0 text-secondary text-center">Don't have an account? <a href="Signup" class="link-primary text-decoration-none">Sign up</a></p>
                                                </div>
                                                <% String error = (String) request.getAttribute("error"); %>
                                                <% if (error != null) { %>
                                                <tr>
                                                    <td><i style="color: red">Error: <%= error %></i></td>
                                                    
                                                </tr>
                                                <% } %>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

            </main>

        </div>
        <!-- Main -->


        <!-- BSB Body End -->
    </body>
</html>
