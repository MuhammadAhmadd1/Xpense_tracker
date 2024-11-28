//main screen to output chart and expense list

import 'package:flutter/material.dart';
import 'package:xtrack/widgets/expense_list/expense_list.dart';
import 'package:xtrack/modle/expense_structure.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseStructure> _registeredExpense = [
    ExpenseStructure(
        title: 'Flutter course',
        amount: 16.85,
        date: DateTime.now(),
        category: Category.work),
    ExpenseStructure(
        title: 'Cinema',
        amount: 18,
        date: DateTime.now(),
        category: Category.leisure)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //CHART
          Text('Chart'),
          //EXPENSE LIST

          //expanded widget restrics the listview column inside the Column widget
          Expanded(
            //expenseList is used to output the expense list
            child: ExpenseList(expenses: _registeredExpense),
          ),
        ],
      ),
    );
  }
}
