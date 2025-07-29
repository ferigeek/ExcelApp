package me.excelapp.excelapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        File excelFile = new File(getServletContext().getInitParameter("excelPath"));
        if (!excelFile.exists()) {
            resp.sendRedirect("upload?empty=true");
            return;
        }
        req.setAttribute("excelContent", showExcel());
        req.getRequestDispatcher("/WEB-INF/index.jsp").forward(req, resp);
    }

    private List<Row> showExcel() throws IOException {
        List<Row> excelRows = new ArrayList<>();

        String excelPath = getServletContext().getInitParameter("excelPath");
        try (FileInputStream fis = new FileInputStream(excelPath); Workbook workbook = new XSSFWorkbook(fis)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                if (row.getCell(0) != null) {
                    excelRows.add(row);
                } else {
                    break;
                }
            }
        }

        return excelRows;
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("_method");
        if (method != null && method.equals("DELETE")) {
            doDelete(req, resp);
            return;
        }
    }

    @Override
    public void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String rowNum = req.getParameter("rowNumber");
        ExcelRow.removeRow(Integer.parseInt(rowNum), getServletContext().getInitParameter("excelPath"));

        resp.sendRedirect(req.getContextPath() + "/index?success=true");
    }
}
