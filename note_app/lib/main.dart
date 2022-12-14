import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/presentation/pages/notes_intro_page.dart';
import 'package:sizer/sizer.dart';
import 'features/note/presentation/bloc/notes_bloc.dart';
import 'ingection_container.dart' as di;

import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<NotesBloc>()..add(GetAllNotesEvent())),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sizer',
            theme: AppTheme.light,
            home: const NotesIntro());
      }),
    );
  }
}
