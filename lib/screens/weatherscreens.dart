//-------------------------------------
//form
//key
//column
// textformfield-- validator/
//

// temp
//conditon        img
// city name
//--------------------------------------

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherappdemo/viewmodel/weatherservice.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final TextEditingController _citycontroller = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final weatherProvider=Provider.of<WeatherServiceProvider>(context);
    return Scaffold(
      backgroundColor: CupertinoColors.systemTeal,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(weatherProvider.isLoading)
                CircularProgressIndicator()
              else if(weatherProvider.error.isNotEmpty)
                Text("${weatherProvider.error}")
              else if (weatherProvider.weather!=null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 30,
                      ),
                    getWeatherIcon(weatherProvider.weather?.weather![0].description.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${weatherProvider.weather?.main!.temp!.toStringAsFixed(0).toString()}",
                            style: TextStyle(
                                fontSize: 48,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "\u2103",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text("${weatherProvider.weather?.weather![0].description}",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${weatherProvider.weather!.name}",
                            style:
                            TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          Icon(
                            Icons.pin_drop,
                            color: Colors.red,
                          )
                        ],
                      ),

                    ],
                  ),


              TextFormField(
                onFieldSubmitted: (value){
                  weatherProvider.fetchWeatherData(value);
                },
                controller: _citycontroller,
                decoration: InputDecoration(
                    hintText: "Enter City",
                    hintStyle: TextStyle(
                        color: Colors.white54
                    ),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white
                        )
                    )),
              ),

            ],
          )
        ),
      ),
    );
  }


  Widget getWeatherIcon(String? description){

    if(description!.contains("clear")){
      return Image.asset('assets/img/clear.png');
    }

    if(description!.contains("clouds")){
      return Image.asset('assets/img/clouds.png');
    }

    if(description!.contains("drizzle")){
      return Image.asset('assets/img/dizzle.png');
    }
    if(description!.contains("rain")){
      return Image.asset('assets/img/rain.png');
    }

    return Image.asset('assets/img/snow.png');
  }
}
