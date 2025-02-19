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
    String petMood = "Neutral 😐";
    Color petColor = Colors.yellow;

  @override
  void initState() {
    super.initState();
    _startHungerTimer();
  }

void _updatePetMood() {
    if (happinessLevel > 70) {
      setState(() {
        petMood = "Happy 😃";
        petColor = Colors.green;
        
      });
    } else if (happinessLevel >= 30 || happinessLevel <=70) {
      setState(() {
        petMood = "Neutral 😐";
        petColor = Colors.orange;
      });
    } else {
      setState(() {
        petMood = "Unhappy 😢";
        petColor = Colors.red;
      });
    }
  }

  

  // Function to start automatic hunger increase
  void _startHungerTimer() {
    hungerTimer = Timer.periodic(Duration(seconds: 10), (timer) 
    {
        setState(() {
          hungerLevel = (hungerLevel + 5).clamp(0, 100);
          _updateHappiness();
        _updatePetMood();
        });
    });
  }


  
  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _updatePetMood();

    });
  }
  
  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
      _updatePetMood();
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
            style: TextStyle(fontSize: 20.0, color: petColor),
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