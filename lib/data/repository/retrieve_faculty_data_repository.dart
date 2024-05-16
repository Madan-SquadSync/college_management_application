import 'package:flutter/src/widgets/framework.dart';
import 'package:nricse123/bussiness/entites/faculty_data_entity.dart';
import 'package:nricse123/bussiness/repository/faculty_bussiness_repository.dart';
import 'package:nricse123/data/data_source/firebase_api_service_for_retrieve_List_of_faculty_Model.dart';

class RetrieveFacultyDataRepository
    implements RetrieveFacultyDataBussinessRepository {
  final FirebaseApiServiceForRetrieveListOfFacultyModel
      firebaseApiServiceForRetrieveListOfFacultyModel;

  RetrieveFacultyDataRepository(
      {required this.firebaseApiServiceForRetrieveListOfFacultyModel});
  @override
  Future<List<FacultyEntity>> retrieveFacultyDetails(
      BuildContext context) async {
    final listOfFacultyModels =
        await firebaseApiServiceForRetrieveListOfFacultyModel
            .getFacultyList(context);
    List<FacultyEntity> temp = [];

    // Use map function correctly to convert each FacultyModel to FacultyEntity
    listOfFacultyModels
        .map((e) => temp.add(FacultyEntity(
              name: e.name,
              previousExperience: e.previousExperience,
              mobileNumber: e.mobileNumber,
              mailId: e.mailId,
              subjects: e.subjects,
            )))
        .toList(); // Ensure to call toList() to execute the map operation

    print(temp);
    return temp;
  }
}
