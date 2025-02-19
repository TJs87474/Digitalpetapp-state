import 'dart:async';
import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
  home: DigitalPetApp(),
  ));
}
class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
    String petName = "Your Pet";
    Timer? hungerTimer;
    int happinessLevel = 50;
    int hungerLevel = 50;

  @override
  void initState() {
    super.initState();
    _startHungerTimer();
  }
    String get petMood {
    if (happinessLevel >= 70) {
      return "Happy 😃";
    } else if (happinessLevel >= 40) {
      return "Neutral 😐";
    } else {
      return "Unhappy 😢";
    }
  }

  // Function to start automatic hunger increase
  void _startHungerTimer() {
    hungerTimer = Timer.periodic(Duration(seconds: 10), (timer) 
    {
        setState(() {
          hungerLevel = (hungerLevel + 5).clamp(0, 100);
          _updateHappiness();
        //  print('Mood: $petMood');
        });
    });
  }


  
  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();

    });
  }
  
  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
    });
  }
  
  // Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
  }
  
  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
            'Name: $petName',
            style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
            'Happiness Level: $happinessLevel',
            style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Mood: $petMood',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
}