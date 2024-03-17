import 'package:flutter/material.dart';
import 'budget_window.dart';
import 'expenses_window.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;
  double budget = 0.0;

  var operationVar = "";

  void updateOperationVar(String newOperation) {
    setState(() {
      operationVar = newOperation;
    });
  }

  void updateBudget(double expenseCost) {
    setState(() {
      switch (operationVar) {
        case "set":
          budget = expenseCost;
          break;
        case "+":
          budget += expenseCost;
          break;
        case "-":
          budget -= expenseCost;
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 147, 210),
        ),
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_outlined),
              label: 'Budżet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_rental),
              label: 'Wydatki',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historia',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ustawienia',
            ),
          ],
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [
            PageStorage(
              child: BudgetWindow(updateBudget: updateBudget, updateOperationVar: updateOperationVar, budget: budget),
              bucket: PageStorageBucket(),
            ),
            PageStorage(
              child: ExpenseWindow(updateBudget: updateBudget, updateOperationVar: updateOperationVar),
              bucket: PageStorageBucket(),
            ),
            const Placeholder(),
            const Placeholder(),
          ],
        ),
      ),
    );
  }
}

