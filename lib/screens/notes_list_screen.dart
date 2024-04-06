import 'package:flutter/material.dart';
import 'package:flutter_final_year_project/model/notes_data.dart';
import 'package:flutter_final_year_project/notes-database/notes_database.dart';
import 'package:flutter_final_year_project/routes.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({Key? key}) : super(key: key);

  @override
  State<NotesListScreen> createState() => _MyNotesListScreenState();
}

class _MyNotesListScreenState extends State<NotesListScreen> {
  late List<NotesData> notes;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Again Build Called');
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = Colors.orange.shade50;
    final Color evenItemColor = Colors.orange.shade100;
    NotesData? result;
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteGenerator.getStartedPage, (route) => false);
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ))
      ]),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return ListTile(
              title: Text(note.notesTitle),
              subtitle: Text(note.notesDetail),
              trailing: Text(note.dateTime.timeZoneName),
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.notesDetail,
                    arguments: notes[index].id!);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            result =
                await Navigator.pushNamed(context, RouteGenerator.notesDetail)
                    as NotesData;
          },
          child: const Icon(Icons.add)),
    );
  }
}

//  for (int index = 0; index < _items.length; index += 1)
//               ListTile(
//                 key: Key('$index'),
//                 tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
//                 title: Text('Note Title ${_items[index]}'),
//                 subtitle: Text('Detail'),
//                 trailing: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _items.removeAt(index);
//                       });
//                     },
//                     icon: const Icon(Icons.delete_outline_rounded)),
//                 onTap: () => Navigator.of(context).pushNamed(
//                   RouteGenerator.notesDetail,
//                   arguments: NotesData(
//                       notesName: 'Notes Title, Title: ${index}',
//                       notesDetail: 'Detail'),
//                 ),
//               ),
