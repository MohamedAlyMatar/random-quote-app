import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:quotes/src/config/locale/app_localizations.dart';
import 'package:quotes/src/core/utils/app_colors.dart';

class ErrorWidget extends StatelessWidget {
  final VoidCallback? onpress;
  const ErrorWidget({super.key, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.warning_amber_outlined,
              color: Colors.red,
              size: 150,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              AppLocalizations.of(context)!.translate('something_went_wrong')!,
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Text(AppLocalizations.of(context)!.translate('please_try_again')!,
              style: TextStyle(
                  color: AppColors.hint,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(AppLocalizations.of(context)!.translate('try_again')!,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: () {
                if (onpress != null) onpress!();
              },
            ),
          )
        ]);
  }
}
