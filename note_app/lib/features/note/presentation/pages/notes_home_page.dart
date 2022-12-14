import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/features/note/presentation/bloc/notes_bloc.dart';

import '../widgets/notes_home_page/notes_card_home.dart';

class NoteHomePage extends StatefulWidget {
  const NoteHomePage({super.key});

  @override
  State<NoteHomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildFloatingActionButton());
  }

  AppBar _buildAppbar() => AppBar(
        title: Text(
          'All Notes',
          style: GoogleFonts.nunito(
              fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocConsumer<NotesBloc, NotesState>(
        listener: ((context, state) {
          if (state.status == NoteStatus.success) {}
        }),
        builder: (context, state) {
          return GridView.builder(
              itemCount: state.notes?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 14, crossAxisCount: 2, crossAxisSpacing: 14),
              itemBuilder: (BuildContext context, int index) {
                return state.notes == null
                    ? const SizedBox()
                    : NotesCardHome(note: state.notes![index]);
              });
        },
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() => FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 217, 97, 76),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      );
}
