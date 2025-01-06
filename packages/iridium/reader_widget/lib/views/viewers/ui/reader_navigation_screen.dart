import 'package:flutter/material.dart';
import 'package:iridium_reader_widget/views/viewers/ui/content_panel.dart';
import 'package:mno_navigator/publication.dart';

class ReaderNavigationScreen extends StatefulWidget {
  final ReaderContext readerContext;

  const ReaderNavigationScreen({super.key, required this.readerContext});

  @override
  State<ReaderNavigationScreen> createState() => _ReaderNavigationScreenState();
}

class _ReaderNavigationScreenState extends State<ReaderNavigationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Tables de Matières'),
        ),
        body: SafeArea(
          child: ContentPanel(
            readerContext: widget.readerContext,
          ),
        ),
      );
}
