<%-- 
    Document   : formdk__pr
    Created on : Mar 5, 2025, 11:19:11 PM
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

    </head>

    <body>

        <jsp:include page="header_user.jsp" />

        <div class="hero-header overflow-hidden px-5">
            <h2 class="text-center">Đăng ký tạm trú</h2>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <form action="Registration" method="post" id="registerForm" class="mx-auto" style="max-width: 1200px;" >
                <input type="hidden" name="action" value="tam">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="firstName">First Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="firstName" name="firstName"  value="<c:out value='${user.getFirstName()}'></c:out>" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="lastName">Last Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="lastName" name="lastName"  value="<c:out value='${user.getLastName()}'></c:out>" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="IDCard">CCCD <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="id" name="id" value="<c:out value='${user.getIDCard()}'></c:out>" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="phone">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="phone" name="phone"  value="<c:out value='${user.getPhoneNumber()}'></c:out>" placeholder="VD: 0987654321" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="addressOld">Địa chỉ cũ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="addressOld" name="addressOld" value="<c:out value='${user.getAddress()}'></c:out>" placeholder="Nhập địa chỉ bạn đã ở trước đây"readonly>
                            </div>
                            <div class="mb-3">
                                <label for="IDCard">City <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="id" name="id" value="<c:out value='${user.getCity()}'></c:out>" readonly>
                            </div>
                            

                           
                           
                             <div class="mb-3">
                                <label for="registerType">Kiểu đăng ký <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="registerType" name="registerType" readonly="true" value="Temporary">
                            </div>
                        </div>
                        <div class="col-md-6">
                            
                            
                            <div class="mb-3">
                                <label for="relationship">Relationship with the head of household <span class="text-danger">*</span></label>
                                <select class="form-select" id="relationship" name="relationship" required>
                                    <option value="" disabled selected>Select relationship with head of household</option>
                                    <option value="Head">Head</option>
                                    <option value="Wife">Wife</option>
                                    <option value="Husband">Husband</option>
                                    <option value="Child">Child</option>
                                    <option value="Father">Father</option>
                                    <option value="Mother">Mother</option>
                                    <option value="Older brother">Older brother</option>
                                    <option value="Older sister">Older sister</option>
                                    <option value="Younger brother">Younger brother</option>
                                    <option value="Younger sister">Younger sister</option>
                                    <option value="Grandfather">Grandfather</option>
                                    <option value="Grandmother">Grandmother</option>
                                    <option value="Grandchild">Grandchild</option>
                                    <option value="Aunt">Aunt</option>
                                    <option value="Uncle">Uncle</option>
                                    <option value="Cousin">Cousin</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            
                            
                            <div class="mb-3">
                                <label for="headOfHousehold">CCCD của chủ hộ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="headOfHousehold" name="headOfHousehold" placeholder="Nhập số CCCD của chủ hộ">
                            </div>
                            <div class="mb-3">
                                <label for="startDate">Ngày bắt đầu tạm trú <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required>
                            </div>
                            <div class="mb-3">
                                <label for="endDate">Ngày kết thúc<span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="endDate" name="endDate">
                            </div> 
                            
                            <div class="mb-3">
                                <label for="address">Địa chỉ chuyển đến <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ nơi bạn muốn đăng ký" required>
                            </div>
                             <div class="mb-3">
                                <label for="inputCity" class="form-label">City <span class="text-danger">*</span></label>
                                 <select id="inputCity" class="form-select"  name="city">

                                    <option value="">Choose...</option>
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
                            </div>

                             <div class="mb-3">
                                <label for="comment">Ghi chú <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="comment" name="comment" rows="3" placeholder="Ghi chú thêm nếu cần"></textarea>
                            </div>
                           


                            
                        </div>
                    </div>
                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary">Đăng ký</button>
                    </div>



                </form>
            </div>

        <jsp:include page="footer_user.jsp" />


        <!-- Bootstrap sẽ tự động căn chỉnh các trường trong lưới -->








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
