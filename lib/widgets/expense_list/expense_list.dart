// This file defines the `ExpenseList` widget, a stateless widget that displays a scrollable list of expenses.
// It uses a `ListView.builder` to efficiently render only the visible items in the list.
import 'package:flutter/material.dart';
import 'package:xtrack/modle/expense_structure.dart';
import 'package:xtrack/widgets/expense_list/expense_items.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses});
  final List<ExpenseStructure> expenses;
  @override
  Widget build(BuildContext context) {
    return
        //list view makes the list scrollable
        //builder tells to create / build list items when they are visible or about to become visible.
        ListView.builder(
      //as many times expenses.length is called itemBuilder will be called the same times
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpenseItems(
        expenses[index],
      ),
    );
  }
}
