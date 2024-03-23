import 'package:batman/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: Image.asset(
                    'assets/images/cross.png',
                    width: 70,
                    height: 70
                ),
              ),
              SizedBox(height: 32),
              Text("Uh-ho!",
                style: kMediumLightText18,),
              SizedBox(height: 12,),
              Text('Error Message. Please contact admin',
                style: kRegularLightText14,
                textAlign: TextAlign.center,)
            ],
          )
      ),
    );
  }
}