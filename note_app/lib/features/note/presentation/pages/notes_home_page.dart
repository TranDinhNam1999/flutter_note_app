import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/theme/app_theme.dart';
import 'package:note_app/features/note/presentation/bloc/notes_bloc.dart';
import '../widgets/notes_home_page/notes_card_home.dart';
import '../widgets/notes_home_page/notes_floating_button.dart';

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
        floatingActionButton: const NoteFloatingBottom());
  }

  @override
  void initState() {
    super.initState();
  }

  Icon iconTheme(BuildContext context) =>
      ThemeModelInheritedNotifier.of(context).theme.brightness ==
              Brightness.light
          ? const Icon(
              Icons.brightness_3,
              size: 25,
              color: Colors.black,
            )
          : const Icon(
              Icons.wb_sunny,
              size: 25,
              color: Colors.orange,
            );
  ThemeSwitcher leadingAppbar(BuildContext context) => ThemeSwitcher(
        clipper: const ThemeSwitcherCircleClipper(),
        builder: (context) {
          return IconButton(
            icon: iconTheme(context),
            onPressed: () {
              ThemeSwitcher.of(context).changeTheme(
                theme:
                    ThemeModelInheritedNotifier.of(context).theme.brightness ==
                            Brightness.light
                        ? AppTheme.dark
                        : AppTheme.light,
              );
            },
          );
        },
      );

  AppBar _buildAppbar() => AppBar(
        leading: leadingAppbar(context),
        title: const Text(
          'Notes',
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
}
