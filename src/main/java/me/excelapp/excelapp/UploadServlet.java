package me.excelapp.excelapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    private static final String TEMP_UPLOAD_PARAM = "tempUploadDir";
    private static final String EXCEL_PATH_PARAM = "excelPath";

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part part = req.getPart("excel_file_upload");
        String uploadPath = getServletContext().getInitParameter(TEMP_UPLOAD_PARAM);
        String excelPath = getServletContext().getInitParameter(EXCEL_PATH_PARAM);

        if (uploadPath == null) {
            throw new ServletException("Upload path is not configured.");
        }
        if (excelPath == null) {
            throw new ServletException("Excel path is not configured.");
        }

        String uploadFileName = part.getSubmittedFileName();
        if (uploadFileName.endsWith(".xlsx")) {
            part.write(uploadPath + File.separator + "temp_" + uploadFileName);
            File uploadFile = new File(uploadPath + File.separator + "temp_" + uploadFileName);
            if (isUploadValid(uploadFile)) {
                File excelFile = new File(excelPath);
                if (excelFile.exists()) {
                    excelFile.delete();
                }
                Files.copy(uploadFile.toPath(), excelFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                uploadFile.delete();
            } else {
                uploadFile.delete();
                req.setAttribute("error", true);
                req.setAttribute("error_message", "فایل بارگذاری شده نامعتبر است!");
                req.getRequestDispatcher("/WEB-INF/upload.jsp").forward(req, resp);
                return;
            }
        } else {
            req.setAttribute("error", true);
            req.setAttribute("error_message", "تنها فایل های اکسل مورد قبول است!");
            req.getRequestDispatcher("/WEB-INF/upload.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect("index");
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/upload.jsp").forward(req,resp);
    }

    private boolean isUploadValid(File uploadFile) throws IOException {
        try (FileInputStream fis = new FileInputStream(uploadFile); Workbook workbook = new XSSFWorkbook(fis)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                try {
                    ExcelRow currentRow =  new ExcelRow(
                            row.getCell(0).toString(),
                            row.getCell(1).toString(),
                            row.getCell(2).toString(),
                            row.getCell(3).toString(),
                            getServletContext().getInitParameter(TEMP_UPLOAD_PARAM)
                                    + File.separator + uploadFile.getName()
                    );
                } catch (Exception e) {
                    return false;
                }
            }
        }
        return true;
    }
}
