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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.rtl.min.css"
          integrity="sha384-Xbg45MqvDIk1e563NLpGEulpX6AvL404DP+/iCgW9eFa2BqztiwTexswJo2jLMue" crossorigin="anonymous">
</head>
<body>
<!--Navbar Section-->
<div>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%=request.getContextPath()%>">
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
                        <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>">خانه</a>
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

<div style="margin-left: 5%; margin-right: 5%; margin-top: 1%;" data-bs-spy="scroll">
    <table class="table" border="1">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">نام</th>
            <th scope="col">نام خانوادگی</th>
            <th scope="col">کد ملّی</th>
            <th scope="col">تاریخ تولد</th>
            <th scope="col">عملیات</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Row> excelContent = (List<Row>) request.getAttribute("excelContent");
            if (excelContent != null) {
                for (Row row : excelContent) {
        %>
        <tr>
            <th scope="row"><%=row.getRowNum()%></th>
            <%
                for (Cell cell : row) {
            %>
            <td><%=cell.getStringCellValue()%></td>
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
                    <input type="hidden" name="rowNumer" value="<%=row.getRowNum()%>">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
        crossorigin="anonymous"></script>
</body>
</html>