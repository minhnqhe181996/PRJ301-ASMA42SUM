<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required Meta Tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Đặt lại mật khẩu thành công</title>
        <!-- CSS Files -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./assets/css/console-bsb.css">
    </head>
    <body>
        <main id="main">
            <section class="bg-light py-3 py-md-5 min-vh-100 d-flex justify-content-center align-items-center">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
                            <div class="card border border-light-subtle rounded-3 shadow-sm">
                                <div class="card-body p-3 p-md-4 p-xl-5">
                                    <div class="text-center mb-3">
                                        <h2>Đặt lại mật khẩu</h2>
                                    </div>
                                    <div class="text-center mb-4">
                                        <div class="alert alert-success">
                                            ${message}
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <a href="Login" class="btn btn-primary">Đăng nhập</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </body>
</html>