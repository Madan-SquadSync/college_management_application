 
import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart';

class ExcelOperations {
  Future<List<List<String>>> parseExcelFile(Uint8List excelBytes) async {
    List<List<String>> resultList = [];
    final excel = Excel.decodeBytes(excelBytes);

    // Assume we only take the first sheet
    final sheet = excel.tables.keys.first;
    final rows = excel.tables[sheet]!.rows;

    // Parse the rows
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      List<String> rowData = [];
      for (var j = 0; j < row.length; j++) {
        rowData.add(
            row[j]?.value?.toString() ?? ''); // Convert cell value to string
      }
      resultList.add(rowData);
    }
    return resultList;
  }

  Future<List<List<String>>> parseExcelFileFromDropDragFile(
      Uint8List excelBytes) async {
    String encodedString =
        utf8.decode(excelBytes); // Assuming the data is UTF-8 encoded
    List<String> items = encodedString.split('\n');
    List<List<String>> resultList = [];
    for (String item in items) {
      List<String> eachItem =
          item.split(','); // Assuming items are in key:value format
      resultList.add(eachItem);
    }
    return resultList;
  }
}

 