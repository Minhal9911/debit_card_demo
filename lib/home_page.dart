import 'package:debit_card/card_details.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  FlipCardController flipController = FlipCardController();

  // GlobalKey<FlipCardState> _flipKey = GlobalKey();
  bool showBackSide = false;

  // FocusNode _focusNode = FocusNode();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _cardFocusNode = FocusNode();
  FocusNode _expiryFocusNode = FocusNode();
  FocusNode _cvvFocusNode = FocusNode();

  // String textFieldValue = '';

  @override
  void dispose() {
    nameController.dispose();
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();

    _nameFocusNode.dispose();
    _cardFocusNode.dispose();
    _expiryFocusNode.dispose();
    _cvvFocusNode.dispose();
    super.dispose();
  }

  final cardMaskFormatter = MaskTextInputFormatter(
      mask: "#### #### #### ####", filter: {"#": RegExp(r'[0-9]')});
  final expiryMaskFormatter =
      MaskTextInputFormatter(mask: "##/##", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _cardFocusNode.unfocus();
        _expiryFocusNode.unfocus();
        _cvvFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FlipCard'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildCard(),
                const SizedBox(height: 16),
                buildFormField(),
                const SizedBox(height: 30),
                buildButton(),
              ],
            ),
          ),
        ),

      ),
    );
  }



  Widget buildCard() {
    return SizedBox(
      height: 290,
      width: 400,
      child: Card(
        elevation: 0.0,
        margin: const EdgeInsets.only(top: 32, bottom: 24, right: 16, left: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: FlipCard(
          // key: _flipKey,
          controller: flipController,
          direction: FlipDirection.HORIZONTAL,
          flipOnTouch: false,
          side: CardSide.FRONT,
          front: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blueAccent, Colors.lightBlue]),
            ),
            child: buildFrontContainer(),
          ),
          back: buildBackContainer(),
        ),
      ),
    );
  }

  Widget buildFrontContainer() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Demo Bank",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "${nameController.text}",
            // textFieldValue,
            // "MOHD  MINHAL  RAZA",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 10),
          Text(
            "${cardController.text}",
            // "6080  3255  2926  7731",
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "VALID \n UPTO",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              const SizedBox(width: 6),
              Text(
                "${expiryController.text}",
                // "01/26",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "RuPay",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    "DEBIT",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 16),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBackContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blue, Colors.blueAccent, Colors.lightBlue]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 45,
            width: double.infinity,
            color: Colors.black,
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(8.0),
            height: 50,
            width: 250,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${cvvController.text}",
                  // '007',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: TextField(
              focusNode: _nameFocusNode,
              keyboardType: TextInputType.name,
              controller: nameController,
              // textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                filled: true,
                fillColor: Colors.white60,
                hintText: "Name",
                hintStyle: TextStyle(
                    color: Colors.purple, fontStyle: FontStyle.italic),
                prefixIcon: Icon(Icons.person, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: 0.1,
                      color: Colors.black),
                ),
              ),
              onChanged: (text) {
                // textFieldValue = text;
                nameController.value = TextEditingValue(
                  text: text.toUpperCase(),
                  selection: nameController.selection,
                );
                setState(() {});
              },
              onTap: () {
                _nameFocusNode.requestFocus();
                /* if (showBackSide == true) {
                  _flipKey.currentState!.toggleCard();
                  setState(() {
                    showBackSide = false;
                  });
                }*/
                if (showBackSide == true) {
                  flipController.toggleCard();
                  setState(() {
                    showBackSide = false;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: TextField(
              focusNode: _cardFocusNode,
              keyboardType: TextInputType.number,
              controller: cardController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                // LengthLimitingTextInputFormatter(16),
                // DebitCardInputFormatter(),
                cardMaskFormatter,
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                filled: true,
                fillColor: Colors.white60,
                hintText: "Card Number",
                hintStyle: TextStyle(
                    color: Colors.purple, fontStyle: FontStyle.italic),
                prefixIcon: Icon(Icons.credit_card, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: 0.1,
                      color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
              onTap: () {
                _cardFocusNode.requestFocus();
                /*if (showBackSide == true) {
                  _flipKey.currentState!.toggleCard();
                  setState(() {
                    showBackSide = false;
                  });
                }*/
                if (showBackSide == true) {
                  flipController.toggleCard();
                  setState(() {
                    showBackSide = false;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                height: 50,
                width: 168,
                child: TextField(
                  focusNode: _expiryFocusNode,
                  keyboardType: TextInputType.datetime,
                  controller: expiryController,
                  // maxLength: 5,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(4),
                    // ExpiryDateTextInputFormatter(),
                    expiryMaskFormatter,
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    filled: true,
                    fillColor: Colors.white60,
                    // counterText: '',
                    hintText: "MM/YY",
                    hintStyle: TextStyle(
                        color: Colors.purple, fontStyle: FontStyle.italic),
                    prefixIcon: Icon(Icons.date_range, color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 0.1,
                          color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  onTap: () {
                    _expiryFocusNode.requestFocus();
                    /*if (showBackSide == true) {
                      _flipKey.currentState!.toggleCard();
                      setState(() {
                        showBackSide = false;
                      });
                    }*/
                    if (showBackSide == true) {
                      flipController.toggleCard();
                      setState(() {
                        showBackSide = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 50,
                width: 168,
                child: TextField(
                  focusNode: _cvvFocusNode,
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    filled: true,
                    fillColor: Colors.white60,
                    hintText: "CVV",
                    counterText: '',
                    hintStyle: TextStyle(
                        color: Colors.purple, fontStyle: FontStyle.italic),
                    prefixIcon: Icon(Icons.domain_verification_outlined,
                        color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 0.1,
                          color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  onTap: () {
                    _cvvFocusNode.requestFocus();
                    /* if (showBackSide == false) {
                      _flipKey.currentState!.toggleCard();
                      setState(() {
                        showBackSide = true;
                      });
                    }*/
                    if (showBackSide == false) {
                      flipController.toggleCard();
                      setState(() {
                        showBackSide = true;
                      });
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildButton() {
    return ElevatedButton(
      onPressed: () {
        _nameFocusNode.unfocus();
        _cardFocusNode.unfocus();
        _expiryFocusNode.unfocus();
        _cvvFocusNode.unfocus();

        String cardNo = cardController.text;
        // int cardDetails = int.parse(cardNo);
        String expiry = expiryController.text;
        // int validUpto = int.parse(expiry);
        String cvv = cvvController.text;
        // int cvvVerify = int.parse(cvv);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetails(
                name: nameController.text,
                cardNo: cardNo,
                expiry: expiry,
                cvv: cvv,
              ),
            ));
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          minimumSize: Size(120, 40.0),
          textStyle: TextStyle(fontSize: 20)),
      child: Text('Done'),
    );
  }
}

class DebitCardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String enteredData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < enteredData.length; i++) {
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 4 == 0 && enteredData.length != index) {
        buffer.write(" ");
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.toString().length));
  }
}

class ExpiryDateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String enteredText = newValue.text;
    StringBuffer expiryBuffer = StringBuffer();

    for (int i = 0; i < enteredText.length; i++) {
      expiryBuffer.write(enteredText[i]);
      if ((i + 1) % 2 == 0 && i != enteredText.length - 1) {
        expiryBuffer.write("/");
      }
    }
    return TextEditingValue(
        text: expiryBuffer.toString(),
        selection:
            TextSelection.collapsed(offset: expiryBuffer.toString().length));
  }
}
