import 'package:flutter/material.dart';

class ExpenseWindow extends StatefulWidget {
  final Function(double) updateBudget;
  final Function(String) updateOperationVar;

  const ExpenseWindow({Key? key, required this.updateBudget, required this.updateOperationVar}) : super(key: key);

  @override
  _ExpenseWindowState createState() => _ExpenseWindowState();
}

class _ExpenseWindowState extends State<ExpenseWindow> {
  final List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => AddExpenseModal(
                onExpenseAdded: (expense) {
                  setState(() {
                    expenses.add(expense);
                  });
                  void updateOperationVarFromExpenseWindow() {
                    widget.updateOperationVar("-");
  }
                  updateOperationVarFromExpenseWindow();
                  widget.updateBudget(expense.cost);
                },
              ),
            );
          },
          child: const Text('Add Expense'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return ExpenseCard(expense: expenses[index]);
            },
          ),
        ),
      ],
    );
  }
}

class AddExpenseModal extends StatefulWidget {
  final Function(Expense) onExpenseAdded;

  const AddExpenseModal({Key? key, required this.onExpenseAdded}) : super(key: key);

  @override
  _AddExpenseModalState createState() => _AddExpenseModalState();
}

class _AddExpenseModalState extends State<AddExpenseModal> {
  final TextEditingController costController = TextEditingController();
  String selectedCategory = 'Food';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: costController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cost'),
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
              });
            },
            items: ['Food', 'Entertainment', 'Shopping', 'Other']
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final double cost = double.tryParse(costController.text) ?? 0.0;
              final DateTime now = DateTime.now();
              final String formattedTime = "${now.hour}:${now.minute}";

              final Expense expense = Expense(
                cost: cost,
                category: selectedCategory,
                time: formattedTime,
              );

              widget.onExpenseAdded(expense);
              Navigator.pop(context);
            },
            child: const Text('Add Expense'),
          ),
        ],
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Category: ${expense.category}'),
        subtitle: Text('Cost: ${expense.cost} zł'),
        trailing: Text('Time: ${expense.time}'),
      ),
    );
  }
}

class Expense {
  final double cost;
  final String category;
  final String time;

  Expense({required this.cost, required this.category, required this.time});
}
