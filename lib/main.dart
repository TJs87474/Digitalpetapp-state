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
    int energyLevel = 100;
    String petName = "Your Pet";
    Timer? hungerTimer;
    int happinessLevel = 50;
    int hungerLevel = 50;

    String petMood = "Neutral 😐";
    Color petColor = Colors.yellow;

    bool gameOver = false;

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
      if (!gameOver){
        setState(() {
          hungerLevel = (hungerLevel + 5).clamp(0, 100);
          energyLevel = (energyLevel - 3).clamp(0, 100);
          _updateHappiness();
        _updatePetMood();
          _checkGameOver();
        //  print('Mood: $petMood');
        });
      }
    });
  }

  // Function to reset the game
  void _resetGame() {
    setState(() {
      happinessLevel = 50;
      hungerLevel = 50;
      gameOver = false;
      _startHungerTimer();
    });
  }

  // Function to check for win condition
  void _checkWin() {
    if (happinessLevel > 80) {
      Future.delayed(Duration(minutes: 2), () {
        if (happinessLevel > 70) {
          _showDialog("You Win!", "Your pet is happy and well cared for!", reset:true);
        }
      });
    }
  }

  // Function to check game over condition
  void _checkGameOver() {
    if (hungerLevel == 100 && happinessLevel <= 10) {
      gameOver = true;
      hungerTimer?.cancel();
      _showDialog("Game Over", "Your pet was unhappy and has starved to death...");
    }
  }

  // Function to show dialogs
  void _showDialog(String title, String message, {bool reset = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (reset) {
                  _resetGame();
                }
              },
              child: Text("YAY!"),
            ),
          ],
        );
      },
    );
  }

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      energyLevel = (energyLevel - 10).clamp(0,100);
      _updateHunger();

      _updatePetMood();


      _checkWin();
      _checkGameOver();

    });
  }
  
  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      energyLevel = (energyLevel + 5).clamp(0,100);
      _updateHappiness();
 moodcolors
      _updatePetMood();

      _checkWin();
      _checkGameOver();

    });
  }
  
  // Function to let the pet rest
  // Increases energy, slightly decreases happiness
  void _restPet() {
    setState(() {
      energyLevel = (energyLevel + 15).clamp(0, 100);
      happinessLevel = (happinessLevel - 5).clamp(0, 100);
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

            SizedBox(height: 16.0),
            Text(
              'Energy Level:',
              style: TextStyle(fontSize: 20.0),
            ),

            SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: energyLevel / 100,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              minHeight: 10,
            ),
            SizedBox(height: 32.0),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _restPet,
              child: Text('Let Your Pet Rest'),
            ),
          ],
        ),
      ),
    );
  }
}