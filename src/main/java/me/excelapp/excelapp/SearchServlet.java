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

import java.io.FileInputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("first_name_search");
        String lastName = req.getParameter("last_name_search");
        String nationalCode = req.getParameter("national_code_search");
        String startDate = req.getParameter("birth_date_search_start");
        String endDate = req.getParameter("birth_date_search_end");

        if (firstName != null || lastName != null || nationalCode != null || startDate != null || endDate != null) {
            req.setAttribute("search_result", getSearchResult(firstName, lastName, nationalCode, startDate, endDate));
        }
        req.getRequestDispatcher("/WEB-INF/search.jsp").forward(req, resp);
    }

    private List<Row> getSearchResult(String firstName, String lastName, String nationalCode, String startDate, String endDate) throws IOException {
        List<Row> excelRows = new ArrayList<>();

        try (FileInputStream fis = new FileInputStream(Config.excelPath); Workbook workbook = new XSSFWorkbook(fis)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                if (firstName != null && !firstName.isEmpty() && row.getCell(0).getStringCellValue().contains(firstName)) {
                    excelRows.add(row);
                    continue;
                }
                if (lastName != null && !lastName.isEmpty() && row.getCell(1).getStringCellValue().contains(lastName)) {
                    excelRows.add(row);
                    continue;
                }
                if (nationalCode != null && !nationalCode.isEmpty() && row.getCell(2).toString().contains(nationalCode)) {
                    excelRows.add(row);
                    continue;
                }
                if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
                    LocalDate start = LocalDate.parse(startDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    LocalDate end = LocalDate.parse(endDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    LocalDate rowDate = LocalDate.parse(row.getCell(3).toString(), DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                    if (!rowDate.isBefore(start) && !rowDate.isAfter(end)) {
                        excelRows.add(row);
                    }
                } else if (startDate != null && !startDate.isEmpty()) {
                    LocalDate start = LocalDate.parse(startDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    LocalDate rowDate = LocalDate.parse(row.getCell(3).toString(), DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                    if (!rowDate.isBefore(start)) {
                        excelRows.add(row);
                    }
                } else if (endDate != null && !endDate.isEmpty()) {
                    LocalDate end = LocalDate.parse(endDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    LocalDate rowDate = LocalDate.parse(row.getCell(3).toString(), DateTimeFormatter.ofPattern("yyyy/MM/dd"));
                    if (!rowDate.isAfter(end)) {
                        excelRows.add(row);
                    }
                }
            }
        }
        return excelRows;
    }
}
