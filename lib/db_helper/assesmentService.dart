import 'package:dra_project/db_helper/database_repository.dart';
import 'package:dra_project/models/AssesmentDataBaseModel.dart';

class AssesmentService {
  late DataBaseRepository _repository;
  AssesmentService() {
    _repository = DataBaseRepository();
  }
  //Save User
  SaveUser(AssesmentDataBaseModel user) async {
    print(user.toString());
    return await _repository.insertData('users', user.userMap());
  }

  //Read All Users
  readAllUsers() async {
    return await _repository.readData('users');
  }

  //Edit User
  UpdateUser(AssesmentDataBaseModel user) async {
    return await _repository.updateData('users', user.userMap());
  }

  findUser(name) async {
    return await _repository.queryRows('users', name);
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }
}
