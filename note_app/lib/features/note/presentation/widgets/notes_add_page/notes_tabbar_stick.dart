import 'package:flutter/material.dart';

class NoteTabbarStick extends StatefulWidget {
  const NoteTabbarStick(
      {super.key, required this.widgetColor, required this.widgetPaper});
  final Widget widgetColor;
  final Widget widgetPaper;

  @override
  State<NoteTabbarStick> createState() => _NoteTabbarStickState();
}

class _NoteTabbarStickState extends State<NoteTabbarStick>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: _controller,
            tabs: const [
              Tab(
                text: 'Colors',
              ),
              Tab(
                text: 'Papers',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[widget.widgetColor, widget.widgetPaper],
            ),
          ),
        ],
      ),
    );
  }
}
