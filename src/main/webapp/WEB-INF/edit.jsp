<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html dir="rtl" lang="fa" data-bs-theme="dark">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ویرایش</title>
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
                </ul>
            </div>
        </div>
    </nav>
</div>
<!--/Navbar Section-->

<%
    if (request.getMethod().equals("GET")) {
        Row row = (Row) request.getAttribute("rowContent");
        if (row != null) {
%>

<form method="POST"
      style="margin-top: 5%; margin-right: 25%; margin-left: 25%; padding-top: 1%; padding-right: 10%; padding-left: 10%;">
    <div class="mb-3">
        <label for="firstNameInput" class="form-label">نام</label>
        <input type="text" class="form-control" id="firstNameInput" aria-describedby="firstNameHelp"
               value="<%=row.getCell(0).getStringCellValue()%>" name="first_name" pattern="^[\u0600-\u06FF\s]+$"
               title="نام شما تنها باید با حروف فارسی باشد!" required>
        <div id="firstNameHelp" class="form-text">نام خود را در این قسمت ویرایش کنید.</div>
    </div>
    <div class="mb-3">
        <label for="lastNameInput" class="form-label">نام خانوادگی</label>
        <input type="text" class="form-control" id="lastNameInput" aria-describedby="lastNameHelp"
               value="<%=row.getCell(1).getStringCellValue()%>" name="last_name" pattern="^[\u0600-\u06FF\s]+$"
               title="نام خانوادگی شما تنها باید با حروف فارسی باشد!" required>
        <div id="lastNameHelp" class="form-text">نام خانوادگی خود را در این قسمت ویرایش کنید.</div>
    </div>
    <div class="mb-3">
        <label for="nationalCodeInput" class="form-label">کد ملّی</label>
        <input type="number" class="form-control" id="nationalCodeInput" aria-describedby="nationalCodeHelp"
               value="<%=row.getCell(2).toString()%>" name="national_code" required>
        <div id="nationalCodeHelp" class="form-text">کد ملّی خود را در این قسمت ویرایش کنید.</div>
    </div>
    <div class="mb-3">
        <label for="birthDateInput" class="form-label">تاریخ تولد</label>
        <input type="date" class="form-control" id="birthDateInput" aria-describedby="birthDateHelp"
               value="<%=row.getCell(3).getStringCellValue().replace('/', '-')%>" name="birth_date" dir="ltr" required>
        <div id="birthDateHelp" class="form-text">تاریخ تولد خود را در این قسمت ویرایش کنید.</div>
    </div>
    <input type="hidden" name="rowNum" value="<%=row.getRowNum()%>">
    <button type="submit" class="btn btn-outline-success">تایید</button>
    <button type="button" onclick="history.back()" class="btn btn-outline-danger">لغو</button>
</form>

<%
    }
} else if (request.getMethod().equals("POST")) {
%>

<form style="margin-top: 5%; margin-right: 25%; margin-left: 25%; padding-top: 1%; padding-right: 10%; padding-left: 10%;">
    <div class="mb-3">
        <label for="firstNameInput" class="form-label">نام</label>
        <input type="text" class="form-control" id="firstNameInput" aria-describedby="firstNameHelp"
               value="<%=request.getParameter("first_name")%>" readonly>
    </div>
    <div class="mb-3">
        <label for="lastNameInput" class="form-label">نام خانوادگی</label>
        <input type="text" class="form-control" id="lastNameInput" aria-describedby="lastNameHelp"
               value="<%=request.getParameter("last_name")%>" readonly>
    </div>
    <div class="mb-3">
        <label for="nationalCodeInput" class="form-label">کد ملّی</label>
        <input type="text" class="form-control" id="nationalCodeInput" aria-describedby="nationalCodeHelp"
               value="<%=request.getParameter("national_code")%>" readonly>
    </div>
    <div class="mb-3">
        <label for="birthDateInput" class="form-label">تاریخ تولد</label>
        <input type="date" class="form-control" id="birthDateInput" aria-describedby="birthDateHelp"
               value="<%=request.getParameter("birth_date")%>" dir="ltr" readonly>
    </div>
    <a href="index"><button type="button" class="btn btn-outline-primary">بازگشت به خانه</button></a>
    <button type="button" onclick="history.back()" class="btn btn-outline-warning">بازگشت</button>
</form>

<%
    boolean success = (boolean) request.getAttribute("success");
    if (success) {
%>
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="liveToast" class="toast bg-success" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <img src="<%=request.getContextPath()%>/images/cloud-check.svg" class="rounded me-2"
                 alt="ویرایش کاربر">
            <strong class="me-auto">ویرایش کاربر</strong>
            <small>نتیجه</small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="بستن"></button>
        </div>
        <div class="toast-body">
            کاربر با موفقیت ویرایش شد!
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
<%
} else {
        String message = (String) request.getAttribute("message");
%>

<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="liveToast" class="toast bg-danger" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <img src="<%=request.getContextPath()%>/images/cloud-slash.svg" class="rounded me-2"
                 alt="ویرایش کاربر">
            <strong class="me-auto">ویرایش کاربر</strong>
            <small>نتیجه</small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="بستن"></button>
        </div>
        <div class="toast-body"><%=message%></div>
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

<%
        }
    }
%>

<script src="<%=request.getContextPath()%>/bootstrap-5.3.7-dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>
</html>