import 'package:batman/styles/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final String loadingText;
  const LoadingIndicator({required this.loadingText});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         SpinKitRipple(
           color: kLightColor,
           size: 85,
         ),
          /*SizedBox(
            height: 80,
            width: 80,
            child: CupertinoActivityIndicator(
              color: Colors.red,
            ),
          ),*/
          SizedBox(height: 45),
          Text(loadingText, style: kRegularLightText16)
        ],
      ),
    ),
    );
  }
}
