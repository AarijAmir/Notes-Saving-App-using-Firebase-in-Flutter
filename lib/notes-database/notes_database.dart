import 'package:flutter_final_year_project/model/notes_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase('notes.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT ';
    const String textType = 'TEXT NOT NULL';
    db.execute('''
CREATE TABLE $tableName (
  ${NotesFields.id} $idType, 
  ${NotesFields.noteTitle} $textType,
  ${NotesFields.noteDetail} $textType
)
''');
  }

  Future<NotesData> create(NotesData note) async {
    final database = await instance.database;
    final id = await database.insert(tableName, note.toJson());
    return note.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<NotesData> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableName,
        columns: NotesFields.values,
        where: '${NotesFields.id}= ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return NotesData.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> update(NotesData note) async {
    final db = await instance.database;
    return db.update(tableName, note.toJson(),
        where: '${NotesFields.id} = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableName, where: '${NotesFields.id} = ?', whereArgs: [id]);
  }

  Future<List<NotesData>> readAllNotes() async {
    final db = await instance.database;
    const orderBy = '${NotesFields.noteTime} ASC';
    final result = await db.query(tableName);
    return result.map((json) => NotesData.fromJson(json)).toList();
  }
}
