const String tableName = 'notes';

class NotesFields {
  static final List<String> values = [id, noteTitle, noteDetail, noteTime];
  static const String id = '_id';
  static const String noteTitle = 'note_title';
  static const String noteDetail = 'note_detail';
  static const String noteTime = 'note_tile';
}

class NotesData {
  final int? id;
  final String notesTitle;
  final String notesDetail;
  final DateTime dateTime;
  const NotesData(
      {required this.id,
      required this.notesTitle,
      required this.notesDetail,
      required this.dateTime});
  Map<String, Object?> toJson() => {
        NotesFields.id: id,
        NotesFields.noteTitle: notesTitle,
        NotesFields.noteDetail: notesDetail,
        NotesFields.noteTime: dateTime.toIso8601String()
      };

  NotesData copy(
      {int? id, String? notesTitle, String? notesDetail, DateTime? dateTime}) {
    return NotesData(
        id: id ?? this.id,
        notesTitle: notesTitle ?? this.notesTitle,
        notesDetail: notesDetail ?? this.notesDetail,
        dateTime: dateTime ?? this.dateTime);
  }

  static NotesData fromJson(Map<String, Object?> json) => NotesData(
      id: json[NotesFields.id] as int?,
      notesTitle: json[NotesFields.noteTitle] as String,
      notesDetail: json[NotesFields.noteDetail] as String,
      dateTime: DateTime.parse(json[NotesFields.noteTime] as String));
}
