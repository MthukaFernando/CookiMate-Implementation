import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  int _selectedConverterIndex = 0;

  // ---------------- WEIGHT CONVERTER ----------------
  TextEditingController _weightController = TextEditingController();
  String _fromWeightUnit = 'Ib';
  String _toWeightUnit = 'Kg';
  double _weightResult = 0;

  // ---------------- TEMPERATURE CONVERTER ----------------
  TextEditingController _tempController = TextEditingController();
  String _fromTempUnit = '°C';
  String _toTempUnit = '°F';
  double _tempResult = 0;

  // ---------------- VOLUME CONVERTER ----------------
  TextEditingController _volumeController = TextEditingController();
  String _fromVolumeUnit = 'Cup';
  String _toVolumeUnit = 'ml';
  double _volumeResult = 0;

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
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
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
    _tempController.addListener(_convertTemperature);
    _volumeController.addListener(_convertVolume);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _tempController.dispose();
    _volumeController.dispose();
    super.dispose();
  }

  // ---------------- WEIGHT ----------------
  void _convertWeight() {
    double value = double.tryParse(_weightController.text) ?? 0;
    double result = value;

    if (_fromWeightUnit == 'Ib' && _toWeightUnit == 'Kg') {
      result = value * 0.453592;
    } else if (_fromWeightUnit == 'Kg' && _toWeightUnit == 'Ib') {
      result = value * 2.20462;
    }

    setState(() => _weightResult = result);
  }

  // ---------------- TEMPERATURE ----------------
  void _convertTemperature() {
    double value = double.tryParse(_tempController.text) ?? 0;
    double result = value;

    if (_fromTempUnit == '°C' && _toTempUnit == '°F') {
      result = (value * 9 / 5) + 32;
    } else if (_fromTempUnit == '°F' && _toTempUnit == '°C') {
      result = (value - 32) * 5 / 9;
    }

    setState(() => _tempResult = result);
  }

  // ---------------- VOLUME ----------------
  void _convertVolume() {
    double value = double.tryParse(_volumeController.text) ?? 0;

    Map<String, double> toMl = {
      'Cup': 236.588,
      'ml': 1,
      'Tbsp': 14.787,
      'Tsp': 4.929,
      'L': 1000,
      'pint': 473.176,
    };

    double valueInMl = value * toMl[_fromVolumeUnit]!;
    double result = valueInMl / toMl[_toVolumeUnit]!;

    setState(() => _volumeResult = result);
  }

  // ---------------- UNIT SELECTOR ----------------
  Widget _buildUnitSelector(
    List<String> units,
    String selectedUnit,
    Function(String) onChanged,
  ) {
    return DropdownButton<String>(
      value: selectedUnit,
      items: units.map((unit) {
        return DropdownMenuItem(
          value: unit,
          child: Text(unit),
        );
      }).toList(),
      onChanged: (value) => onChanged(value!),
      dropdownColor: const Color(0xFFF8F0DE),
      underline: Container(height: 2, color: Colors.black),
    );
  }

  // ---------------- SHARED LAYOUT ----------------
  Widget _buildConverterLayout(
    TextEditingController controller,
    String fromUnit,
    String toUnit,
    double result,
    List<String> units,
    Function(String) onFrom,
    Function(String) onTo,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text('From:'),
              const SizedBox(height: 8),
              SizedBox(
                width: 120, // same width for both fields
                height: 48, // same height
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF8F0DE),
                    filled: true,          
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildUnitSelector(units, fromUnit, onFrom),
            ],
          ),
          const Icon(Icons.swap_horiz, size: 32),
          Column(
            children: [
              const Text('To:'),
              const SizedBox(height: 8),
              SizedBox(
                width: 120, // same width
                height: 48, // same height
                child: TextField(
                  controller: TextEditingController(
                      text: result.toStringAsFixed(2)), // shows result
                  readOnly: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF8F0DE),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildUnitSelector(units, toUnit, onTo),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightConverter() => _buildConverterLayout(
        _weightController,
        _fromWeightUnit,
        _toWeightUnit,
        _weightResult,
        ['Ib', 'Kg'],
        (v) => setState(() => _fromWeightUnit = v),
        (v) => setState(() => _toWeightUnit = v),
      );

  Widget _buildTemperatureConverter() => _buildConverterLayout(
        _tempController,
        _fromTempUnit,
        _toTempUnit,
        _tempResult,
        ['°C', '°F'],
        (v) => setState(() => _fromTempUnit = v),
        (v) => setState(() => _toTempUnit = v),
      );

  Widget _buildVolumeConverter() => _buildConverterLayout(
        _volumeController,
        _fromVolumeUnit,
        _toVolumeUnit,
        _volumeResult,
        ['Cup', 'ml', 'Tbsp', 'Tsp', 'L', 'pint'],
        (v) => setState(() => _fromVolumeUnit = v),
        (v) => setState(() => _toVolumeUnit = v),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0DE),
      body: SafeArea(
        child: Center(
          child: Transform.translate(
            offset: const Offset(0, -60),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 347,
                height: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9B99B),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      'Converter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildConverterSelector(),
                    Expanded(
                      child: [
                        _buildWeightConverter(),
                        _buildTemperatureConverter(),
                        _buildVolumeConverter(),
                      ][_selectedConverterIndex],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}