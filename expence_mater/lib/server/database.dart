import 'package:hive_flutter/hive_flutter.dart';
import '../models/expenseModel.dart';

class Database {
  //create a database reference
  final _myBox = Hive.box("expenseDatabase");

  List<ExpenseModel> expenseList = []; //list of expenses

//create the init expense list function
  void createInitialDatabase() {
    expenseList = [
      ExpenseModel(
          amount: 12.5,
          date: DateTime.now(),
          title: "Football",
          category: Categorys.leasure),
      ExpenseModel(
          amount: 10,
          date: DateTime.now(),
          title: "Carrot",
          category: Categorys.food),
      ExpenseModel(
          amount: 11,
          date: DateTime.now(),
          title: "Bag",
          category: Categorys.travel)
    ];
  }

//load the data
  void loadData() {
    final dynamic data = _myBox.get("EXP_DATA"); //get the data from the box
    //Validate the data
    if (data != null && data is List<dynamic>) {
      expenseList = data
          .cast<ExpenseModel>()
          .toList(); //cast the data to the list of expense model
    }
  }

  //update the data
  Future<void> updateData() async {
    await _myBox.put("EXP_DATA", expenseList);
    print("data saved");
  }
}
