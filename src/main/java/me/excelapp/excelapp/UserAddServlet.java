package me.excelapp.excelapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/adduser")
public class UserAddServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/adduser.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String firstName = req.getParameter("first_name");
            String lastName = req.getParameter("last_name");
            String nationalCode = req.getParameter("national_code");
            String birthDate = req.getParameter("birth_date").replace('-', '/');
            String excelPath = getServletContext().getInitParameter("excel_path");

            ExcelRow newRow = new  ExcelRow(firstName,lastName,nationalCode,birthDate,excelPath);
            newRow.addToExcel();

            req.setAttribute("success", true);
            req.getRequestDispatcher("/WEB-INF/adduser.jsp").forward(req,resp);
        } catch (Exception ex) {
            req.setAttribute("success", false);
            req.setAttribute("message", ex.getMessage());
            req.getRequestDispatcher("/WEB-INF/adduser.jsp").forward(req,resp);
        }
    }
}
