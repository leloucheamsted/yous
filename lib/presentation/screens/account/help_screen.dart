import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:youscribe/presentation/blocs/help/help_cubit.dart';
import 'package:youscribe/presentation/screens/account/components/help_components/help_account.dart';
import 'package:youscribe/presentation/screens/account/components/help_components/help_contact.dart';
import 'package:youscribe/presentation/screens/account/components/help_components/help_general.dart';
import 'package:youscribe/presentation/screens/account/components/help_components/help_library.dart';
import 'package:youscribe/presentation/screens/account/components/help_components/help_tokens.dart';
import 'package:youscribe/presentation/screens/dialog/dialogs.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/constants.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({required this.isTokenExpand, super.key});
  final bool isTokenExpand;
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String version = "";
  bool isBusy = false;

  final GlobalKey<ExpansionTileCardState> tokensCardKey = GlobalKey();
  final ScrollController _scrollViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  void getInfo() {
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Locale myLanguage = Localizations.localeOf(context);
    final cubit = HelpCubit();

    final baseURL = myLanguage.languageCode.isNullOrEmpty
        ? "https://youscribe.com"
        : "https://${myLanguage.languageCode}.youscribe.com";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0.5,
        title: Image(
            height: 35,
            image: AssetImage(Provider.of<YouScribeTheme>(context).brand)),
      ),
      body: BlocProvider.value(
          value: cubit,
          child: BlocBuilder<HelpCubit, HelpState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is HelpExceptionErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Dialogs.displayGeneralAPIErrorAlert(context: context);
                  });
                }
                final loadedState = state as HelpInitialState;

                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: SingleChildScrollView(
                            controller: _scrollViewController,
                            child: Column(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.faqName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    HelpGeneral(baseUrl: baseURL),
                                    HelpAccount(baseUrl: baseURL, cubit: cubit),
                                    const HelpLibrary(),
                                    HelpContact(baseUrl: baseURL),
                                    HelpTokens(
                                      isTokenExpand: widget.isTokenExpand,
                                      keys: tokensCardKey,
                                      scrollViewController:
                                          _scrollViewController,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${AssetsName.appName} ($version)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                overflow: TextOverflow.clip,
                                                color: YouScribeColors
                                                    .secondaryTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: loadedState.isBusy
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: YouScribeColors.accentColor,
                              ),
                            )
                          : null,
                    ),
                  ],
                );
              })),
    );
  }
}
