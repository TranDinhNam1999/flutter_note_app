// ignore_for_file: unrelated_type_equality_checks

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/string/icons.dart';
import 'package:note_app/core/theme/app_font.dart';
import 'package:note_app/features/note/presentation/widgets/common/common.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/util/custom_text_field.dart';
import '../../domain/entites/note.dart';
import '../bloc/notes_bloc.dart';
import '../widgets/notes_add_page/notes_icon.dart';
import '../widgets/notes_add_page/notes_model_bottom_sheet_text_style.dart';
import '../widgets/notes_add_page/notes_stick_dialog.dart';

// ignore: must_be_immutable
class NoteAddPage extends StatefulWidget {
  NoteAddPage(
      {super.key,
      this.noteEdit = const Note(
          uuid: "",
          title: "title",
          body: "body",
          isPin: 0,
          indexColor: 0,
          indexFont: 0,
          colorText: 0,
          sizeText: 0,
          alignText: "alignText"),
      required this.isCheckEdit,
      this.heroTag = "herotag"});
  Note noteEdit;
  bool isCheckEdit;
  String heroTag;

  @override
  State<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  bool isthefirst = true;

  @override
  Widget build(BuildContext context) {
    //* Check theme brightness is light -> set color text is back and set backgourd card is dark
    //* Check theme brightness is dark -> set color text is white and set backgourd card is light
    if (!widget.isCheckEdit && isthefirst) {
      final theme = ThemeModelInheritedNotifier.of(context).theme;
      textColor = theme.brightness == Brightness.light
          ? textColor = Colors.black
          : textColor = Colors.white;
      indexColor = theme.brightness == Brightness.light ? 0 : 30;
      colorBottomNavigateBar = theme.brightness == Brightness.light
          ? textColor = Colors.white
          : textColor = const Color(0xFF2D2D44);
      isthefirst = false;
    }
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
  late FocusNode texttitleFocusNode;
  late int isPin = 0;
  late int indexColor = 0;
  late TextStyleEnum textStyleNote = TextStyleEnum.small;
  late IconAlignEnum iconAlignNote = IconAlignEnum.center;
  late Color textColor = Colors.black;
  late int indexFontText = 0;
  late Color colorBottomNavigateBar = Colors.white;

  @override
  void initState() {
    super.initState();
    if (widget.isCheckEdit) {
      isPin = widget.noteEdit.isPin;
      _titleTextController.text = widget.noteEdit.title;
      _bodyTextController.text = widget.noteEdit.body;
      textColor = Color(widget.noteEdit.colorText);
      indexFontText = widget.noteEdit.indexFont;
      indexColor = widget.noteEdit.indexColor;
      textStyleNote = getTextStyleEnum(widget.noteEdit.sizeText);
      iconAlignNote = getIconAlignEnum(widget.noteEdit.alignText);
      widget.heroTag = widget.noteEdit.uuid;
    }
    textBodyFocusNode = FocusNode();
    texttitleFocusNode = FocusNode();
  }

  TextStyleEnum getTextStyleEnum(int index) {
    if (index == TextStyleEnum.small.sizetext) return TextStyleEnum.small;
    if (index == TextStyleEnum.medium.sizetext) return TextStyleEnum.medium;
    if (index == TextStyleEnum.large.sizetext) return TextStyleEnum.large;
    return TextStyleEnum.huge;
  }

  IconAlignEnum getIconAlignEnum(String index) {
    if (index == IconAlignEnum.left.description) return IconAlignEnum.left;
    if (index == IconAlignEnum.center.description) return IconAlignEnum.center;
    return IconAlignEnum.right;
  }

  @override
  void dispose() {
    // * Clean up the focus node when the Form is disposed.
    textBodyFocusNode.dispose();
    super.dispose();
  }

  GestureDetector leadingAppbar(BuildContext context) => GestureDetector(
        onTap: (() {
          Navigator.pop(context);
          textBodyFocusNode.unfocus();
          texttitleFocusNode.unfocus();
        }),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 26,
        ),
      );
  List<Widget> actionAppbar(BuildContext context) => [
        GestureDetector(
            onTap: (() {
              // * If isEdit is True -> action update
              // * If isEdit is Flase -> action add new
              if (widget.isCheckEdit) {
                Note note = Note(
                    uuid: widget.noteEdit.uuid,
                    title: _titleTextController.text,
                    body: _bodyTextController.text,
                    isPin: isPin,
                    indexColor: indexColor,
                    indexFont: indexFontText,
                    colorText: textColor.value,
                    sizeText: textStyleNote.sizetext.toInt(),
                    alignText: iconAlignNote.description);
                context.read<NotesBloc>().add(UpdateNoteEvent(note: note));
              } else {
                var uuid = const Uuid();
                Note note = Note(
                    uuid: uuid.v4(),
                    title: _titleTextController.text,
                    body: _bodyTextController.text,
                    isPin: isPin,
                    indexColor: indexColor,
                    indexFont: indexFontText,
                    colorText: textColor.value,
                    sizeText: textStyleNote.sizetext.toInt(),
                    alignText: iconAlignNote.description);
                context.read<NotesBloc>().add(AddNoteEvent(note: note));
              }

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
      ];

  AppBar _buildAppbar(BuildContext context) => AppBar(
        leading: leadingAppbar(context),
        actions: actionAppbar(context),
        title: const Text('New note'),
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
                      image: null,
                      // image: const DecorationImage(
                      //     image: AssetImage(photo_1), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Hero(
                      tag: widget.heroTag,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [_buildTitleNote(), _buildBodyNote()],
                        ),
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
      color: colorBottomNavigateBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (widget.isCheckEdit) ...{
                NoteIcon(
                  nameIcon: TRASH_ICON,
                  callback: () {
                    dialogDeleteNote(context);
                  },
                )
              },
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
                            iconAlignNote: iconAlignNote,
                            iconAlignEnumValueSetter: (value) {
                              setState(() {
                                iconAlignNote = value;
                              });
                            },
                            textColor: textColor,
                            textColorChangeValueSetter: (value) {
                              setState(() {
                                textColor = value;
                              });
                            },
                            fontTextCurrent: listFont[indexFontText],
                            fontTextChangeValueSetter: (value) {
                              setState(() {
                                indexFontText = value;
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
          child: CustomTextField(
            controller: _titleTextController,
            focusNode: texttitleFocusNode,
            textColor: textColor,
            borderColor: listColors[indexColor],
            hint: "Type title here...",
            inputType: TextInputType.text,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.left,
            googlefont: listFont[indexFontText],
            isImage: 1,
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
        child: CustomTextField(
          controller: _bodyTextController,
          focusNode: textBodyFocusNode,
          textColor: textColor,
          borderColor: listColors[indexColor],
          inputType: TextInputType.multiline,
          textAlign: iconAlignNote.textAlign,
          fontSize: textStyleNote.sizetext,
          isExpand: true,
          googlefont: listFont[indexFontText],
          isImage: 1,
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

  dialogDeleteNote(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text(
              "Delete note",
              style: TextStyle(color: Colors.red),
            ),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: listColors[indexColor],
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 200,
                width: 100,
                child: Center(
                    child: FittedBox(
                  child: Text(
                    _titleTextController.text,
                    style: GoogleFonts.getFont(listFont[indexFontText],
                        fontSize: 24, color: textColor),
                  ),
                )),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text("Ok", style: TextStyle(color: Colors.green)),
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<NotesBloc>()
                      .add(DeleteNoteEvent(uuid: widget.noteEdit.uuid));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
}
