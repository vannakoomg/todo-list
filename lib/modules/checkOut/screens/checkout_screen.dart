import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Check Out"),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Remake",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          " *",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColor.dangerColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.secondnaryColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: AppColor.secondnaryColor,
                          ),
                        ),
                        hintText: "Enter remake",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Image",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColor.secondnaryColor,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "Attament Image",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Image",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ]),
            ),
            CustomButtom(
              title: "CHECK OUT",
              onTap: () {},
              white: MediaQuery.of(context).size.width / 2.7,
            )
          ],
        ),
      ),
    );
  }
}
