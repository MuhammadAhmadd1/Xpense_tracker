//main screen to output chart and expense list

import 'package:flutter/material.dart';
import 'package:xtrack/widgets/expense_list/expense_list.dart';
import 'package:xtrack/modle/expense_structure.dart';
import 'package:xtrack/widgets/new_expense.dart';

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
        category: Category.leisure),
    ExpenseStructure(
        title: 'Biryani',
        amount: 18,
        date: DateTime.now(),
        category: Category.food)
  ];

  void _openAddExpenseOverLay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XpenseTrack'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverLay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
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
