import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/temperature_converter_service.dart';
import '../widgets/primary_button.dart';

// Basic temperature converter screen
class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final _inputController = TextEditingController();
  
  String _fromScale = 'Celsius';
  String _toScale = 'Fahrenheit';
  String _result = '';
  
  final List<String> _scales = ['Celsius', 'Fahrenheit', 'Kelvin'];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  // Perform conversion
  void _convert() {
    final inputText = _inputController.text.trim();
    if (inputText.isEmpty) {
      setState(() {
        _result = 'Please enter a value';
      });
      return;
    }

    final value = double.tryParse(inputText);
    if (value == null) {
      setState(() {
        _result = 'Invalid input';
      });
      return;
    }

    final converted = TemperatureConverterService.convert(
      value,
      _fromScale,
      _toScale,
    );

    setState(() {
      _result = '${converted.toStringAsFixed(2)} °${_getScaleSymbol(_toScale)}';
    });
  }

  String _getScaleSymbol(String scale) {
    switch (scale) {
      case 'Celsius':
        return 'C';
      case 'Fahrenheit':
        return 'F';
      case 'Kelvin':
        return 'K';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.converterTitle,
            style: AppConstants.headingStyle,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'Convert temperatures between different scales',
            style: AppConstants.labelStyle,
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Input field
          TextField(
            controller: _inputController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: AppConstants.bodyStyle,
            decoration: InputDecoration(
              labelText: 'Enter temperature',
              labelStyle: AppConstants.labelStyle,
              filled: true,
              fillColor: AppConstants.surfaceColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                borderSide: const BorderSide(
                  color: AppConstants.primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          
          // From scale dropdown
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('From:', style: AppConstants.labelStyle),
                    const SizedBox(height: AppConstants.smallPadding),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.mediumPadding,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.surfaceColor,
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadius,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: _fromScale,
                        isExpanded: true,
                        underline: const SizedBox(),
                        dropdownColor: AppConstants.surfaceColor,
                        style: AppConstants.bodyStyle,
                        items: _scales.map((scale) {
                          return DropdownMenuItem(
                            value: scale,
                            child: Text(scale),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromScale = value!;
                            _result = '';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.mediumPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('To:', style: AppConstants.labelStyle),
                    const SizedBox(height: AppConstants.smallPadding),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.mediumPadding,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.surfaceColor,
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadius,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: _toScale,
                        isExpanded: true,
                        underline: const SizedBox(),
                        dropdownColor: AppConstants.surfaceColor,
                        style: AppConstants.bodyStyle,
                        items: _scales.map((scale) {
                          return DropdownMenuItem(
                            value: scale,
                            child: Text(scale),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _toScale = value!;
                            _result = '';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Convert button
          PrimaryButton(
            text: 'Convert',
            onPressed: _convert,
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Result display
          if (_result.isNotEmpty)
            Card(
              color: AppConstants.surfaceColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                child: Column(
                  children: [
                    Text(
                      'Result',
                      style: AppConstants.labelStyle,
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      _result,
                      style: AppConstants.headingStyle.copyWith(
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
