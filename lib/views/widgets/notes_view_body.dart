import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/cubits/notes_cubit/notes_cubit.dart';
import 'package:notesapp/views/widgets/custom_app_bar.dart';
import 'package:notesapp/views/widgets/custom_listview.dart';

class ViewNotesBody extends StatefulWidget {
  const ViewNotesBody({super.key});

  @override
  State<ViewNotesBody> createState() => _ViewNotesBodyState();
}

class _ViewNotesBodyState extends State<ViewNotesBody> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
    super.initState();
  }

  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          CustomAppBar(
            icon: Icons.search,
            title: "Notes",
          ),
          Expanded(child: NotesListView()),
        ],
      ),
    );
  }
}
