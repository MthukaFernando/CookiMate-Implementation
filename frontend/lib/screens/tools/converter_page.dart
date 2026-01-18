import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  // Tracks which converter is selected:
  // 0 = Weight, 1 = Temperature, 2 = Volume
  int _selectedConverterIndex = 0;

   // ---------------- WEIGHT CONVERTER ----------------   
  TextEditingController _weightController = TextEditingController();  
  String _fromWeightUnit = 'Ib';  
  String _toWeightUnit = 'Kg';  
  double _weightResult = 0;  

  // ---------------- CONVERTER TYPE SELECTOR ----------------
  Widget _buildConverterSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFD8B084),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          return GestureDetector(
            onTap: () => setState(() => _selectedConverterIndex = i),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: _selectedConverterIndex == i
                    ? const Color(0xFFF8F0DE)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                ['Weight', 'Temperature', 'Volume'][i],
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
          );
        }),
      ),
    );
  }

   @override  
  void initState() {  
    super.initState();  
    _weightController.addListener(_convertWeight);  
  }

  @override  
  void dispose() {  
    _weightController.dispose();  
    super.dispose();  
  }

  // ---------------- WEIGHT CONVERSION LOGIC ----------------
  void _convertWeight() {
    double value = double.tryParse(_weightController.text) ?? 0;
    double result = 0;

    if (_fromWeightUnit == 'Ib' && _toWeightUnit == 'Kg') {
      result = value * 0.453592;
    } else if (_fromWeightUnit == 'Kg' && _toWeightUnit == 'Ib') {
      result = value * 2.20462;
    } else if (_fromWeightUnit == 'g' && _toWeightUnit == 'Kg') {
      result = value / 1000;
    } else if (_fromWeightUnit == 'Kg' && _toWeightUnit == 'g') {
      result = value * 1000;
    } else if (_fromWeightUnit == 'g' && _toWeightUnit == 'Ib') {
      result = value * 0.00220462;
    } else if (_fromWeightUnit == 'Ib' && _toWeightUnit == 'g') {
      result = value * 453.592;
    } else if (_fromWeightUnit == 'oz' && _toWeightUnit == 'g') {
      result = value * 28.3495;
    } else if (_fromWeightUnit == 'g' && _toWeightUnit == 'oz') {
      result = value / 28.3495;
    } else if (_fromWeightUnit == 'oz' && _toWeightUnit == 'Kg') {
      result = value * 0.0283495;
    } else if (_fromWeightUnit == 'Kg' && _toWeightUnit == 'oz') {
      result = value / 0.0283495;
    } else if (_fromWeightUnit == 'oz' && _toWeightUnit == 'Ib') {
      result = value * 0.0625;
    } else if (_fromWeightUnit == 'Ib' && _toWeightUnit == 'oz') {
      result = value / 0.0625;
    } else {
      result = value; // Same unit
    }

    setState(() => _weightResult = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0DE),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 347,
            height: 378,
            decoration: BoxDecoration(
              color: const Color(0xFFE6C39A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Text(
                  'Converter',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                _buildConverterSelector(), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}