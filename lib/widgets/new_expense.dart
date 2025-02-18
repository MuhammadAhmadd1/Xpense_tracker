import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtrack/modle/expense_structure.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseStructure expense) onAddExpense;

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

  void _showDialog() {
    //to find out on which device we are running and then which dialog will run
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
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
    } else {
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

  // Function to validate and submit the expense data
  void _submitExpenseData() {
    // Convert amount from text to double, returns null if invalid
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // Check if title is empty (validation)
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    // Call the callback function to add the new expense
    widget.onAddExpense(
      ExpenseStructure(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );

    // Close the expense input form
    Navigator.pop(context);
  }

  // Dispose method to free up memory when the widget is removed
  @override
  void dispose() {
    _titleController.dispose(); // Dispose title controller
    _amountController.dispose(); // Dispose amount controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardspace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardspace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title input field
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 50,
                            decoration: InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        SizedBox(width: 25),
                        // Amount input field
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
                      ],
                    )
                  else
                    // Title input field (for smaller screens)
                    TextField(
                      controller: _titleController,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  if (width >= 600)
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
                          },
                        ),
                        SizedBox(width: 25),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        // Amount input field
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
                        SizedBox(width: 24),
                        // Date picker section
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text('Save'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        // Dropdown for selecting category
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
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text('Save'),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
