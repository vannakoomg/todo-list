import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/checkOut/screens/checkout_screen.dart';
import 'package:googlemap_ui/modules/todo/controller/todo_controller.dart';
import 'package:googlemap_ui/modules/todo/screen/simple_google_map.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(title: "Todo Detail"),
      body: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          margin:
              const EdgeInsets.only(bottom: 20, right: 10, left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shop Name",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                    Text(
                      "Khmer",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Address",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                    Text(
                      "Khmersdjfsjdflkjdslfjsldfjlasdfjlsdjflksdjflsjdfjdslfjdslfjssdfjsdjfdsjfljsdalfjlsadjlkasjdfljsadfjsadj",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.showMapDetail(context);
                      },
                      child: const SizedBox(
                        height: 200,
                        child: SimpleGoogleMap(),
                      ),
                    )
                  ],
                ),
              )),
              CustomButtom(
                white: MediaQuery.sizeOf(context).width / 2.7,
                title: "CHECKIN",
                onTap: () {
                  Get.to(() => const CheckOutScreen());
                },
              )
            ],
          )),
    );
  }
}
