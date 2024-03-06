import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/custom_buttom.dart';

Future<void> youNotinLocation(BuildContext context, String descrition) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          height: 150,
          child: Column(
            children: [
              Text('Location', style: Theme.of(context).textTheme.titleMedium),
              Expanded(
                child: Center(
                  child: Text(
                    descrition,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              CustomButtom(
                title: "OK",
                height: 30,
                white: 50,
                onTap: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      );
    },
  );
}
