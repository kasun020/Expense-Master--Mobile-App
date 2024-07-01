import 'package:expence_mater_yt/server/categories_adapter.dart';
import 'package:flutter/material.dart';
import 'models/expenseModel.dart';
import 'pages/expenses.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  //Hive
  await Hive.initFlutter(); //initialize hive

  //register the adapter
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  await Hive.openBox("expenseDatabase"); //open the box

  runApp(const MainApp()); //run the app
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expenses(), //custom widget
    );
  }
}
