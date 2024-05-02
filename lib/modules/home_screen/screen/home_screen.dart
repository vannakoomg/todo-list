import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/home_screen/controller/home_controller.dart';
import 'package:googlemap_ui/modules/todo/screen/check_in_non_customer.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';
import 'package:googlemap_ui/utils/widgets/custom_oops.dart';
import 'package:googlemap_ui/utils/widgets/custom_todo_card.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/fuction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());

  @override
  void initState() {
    debugPrint("selellll ${controller.dateSelected.value}");

    Future.delayed(const Duration(milliseconds: 100), () {
      controller.dateSelected.value = formatDate(DateTime.now());
      requestPermission();
      controller.fetchSale(
          dateTo: formatDate(
            DateTime.now(),
          ),
          fromDate: formatDate(
            DateTime.now(),
          ));
      controller.getCurrentLocation();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Obx(
        () => Scaffold(
          appBar: CustomAppBar(
            isLeading: false,
            title: "Sale Activity",
            action: CustomButtom(
              title: "",
              white: 40,
              onTap: () {
                Get.to(const CheckInNonCustomerScreen());
              },
              icon: Icons.add,
            ),
          ),
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TableCalendar(
                    daysOfWeekHeight: 30,
                    calendarBuilders: CalendarBuilders(
                      disabledBuilder: (context, day, focusedDay) {
                        return SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                              child: Text("${day.day}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withOpacity(0.7),
                                      ))),
                        );
                      },
                      defaultBuilder: (context, day, focusedDay) {
                        return SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                              child: Text("${day.day}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ))),
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        return SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                              child: Text("${day.day}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ))),
                        );
                      },
                      selectedBuilder: (context, timeNow, event) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.secondnaryColor.withOpacity(0.2),
                            border: Border.all(
                              color: AppColor.secondnaryColor,
                              width: 0.6,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${timeNow.day}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                    // headerVisible: false,
                    headerStyle: const HeaderStyle(
                      // rightChevronVisible: false,
                      formatButtonVisible: false,

                      // formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    weekendDays: const [DateTime.sunday],

                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.now(),
                    focusedDay: DateTime.parse(controller.dateSelected.value),
                    selectedDayPredicate: (day) {
                      // debugPrint("ddd $day");
                      if (formatDate(day) == controller.dateSelected.value) {
                        return true;
                      }
                      return false;
                    },

                    onPageChanged: ((focusedDay) {
                      var dates = getStartAndEndOfWeek(focusedDay);
                      controller.fromDate.value = formatDate(DateTime.parse(
                          dates['startOfWeek']!.toIso8601String()));
                      controller.dateTo.value = formatDate(DateTime.parse(
                          dates['endOfWeek']!.toIso8601String()));
                      controller.fetchSale(
                          fromDate: controller.fromDate.value,
                          dateTo: controller.dateTo.value);
                      controller.dateSelected.value =
                          dates['startOfWeek']!.toIso8601String();
                    }),
                    onDaySelected: (selectedDay, focusedDay) {
                      debugPrint("$focusedDay");
                      controller.dateSelected.value = formatDate(selectedDay);
                      controller.fromDate.value = formatDate(selectedDay);
                      controller.dateTo.value = formatDate(selectedDay);
                      controller.fetchSale(
                        fromDate: controller.fromDate.value,
                        dateTo: controller.dateTo.value,
                      );
                      //user that setState just make the screen render again
                      setState(() {});
                    },
                    calendarFormat:
                        CalendarFormat.week, // Show only one week at a time
                    // Customize days of the week appearance
                    // calendarStyle: CalendarStyle(weekendTextStyle: ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      // Example of customization
                      weekdayStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary),
                      weekendStyle: const TextStyle(
                        color: Colors.red,
                      ),
                    ),

                    // Other customizations can be applied according to your requirements
                  ),
                  Expanded(
                    child: controller.isloading.value
                        ? const Center(
                            child: CustomLoading(),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              debugPrint("dfdfdf");

                              controller.fetchSale(
                                fromDate: controller.fromDate.value,
                                dateTo: controller.dateTo.value,
                              );
                            },
                            color: AppColor.secondnaryColor,
                            triggerMode: RefreshIndicatorTriggerMode.anywhere,
                            displacement: 40,
                            child: controller.saleData.value.data != null
                                ? controller.saleData.value.data!.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: controller
                                            .saleData.value.data!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              controller.gpsRange.value =
                                                  10000000000;
                                              // controller.saleData.value
                                              //     .data![index].gpsRange!;
                                              controller.indexOfSale.value =
                                                  index;
                                              double photoLat = controller
                                                          .saleData
                                                          .value
                                                          .data![index]
                                                          .photoLat ==
                                                      ""
                                                  ? 0
                                                  : double.parse(controller
                                                      .saleData
                                                      .value
                                                      .data![index]
                                                      .photoLat!);
                                              double photoLong = controller
                                                          .saleData
                                                          .value
                                                          .data![index]
                                                          .photoLong ==
                                                      ""
                                                  ? 0
                                                  : double.parse(controller
                                                      .saleData
                                                      .value
                                                      .data![index]
                                                      .photoLong!);
                                              controller.ontapSaleActivity(
                                                  photolong: photoLong,
                                                  photoLat: photoLat,
                                                  date:
                                                      "${controller.saleData.value.data![index].checkOutDate}",
                                                  hasOrder: controller
                                                          .saleData
                                                          .value
                                                          .data![index]
                                                          .hasOrder ??
                                                      false,
                                                  remark:
                                                      "${controller.saleData.value.data![index].remark}",
                                                  urlImage:
                                                      "${controller.saleData.value.data![index].photo}",
                                                  checkInId: controller
                                                          .saleData
                                                          .value
                                                          .data![index]
                                                          .id ??
                                                      0,
                                                  name:
                                                      "${controller.saleData.value.data![index].customerName}",
                                                  lat: controller.saleData.value
                                                          .data![index].lat ??
                                                      0.0,
                                                  lng: controller.saleData.value
                                                          .data![index].long ??
                                                      0.0,
                                                  status:
                                                      "${controller.saleData.value.data![index].status}");
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                                right: 10,
                                              ),
                                              child: CustomTodoCard(
                                                name: controller
                                                        .saleData
                                                        .value
                                                        .data![index]
                                                        .customerName ??
                                                    "",
                                                stuts: controller.saleData.value
                                                        .data![index].status ??
                                                    "",
                                                customer: controller
                                                        .saleData
                                                        .value
                                                        .data![index]
                                                        .customerName ??
                                                    "",
                                                address: controller
                                                        .saleData
                                                        .value
                                                        .data![index]
                                                        .address ??
                                                    "",
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height +
                                                4000,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.coffee,
                                              color: Color.fromARGB(
                                                  255, 235, 55, 103),
                                              size: 50,
                                            ),
                                            Text(
                                              "No Task!",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )
                                : CustomOops(
                                    ontap: () {
                                      controller.fetchSale(
                                        fromDate: controller.fromDate.value,
                                        dateTo: controller.dateTo.value,
                                      );
                                    },
                                  ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
