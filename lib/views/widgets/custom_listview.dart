import 'package:flutter/material.dart';
import 'package:notesapp/views/widgets/custom_note_item.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 40),
        itemBuilder: (context, index) {
          return const NoteItem();
        },
      ),
    );
  }
}
