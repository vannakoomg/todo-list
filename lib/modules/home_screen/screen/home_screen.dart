import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/todo/screen/todo_detail.dart';
import 'package:googlemap_ui/utils/widgets/custom_cache_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     CustomCachedImageCircle(
              //       image: "",
              //       height: 50,
              //       width: 50,
              //       border: Border.all(color: Colors.black),
              //     ),
              //   ],
              // ),
              Text(
                "TODO TODAY",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const TodoDetail());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: AppColor.secondnaryColor,
                            ),
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Khmer Sl khmesdafsajdfsajflksjdflkajdsflsfskdfksdjfsdjfr",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                      ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: AppColor.secondnaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
