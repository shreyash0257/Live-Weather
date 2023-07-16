import 'package:live_weather/services/networking.dart';
import 'package:live_weather/services/location.dart';

const apiKey = 'apikey';  // your own openwaethermap api key
const opmURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCity(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper('$opmURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('$opmURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp, int condition) {
    if (temp > 35) {
      if(condition < 600) {
        return 'Bring a 🧥';
      } else if(condition < 700) {
        return 'You\'ll need 🧣 and 🧤';
      } else if(condition <= 804) {
        return 'Time for shorts and 👕';
      } else if(condition > 800) {
        return 'It\'s really cloudy here';
      }
      return 'It\'s 🍦 time';
    } else if (temp > 25) {
        if(condition < 600) {
          return 'Bring a 🧥';
        } else if(condition < 700) {
          return 'You\'ll need 🧣 and 🧤';
        } else if(condition > 800) {
          return 'It\'s really cloudy here';
        }
        return 'Time for shorts and 👕';
    } else if (temp < 25 && temp > 15) {
      if(condition < 600) {
        return 'Bring a 🧥';
      } else if(condition < 700) {
        return 'You\'ll need 🧣 and 🧤';
      } else if(condition > 800) {
        return 'It\'s really cloudy here';
      }
      return 'Time for shorts and 👕';
    }
    else if (temp < 15) {
      if(condition < 600) {
        return 'Bring a 🧥';
      } else if(condition < 700) {
        return 'You\'ll need 🧣 and 🧤';
      } else if(condition > 800) {
        return 'It\'s really cloudy here';
      }
      return 'You\'ll need 🧣 and 🧤';
    }  else {
      return 'All clear here';
    }
  }
}
