<%--
  Created by IntelliJ IDEA.
  User: farnam
  Date: 7/27/25
  Time: 1:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell" %>
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
                        <%
                            String sfName = request.getParameter("first_name_search");
                            if (sfName != null && !sfName.isEmpty()) {
                        %>
                        <input type="text" name="first_name_search" class="form-control form-control-sm" placeholder="جست و جوی نام" value="<%=sfName%>">
                        <%
                            } else {
                        %>
                        <input type="text" name="first_name_search" class="form-control form-control-sm" placeholder="جست و جوی نام">
                        <%
                            }
                        %>

                    </div>
                </th>
                <th scope="col">
                    <div class="mb-1">
                        <%
                            String slName = request.getParameter("last_name_search");
                            if (slName != null && !slName.isEmpty()) {
                        %>
                        <input type="text" name="last_name_search" class="form-control form-control-sm" placeholder="جست و جوی نام خانوادگی" value="<%=slName%>">
                        <%
                            } else {
                        %>
                        <input type="text" name="last_name_search" class="form-control form-control-sm" placeholder="جست و جوی نام خانوادگی">
                        <%
                            }
                        %>
                    </div>
                </th>
                <th scope="col">
                    <div class="mb-1">
                        <%
                            String snCode = request.getParameter("national_code_search");
                            if (snCode != null && !snCode.isEmpty()) {
                        %>
                        <input type="number" name="national_code_search" class="form-control form-control-sm" placeholder="جست و جوی کد ملّی" value="<%=snCode%>">
                        <%
                            } else {
                        %>
                        <input type="number" name="national_code_search" class="form-control form-control-sm" placeholder="جست و جوی کد ملّی">
                        <%
                            }
                        %>
                    </div>
                </th>
                <th scope="col">
                    <div class="mb-1 d-flex gap-2">
                        <%
                            String sStart = request.getParameter("birth_date_search_start");
                            if (sStart != null && !sStart.isEmpty()) {
                        %>
                        <input type="date" name="birth_date_search_start" class="form-control form-control-sm" style="width: 50%;" placeholder="از" value="<%=sStart%>">
                        <%
                            } else {
                        %>
                        <input type="date" name="birth_date_search_start" class="form-control form-control-sm" style="width: 50%;" placeholder="از">
                        <%
                            }
                        %>

                        <%
                            String sEnd = request.getParameter("birth_date_search_end");
                            if (sEnd != null && !sEnd.isEmpty()) {
                        %>
                        <input type="date" name="birth_date_search_end" class="form-control form-control-sm" style="width: 50%;" placeholder="از" value="<%=sEnd%>">
                        <%
                        } else {
                        %>
                        <input type="date" name="birth_date_search_end" class="form-control form-control-sm" style="width: 50%;" placeholder="از">
                        <%
                            }
                        %>
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
            List<Row> excelContent = (List<Row>) request.getAttribute("search_result");
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

<script src="<%=request.getContextPath()%>/bootstrap-5.3.7-dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>
</html>