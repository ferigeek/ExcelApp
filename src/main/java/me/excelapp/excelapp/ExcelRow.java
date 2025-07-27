package me.excelapp.excelapp;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class ExcelRow {
    private String firstName;
    private String lastName;
    private String nationalCode;
    private LocalDate birthDate;

    public ExcelRow(String firstName, String lastName, String nationalCode, String birthDate) throws IllegalArgumentException {
        String persianPattern = "^[\\u0600-\\u06FF\\u067E\\u0686\\u06AF\\u200C]+$";

        // First name validation
        if (firstName != null && firstName.length() > 1 && firstName.matches(persianPattern)) {
            this.firstName = firstName;
        } else {
            throw new IllegalArgumentException("نام باید با حروف فارسی و با طول بیشتر از یک باشد!");
        }

        // Last name validation
        if (lastName != null && lastName.length() > 1 && lastName.matches(persianPattern)) {
            this.lastName = lastName;
        } else {
            throw new IllegalArgumentException("نام خانوادگی باید با حروف فارسی و با طول بیشتر از یک باشد!");
        }

        // National code validation
        if (nationalCode != null && nationalCode.length() == 10 && nationalCode.matches("^\\d+$")) {
            this.nationalCode = nationalCode;
        } else {
            throw new IllegalArgumentException("کد ملی باید با طول ۱۰ و شامل اعداد انگلیسی باشد!");
        }

        // Birthdate validation
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        LocalDate date = LocalDate.parse(birthDate, dtf);
        if (!date.isAfter(LocalDate.now())) {
            this.birthDate = date;
        }
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getNationalCode() {
        return nationalCode;
    }

    public String getBirthDate() {
        return birthDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
    }

    public void addToExcel() throws IOException, IllegalArgumentException{
        Workbook workbook;
        try (FileInputStream fis = new FileInputStream(Config.excelPath)) {
            workbook = new XSSFWorkbook(fis);
        }

        Sheet sheet = workbook.getSheetAt(0);

        // National code duplication check
        for (Row row : sheet) {
            Cell ncCell =  row.getCell(2);
            if (ncCell != null && ncCell.toString().equals(this.nationalCode)) {
                throw new IllegalArgumentException("کد ملی تکراری نمی‌تواند باشد!");
            }
            if (ncCell == null) {
                break;
            }
        }

        Row newRow = sheet.createRow(sheet.getLastRowNum() + 1);

        newRow.createCell(0).setCellValue(getFirstName());
        newRow.createCell(1).setCellValue(getLastName());
        newRow.createCell(2).setCellValue(getNationalCode());
        newRow.createCell(3).setCellValue(getBirthDate());

        try (FileOutputStream fos = new FileOutputStream(Config.excelPath)) {
            workbook.write(fos);
        }

        workbook.close();
    }

    /**
     * Removes a specific row by shifting following rows down,
     * and removes the last row at last.
     * @param rowNum
     * @throws IOException
     */
    public static void removeRow(int rowNum) throws IOException {
        Workbook workbook;

        try (FileInputStream fis = new FileInputStream(Config.excelPath)) {
            workbook = new XSSFWorkbook(fis);
        }

        Sheet sheet = workbook.getSheetAt(0);
        int lastRowNum = sheet.getLastRowNum();

        if (rowNum >= 0 && rowNum <= lastRowNum) {
            if (rowNum < lastRowNum) {
                sheet.shiftRows(rowNum + 1, lastRowNum, -1);
            }

            Row lastRow = sheet.getRow(lastRowNum);
            if (lastRow != null) {
                sheet.removeRow(lastRow);
            }
        }

        try (FileOutputStream fos = new FileOutputStream(Config.excelPath)) {
            workbook.write(fos);
        }

        workbook.close();
    }

    public static Row getRow(int rowNum) throws IOException {
        try (FileInputStream fis = new FileInputStream(Config.excelPath)) {
            Workbook workbook = new XSSFWorkbook(fis);
            Sheet sheet = workbook.getSheetAt(0);
            return sheet.getRow(rowNum);
        }
    }

    public void editRow(int rowNum) throws IOException, IllegalArgumentException {
        Workbook workbook;

        try (FileInputStream file = new FileInputStream(Config.excelPath)) {
            workbook = new XSSFWorkbook(file);
        }

        Sheet sheet = workbook.getSheetAt(0);
        Row row = sheet.getRow(rowNum);

        // National duplication check
        for (Row r : sheet) {
            Cell ncCell = r.getCell(2);
            if (ncCell != null && r.getRowNum() != rowNum && ncCell.toString().equals(this.nationalCode)) {
                throw new IllegalArgumentException("کد ملّی تکراری نمی‌تواند باشد!");
            }
            if (ncCell == null) {
                break;
            }
        }

        row.getCell(0).setCellValue(getFirstName());
        row.getCell(1).setCellValue(getLastName());
        row.getCell(2).setCellValue(getNationalCode());
        row.getCell(3).setCellValue(getBirthDate());

        try (OutputStream outputStream = new FileOutputStream(Config.excelPath)) {
            workbook.write(outputStream);
        }

        workbook.close();
    }
}
