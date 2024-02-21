import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/modules/checkOut/screens/checkout_screen.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(title: "Todo Detail"),
      body: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
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
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 0.5),
                        borderRadius: BorderRadius.circular(8),
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
