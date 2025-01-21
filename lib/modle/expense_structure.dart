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
