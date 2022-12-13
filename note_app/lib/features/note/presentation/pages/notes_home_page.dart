import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBar(
        title: Text(
          'All Notes',
          style: GoogleFonts.nunito(
              fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 16, crossAxisCount: 2, crossAxisSpacing: 16),
          children: const [
            NotesCardHome(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 217, 97, 76),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
