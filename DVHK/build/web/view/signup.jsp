<%--
    Document   : signup
    Created on : Mar 18, 2025, 10:23:04 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Document Title, Description, and Author -->
        <title>Sign Up</title>
        <meta name="description" content="Console is a Free Bootstrap Admin Template.">
        <meta name="author" content="BootstrapBrain">

        <!-- Favicon and Touch Icons -->
        <link rel="icon" type="image/png" sizes="512x512" href="<%=request.getContextPath()%>/assets/favicon/favicon-512x512.png">

        <!-- Google Fonts Files -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- CSS Files -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/console-bsb.css">
    </head>
    <body>
        <main id="main">
            <!-- Registration Form -->
            <section class="bg-light py-3 py-md-5 min-vh-100 d-flex justify-content-center align-items-center">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-12 col-sm-10 col-md-10 col-lg-8 col-xl-7 col-xxl-6">
                            <div class="card border border-light-subtle rounded-3 shadow-sm">
                                <div class="card-body p-3 p-md-4 p-xl-5">
                                    <div class="text-center mb-3">
                                        <a href="#" class="fs-4 fw-bold text-dark text-decoration-none">
                                            Sign Up
                                        </a>
                                    </div>
                                    <h2 class="fs-6 fw-normal text-center text-secondary mb-4">Enter your details to register</h2>

                                    <!-- Hiển thị thông báo lỗi nếu có -->
                                    <% if (request.getAttribute("error") != null) { %>
                                    <div class="alert alert-danger text-center" role="alert">
                                        <%= request.getAttribute("error") %>
                                    </div>
                                    <% } %>

                                    <form action="<%=request.getContextPath()%>/SignupServlet" method="post">
                                        <div class="row gy-3 gx-3 overflow-hidden">
                                            <div class="col-12 col-lg-6">
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" name="idCard" id="idCard" placeholder="ID Card" required>
                                                    <label for="idCard" class="form-label">ID Card</label>
                                                </div>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" name="firstName" id="firstName" placeholder="First Name" required>
                                                    <label for="firstName" class="form-label">First Name</label>
                                                </div>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" name="lastName" id="lastName" placeholder="Last Name" required>
                                                    <label for="lastName" class="form-label">Last Name</label>
                                                </div>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <div class="form-floating mb-3">
                                                    <select class="form-select" name="gender" id="gender" required>
                                                        <option value="" selected disabled>Select Gender</option>
                                                        <option value="Male">Male</option>
                                                        <option value="Female">Female</option>
                                                    </select>
                                                    <label for="gender" class="form-label">Gender</label>
                                                </div>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <div class="form-floating mb-3">
                                                    <select class="form-select" name="city" id="city" required>
                                                        <option value="" selected disabled>Choose...</option>
                                                        <option value="An Giang">An Giang</option>
                                                        <option value="Ba Ria - Vung Tau">Ba Ria - Vung Tau</option>
                                                        <option value="Bac Giang">Bac Giang</option>
                                                        <option value="Bac Kan">Bac Kan</option>
                                                        <option value="Bac Lieu">Bac Lieu</option>
                                                        <option value="Bac Ninh">Bac Ninh</option>
                                                        <option value="Ben Tre">Ben Tre</option>
                                                        <option value="Binh Dinh">Binh Dinh</option>
                                                        <option value="Binh Duong">Binh Duong</option>
                                                        <option value="Binh Phuoc">Binh Phuoc</option>
                                                        <option value="Binh Thuan">Binh Thuan</option>
                                                        <option value="Ca Mau">Ca Mau</option>
                                                        <option value="Can Tho">Can Tho</option>
                                                        <option value="Cao Bang">Cao Bang</option>
                                                        <option value="Da Nang">Da Nang</option>
                                                        <option value="Dak Lak">Dak Lak</option>
                                                        <option value="Dak Nong">Dak Nong</option>
                                                        <option value="Dien Bien">Dien Bien</option>
                                                        <option value="Dong Nai">Dong Nai</option>
                                                        <option value="Dong Thap">Dong Thap</option>
                                                        <option value="Gia Lai">Gia Lai</option>
                                                        <option value="Ha Giang">Ha Giang</option>
                                                        <option value="Ha Nam">Ha Nam</option>
                                                        <option value="Ha Noi">Ha Noi</option>
                                                        <option value="Ha Tinh">Ha Tinh</option>
                                                        <option value="Hai Duong">Hai Duong</option>
                                                        <option value="Hai Phong">Hai Phong</option>
                                                        <option value="Hau Giang">Hau Giang</option>
                                                        <option value="Hoa Binh">Hoa Binh</option>
                                                        <option value="Hung Yen">Hung Yen</option>
                                                        <option value="Khanh Hoa">Khanh Hoa</option>
                                                        <option value="Kien Giang">Kien Giang</option>
                                                        <option value="Kon Tum">Kon Tum</option>
                                                        <option value="Lai Chau">Lai Chau</option>
                                                        <option value="Lam Dong">Lam Dong</option>
                                                        <option value="Lang Son">Lang Son</option>
                                                        <option value="Lao Cai">Lao Cai</option>
                                                        <option value="Long An">Long An</option>
                                                        <option value="Nam Dinh">Nam Dinh</option>
                                                        <option value="Nghe An">Nghe An</option>
                                                        <option value="Ninh Binh">Ninh Binh</option>
                                                        <option value="Ninh Thuan">Ninh Thuan</option>
                                                        <option value="Phu Tho">Phu Tho</option>
                                                        <option value="Phu Yen">Phu Yen</option>
                                                        <option value="Quang Binh">Quang Binh</option>
                                                        <option value="Quang Nam">Quang Nam</option>
                                                        <option value="Quang Ngai">Quang Ngai</option>
                                                        <option value="Quang Ninh">Quang Ninh</option>
                                                        <option value="Quang Tri">Quang Tri</option>
                                                        <option value="Soc Trang">Soc Trang</option>
                                                        <option value="Son La">Son La</option>
                                                        <option value="Tay Ninh">Tay Ninh</option>
                                                        <option value="Thai Binh">Thai Binh</option>
                                                        <option value="Thai Nguyen">Thai Nguyen</option>
                                                        <option value="Thanh Hoa">Thanh Hoa</option>
                                                        <option value="Thua Thien Hue">Thua Thien Hue</option>
                                                        <option value="Tien Giang">Tien Giang</option>
                                                        <option value="TP Ho Chi Minh">TP Ho Chi Minh</option>
                                                        <option value="Tra Vinh">Tra Vinh</option>
                                                        <option value="Tuyen Quang">Tuyen Quang</option>
                                                        <option value="Vinh Long">Vinh Long</option>
                                                        <option value="Vinh Phuc">Vinh Phuc</option>
                                                        <option value="Yen Bai">Yen Bai</option>
                                                    </select>
                                                    <label for="city" class="form-label">City</label>
                                                </div>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <div class="form-floating mb-3">
                                                    <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required>
                                                    <label for="email" class="form-label">Email</label>
                                                </div>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <div class="form-floating mb-3">
                                                    <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
                                                    <label for="password" class="form-label">Password</label>
                                                </div>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <div class="form-floating mb-3">
                                                    <input type="tel" class="form-control" name="phoneNumber" id="phoneNumber" placeholder="Phone Number" required>
                                                    <label for="phoneNumber" class="form-label">Phone Number</label>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <textarea class="form-control" name="address" id="address" placeholder="Address" required style="height: 100px;"></textarea>
                                                    <label for="address" class="form-label">Address</label>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="" name="iAgree" id="iAgree" required>
                                                    <label class="form-check-label text-secondary" for="iAgree">
                                                        I agree to the <a href="#!" class="link-primary text-decoration-none">terms and conditions</a>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="d-grid my-3">
                                                    <button class="btn btn-primary btn-lg" type="submit">Sign up</button>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <p class="m-0 text-secondary text-center">Already have an account? <a href="<%=request.getContextPath()%>/Login" class="link-primary text-decoration-none">Sign in</a></p>
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
    </body>
</html>