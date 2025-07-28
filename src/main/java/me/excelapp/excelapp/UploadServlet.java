package me.excelapp.excelapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part part = req.getPart("excel_file_upload");
        String uploadPath = getServletContext().getInitParameter("excelPath");

        if (uploadPath == null) {
            throw new ServletException("Upload path is not configured.");
        }

        part.write(uploadPath);
        resp.sendRedirect("index");
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/upload.jsp").forward(req,resp);
    }
}
