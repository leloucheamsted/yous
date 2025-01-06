import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iridium_reader_widget/views/viewers/epub_screen.dart';
import 'package:mno_navigator/epub.dart';
import 'package:youscribe/presentation/blocs/epub_reader/epub_reader_bloc.dart'
    as e_bloc;
import 'package:youscribe/presentation/blocs/epub_reader/epub_reader_bloc.dart';
import 'package:youscribe/styles/youscribe_colors.dart';

class EpubReader extends StatelessWidget {
  const EpubReader({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = ReaderThemeConfig.defaultTheme
      ..backgroundColor = Theme.of(context).scaffoldBackgroundColor
      ..textColor = YouScribeColors.primaryTextColor;

    return BlocBuilder<e_bloc.EpubReaderBloc, e_bloc.EpubReaderState>(
      builder: (context, state) {
        final bloc = context.read<e_bloc.EpubReaderBloc>();
        if (state is EpubReaderLoadedState) {
          return EpubScreen.fromPath(
              filePath: state.path,
              startPage: state.startPage,
              paginationCallback: (info) {
                bloc.add(e_bloc.PageChangedEpubReaderEvent(
                    spineIndex: info.spineItemIndex,
                    href: info.locator.href,
                    percentage: info.percent,
                    currentPage: info.page));
              },
              onPageSwiped: (href, percentage, spineIndex, currentPage) {
                bloc.add(e_bloc.PageChangedEpubReaderEvent(
                    spineIndex: spineIndex,
                    href: href,
                    percentage: percentage,
                    currentPage: currentPage));
              },
              onDocumentLoaded: (pageCount) async {
                bloc.add(e_bloc.EpubReaderLoadedEvent(totalPages: pageCount));
              },
              themeObject: themeConfig);
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
