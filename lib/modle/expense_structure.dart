//expense structure is defined

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

//variable to store unique id for every expense
const uuid = Uuid();

enum Category { food, travel, leisure, work, shopping }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie_rounded,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.shopping: Icons.shopping_bag,
};

class ExpenseStructure {
  ExpenseStructure({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  })
  //id id initialized here
  //it will not be received as a parameter
  : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  // Constructor that initializes the ExpenseBucket with a list of expenses and a category
  ExpenseBucket({required this.expenses, required this.category});

  // Named constructor to filter expenses by category from a given list
  ExpenseBucket.forCategory(List<ExpenseStructure> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) =>
                expense.category ==
                category) // Filters only expenses that match the given category
            .toList();

  final Category
      category; // The category of expenses (e.g., Food, Travel, Shopping)
  final List<ExpenseStructure>
      expenses; // List of expenses belonging to this category

  // Getter to calculate the total sum of all expenses in this category
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount; // Adds each expense amount to the total sum
    }
    return sum; // Returns the total sum of expenses in this category
  }
}
