<%-- 
    Document   : trang_chu_tr
    Created on : Mar 10, 2025, 8:28:59 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        
    </head>
    <body>
         <div id="spinner"
             class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar & Hero Start -->
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg fixed-top navbar-light bg-white shadow-sm px-4 px-lg-5 py-3 py-lg-0">


                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto py-0">
                        <a href="Home" class="nav-item nav-link active">Trang chủ</a>

                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Dịch vụ công</a>
                            <div class="dropdown-menu rounded-3 shadow border-0">
                                 <a href="dichvucong?action=tr" class="dropdown-item">Đăng ký tạm trú</a>
                                <a href="dichvucong?action=pt" class="dropdown-item">Đăng ký thường trú</a>
                                <a href="dichvucong?action=lt" class="dropdown-item active">Khai báo lưu trú</a>
                                
                            </div>
                        </div>

                        
                    </div>
                    <form >
                        <div class="d-flex align-items-center">
                            <a href="Login" class="btn btn-light border border-primary rounded-pill text-primary py-2 px-4 me-4">Log
                                In</a>
                            <a href="view/login.jsp" class="btn btn-primary rounded-pill text-white py-2 px-4">Sign Up</a>
                        </div>
                    </form>

                </div>
            </nav>
        </div>
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
           
            
            <a href="Login" class="btn btn-primary d-inline rounded-pill px-5 py-3">Đăng ký ngay</a>
            <a href="Home" class="btn btn-secondary d-inline rounded-pill px-5 py-3 ms-3">Quay lại trang chủ</a>
        </div>


        <!-- Footer Start -->
        <jsp:include page="footer_user.jsp" />


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
