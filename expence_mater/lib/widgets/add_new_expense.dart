import 'package:expence_mater_yt/models/expenseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddNewExpense extends StatefulWidget {
  final void Function(ExpenseModel expense) onAddExpense; //callback function

  const AddNewExpense({super.key, required this.onAddExpense});

  // onAddExpense is a function that takes no arguments and returns void
  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  //controllers for the text fields
  final _titleController = TextEditingController(); //controller for the title
  final _amountController =
      TextEditingController(); //controller for the amount  //TextEditingController pass the String to the text field
  Categorys _selectedCategory = Categorys.food; //default category

//date variables
  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
  DateTime _selectedDate = DateTime.now();

  //date picker function
  Future<void> _openDateModal() async {
    try {
      //show the date model then store the user selected date
      final pickedDate = await showDatePicker(
          context: context, firstDate: firstDate, lastDate: lastDate);

      //if the user selected a date then update the state
      setState(() {
        _selectedDate = pickedDate!;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  //handle form submission  //function to handle form submission
  void _handleFormSubmit() {
    //form validation
    //convert the amount to double
    final userAmount = double.parse(_amountController.text.trim());
    if (_titleController.text.trim().isEmpty || userAmount <= 0) {
      showDialog(
          //show a dialog if the user enters invalid data
          context: context,
          builder: (context) {
            return (AlertDialog(
              title: const Text("Enter Valid Data"),
              content: const Text("Please enter a valid title and amount."
                  "Also make sure the amount is greater than 0 "
                  "and don't leave the fields empty of title and amount"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"))
              ],
            ));
          });
    } else {
      //create the new expense
      ExpenseModel newExpense = ExpenseModel(
          amount: userAmount,
          date: _selectedDate,
          title: _titleController.text.trim(),
          category: _selectedCategory);
      //Save the data and create new response
      widget.onAddExpense(
          newExpense); //widget is a reference to the current stateful widget
      Navigator.pop(context);
    }
  }

  @override //dispose the controller
  void dispose() {
    //remove memory leaks by disposing the controller
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          //title text field
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                hintText: "Add new expense title", label: Text("Title")),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
              //amount
              Expanded(
                //to take the remaining space
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    hintText: "Enter the Amount",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              //date picker
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(formattedDate.format(_selectedDate)),
                  IconButton(
                      onPressed: _openDateModal,
                      icon: const Icon(Icons.date_range_outlined))
                ],
              ))
            ],
          ),
          //category
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Categorys.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {});
                  _selectedCategory = value!;
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.redAccent),
                      ),
                      child: Text("Close"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _handleFormSubmit,
                      child: Text("Save"),
                      style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.greenAccent),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
