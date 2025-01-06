import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youscribe/styles/youscribe_theme.dart';

class PersonnalLegalNoticeScreen extends StatelessWidget {
  const PersonnalLegalNoticeScreen({
    required this.content,
    super.key,
  });
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0.5,
          title: Image(
              height: 35,
              image: AssetImage(Provider.of<YouScribeTheme>(context).brand)),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Html(
                data: """
                $content
                """,
                onLinkTap: (url, _, __) async {
                  final Uri uri = Uri.parse(url ?? '');
                  await launchUrl(uri);
                }),
          ),
        ));
  }
}
