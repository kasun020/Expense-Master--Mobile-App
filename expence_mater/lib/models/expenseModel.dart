//@formatter:on
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'expenseModel.g.dart';

//create a unique id using uuid
final uuid = const Uuid().v4(); //To generate auto id

//date formatter
final formattedDate = DateFormat.yMd();

//enum for category
enum Categorys { food, travel, leasure, work }

//category's Icons
final CategoryIcons = {
  Categorys.food: Icons.lunch_dining,
  Categorys.leasure: Icons.leak_add,
  Categorys.travel: Icons.travel_explore,
  Categorys.work: Icons.work
};

@HiveType(typeId: 1)
class ExpenseModel {
  //construction
  ExpenseModel(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid;

  //fields > id, title, amount, date, category
  //HiveField is used to store the fields in the box
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Categorys category;

  //getter > formatted date
  String get getFormattedDate {
    return formattedDate.format(date);
  }
}
