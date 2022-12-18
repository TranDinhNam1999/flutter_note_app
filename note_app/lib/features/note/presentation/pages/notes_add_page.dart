import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/string/icons.dart';
import 'package:note_app/features/note/presentation/widgets/common/common.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_color.dart';
import '../widgets/notes_add_page/notes_icon.dart';
import '../widgets/notes_add_page/notes_model_bottom_sheet_text_style.dart';
import '../widgets/notes_add_page/notes_stick_dialog.dart';

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
  late FocusNode textBodyFocusNode;
  late int isPin = 0;
  late int indexColor = 0;
  late String sizeFontText = "Small";
  late TextStyleEnum textStyleNote = TextStyleEnum.small;

  @override
  void initState() {
    super.initState();
    textBodyFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // * Clean up the focus node when the Form is disposed.
    textBodyFocusNode.dispose();

    super.dispose();
  }

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
                      color: listColors[indexColor],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
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
                callback: () {
                  setState(() {
                    if (isPin == 0) {
                      isPin = 1;
                    } else {
                      isPin = 0;
                    }
                  });
                },
              ),
              NoteIcon(
                nameIcon: FONT_ICON,
                callback: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (
                        context,
                      ) =>
                          NoteModelBottomSheetTextStyle(
                            textStyleNote: textStyleNote,
                            textStyleEnumValueSetter: (value) {
                              setState(() {
                                textStyleNote = value;
                              });
                            },
                          ));
                },
              ),
              NoteIcon(
                nameIcon: PAINT_ICON,
                callback: () {
                  _builDialogStick(context);
                },
              ),
            ],
          ),
          Row(
            children: [
              NoteIcon(
                nameIcon: KEYBOARD_ICON,
                callback: () {
                  textBodyFocusNode.requestFocus();
                },
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
        Flexible(
          flex: 8,
          child: TextField(
            controller: _titleTextController,
            style: GoogleFonts.roboto(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Type title here...',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: listColors[indexColor]),
              ),
              focusColor: listColors[indexColor],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  color: listColors[indexColor],
                ),
              ),
            ),
            maxLines: null,
            keyboardType: TextInputType.text,
          ),
        ),
        (isPin == 0)
            ? const SizedBox(
                width: 0,
                height: 0,
              )
            : Flexible(
                flex: 1,
                child: Image.asset(
                  PIN_ICON,
                ),
              )
      ],
    );
  }

  Widget _buildBodyNote() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5, top: 10),
        child: TextField(
          focusNode: textBodyFocusNode,
          style: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: textStyleNote.sizetext),
          textAlign: TextAlign.center,
          controller: _bodyTextController,
          decoration: InputDecoration(
            hintText: 'Type text here...',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: listColors[indexColor]),
            ),
            focusColor: listColors[indexColor],
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                color: listColors[indexColor],
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

  _builDialogStick(context) {
    return showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
            scale: curve,
            child: NoteStickDialog(indexColorValueSetter: ((value) {
              setState(() {
                indexColor = value;
              });
            })),
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }
}
