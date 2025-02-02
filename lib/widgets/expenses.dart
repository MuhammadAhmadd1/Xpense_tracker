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
        title: 'Cinema',
        amount: 18.23,
        date: DateTime.now(),
        category: Category.leisure),
    ExpenseStructure(
        title: 'Biryani',
        amount: 3.45,
        date: DateTime.now(),
        category: Category.food),
    ExpenseStructure(
        title: 'Begams Expense',
        amount: 1000,
        date: DateTime.now(),
        category: Category.shopping),
  ];

  void _openAddExpenseOverLay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpenses),
    );
  }

  //to add expense
  void _addExpenses(ExpenseStructure expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  //to remove expense
  void _removeExpenses(ExpenseStructure expense) {
    //to store the index of the removed card and undo it back on the same index
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    //to clear the existing snackbar if we have deleted another card and show its snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    //snackbar to show card is deleted and if user want to undo it
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: const Text('Expense Deleted!'),
        action: SnackBarAction(label: 'Undo', onPressed: () {
          setState(() {
            _registeredExpense.insert(expenseIndex, expense);
          });
        },),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //when no expense is added
    Widget mainContent = const Center(
      child: Text('No Expense!'),
    );
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpense,
        onRemoveExpense: _removeExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Xpense'),
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
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
