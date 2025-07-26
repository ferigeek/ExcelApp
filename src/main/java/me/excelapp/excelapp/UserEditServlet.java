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
        req.setAttribute("rowContent", ExcelRow.getRow(Integer.parseInt(rowNum)));
        req.getRequestDispatcher("/WEB-INF/edit.jsp").forward(req, resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName =  req.getParameter("first_name");
        String lastName = req.getParameter("last_name");
        String nationalCode = req.getParameter("national_code");
        String birthDate = req.getParameter("birth_date").replace("-", "/");
        String rowNum =  req.getParameter("rowNum");

        ExcelRow editedRow = new ExcelRow(firstName,lastName,nationalCode,birthDate);
        editedRow.editRow(Integer.parseInt(rowNum));

        req.getRequestDispatcher("/WEB-INF/edit.jsp").forward(req, resp);
    }
}
