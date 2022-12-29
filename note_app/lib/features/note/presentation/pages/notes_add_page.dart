import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/string/icons.dart';
import 'package:note_app/core/theme/app_font.dart';
import 'package:note_app/features/note/data/model/note_check_list.dart';
import 'package:note_app/features/note/presentation/widgets/common/common.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_image.dart';
import '../../../../core/util/custom_text_field.dart';
import '../../domain/entites/note.dart';
import '../bloc/notes_bloc.dart';
import '../widgets/notes_add_page/notes_icon.dart';
import '../widgets/notes_add_page/notes_model_bottom_sheet_text_style.dart';
import '../widgets/notes_add_page/notes_stick_dialog.dart';
import '../widgets/notes_home_page/notes_password_dialog.dart';

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
          alignText: "alignText",
          indexImage: -1,
          isPassword: 0,
          listCheck: []),
      required this.isCheckEdit,
      this.isCheckList = false,
      this.heroTag = "herotag"});
  Note noteEdit;
  bool isCheckEdit;
  bool isCheckList;
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
      textColor =
          theme.brightness == Brightness.light ? Colors.black : Colors.white;
      indexColor = theme.brightness == Brightness.light ? 0 : 30;
      isthefirst = false;
    }

    if (listItem.isNotEmpty) {
      widget.isCheckList = true;
    }
    MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: listColors[indexColor],
      appBar: _buildAppbar(context),
      body: _buidBody(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _bodyTextController = TextEditingController();
  final TextEditingController _bodyCheckListController =
      TextEditingController();
  late FocusNode textBodyFocusNode;
  late FocusNode texttitleFocusNode;
  late int isPin = 0;
  late int isPassword = 0;
  late int indexColor = 0;
  late int indexImage = -1;
  late bool isNotColor = false;
  late TextStyleEnum textStyleNote = TextStyleEnum.small;
  late IconAlignEnum iconAlignNote = IconAlignEnum.left;
  late Color textColor;
  late int indexFontText = 0;
  late List<CheckListModel> listItem = [];
  late bool isCheckValue = false;
  late bool isAlowEdit = true;

  @override
  void initState() {
    super.initState();
    if (widget.isCheckEdit) {
      isPin = widget.noteEdit.isPin;
      isPassword = widget.noteEdit.isPassword;
      _titleTextController.text = widget.noteEdit.title;
      _bodyTextController.text = widget.noteEdit.body;
      textColor = Color(widget.noteEdit.colorText);
      indexFontText = widget.noteEdit.indexFont;
      indexColor = widget.noteEdit.indexColor;
      textStyleNote = getTextStyleEnum(widget.noteEdit.sizeText);
      iconAlignNote = getIconAlignEnum(widget.noteEdit.alignText);
      widget.heroTag = widget.noteEdit.uuid;
      indexImage = widget.noteEdit.indexImage;
      isNotColor = widget.noteEdit.indexImage >= 0 ? true : false;
      listItem.addAll(widget.noteEdit.listCheck);
      isAlowEdit = false;
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
              if (isAlowEdit) {
                var uuid = const Uuid();
                Note note = Note(
                    uuid: widget.isCheckEdit ? widget.noteEdit.uuid : uuid.v4(),
                    title: _titleTextController.text,
                    body: _bodyTextController.text,
                    isPin: isPin,
                    indexColor: indexColor,
                    indexFont: indexFontText,
                    colorText: textColor.value,
                    sizeText: textStyleNote.sizetext.toInt(),
                    alignText: iconAlignNote.description,
                    indexImage: indexImage,
                    isPassword: isPassword,
                    listCheck: listItem);

                if (widget.isCheckEdit) {
                  context.read<NotesBloc>().add(UpdateNoteEvent(note: note));
                } else {
                  context.read<NotesBloc>().add(AddNoteEvent(note: note));
                }

                Navigator.pop(context);
              } else {
                setState(() {
                  isAlowEdit = true;
                });
              }
            }),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 30,
                width: 30,
                child: isAlowEdit
                    ? Image.asset(
                        CHECK_ICON,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        EDIT_ICON,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: isNotColor
                          ? listColors[indexColor].withOpacity(0)
                          : listColors[indexColor],
                    ),
                    child: Stack(
                      children: [
                        if (indexImage >= 0) ...{
                          SvgPicture.asset(
                            listImage[indexImage],
                            alignment: Alignment.center,
                            fit: BoxFit.fitHeight,
                          )
                        },
                        Material(
                          color: isNotColor
                              ? listColors[indexColor].withOpacity(0)
                              : listColors[indexColor],
                          child: Column(
                            children: [
                              _buildTitleNote(),
                              !widget.isCheckList
                                  ? _buildBodyTextNote()
                                  : _buidldBodyCheckListNote()
                            ],
                          ),
                        ),
                      ],
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
      color: listColors[indexColor],
      child: Row(
        children: [
          if (widget.isCheckEdit) ...{
            NoteIcon(
              nameIcon: TRASH_ICON,
              callback: () {
                dialogDeleteNote(context);
              },
            )
          },
          Flexible(
            flex: 1,
            child: NoteIcon(
              nameIcon: PIN_ICON,
              callback: () {
                setState(() {
                  if (isPin == 0) {
                    isPin = 1;
                  } else {
                    isPin = 0;
                  }
                  if (widget.isCheckEdit) {
                    context.read<NotesBloc>().add(ChangePinNodeEvent(
                        isPin: isPin, uuid: widget.noteEdit.uuid));
                  }
                });
              },
            ),
          ),
          if (widget.isCheckEdit) ...{
            Flexible(
              flex: 1,
              child: BlocConsumer<NotesBloc, NotesState>(
                listener: (context, state) {
                  if (state.status == NoteStatus.passwordIsNoTConfigured) {
                    _builDialogStick(context, const PasswordDialog());
                  }
                  if (state.status == NoteStatus.changePasswordSuccess) {
                    context.read<NotesBloc>().add(ChangeIsPasswordNoteEvent(
                        isPassword: isPassword, uuid: widget.noteEdit.uuid));
                  }
                },
                builder: (context, state) {
                  return NoteIcon(
                    nameIcon: isPassword == 0 ? UNLOCK_ICON : LOCK_ICON,
                    callback: () {
                      setState(() {
                        if (isPassword == 0) {
                          isPassword = 1;
                        } else {
                          isPassword = 0;
                        }
                        if (widget.isCheckEdit) {
                          context.read<NotesBloc>().add(
                              ChangeIsPasswordNoteEvent(
                                  isPassword: isPassword,
                                  uuid: widget.noteEdit.uuid));
                        }
                      });
                    },
                  );
                },
              ),
            ),
          },
          if (isAlowEdit) ...{
            Flexible(
              flex: 1,
              child: NoteIcon(
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
            ),
          },
          if (isAlowEdit) ...{
            Flexible(
              flex: 1,
              child: NoteIcon(
                nameIcon: PAINT_ICON,
                callback: () {
                  _builDialogStick(
                      context,
                      NoteStickDialog(
                        indexColorValueSetter: ((value) {
                          setState(() {
                            indexColor = value;
                            indexImage = -1;
                            isNotColor = false;
                          });
                        }),
                        indexImageValueSetter: ((value) {
                          setState(() {
                            indexImage = value;
                            isNotColor = true;
                          });
                        }),
                      ));
                },
              ),
            ),
          }
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
            isEnable: isAlowEdit,
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

  Widget _buildBodyTextNote() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: CustomTextField(
        isEnable: isAlowEdit,
        controller: _bodyTextController,
        focusNode: textBodyFocusNode,
        textColor: textColor,
        borderColor: listColors[indexColor],
        inputType: TextInputType.multiline,
        textAlign: iconAlignNote.textAlign,
        fontSize: textStyleNote.sizetext,
        isExpand: false,
        googlefont: listFont[indexFontText],
        isImage: 1,
      ),
    );
  }

  Widget _buidldBodyCheckListNote() {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 10),
      child: listItem.isEmpty
          ? addCheckBox()
          : SizedBox(
              width: 100.w,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listItem.length,
                itemBuilder: (context, index) {
                  return index + 1 == listItem.length
                      ? Column(children: [
                          checkbox(index),
                          if (isAlowEdit) ...{addCheckBox()}
                        ])
                      : Column(
                          children: [checkbox(index)],
                        );
                },
              ),
            ),
    );
  }

  CheckboxListTile checkbox(int index) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(listItem[index].text,
          style: GoogleFonts.getFont(listFont[indexFontText],
              fontSize: textStyleNote.sizetext, color: textColor)),
      onChanged: (bool? value) {
        setState(() {
          listItem[index] = CheckListModel(
              uuidCheckList: listItem[index].uuidCheckList,
              text: listItem[index].text,
              isCheck: value! ? 1 : 0);
          _bodyCheckListController.text = "";

          if (widget.isCheckEdit && !isAlowEdit) {
            context.read<NotesBloc>().add(ChangeCheckboxNodeEvent(
                uuid: widget.noteEdit.uuid, listCheckModel: listItem));
          }
        });
      },
      value: listItem[index].isCheck == 0 ? false : true,
      secondary: isAlowEdit
          ? IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              iconSize: textStyleNote.sizetext + 10,
              onPressed: () {
                setState(() {
                  listItem.removeAt(index);
                });
              },
            )
          : const SizedBox(),
    );
  }

  CheckboxListTile addCheckBox() {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: CustomTextField(
        controller: _bodyCheckListController,
        focusNode: textBodyFocusNode,
        textColor: textColor,
        borderColor: listColors[indexColor],
        inputType: TextInputType.multiline,
        textAlign: iconAlignNote.textAlign,
        fontSize: textStyleNote.sizetext,
        isExpand: false,
        googlefont: listFont[indexFontText],
        isImage: 1,
      ),
      onChanged: (bool? value) {
        isCheckValue = value!;
      },
      value: isCheckValue,
      secondary: IconButton(
        icon: const Icon(Icons.add),
        iconSize: textStyleNote.sizetext + 10,
        onPressed: () {
          var uuid = const Uuid();
          setState(() {
            if (_bodyCheckListController.text != "") {
              listItem.add(CheckListModel(
                  uuidCheckList: uuid.v4(),
                  text: _bodyCheckListController.text,
                  isCheck: isCheckValue ? 1 : 0));

              isCheckValue = false;
              _bodyCheckListController.text = "";
            }
          });
        },
      ),
    );
  }

  _builDialogStick(context, Widget currentWidget) {
    return showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
            scale: curve,
            child: currentWidget,
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
