import 'package:flutter/material.dart';
import 'package:lms/screen/home/home_screen/content/home_content.dart';
import 'package:lms/screen/home/home_screen/home_provider.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: HomeContent(provider: provider,),
          ),
        );
      },
    );
  }
}

