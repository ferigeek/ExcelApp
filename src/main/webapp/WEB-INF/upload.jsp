<%--
  Created by IntelliJ IDEA.
  User: farnam
  Date: 7/28/25
  Time: 3:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html dir="rtl" lang="fa" data-bs-theme="dark">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>خانه</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-5.3.7-dist/css/bootstrap.rtl.min.css"
        crossorigin="anonymous">
</head>
<body>
<!--Navbar Section-->
<div>
  <nav class="navbar navbar-expand-lg bg-body-tertiary fixed-top">
    <div class="container-fluid">
      <a class="navbar-brand" href="index">
        <img src="<%=request.getContextPath()%>/images/icons8-excel-48.png" alt="icon" width="30">
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
              data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
              aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="index">خانه</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="adduser">اضافه کردن کاربر</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              فایل اکسل
            </a>
            <ul class="dropdown-menu">
              <li>
                <a class="dropdown-item" href="download" download="result.xlsx">دریافت فایل اکسل</a>
              </li>
              <li><hr class="dropdown-divider"></li>
              <form action="upload" method="POST" enctype="multipart/form-data">
                <li>
                  <button type="submit" class="dropdown-item">بارگذاری فایل اکسل دیگر</button>
                </li>
                <li>
                  <input type="file" name="excel_file_upload" required class="dropdown-item"
                         style="width: 250px;" accept=".xls,.xlsx"/>
                </li>
              </form>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</div>
<!--/Navbar Section-->

<div style="margin: 20%;">
  <form action="upload" method="POST" enctype="multipart/form-data">
    <div class="mb-3">
      <input type="file" name="excel_file_upload" class="form-control" required style="width: 250px;" accept=".xls,.xlsx"/>
    </div>
    <button type="submit" class="btn btn-outline-warning">بارگذاری فایل اکسل</button>
  </form>
</div>

<div class="toast-container position-fixed bottom-0 end-0 p-3">
  <div id="liveToast" class="toast bg-danger" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <img src="<%=request.getContextPath()%>/images/cloud-upload.svg" class="rounded me-2" alt="بارگذاری فایل اکسل">
      <strong class="me-auto">خطا</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="بستن"></button>
    </div>
    <div class="toast-body">
      فایل اکسلی برای خواندن داده پیدا نشد. لطفا یک فایل اکسل بارگذاری کنید.
    </div>
  </div>
</div>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const toastEl = document.getElementById("liveToast");
    const toast = bootstrap.Toast.getOrCreateInstance(toastEl, {
      autohide: false
    });
    toast.show();

    setTimeout(() => {
      toast.hide();
    }, 5000); // Hide after 5 seconds
  });
</script>

<script src="<%=request.getContextPath()%>/bootstrap-5.3.7-dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>
</html>
