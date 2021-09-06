import 'package:calculator_app/apps/calculator_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Listener method to attach a UI Widget to its notifier
T useChangeNotifierListener<T extends CalculatorChangeNotifier>(T data) {
  final state = useState<T>(data);
  return useListenable(state.value);
}

class CalculatorView extends HookWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initializer of specified notifier
    CalculatorChangeNotifier changeNotifier =
        useChangeNotifierListener(CalculatorChangeNotifier());

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(title: const Text('Calculator'), centerTitle: false),
        body: Container(
            color: Colors.grey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.03, right: size.width * 0.05),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                          changeNotifier.currentStringValue == ''
                              ? '0'
                              : changeNotifier.currentStringValue,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20))), // Shows zero if no inputs
                ),
                Container(height: size.width * 0.3),
                Expanded(
                  child: GridView.count(
                      // Created GridView to stack calculator buttons.
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      children:
                          // Generate list with buttons based on keyapad variables from viewModel
                          List.generate(changeNotifier.keypads.length, (index) {
                        String value = changeNotifier.keypads[index];
                        bool isOperational =
                            changeNotifier.isOperational(value);

                        return OutlinedButton(
                            onPressed: () => inputValue(value,
                                changeNotifier), // Call inputValue method on each button pressed
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7, left: 1),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(value,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20))),
                            ),
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(size.width * 0.25, size.width * 0.25)),
                                backgroundColor: MaterialStateProperty
                                    .all<Color>(isOperational
                                        ? Colors.indigo
                                        : Colors
                                            .white))); // Assign colors depends on if button is an operation or not
                      })),
                )
              ],
            )));
  }

  // Method to call reloadState method from CalculatorChangeNotifier
  void inputValue(String value, CalculatorChangeNotifier changeNotifier) {
    changeNotifier.reloadState(value);
  }
}
