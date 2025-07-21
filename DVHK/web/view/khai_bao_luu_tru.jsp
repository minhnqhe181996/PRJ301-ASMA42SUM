<%-- 
    Document   : dk_tam_tru
    Created on : Mar 5, 2025, 8:46:52 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Quản lý hệ thống cư trú</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">
        <link href="img/hero-img-1.png" rel="icon">
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@500;600;700&family=Rubik:wght@400;500&display=swap"
            rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">


        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">



        <link href="css/bootstrap.min.css" rel="stylesheet">


        <link href="css/style.css" rel="stylesheet">
        
    <body>

        <!-- Spinner Start -->
        <jsp:include page="header_user.jsp" />


        <!-- Header Start -->
        <div class="container-fluid bg-breadcrumb">
            <ul class="breadcrumb-animation">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
            <div class="container text-center py-5" style="max-width: 900px;">
                <h3 class="display-3 mb-4 wow fadeInDown" data-wow-delay="0.1s">Khai Báo Lưu Trú</h3>
                <ol class="breadcrumb justify-content-center mb-0 wow fadeInDown" data-wow-delay="0.3s">
                    <li class="breadcrumb-item"><a href="User">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="#">Dịch vụ công</a></li>
                    <li class="breadcrumb-item active text-primary">Khai báo lưu trú</li>
                </ol>
            </div>
        </div>
        <!-- Header End -->

        <!-- Hướng dẫn đăng ký tạm trú -->
        <div class="container py-5">
            <h2 class="text-center mb-4">Hướng dẫn đăng ký lưu trú chi tiết</h2>
            <p>Việc đăng ký lưu trú là một thủ tục quan trọng giúp đảm bảo quyền lợi và an ninh khi bạn lưu trú tại địa phương. Dưới đây là hướng dẫn chi tiết từng bước:</p>
            <ul class="list-group">
                <li class="list-group-item"><b>Bước 1:</b> <b>Chuẩn bị hồ sơ</b>
                    <ul>
                        <li>CMND/CCCD hoặc hộ chiếu (bản gốc và bản sao).</li>
                        <li>Giấy tờ xác nhận lưu trú (ví dụ: giấy mời, hợp đồng lưu trú hoặc giấy xác nhận của chủ cơ sở lưu trú).</li>
                        <li>Phiếu khai báo lưu trú (theo mẫu).</li>
                        <li>Ảnh chân dung 3x4 (nền trắng, nếu cần).</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 2:</b> <b>Truy cập hệ thống và đăng nhập</b>
                    <ul>
                        <li>Truy cập vào cổng dịch vụ công trực tuyến hoặc hệ thống đăng ký lưu trú của địa phương.</li>
                        <li>Đăng nhập bằng tài khoản cá nhân hoặc tạo tài khoản mới.</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 3:</b> <b>Điền thông tin đăng ký</b>
                    <ul>
                        <li>Họ và tên, ngày tháng năm sinh, số CMND/CCCD hoặc hộ chiếu.</li>
                        <li>Địa chỉ lưu trú cụ thể (số phòng, khách sạn, nhà nghỉ hoặc địa chỉ nhà dân).</li>
                        <li>Thời gian lưu trú (ngày bắt đầu, ngày kết thúc hoặc lưu trú dài hạn).</li>
                        <li>Thông tin liên hệ: số điện thoại, email để nhận thông báo.</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 4:</b> <b>Tải lên hồ sơ đính kèm</b>
                    <ul>
                        <li>Chọn và tải lên bản scan/ảnh chụp các giấy tờ cần thiết.</li>
                        <li>Đảm bảo các tài liệu rõ nét, không bị cắt góc hoặc thiếu thông tin.</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 5:</b> <b>Kiểm tra và xác nhận thông tin</b>
                    <ul>
                        <li>Xem lại toàn bộ thông tin đã nhập.</li>
                        <li>Chỉnh sửa nếu cần thiết để đảm bảo chính xác.</li>
                        <li>Nhấn nút "Gửi hồ sơ" để hoàn tất đăng ký lưu trú.</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 6:</b> <b>Theo dõi kết quả và nhận xác nhận lưu trú</b>
                    <ul>
                        <li>Theo dõi trạng thái hồ sơ trực tuyến.</li>
                        <li>Nhận thông báo qua email hoặc tin nhắn khi hồ sơ được duyệt.</li>
                        <li>Nhận giấy xác nhận lưu trú trực tiếp hoặc qua email (tuỳ theo chính sách hỗ trợ).</li>
                    </ul>
                </li>
            </ul>
            <p class="mt-4">Lưu ý: Thời gian xử lý hồ sơ thường từ 1-3 ngày làm việc. Nếu gặp khó khăn, bạn có thể liên hệ tổng đài hỗ trợ hoặc đến cơ quan công an/phường xã để được hướng dẫn thêm.</p>
        </div>

        <!-- Đăng ký tạm trú trực tuyến -->
        <div class="container text-center py-5">
           
            
            <a href="Registration?action=formlt" class="btn btn-primary d-inline rounded-pill px-5 py-3">Đăng ký ngay</a>
            <a href="User" class="btn btn-secondary d-inline rounded-pill px-5 py-3 ms-3">Quay lại trang chủ</a>
        </div>


        <!-- Footer Start -->
        <div class="container-fluid footer py-5 wow fadeIn" data-wow-delay="0.2s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-md-6 col-lg-6 col-xl-3">
                        <div class="footer-item d-flex flex-column">
                            <h4 class="text-dark mb-4">Company</h4>
                            <a href=""> Why Mailler?</a>
                            <a href=""> Our Features</a>
                            <a href=""> Our Portfolio</a>
                            <a href=""> About Us</a>
                            <a href=""> Our Blog & News</a>
                            <a href=""> Get In Touch</a>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6 col-xl-3">
                        <div class="footer-item d-flex flex-column">
                            <h4 class="mb-4 text-dark">Quick Links</h4>
                            <a href=""> About Us</a>
                            <a href=""> Contact Us</a>
                            <a href=""> Privacy Policy</a>
                            <a href=""> Terms & Conditions</a>
                            <a href=""> Our Blog & News</a>
                            <a href=""> Our Team</a>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6 col-xl-3">
                        <div class="footer-item d-flex flex-column">
                            <h4 class="mb-4 text-dark">Services</h4>
                            <a href=""> All Services</a>
                            <a href=""> Promotional Emails</a>
                            <a href=""> Product Updates</a>
                            <a href=""> Email Marketing</a>
                            <a href=""> Acquistion Emails</a>
                            <a href=""> Retention Emails</a>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6 col-xl-3">
                        <div class="footer-item d-flex flex-column">
                            <h4 class="mb-4 text-dark">Contact Info</h4>
                            <a href=""><i class="fa fa-map-marker-alt me-2"></i> 123 Street, New York, USA</a>
                            <a href=""><i class="fas fa-envelope me-2"></i> info@example.com</a>
                            <a href=""><i class="fas fa-phone me-2"></i> +012 345 67890</a>
                            <a href="" class="mb-3"><i class="fas fa-print me-2"></i> +012 345 67890</a>
                            <div class="d-flex align-items-center">
                                <i class="fas fa-share fa-2x text-secondary me-2"></i>
                                <a class="btn-square btn btn-primary rounded-circle mx-1" href=""><i
                                        class="fab fa-facebook-f"></i></a>
                                <a class="btn-square btn btn-primary rounded-circle mx-1" href=""><i
                                        class="fab fa-twitter"></i></a>
                                <a class="btn-square btn btn-primary rounded-circle mx-1" href=""><i
                                        class="fab fa-instagram"></i></a>
                                <a class="btn-square btn btn-primary rounded-circle mx-1" href=""><i
                                        class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Copyright Start -->
        <div class="container-fluid copyright py-4">
            <div class="container">
                <div class="row g-4 align-items-center">
                    <div class="col-md-6 text-center text-md-start mb-md-0">
                        <span class="text-white"><a href="#"><i class="fas fa-copyright text-light me-2"></i>Your Site
                                Name</a>, All right reserved.</span>
                    </div>
                    <div class="col-md-6 text-center text-md-end text-white">
                        <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                        <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                        <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                        Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a> Distributed By <a
                            class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Copyright End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i class="fa fa-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/counterup/counterup.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/lightbox/js/lightbox.min.js"></script>


        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
