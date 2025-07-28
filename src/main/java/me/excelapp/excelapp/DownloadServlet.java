package me.excelapp.excelapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/download")
public class DownloadServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String excelPath = getServletContext().getInitParameter("excelPath");
        File file = new File(excelPath);
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }

        resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        resp.setHeader("Content-Disposition", "attachment; filename=\"result.xlsx\"");
        resp.setContentLengthLong(file.length());
        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
             OutputStream out = resp.getOutputStream()) {
            byte[] buffer = new byte[8192];
            // reads the file chunk by chunk (8 KB at a time), and writes each chunk to the HTTP response.

            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
