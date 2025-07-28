package me.excelapp.excelapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/edit")
public class UserEditServlet extends HttpServlet{
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String rowNum = req.getParameter("rowNumber");
        String excelPath = getServletContext().getInitParameter("excelPath");
        req.setAttribute("rowContent", ExcelRow.getRow(Integer.parseInt(rowNum), excelPath));
        req.getRequestDispatcher("/WEB-INF/edit.jsp").forward(req, resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String firstName =  req.getParameter("first_name");
            String lastName = req.getParameter("last_name");
            String nationalCode = req.getParameter("national_code");
            String birthDate = req.getParameter("birth_date").replace("-", "/");
            String rowNum =  req.getParameter("rowNum");
            String excelPath = getServletContext().getInitParameter("excelPath");

            ExcelRow editedRow = new ExcelRow(firstName,lastName,nationalCode,birthDate,excelPath);
            editedRow.editRow(Integer.parseInt(rowNum));

            req.setAttribute("success", true);
            req.getRequestDispatcher("/WEB-INF/edit.jsp").forward(req, resp);
        } catch (Exception ex) {
            req.setAttribute("success", false);
            req.setAttribute("message", ex.getMessage());
            req.getRequestDispatcher("/WEB-INF/edit.jsp").forward(req, resp);
        }
    }
}
