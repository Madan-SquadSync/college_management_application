import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:nricse123/common/custom_snack_bar.dart';
import 'package:nricse123/common/data.dart';

class RetrieveBatchData {
  Future<List<String>> retrieveBatch(BuildContext context) async {
    List<String> batchNames = [];

    try {
      final batchRef = await database.child('Batch');
      DatabaseEvent databaseEvent = await batchRef.once();

      if (databaseEvent.snapshot.value != null) {
        Map<dynamic, dynamic> batchMap = databaseEvent.snapshot.value as Map;
        batchNames = batchMap.values
            .map<String>((batch) => batch['name'] as String)
            .toList();
         
        return batchNames;
      } else {
        return [];
      }
    } catch (error) {
      CustomSnackBar().show(context, error.toString());
      return batchNames;
    }
  }
}
