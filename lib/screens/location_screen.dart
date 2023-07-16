import 'package:live_weather/screens/city_screen.dart';
import 'package:live_weather/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:live_weather/services/weather.dart';

class LocationScreen extends StatefulWidget {

  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();

  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String message;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if(weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        message = 'Unable to Find Weather data, check your GPS settings';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      message = weather.getMessage(temperature, condition);
      cityName = weatherData['name'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/location_background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.8),
              BlendMode.dstATop),
        ),
      ),




        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(

                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: Colors.white,
                        ),
                        Text('Current', style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Spartan MB',
                        ),),
                        Text('Location', style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Spartan MB',
                        ),)
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const CityScreen();
                      },),);
                      if(typedName != null) {
                        var weatherData = await weather.getCity(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.location_city,
                          size: 50.0,
                          color: Colors.white,
                        ),
                        Text('Change', style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Spartan MB',
                        ),),
                        Text('Location', style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Spartan MB',
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
               Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                     Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      );
  }
}




