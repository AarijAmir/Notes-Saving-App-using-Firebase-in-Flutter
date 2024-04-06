import 'package:flutter/material.dart';
import 'package:flutter_final_year_project/model/notes_data.dart';
import 'package:flutter_final_year_project/notes-database/notes_database.dart';
import 'package:intl/intl.dart';
import 'package:text_style_editor/text_style_editor.dart';

class NotesSavingScreen extends StatefulWidget {
  const NotesSavingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  State<NotesSavingScreen> createState() => _NotesSavingScreenState();
}

class _NotesSavingScreenState extends State<NotesSavingScreen> {
  List<String> fonts = [
    'Billabong',
    'AlexBrush',
    'Allura',
    'Arizonia',
    'ChunkFive',
    'GrandHotel',
  ];

  List<Color> paletteColors = [
    Colors.black,
    Colors.white,
    Color(int.parse('0xffEA2027')),
    Color(int.parse('0xff006266')),
    Color(int.parse('0xff1B1464')),
    Color(int.parse('0xff009432')),
    Color(int.parse('0xff833471')),
    Color(int.parse('0xff112CBC4')),
    Color(int.parse('0xffF79F1F')),
    Color(int.parse('0xffA3CB38')),
  ];
  late TextStyle textStyle;
  late TextAlign textAlign;
  bool edit = false;
  late TextEditingController _textEditingControllerForTitle;
  late TextEditingController _textEditingControllerForDetail;
  late NotesData note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
    textStyle = const TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontFamily: 'OpenSans',
    );

    textAlign = TextAlign.left;
    _textEditingControllerForTitle = TextEditingController();
    _textEditingControllerForDetail = TextEditingController();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    int id = ModalRoute.of(context)!.settings.arguments as int;
    this.note = await NotesDatabase.instance.readNote(id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingControllerForTitle.dispose();
    _textEditingControllerForDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // NotesData data =
    //     (ModalRoute.of(context)!.settings.arguments as NotesData?) ??
    //         const NotesData(notesName: '', notesDetail: '');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.orange,
            floating: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.check, color: Colors.white),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: size.height * 0.7,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.1),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 30,
                        child: TextFormField(
                          initialValue: note.notesTitle,
                          cursorColor: Colors.black,
                          maxLines: 2,
                          maxLength: 60,
                          style: TextStyle(
                              fontSize: size.height * 0.035,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Note Title',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: size.height * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 65,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          maxLines: 20,
                          maxLength: 500,
                          style: textStyle,
                          textAlign: textAlign,
                          initialValue: note.notesDetail,
                          decoration: InputDecoration(
                            hintText: 'Enter Note',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: size.height * 0.021,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child:
                              Text(DateFormat.yMMMMd().format(note.dateTime))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height * 0.6,
                child: SafeArea(
                  bottom: false,
                  child: Container(
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: TextStyleEditor(
                        fonts: fonts,
                        paletteColors: paletteColors,
                        textStyle: textStyle,
                        textAlign: textAlign,
                        initialTool: EditorToolbarAction.fontFamilyTool,
                        onTextAlignEdited: (align) {
                          setState(() {
                            textAlign = align;
                          });
                        },
                        onTextStyleEdited: (style) {
                          setState(() {
                            textStyle = textStyle.merge(style);
                            print(textStyle.color);
                          });
                        },
                        onCpasLockTaggle: (caps) {
                          print(caps);
                        },
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
