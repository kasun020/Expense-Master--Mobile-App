import 'package:expence_mater_yt/models/expenseModel.dart';
import 'package:flutter/material.dart';

//@formatter:on
class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(expense.amount.toStringAsFixed(2)),
                const Spacer(),
                Icon(CategoryIcons[expense.category]),
                const SizedBox(
                  width: 8,
                ),
                Text(expense.getFormattedDate)
              ],
            )
          ],
        ),
      ),
    );
  }
}
