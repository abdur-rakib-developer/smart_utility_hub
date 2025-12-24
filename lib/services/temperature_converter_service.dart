// Temperature conversion service with pure functions
// This service provides all temperature conversions between Celsius, Fahrenheit, and Kelvin

class TemperatureConverterService {
  // Celsius to Fahrenheit
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  // Celsius to Kelvin
  static double celsiusToKelvin(double celsius) {
    return celsius + 273.15;
  }

  // Fahrenheit to Celsius
  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  // Fahrenheit to Kelvin
  static double fahrenheitToKelvin(double fahrenheit) {
    double celsius = fahrenheitToCelsius(fahrenheit);
    return celsiusToKelvin(celsius);
  }

  // Kelvin to Celsius
  static double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  // Kelvin to Fahrenheit
  static double kelvinToFahrenheit(double kelvin) {
    double celsius = kelvinToCelsius(kelvin);
    return celsiusToFahrenheit(celsius);
  }

  // Convert from one scale to another
  static double convert(double value, String fromScale, String toScale) {
    if (fromScale == toScale) return value;

    // Convert from source to Celsius first
    double celsius;
    switch (fromScale) {
      case 'Celsius':
        celsius = value;
        break;
      case 'Fahrenheit':
        celsius = fahrenheitToCelsius(value);
        break;
      case 'Kelvin':
        celsius = kelvinToCelsius(value);
        break;
      default:
        celsius = value;
    }

    // Convert from Celsius to target
    switch (toScale) {
      case 'Celsius':
        return celsius;
      case 'Fahrenheit':
        return celsiusToFahrenheit(celsius);
      case 'Kelvin':
        return celsiusToKelvin(celsius);
      default:
        return celsius;
    }
  }
}
