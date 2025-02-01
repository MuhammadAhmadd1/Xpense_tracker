import 'package:flutter/material.dart';
import 'package:xtrack/modle/expense_structure.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // Controllers for handling text input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // Selected date for the expense (initially null)
  DateTime? _selectedDate;

  // Default category for the dropdown
  Category _selectedCategory = Category.food;

  // Function to open a date picker and allow the user to select a date
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    // Update the selected date when the user picks one
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Function to validate and submit the expense data
  void _submitExpenseData() {
    // Convert amount from text to double, returns null if invalid
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // Check if title is empty (validation)
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  // Dispose method to free up memory when the widget is removed
  @override
  void dispose() {
    _titleController.dispose(); // Dispose title controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Text field for entering expense title
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              // Text field for entering the expense amount
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('amount'),
                  ),
                ),
              ),
              SizedBox(width: 18),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display selected date or default message
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!),
                  ),
                  // Button to open date picker
                  IconButton(
                    onPressed: () {
                      _presentDatePicker();
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Dropdown for selecting expense category
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              // Cancel button to close the form
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              // Save button to submit the expense
              ElevatedButton(
                  onPressed: _submitExpenseData, child: Text('Save')),
            ],
          )
        ],
      ),
    );
  }
}
