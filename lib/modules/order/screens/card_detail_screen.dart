import 'package:flutter/material.dart';
import 'package:googlemap_ui/utils/widgets/custom_add_to_card.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_cache_network_image.dart';

class CardDetailScreen extends StatefulWidget {
  const CardDetailScreen({super.key});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isClose: true,
        title: "Cart",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              // color: const Color.fromARGB(255, 255, 246, 232),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              ...[1, 1, 1, 1, 1, 1, 1, 1].asMap().entries.map((e) {
                return Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(),
                      width: double.infinity,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCachedImageCircle(
                            height: 80,
                            width: 80,
                            image:
                                "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202209/Drugs_1200x768.jpeg?VersionId=sexzIYibOYVaJRFr6cOuQeYsxbkT1MuZ&size=690:388",
                            borderRadius: BorderRadius.circular(10),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 80,
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Ssometric medicine lsdafadsfksafk;lfdpills bottle",
                                  ),
                                  CustomAddToCard(
                                    number: 1,
                                    ontap1: () {},
                                    ontap2: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "100\$",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      height: 0.5,
                      color: Theme.of(context).colorScheme.onSecondary,
                    )
                  ],
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "SUBTOTAL",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    "1000\$",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "DISCOUNT",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    "10%",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "TOTAL",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    "900\$",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
