import 'package:bitirme_projesi/db/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_cubit.dart';
import '../localizations/localizations.dart';

class titleWidget extends StatefulWidget {
  titleWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<titleWidget> createState() => _titleWidgetState();
}

class _titleWidgetState extends State<titleWidget> {
  late final SettingsCubit settings;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settings = context.read<SettingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          width: constraint.maxWidth,
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                settings.state.userInfo.isNotEmpty
                    ? settings.state.userInfo[0]
                    : '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w200,
                    ),
              ),
              Wrap(children: [
                Text(
                  AppLocalizations.of(context).getTranslate("title_text"),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
