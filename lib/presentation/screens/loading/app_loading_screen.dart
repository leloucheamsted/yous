import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:youscribe/presentation/blocs/app_loading/app_loading_bloc.dart';
import 'package:youscribe/styles/youscribe_colors.dart';
import 'package:youscribe/utilities/constants.dart';

class AppLoadingScreen extends StatefulWidget {
  const AppLoadingScreen({super.key});

  @override
  State<AppLoadingScreen> createState() => _AppLoadingScreenState();
}

class _AppLoadingScreenState extends State<AppLoadingScreen> {
  String version = "";

  void getInfo() {
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        version = "${packageInfo.version} (${packageInfo.buildNumber})";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getInfo();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLoadingBloc, AppLoadingState>(
      builder: (context, state) {
        return Scaffold(
          body: ColoredBox(
              color: YouScribeColors.whiteColor,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                          height: 100,
                          child: Image.asset("assets/images/app_icon.png")),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        child: Text(
                          '${AssetsName.appName} - $version',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  overflow: TextOverflow.clip,
                                  color: YouScribeColors.secondaryTextColor),
                        )),
                  ),
                ],
              )),
        );
      },
    );
  }
}
