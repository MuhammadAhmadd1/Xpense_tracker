//for outputting individual list items
import 'package:flutter/material.dart';
import 'package:xtrack/modle/expense_structure.dart';

class ExpenseItems extends StatelessWidget {
  const ExpenseItems(this.expense, {super.key});
  final ExpenseStructure expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  //toStringAsFixed(2) insures that the amount is displayed upto 2 decimal points
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(
                      expense.formatedDate,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
