import 'package:flutter/material.dart';

class CustomInputFiledSeedWeight extends StatefulWidget {
  const CustomInputFiledSeedWeight({super.key});

  @override
  State<CustomInputFiledSeedWeight> createState() =>
      _CustomInputFiledSeedWeightState();
}

class _CustomInputFiledSeedWeightState
    extends State<CustomInputFiledSeedWeight> {
  final TextEditingController _controller = TextEditingController(text: '30');
  String selectedUnit = 'gms';

  void _increment() {
    final value = int.tryParse(_controller.text) ?? 0;
    _controller.text = (value + 1).toString();
  }

  void _decrement() {
    final value = int.tryParse(_controller.text) ?? 0;
    if (value > 0) {
      _controller.text = (value - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        border: Border.all(color: Colors.green.shade900),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.green.shade700),
              ),
              suffixIcon: Container(
                padding: const EdgeInsets.only(right: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Unit Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedUnit,
                          dropdownColor: Colors.green[700],
                          iconEnabledColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          items: ['gms', 'kgs'].map((unit) {
                            return DropdownMenuItem<String>(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => selectedUnit = value);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),

                    // Combined + / - buttons
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          _actionButton('+', _increment),
                          const VerticalDivider(
                            width: 1,
                            color: Colors.white,
                          ),
                          _actionButton('–', _decrement),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String symbol, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        alignment: Alignment.center,
        child: Text(
          symbol,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
