import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notesapp/cubits/add_note_cubit/add_note_state.dart';
import 'package:notesapp/cubits/notes_cubit/notes_cubit.dart';
import 'package:notesapp/models/note_model.dart';
import 'package:notesapp/views/widgets/color_list_view.dart';
import 'package:notesapp/views/widgets/custom_button.dart';
import 'package:notesapp/views/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            initValue: "",
            onSaved: (value) {
              title = value;
            },
            hintText: "title",
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            initValue: "",
            onSaved: (value) {
              content = value;
            },
            hintText: "content",
            maxLines: 5,
          ),
          const SizedBox(
            height: 50,
          ),
          ColorListView(),
          SizedBox(
            height: 50,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    String formattedCurrentDate = formatDate();
                    addNote(context, formattedCurrentDate);
                  } else {
                    autoValidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  void addNote(BuildContext context, String formattedCurrentDate) {
    BlocProvider.of<AddNoteCubit>(context).addNote(NoteModel(
        title: title!,
        content: content!,
        date: formattedCurrentDate,
        color: Colors.blue.value));
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
  }

  String formatDate() {
    var currentDate = DateTime.now();
    var formattedCurrentDate = DateFormat.yMd().format(currentDate);
    return formattedCurrentDate;
  }
}
