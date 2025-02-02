// This file defines the `ExpenseList` widget, a stateless widget that displays a scrollable list of expenses.
// It uses a `ListView.builder` to efficiently render only the visible items in the list.
import 'package:flutter/material.dart';
import 'package:xtrack/modle/expense_structure.dart';
import 'package:xtrack/widgets/expense_list/expense_items.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final void Function(ExpenseStructure expense) onRemoveExpense;
  final List<ExpenseStructure> expenses;
  @override
  Widget build(BuildContext context) {
    return
        //list view makes the list scrollable
        //builder tells to create / build list items when they are visible or about to become visible.
        ListView.builder(
      //as many times expenses.length is called itemBuilder will be called the same times
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        //to swipe and delete the card
        key: ValueKey(
          expenses[index],
        ),
       // background: Container(
          //color: Theme.of(context).colorScheme.error,
          //margin: EdgeInsets.symmetric(
            //horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          //),
        //),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItems(
          expenses[index],
        ),
      ),
    );
  }
}
