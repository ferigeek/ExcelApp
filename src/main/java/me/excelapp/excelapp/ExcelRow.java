package me.excelapp.excelapp;

import jakarta.servlet.ServletContext;
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

    public void addToExcel() throws IOException {
        FileInputStream fis = new FileInputStream(Config.excelPath);
        Workbook workbook = new XSSFWorkbook(fis);
        Sheet sheet = workbook.getSheetAt(0);

        Row newRow = sheet.createRow(sheet.getLastRowNum() + 1);

        newRow.createCell(0).setCellValue(getFirstName());
        newRow.createCell(1).setCellValue(getLastName());
        newRow.createCell(2).setCellValue(getNationalCode());
        newRow.createCell(3).setCellValue(getBirthDate());

        try {
            OutputStream outputStream = new FileOutputStream(Config.excelPath);
            workbook.write(outputStream);
            workbook.close();
        } catch (IOException e) {
            workbook.close();
            throw e;
        }
    }

    public static void removeRow(int rowNum) throws IOException, IllegalStateException {
        FileInputStream file = new FileInputStream(Config.excelPath);
        Workbook workbook = new XSSFWorkbook(file);
        Sheet sheet = workbook.getSheetAt(0);
        sheet.removeRow(sheet.getRow(rowNum));

        // Removing the empty rows by replacing the empty row with the last row.
        for (int i = 0; i < sheet.getLastRowNum(); i++) {
            if (sheet.getRow(i).getCell(0) == null) {
                Row lastRow = sheet.getRow(sheet.getLastRowNum());
                Row currentRow = sheet.getRow(i);

                currentRow.getCell(0).setCellValue(lastRow.getCell(0).getStringCellValue());
                currentRow.getCell(1).setCellValue(lastRow.getCell(1).getStringCellValue());
                currentRow.getCell(2).setCellValue(lastRow.getCell(2).getStringCellValue());
                currentRow.getCell(3).setCellValue(lastRow.getCell(3).getStringCellValue());

                sheet.removeRow(sheet.getRow(sheet.getLastRowNum()));
            }
        }
    }
}
