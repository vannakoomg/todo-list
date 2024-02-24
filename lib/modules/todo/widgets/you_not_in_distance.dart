import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';

Future<void> youNotinLocation(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          height: 100,
          child: Column(
            children: [
              Text('Location', style: Theme.of(context).textTheme.titleMedium),
              Expanded(
                child: Center(
                  child: Text('You are not in the rang of Shop ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColor.secondnaryColor)),
          ),
        ],
      );
    },
  );
}
