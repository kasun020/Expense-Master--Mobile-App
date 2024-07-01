import 'package:expence_mater_yt/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:expence_mater_yt/models/expenseModel.dart'; //import the model

//@formatter:on
class ExpenseList extends StatelessWidget {
  //list of expenses
  final List<ExpenseModel> expenseList;

  //required this.expenseList - the list of expenses
  // List<ExpenseModel> is the type   //expenseList is the name

  //function to delete the expense
  final void Function(ExpenseModel expense) onDeleteExpense;

  //constructor
  const ExpenseList(
      {super.key, required this.expenseList, required this.onDeleteExpense});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //to take the remaining space
      child: ListView.builder(
          itemCount: expenseList.length, //length of the list
          itemBuilder: (context, index) {
            //index of the list   //context - the current widget
            //create card
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Dismissible(
                key: ValueKey(expenseList[index]),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  onDeleteExpense(expenseList[index]); //delete the expense
                },
                child: ExpenseTile(
                  expense: expenseList[index], //pass the expense
                ),
              ),
            );
          }),
    );
  }
}
