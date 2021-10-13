import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String card = "";
  late String turn = "player";
  var deck = Deck();
  List<Card> player = [];
  List<Card> computer = [];
  List<Card> remainingDeck = [];

  @override
  void initState() {
    deck.shuffle();
    remainingDeck = deck.cards;
    placeCards(deck);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: (){
                  setState(() {
                    turn = "player";
                  });
                },
                child: Container(
                  width: 20.w,
                  height: 5.h,
                  color: Colors.lightBlueAccent,
                  child: const Center(child: Text("Pass")),
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 15.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: computer.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: GestureDetector(
                          onTap: () {
                            if(turn == "computer"){
                              setState(() {
                                turn = "player";
                                card = computer[index].image;
                                computer.remove(computer[index]);
                              });
                            }
                            else{
                              Get.snackbar("Please Wait", "Its player turn",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          child: Container(
                            width: 20.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1.0),
                              // image: const DecorationImage(
                              //     fit: BoxFit.fill,
                              //     image: AssetImage("images/card1.png")
                              // )
                            ),
                            child: Center(
                                child: Text(
                              computer[index].image,
                              style: TextStyle(fontSize: 8.sp),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(remainingDeck.isNotEmpty){
                        if(turn == "computer"){
                          computer.add(remainingDeck.last);
                          remainingDeck.removeLast();
                        }
                        else{
                          player.add(remainingDeck.last);
                          remainingDeck.removeLast();
                        }
                      }
                      print(remainingDeck.length);
                      setState(() {});
                    },
                    child: Container(
                      width: 20.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          // image: DecorationImage(
                          //     fit: BoxFit.fill,
                          //     image: card == "images/card1.png"
                          //         ? const AssetImage("images/card1.png")
                          //         : card == "images/card2.png"
                          //             ? const AssetImage("images/card2.png")
                          //             : const AssetImage("images/card3.png"))
                      ),
                      child: Center(
                          child: Text(
                            remainingDeck.isEmpty ? "Finish" : "Deck",
                            style: TextStyle(fontSize: 8.sp),
                          )),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Container(
                    width: 20.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      // image: DecorationImage(
                      //     fit: BoxFit.fill,
                      //     image: card == "images/card1.png"
                      //         ? const AssetImage("images/card1.png")
                      //         : card == "images/card2.png"
                      //             ? const AssetImage("images/card2.png")
                      //             : const AssetImage("images/card3.png"))
                    ),
                    child: Center(
                        child: Text(
                          card,
                          style: TextStyle(fontSize: 8.sp),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 15.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: player.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: GestureDetector(
                          onTap: () {
                            if(turn == "player"){
                              setState(() {
                                card = player[index].image;
                                player.remove(player[index]);
                                turn = "computer";
                              });
                            }
                            else{
                            Get.snackbar("Please Wait", "Its computer turn",
                            snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          child: Container(
                            width: 20.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                // image: const DecorationImage(
                                //     fit: BoxFit.fill,
                                //     image: AssetImage("images/card2.png"))
                            ),
                            child: Center(
                                child: Text(
                                  player[index].image,
                                  style: TextStyle(fontSize: 8.sp),
                                )),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: (){
                  setState(() {
                    turn = "computer";
                  });
                },
                child: Container(
                  width: 20.w,
                  height: 5.h,
                  color: Colors.lightBlueAccent,
                  child: const Center(child: Text("Pass")),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  placeCards(Deck deck){
    for(int i=0; i<16; i++){
      if(i%2 == 0){
        player.add(deck.cards[i]);
        remainingDeck.remove(deck.cards[i]);
      }
      else{
        computer.add(deck.cards[i]);
        remainingDeck.remove(deck.cards[i]);
      }
    }

    print(player);
    print(computer);
    print(remainingDeck);

  }

}

class Deck {
  List<Card> cards =
      []; //List creation and initialization. If not initialized, it is null
  //List is same as array in JAVA. So, saying List<Card> cards essentially means an array of
  //Card objects with the array variable name as cards
  Deck() {
    var ranks = [
      'ace',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
      'ten',
      'jack',
      'queen',
      'king'
    ];
    var suits = ['Clubs', 'Diamonds', 'Hearts', 'Spades'];

    for (var suit in suits) {
      for (var rank in ranks) {
        var card = Card(rank, suit, "${rank}${suit}");
        cards.add(
            card); //If list not initialized, list becomes null and add() will not work
      }
    }
  }

  toString() {
    return cards.toString();
  }

  @override
  toLength() {
    return cards.length;
  }

  //Shuffles all cards of the deck randomly
  shuffle() {
    cards.shuffle();
  }

  //Short form of function syntax. Long form below
  //Returns all cards of a specific suit
  cardsWithSuit(String suit) {
    // => is implicit return
    //Whatever is evaluated on the right is automatically returned to the left
    return cards.where((card) => card.suit == suit);
    //Long form of function syntax
    //return cards.where((card) {
    //where() needs a method as param, so passed a nameless method which returns a bool value
    //return card.suit == suit;
    //});
  }
}

class Card {
  String rank;
  String suit;
  String image;

  Card(this.rank, this.suit, this.image);

  toString() {
    return '$image';
  }
}
