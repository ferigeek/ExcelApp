<%@ page import="java.util.List" %>
<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

<div class="table-responsive" style="margin-top: 5%; margin-left: 1%; margin-right: 1%;">
    <table class="table table-striped-columns" border="1">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">نام</th>
            <th scope="col">نام خانوادگی</th>
            <th scope="col">کد ملّی</th>
            <th scope="col">تاریخ تولد</th>
            <th scope="col">عملیات</th>
        </tr>
        <tr>
            <form action="search" method="GET">
                <th scope="col">
                    <div class="mb-1">
                        جست و جو
                    </div>
                </th>
                <th scope="col">
                    <div class="mb-1">
                        <input type="text" name="first_name_search" class="form-control form-control-sm"
                               placeholder="جست و جوی نام">
                    </div>
                </th>
                <th scope="col">
                    <div class="mb-1">
                        <input type="text" name="last_name_search" class="form-control form-control-sm"
                               placeholder="جست و جوی نام خانوادگی">
                    </div>
                </th>
                <th scope="col">
                    <div class="mb-1">
                        <input type="number" name="national_code_search" class="form-control form-control-sm"
                               placeholder="جست و جوی کد ملّی">
                    </div>
                </th>
                <th scope="col">
                    <div class="mb-1 d-flex gap-2">
                        <input type="date" name="birth_date_search_start"
                               class="form-control form-control-sm"
                               style="width: 50%;" placeholder="از">
                        <input type="date" name="birth_date_search_end"
                               class="form-control form-control-sm"
                               style="width: 50%;" placeholder="تا">
                    </div>
                </th>
                <th scope="col">
                    <div class="mb-1">
                        <button type="submit" class="btn btn-outline-light btn-sm">جست و جو</button>
                    </div>
                </th>
            </form>
        </tr>
        </thead>
        <tbody>
        <%
            List<Row> excelContent = (List<Row>) request.getAttribute("excelContent");
            if (excelContent != null) {
                for (Row row : excelContent) {
        %>
        <tr>
            <th scope="row"><%=row.getRowNum()%>
            </th>
            <%
                for (Cell cell : row) {
            %>
            <td><%=cell.toString()%>
            </td>
            <%
                }
            %>
            <td>
                <form method="GET" action="edit" class="d-inline">
                    <input type="hidden" name="rowNumber" value="<%=row.getRowNum()%>">
                    <button type="submit" class="btn btn-outline-info" aria-label="ویرایش کاربر">ویرایش</button>
                </form>
                <form method="POST" class="d-inline">
                    <input type="hidden" name="_method" value="DELETE">
                    <input type="hidden" name="rowNumber" value="<%=row.getRowNum()%>">
                    <button type="submit" class="btn btn-outline-danger" aria-label="حذف کاربر">حذف</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<%
    String deleteResult = request.getParameter("success");
    if (deleteResult != null && deleteResult.equals("true")) {
%>

<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="liveToast" class="toast bg-success" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <img src="<%=request.getContextPath()%>/images/cloud-check.svg" class="rounded me-2" alt="حذف کاربر">
            <strong class="me-auto">حذف کاربر</strong>
            <small>نتیجه</small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="بستن"></button>
        </div>
        <div class="toast-body">
            حذف کاربر با موفقیت انجام شد!
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
    }
%>

<script src="<%=request.getContextPath()%>/bootstrap-5.3.7-dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>
</html>