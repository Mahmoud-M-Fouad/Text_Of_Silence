
/*
import 'package:flutter/material.dart';
import 'package:text_of_silence_app0/screens/prediction_result_screen.dart';

import '../components/help_dialog.dart';
import '../components/no_categories_selected_dialog.dart';
import 'camera_screen.dart';

class SentenceStructureScreen extends StatefulWidget {
  const SentenceStructureScreen({Key? key}) : super(key: key);

  @override
  _SentenceStructureScreenState createState() =>
      _SentenceStructureScreenState();
}

class _SentenceStructureScreenState extends State<SentenceStructureScreen> {
  // Chips to be shown as user clicks on categories
  final List<Chip> _sentenceStructureChips = [];

  // Chips to be shown on the Camera Screen
  final List<Chip> _sentenceStructureCameraChips = [];

  // Is category pressed?
  // Used to make categories clickable once
  final Map<String, bool> _pressed = {
    'Adverb': false,
    'Alphabet': false,
    'Colors': false,
    'Commands': false,
    'Numbers': false,
    'Prepositions': false,
  };

  // Show a help dialog when user clicks on the help button
  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (_) => const HelpDialog(),
    );
  }

  // Remove category from chips array
  void _removeSelectedCategory(String category) {
    setState(() {
      _pressed[category] = false;
      _sentenceStructureCameraChips.removeWhere((Chip chip) {
        return chip.label.toString() == Text(category).toString();
      });
      _sentenceStructureChips.removeWhere((Chip chip) {
        return chip.label.toString() == Text(category).toString();
      });
    });
  }

  // Show an alert if the user clicks
  // on the 'Open Camera' button without selecting any category
  void _showCategoriesAlert() {
    showDialog(
      context: context,
      builder: (_) => const NoCategoriesSelectedDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Structure'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/icon.jpg',
                    width: 150.0,
                  ),
                ),
              ),
              const Text(
                'My sentence structure will be:',
                textScaleFactor: 1.7,
                style: TextStyle(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _categoryButton('Adverb'),
                  _categoryButton('Alphabet'),
                  _categoryButton('Colors'),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _categoryButton('Commands'),
                  _categoryButton('Numbers'),
                  _categoryButton('Prepositions'),
                ],
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                height: 70.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _sentenceStructureChips,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: _sentenceStructureChips.length > 0 ? 4.0 : null,
        icon: const Icon(Icons.videocam),
        label: const Text('Open Camera'),
        onPressed: _sentenceStructureChips.length > 0
            ? () {



          /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CameraScreen(_sentenceStructureCameraChips),
                  ),
                );
                */
              }
            : () => _showCategoriesAlert(),
        backgroundColor:
            _sentenceStructureChips.length > 0 ? null : Colors.grey[400],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _categoryButton(String category) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: RaisedButton(
          onPressed: _pressed[category]!
              ? null
              : () {
                  setState(
                    () {
                      _sentenceStructureCameraChips
                          .add(Chip(label: Text(category)));
                      _sentenceStructureChips.add(
                        Chip(
                          deleteIcon: const Icon(Icons.cancel),
                          deleteButtonTooltipMessage: 'Remove category',
                          //deleteIconColor: const Color(0xFFC7042C),
                          deleteIconColor: Colors.blue,
                          label: Text(category),
                          padding: const EdgeInsets.all(3.0),
                          onDeleted: () {
                            _pressed[category] = false;
                            _sentenceStructureCameraChips
                                .removeWhere((Chip chip) {
                              return chip.label.toString() ==
                                  Text(category).toString();
                            });
                            _sentenceStructureChips.removeWhere((Chip chip) {
                              return chip.label.toString() ==
                                  Text(category).toString();
                            });
                            setState(() {});
                          },
                          elevation: 2.0,
                        ),
                      );
                      _pressed[category] = true;
                    },
                  );
                },
          child: Text(category),
          color: _pressed[category]!? Colors.grey : null,
        ),
      ),
    );
  }
}



 */
//----------

