import 'dart:async';

int totalCoins = 0;
int countModifier = 1;
//start xp:10,add 20 for each next lvl
int blootLvl = 1;
late Timer gameTimer;

List<Map> shopList = [
  {"name": "Apple", "cost": 10, "type": "food", "xp": 2},
  {"name": "Smoothie", "cost": 50, "type": "food", "xp": 10},
  {"name": "Chocolate", "cost": 25, "type": "food", "xp": 5},

  {"name": "???", "cost": 1000, "type": "food", "xp": 25},
];

List<Map> activeAbilitiesList = [];
