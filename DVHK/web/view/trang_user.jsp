<%-- 
    Document   : trang_user
    Created on : Mar 4, 2025, 5:08:55 PM
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
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        %>
        
    </head>
    <body>

    <jsp:include page="header_user.jsp" />

        
        <div class="hero-header overflow-hidden px-5">
            <div class="rotate-img">
                <img src="img/sty-1.png" class="img-fluid w-100" alt="">
                <div class="rotate-sty-2"></div>
            </div>
            <div class="row gy-5 align-items-center">
                <div class="col-lg-6 wow fadeInLeft" data-wow-delay="0.1s">
                    <h1 class="display-4 text-dark mb-4 wow fadeInUp" data-wow-delay="0.3s">Cổng Dịch Vụ Trực
                        Tuyến</h1>
                    <p class="fs-6 mb-4 wow fadeInUp" data-wow-delay="0.5s">
                        Nhanh chóng đăng ký hộ khẩu thường trú, tạm trú, lưu trú ngay tại nhà!  
                        Tiết kiệm thời gian, đơn giản và thuận tiện với vài thao tác dễ dàng.
                    </p>

                </div>
                <div class="col-lg-6 wow fadeInRight" data-wow-delay="0.2s">
                    <img src="img/gt.webp" class="img-fluid w-100 h-100" alt="">
                </div>
            </div>
        </div>
        <div class="container-fluid overflow-hidden py-5" style="margin-top: 6rem;">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="RotateMoveLeft">
                            <img src="img/intro.webp" class="img-fluid w-100" alt="">
                        </div>
                    </div>
                    <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.3s">
                        <h4 class="mb-1 text-primary">Giới Thiệu</h4>
                        <h1 class="display-5 mb-4">Quản Lý Hộ Khẩu Trực Tuyến Nhanh Chóng, Tiện Lợi</h1>
                        <p class="mb-6">
                            Hệ thống hỗ trợ đăng ký, theo dõi và quản lý thông tin cư trú dễ dàng ngay tại nhà.
                            Với quy trình điện tử hóa, bạn có thể thực hiện các thủ tục như đăng ký thường trú, tạm trú, lưu
                            trú mà không cần đến trực tiếp cơ quan hành chính.
                            Đội ngũ quản lý sẽ xử lý và phê duyệt hồ sơ nhanh chóng, minh bạch, giúp tiết kiệm thời gian và
                            tối ưu hóa công tác quản lý dân cư.
                        </p>
                        <a href="#" class="btn btn-primary rounded-pill py-3 px-5">Tìm Hiểu Thêm</a>
                    </div>

                </div>
            </div>
        </div>
        <div class="container-fluid service py-5">
            <div class="container py-5">
                <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 900px;">
                    <h4 class="mb-1 text-primary">Dịch Vụ</h4>
                    <h1 class="display-5 mb-4">Các Tiện Ích Chúng Tôi Cung Cấp</h1>
                    <p class="mb-0">Hệ thống hỗ trợ người dân và cơ quan chức năng trong công tác quản lý thông tin cư trú
                        nhanh chóng, minh bạch và chính xác.</p>
                </div>
                <div class="row g-4 justify-content-center">

                    <div class="col-md-6 col-lg-4 col-xl-3 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="service-item text-center rounded p-4">
                            <div class="service-icon d-inline-block bg-light rounded p-4 mb-4"><i
                                    class="fas fa-home fa-5x text-secondary"></i></div>
                            <div class="service-content">
                                <h4 class="mb-4">Đăng Ký Thường Trú</h4>
                                <p class="mb-4">Thực hiện đăng ký thường trú trực tuyến, tiết kiệm thời gian và công sức.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4 col-xl-3 wow fadeInUp" data-wow-delay="0.3s">
                        <div class="service-item text-center rounded p-4">
                            <div class="service-icon d-inline-block bg-light rounded p-4 mb-4"><i
                                    class="fas fa-user-clock fa-5x text-secondary"></i></div>
                            <div class="service-content">
                                <h4 class="mb-4">Đăng Ký Tạm Trú</h4>
                                <p class="mb-4">Hỗ trợ khai báo và theo dõi thông tin tạm trú nhanh chóng, chính xác.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4 col-xl-3 wow fadeInUp" data-wow-delay="0.5s">
                        <div class="service-item text-center rounded p-4">
                            <div class="service-icon d-inline-block bg-light rounded p-4 mb-4"><i
                                    class="fas fa-bed fa-5x text-secondary"></i></div>
                            <div class="service-content">
                                <h4 class="mb-4">Khai Báo Lưu Trú</h4>
                                <p class="mb-4">Đơn giản hóa việc khai báo lưu trú đối với khách vãng lai, du lịch.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4 col-xl-3 wow fadeInUp" data-wow-delay="0.7s">
                        <div class="service-item text-center rounded p-4">
                            <div class="service-icon d-inline-block bg-light rounded p-4 mb-4"><i
                                    class="fas fa-search fa-5x text-secondary"></i></div>
                            <div class="service-content">
                                <h4 class="mb-4">Tra Cứu Thông Tin</h4>
                                <p class="mb-4">Tra cứu nhanh chóng thông tin cư trú, hỗ trợ công tác quản lý hiệu quả.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4 col-xl-3 wow fadeInUp" data-wow-delay="0.5s">
                        <div class="service-item text-center rounded p-4">
                            <div class="service-icon d-inline-block bg-light rounded p-4 mb-4"><i
                                    class="fas fa-bed fa-5x text-secondary"></i></div>
                            <div class="service-content">
                                <h4 class="mb-4">Chuyển Hộ Khẩu</h4>
                                <p class="mb-4">Đơn giản hóa việc khai báo lưu trú đối với khách vãng lai, du lịch.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-4 col-xl-3 wow fadeInUp" data-wow-delay="0.7s">
                        <div class="service-item text-center rounded p-4">
                            <div class="service-icon d-inline-block bg-light rounded p-4 mb-4"><i
                                    class="fas fa-search fa-5x text-secondary"></i></div>
                            <div class="service-content">
                                <h4 class="mb-4">Tách Hộ Khẩu</h4>
                                <p class="mb-4">Tra cứu nhanh chóng thông tin cư trú, hỗ trợ công tác quản lý hiệu quả.</p>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>

        <!-- Service End -->



        <!-- Feature Start -->

        <!-- Feature End -->


        <!-- FAQ Start -->
        <div class="container-fluid news bg-light overflow-hidden py-5">
            <div class="container py-5">
                <div class="row g-5 align-items-center">
                    <div class="col-lg-6 wow fadeInLeft" data-wow-delay="0.1s">
                        <div class="accordion" id="accordionExample">
                            <div class="accordion-item border-0 mb-4">
                                <h2 class="accordion-header" id="headingOne">
                                    <button class="accordion-button rounded-top" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Thông báo về các quy định mới liên quan đến cư trú
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne"
                                     data-bs-parent="#accordionExample">
                                    <div class="accordion-body my-2">
                                        <h5>Cập nhật quy định cư trú năm 2025</h5>
                                        <p>Theo nghị định mới ban hành, các hộ gia đình và cá nhân cần thực hiện việc đăng
                                            ký cư trú đúng hạn. Các quy định mới nhằm đảm bảo quản lý dân cư chặt chẽ và
                                            nâng cao chất lượng dịch vụ hành chính công.</p>
                                        <p>Người dân cần nắm rõ các thủ tục đăng ký thường trú, tạm trú, khai báo lưu trú để
                                            tránh vi phạm hành chính. Mọi thắc mắc vui lòng liên hệ cơ quan công an địa
                                            phương để được hướng dẫn cụ thể.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item border-0 mb-4">
                                <h2 class="accordion-header" id="headingTwo">
                                    <button class="accordion-button collapsed rounded-top" type="button"
                                            data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false"
                                            aria-controls="collapseTwo">
                                        Hướng dẫn cập nhật giấy tờ
                                    </button>
                                </h2>
                                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                                     data-bs-parent="#accordionExample">
                                    <div class="accordion-body my-2">
                                        <h5>Thủ tục cập nhật giấy tờ cư trú</h5>
                                        <p>Người dân cần chuẩn bị các giấy tờ như CMND/CCCD, sổ hộ khẩu (nếu có), giấy chứng
                                            nhận quyền sử dụng đất hoặc hợp đồng thuê nhà, đơn đăng ký cư trú để tiến hành
                                            cập nhật thông tin theo đúng quy định.</p>
                                        <p>Việc cập nhật giấy tờ đảm bảo quyền lợi về cư trú, học tập, y tế và các dịch vụ
                                            công cộng. Người dân nên kiểm tra kỹ thông tin để tránh sai sót trong quá trình
                                            xử lý hồ sơ.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item border-0">
                                <h2 class="accordion-header" id="newsThree">
                                    <button class="accordion-button collapsed rounded-top" type="button"
                                            data-bs-toggle="collapse" data-bs-target="#collapseNewsThree" aria-expanded="false"
                                            aria-controls="collapseNewsThree">
                                        Lưu ý về hạn đăng ký thường trú
                                    </button>
                                </h2>
                                <div id="collapseNewsThree" class="accordion-collapse collapse" aria-labelledby="newsThree"
                                     data-bs-parent="#accordionNews">
                                    <div class="accordion-body my-2">
                                        <h5>Thời hạn đăng ký thường trú</h5>
                                        <p>Công dân phải đăng ký thường trú trong vòng 60 ngày kể từ khi có đủ điều kiện
                                            theo quy định pháp luật về cư trú.</p>
                                        <p>Quá thời hạn quy định có thể bị xử phạt hành chính theo nghị định 167/2013/NĐ-CP.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 wow fadeInRight" data-wow-delay="0.3s">
                        <div class="news-img RotateMoveRight rounded">
                            <img src="img/about-1.png" class="img-fluid w-100" alt="Thông báo về quy định cư trú">
                        </div>
                    </div>
                </div>
            </div>
        </div>





        <!-- Footer Start -->
       <jsp:include page="footer_user.jsp" />
        <!-- Footer End -->


       
       

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
