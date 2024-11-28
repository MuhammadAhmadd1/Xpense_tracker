//for outputting individual list items
import 'package:flutter/material.dart';
import 'package:xtrack/modle/expense_structure.dart';

class ExpenseItems extends StatelessWidget {
  const  ExpenseItems(this.expense,{super.key});
  final ExpenseStructure expense;
  @override
  Widget build(BuildContext context) {
    return Card(child: Text(expense.title),);
  }
}