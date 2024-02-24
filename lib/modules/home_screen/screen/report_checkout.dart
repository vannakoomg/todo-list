import 'package:flutter/material.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_cache_network_image.dart';

class ReportCheckOut extends StatelessWidget {
  const ReportCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(title: "Detail"),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: AppColor.secondnaryColor,
          //   width: 0.5,
          // ),
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date:",
              style: Theme.of(context).textTheme.titleMedium!,
            ),
            Text(
              "12/12/2024",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Remake:",
              style: Theme.of(context).textTheme.titleMedium!,
            ),
            Text(
              "12/12/sadkjfkldajsdkdsakdsalkjksaj;lkdjlkdslkjsafdsa;lkjdsal;kjdsalkjdsa;lklkdsajdsakjsalkfdjaskdjfsadjfadsjasdkfjsajdjf2024",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            Row(
              children: [
                Text(
                  "Get Order",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Checkbox(
                  value: true,
                  activeColor: AppColor.successColor,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    // controller.ischeck.value = !controller.ischeck.value;
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            CustomCachedImageCircle(
              borderRadius: BorderRadius.circular(0),
              height: 200,
              width: 400,
              image:
                  "https://scontent.fpnh24-1.fna.fbcdn.net/v/t39.30808-6/386646496_880697763424738_311833906648663546_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeFpnw8CeKvgWHZx7iHDfb1fSrticfRa7l5Ku2Jx9FruXvvzI7lxO2SE7QREmxr5eYxJ78eLMJ8EMP1iNHNtRfp6&_nc_ohc=xAi-ZWnGqDsAX_VnXSy&_nc_ht=scontent.fpnh24-1.fna&oh=00_AfCAiN_YYqDKSnVGEeZg0p2-4B6mNu_zP_57aA3iERBJqQ&oe=65DCAC60",
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "11.569569289012044, 104.89129363516827",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openGoogleMap(
                        context, 11.568449483008305, 104.89069000146132);
                  },
                  child: Text(
                    "View Map",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColor.secondnaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
