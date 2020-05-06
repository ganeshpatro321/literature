import 'package:flutter/material.dart';
import 'package:literature/models/playing_cards.dart';
import 'package:enum_to_string/enum_to_string.dart';

class CardDeck extends StatefulWidget {
  CardDeck({
    Key key,
    this.cards,
  }): super(key: key);

  List<PlayingCard> cards;

  _CardDeckState createState() => _CardDeckState();
}

class _CardDeckState extends State<CardDeck> {
  static const font = "Courier New";

  // Do we have to show
  // the miniView?
  bool _miniView = false;

  // IMPORTANT: Container height
  // See: card height.
  double height = 200.0;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Widget _largeCardList() {
    return _miniCardsDeck();
  }

  Widget _rowCardsView() {
    return _largeCardsDeck();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.transparent,
      height: height,
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
                width: 84,
                child: new RaisedButton(
                  onPressed: () {
                    if (height == 320.0) {
                      height = 200.0;
                    } else {
                      height = 320.0;
                    }
                    setState(() {
                      _miniView = !_miniView;
                    });
                  },
                  child: new Text(
                    "switch",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              )
            ]
          ),
          _miniView == false ?
          _rowCardsView():
          _largeCardList()
        ],
      )
    );
  }

  // Mini representation of all
  // cards in a single view.
  Widget _miniCardsDeck() {
    return Container(
      height: 300,
      child: GridView.count(
        crossAxisCount: 6,
        children: widget.cards.map((card) {
          return Center(
            child: _buildMiniCard(EnumToString.parse(card.cardType), EnumToString.parse(card.cardSuit)),
          );
        }).toList()
      ),
    );
  }

  // Large list of playing cards
  Widget _largeCardsDeck() {
    if (widget.cards == null) {
      return new Text("No cards yet");
    } else {
      var children = widget.cards.map((card) {
        return new Column(
          children: <Widget>[
            _buildLargeCard(EnumToString.parse(card.cardType), EnumToString.parse(card.cardSuit))
          ],
        );
      }).toList();
      
      return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children
          ),
        ),
      );
    }
  }

  // Returns a string representing
  // the shorthand of a card suit.
  String _cardTypeToString(String type) {
    switch(type) {
      case "ace":
        return "A";
        break;
      case "two":
        return "2";
        break;
      case "three":
        return "3";
        break;
      case "four":
        return "4";
        break;
      case "five":
        return "5";
        break;
      case "six":
        return "6";
        break;
      case "eight":
        return "8";
        break;
      case "nine":
        return "9";
        break;
      case "ten":
        return "10";
        break;
      case "jack":
        return "J";
        break;
      case "king":
        return "K";
        break;
      case "queen":
        return "Q";
        break;
      default:
        return "0";
        break;
    }
  }

  Image _cardSuitToImage(String suit) {
    switch(suit) {
      case "hearts":
        return Image.asset("assets/hearts.png");
        break;
      case "diamonds":
        return Image.asset("assets/diamonds.png");
        break;
      case "clubs":
        return Image.asset("assets/clubs.png");
        break;
      case "spades":
        return Image.asset("assets/spades.png");
        break;
      default:
        return Image.asset("assets/spades.png");
        break;
    }
  }

  // A mini card in an
  // all cards view.
  Widget _buildMiniCard(type, suit) {
    return new Material(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        // Height of each mini card.
        height: 100,
        width: 100,
        child: Stack(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(child: Text(
                    _cardTypeToString(type),
                    style: TextStyle(
                        fontFamily: font,
                        fontSize: 20.0,
                        color: (
                          suit == "clubs" || 
                          suit == "spades" ? Colors.black : Colors.red
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Card emblem on top
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                // color: Colors.blue,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                          height: 16.0,
                            child: _cardSuitToImage(suit),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A particular card in row of 
  // row card view.
  Widget _buildLargeCard(type, suit) {
    return new Material(
      color: Colors.white,
      // The card number
      // in the center.
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        // See: height of each card.
        height: 160.0,
        width: 100,
        child: Stack(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Text(
                      // put the card type here
                      _cardTypeToString(type),
                      style: TextStyle(
                        fontFamily: font,
                        fontSize: 60.0,
                        color: (
                          suit == "clubs" || 
                          suit == "spades" ? Colors.black : Colors.red
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Card emblem on the top.
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                // color: Colors.blue,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              _cardTypeToString(type),
                              style: TextStyle(
                                fontFamily: font,
                                fontSize: 20.0,
                                color: (
                                  suit == "clubs" || 
                                  suit == "spades" ? Colors.black : Colors.red
                                ),
                              ),
                            ),
                          ),
                          Container(
                          height: 16.0,
                            child: _cardSuitToImage(suit),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Card emblem on the bottom.
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 115, 4.0, 0),
              child: Container(
                // color: Colors.blue,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                          height: 16.0,
                            child: _cardSuitToImage(suit),
                          ),
                          Container(
                            child: Text(
                              _cardTypeToString(type),
                              style: TextStyle(
                                fontFamily: font,
                                fontSize: 20.0,
                                color: (
                                  suit == "clubs" || 
                                  suit == "spades" ? Colors.black : Colors.red
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}