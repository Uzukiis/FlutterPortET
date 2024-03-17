import 'package:flutter/material.dart';

class BudgetWindow extends StatefulWidget {
  final Function(double) updateBudget;
  final Function(String) updateOperationVar;
  final double budget;

  const BudgetWindow({Key? key, required this.updateBudget, required this.budget, required this.updateOperationVar}) : super(key: key);

  @override
  _BudgetWindowState createState() => _BudgetWindowState();
}

class _BudgetWindowState extends State<BudgetWindow> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: budgetPage(context),
    );
  }

  Widget budgetPage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Obecny budżet',
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 30),
        Text(
          '${widget.budget} zł',
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => SetNewBudgetModal(
                    onBudgetChanged: (newBudget) {
                      widget.updateOperationVar("set");
                      widget.updateBudget(newBudget);
                    },
                  ),
                );
              },
              child: const Text('Ustaw nowy budżet'),
            ),
          ],
        ),
      ],
    );
  }
}

class SetNewBudgetModal extends StatefulWidget {
  final Function(double) onBudgetChanged;

  const SetNewBudgetModal({Key? key, required this.onBudgetChanged}) : super(key: key);

  @override
  _SetNewBudgetModalState createState() => _SetNewBudgetModalState();
}

class _SetNewBudgetModalState extends State<SetNewBudgetModal> {
  final TextEditingController newBudgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: newBudgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nowy budżet'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              double newBudgetValue = double.tryParse(newBudgetController.text) ?? 0.0;
              widget.onBudgetChanged(newBudgetValue);
              Navigator.pop(context);
            },
            child: const Text('Zatwierdź'),
          ),
        ],
      ),
    );
  }
}
