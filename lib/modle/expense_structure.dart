//expense structure is defined 

import 'package:uuid/uuid.dart';

//variable to store unique id for every expense
const uuid = Uuid();
enum Category {food, travel, leisure, work}
class ExpenseStructure {
  ExpenseStructure(
      {required this.title, required this.amount, required this.date,required this.category,})
      //id id initialized here
      //it will not be received as a parameter
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
