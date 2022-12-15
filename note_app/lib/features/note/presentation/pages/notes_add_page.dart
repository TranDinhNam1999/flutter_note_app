import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/string/icons.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_color.dart';
import '../widgets/notes_add_page/notes_icon.dart';

class NoteAddPage extends StatefulWidget {
  const NoteAddPage({super.key});

  @override
  State<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buidBody(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();

  AppBar _buildAppbar(BuildContext context) => AppBar(
        leading: GestureDetector(
          onTap: (() {
            Navigator.pop(context);
          }),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 26,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: (() {
                Navigator.pop(context);
              }),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    CHECK_ICON,
                    fit: BoxFit.contain,
                  ),
                ),
              )),
        ],
        title: Text('New note',
            style: GoogleFonts.roboto(
                color: Colors.black, fontWeight: FontWeight.bold)),
      );

  Widget _buidBody() {
    return GestureDetector(
      onTap: (() {
        FocusScope.of(context).requestFocus(FocusNode());
      }),
      child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 92.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: listColors[0],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_buildTitleNote(), _buildBodyNote()],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              NoteIcon(
                nameIcon: TRASH_ICON,
                callback: () {},
              ),
              NoteIcon(
                nameIcon: PIN_ICON,
                callback: () {},
              ),
              NoteIcon(
                nameIcon: FONT_ICON,
                callback: () {},
              ),
              NoteIcon(
                nameIcon: PAINT_ICON,
                callback: () {},
              ),
            ],
          ),
          Row(
            children: [
              NoteIcon(
                nameIcon: KEYBOARD_ICON,
                callback: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            controller: _titleTextController,
            style: GoogleFonts.roboto(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: listColors[0]),
              ),
              focusColor: listColors[0],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  color: listColors[0],
                ),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }

  Widget _buildBodyNote() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5, top: 10),
        child: TextField(
          style: GoogleFonts.roboto(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          controller: _bodyTextController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: listColors[0]),
            ),
            focusColor: listColors[0],
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                color: listColors[0],
              ),
            ),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          expands: true,
        ),
      ),
    );
  }
}
