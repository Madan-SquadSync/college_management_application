import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nricse123/presentation/widgets/functions_for_sheets_snackbar_banners.dart';


List<List<String>> ListOfOutput = [];


class WorkingExcel {
  String filePath = '';
  FilePickerResult resultPicker = FilePickerResult([]);
   

  Future<String> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result != null) {
      resultPicker = result;
      filePath = result.files.single.path!;
      await readExcelDataConvertIntoList(context, filePath);
      return result.files.single.name;
    }
    return "";
  }

  Future<List<List<String>>> readExcel(String _filePath) async {
    var bytes = File(_filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List<List<String>> _excelData = [];
    var count = 0;
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        List<String> rowData = [];
        for (var cell in row) {
          if (cell?.value != null) {
            rowData.add(cell!.value.toString().trim());
          }
        }
        count++;
        if (rowData.length != 0 && count > 1) {
          _excelData.add(rowData);
        }
      }
    }

    // _excelData.removeAt(0);
    return _excelData;
  }

  Future<void> readExcelDataConvertIntoList(
      BuildContext context, String filePath) async {
    await readExcel(filePath).then((value) {
      ListOfOutput = value;
      print(value);
      showSnackbarScreen(context, "${ListOfOutput.length} rows");
    });
  }
}
