import 'package:expence_mater_yt/models/expenseModel.dart';
import 'package:expence_mater_yt/server/database.dart';
import 'package:expence_mater_yt/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widgets/add_new_expense.dart';
import 'package:pie_chart/pie_chart.dart';

//@formatter:on
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  //
  final _myBox = Hive.box("expenseDatabase");
  Database db = Database();

//---------expenseList -------------
// final List<ExpenseModel> _expenseList = [
//   ExpenseModel(
//       amount: 12.5,
//       date: DateTime.now(),
//       title: "Football",
//       category: Categorys.leasure),
//   ExpenseModel(
//       amount: 10,
//       date: DateTime.now(),
//       title: "Carrot",
//       category: Categorys.food),
//   ExpenseModel(
//       amount: 11,
//       date: DateTime.now(),
//       title: "Bag",
//       category: Categorys.travel)
// ];
//---------dataMap -------------
  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Leasure": 0,
    "Work": 0,
  };

//add new expense
  void onAddNewExpense(ExpenseModel expense) {
    setState(() {
      //setState is a function that takes a function and updates the state of the widget
      db.expenseList.add(expense);
      calculatecategoryValues();
    });
    db.updateData();
  }

  //remove expense
  void onDeleteExpense(ExpenseModel expense) {
    //store the deleting expense
    ExpenseModel deletingExpense = expense;

    //get the index of the removing expense
    final int removingIndex = db.expenseList.indexOf(expense);

    setState(() {
      db.expenseList.remove(expense);
      db.updateData();
      calculatecategoryValues();
    });
    //show snack bar
    ScaffoldMessenger.of(contextBar(
      SnackBar(
        content: const Text("Delete Successfully!"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                db.expenseList.insert(removingIndex, deletingExpense);
                calculatecategoryValues();
              });
            }),
      ),
    );
  }

  //pie chart
  double foodValue = 0;
  double travelValue = 0;
  double leasureValue = 0;
  double workValue = 0;

  void calculatecategoryValues() {
    double foodValueTotal = 0;
    double travelValueTotal = 0;
    double leasureValueTotal = 0;
    double workValueTotal = 0;

    for (final expense in db.expenseList) {
      if (expense.category == Categorys.food) {
        foodValueTotal += expense.amount;
      }
      if (expense.category == Categorys.travel) {
        travelValueTotal += expense.amount;
      }
      if (expense.category == Categorys.leasure) {
        leasureValueTotal += expense.amount;
      }
      if (expense.category == Categorys.work) {
        workValueTotal += expense.amount;
      }
    }
    setState(() {
      foodValue = foodValueTotal;
      travelValue = travelValueTotal;
      leasureValue = leasureValueTotal;
      workValue = workValueTotal;
    });
    //update the dataMap
    dataMap = {
      "Food": foodValue,
      "Travel": travelValue,
      "Leasure": leasureValue,
      "Work": workValue,
    };
  }

//initState is a function that is called when the state of the widget is initialized
  @override
  void initState() {
    super.initState();
    //is this is the first time create the initial data
    if (_myBox.get("EXP_DATA") == null) {
      db.createInitialDatabase();
      calculatecategoryValues();
    } else {
      db.loadData();
      calculatecategoryValues();
    }
  }

  //function to open a modal overlay
  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      //showModalBottomSheet is a function that takes a context and a builder
      context: context,
      builder: (context) {
        return AddNewExpense(
          onAddExpense: onAddNewExpense,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense Master"),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          backgroundColor: Colors.purple,
          elevation: 0,
          actions: [
            Container(
                color: Colors.yellow,
                child: IconButton(
                  onPressed: _openAddExpensesOverlay,
                  icon: const Icon(Icons.add),
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          children: [
            PieChart(dataMap: dataMap),

            //Display the list of expenses
            ExpenseList(
              expenseList: db.expenseList,
              onDeleteExpense: onDeleteExpense,
            ),
          ],
        ));
  }
}
