// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:googlemap_ui/config/const/app_colors.dart';
// import 'package:googlemap_ui/modules/order/controller/order_controller.dart';
// import 'package:googlemap_ui/modules/order/models/order_model.dart';
// import 'package:googlemap_ui/utils/widgets/custom_add_to_card.dart';
// import 'package:googlemap_ui/utils/widgets/custom_app.dart';
// import 'package:googlemap_ui/utils/widgets/custom_cache_network_image.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   final controller = Get.put(OrderController());
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Scaffold(
//           appBar: CustomAppBar(
//               isClose: true,
//               title: "Order",
//               action: Container(
//                 margin: const EdgeInsets.only(right: 10),
//                 height: 50,
//                 width: 50,
//                 child: Stack(
//                   children: [
//                     const Center(
//                       child: Icon(
//                         Icons.shopping_cart_outlined,
//                       ),
//                     ),
//                     if (controller.order.isNotEmpty)
//                       Positioned(
//                         top: 5,
//                         right: 3,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColor.secondnaryColor),
//                           child: Text(
//                             "${controller.order.length}",
//                             style:
//                                 Theme.of(context).textTheme.bodySmall!.copyWith(
//                                       fontSize: 10,
//                                       color: Colors.white,
//                                     ),
//                           ),
//                         ),
//                       )
//                   ],
//                 ),
//               )),
//           body: Container(
//             padding: const EdgeInsets.only(left: 10, right: 10),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: GridView.count(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 20,
//                     crossAxisSpacing: 20,
//                     childAspectRatio: 0.9,
//                     children: [
//                       ...[1, 1, 1, 1, 1, 1, 11, 1].map((e) {
//                         return GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                             clipBehavior: Clip.antiAlias,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                 width: 0.5,
//                                 color: Theme.of(context).colorScheme.onPrimary,
//                               ),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             width: double.infinity,
//                             child: Column(
//                               children: [
//                                 const Expanded(
//                                   flex: 6,
//                                   child: CustomCachedImageCircle(
//                                     width: double.infinity,
//                                     image:
//                                         "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202209/Drugs_1200x768.jpeg?VersionId=sexzIYibOYVaJRFr6cOuQeYsxbkT1MuZ&size=690:388",
//                                     borderRadius: BorderRadius.zero,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Container(
//                                     padding: const EdgeInsets.only(
//                                         left: 10, right: 10),
//                                     width: double.infinity,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text(
//                                           "Ranitidine",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .copyWith(
//                                                   color: Theme.of(context)
//                                                       .colorScheme
//                                                       .onSecondary),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 "10\$",
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             CustomAddToCard(
//                                                 number: 3,
//                                                 ontap1: () {
//                                                   controller.order.add(
//                                                     OrderModel(19, "sdfdsf"),
//                                                   );
//                                                 },
//                                                 ontap2: () {
//                                                   controller.order.add(
//                                                     OrderModel(19, "sdfdsf"),
//                                                   );
//                                                 })
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       })
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
