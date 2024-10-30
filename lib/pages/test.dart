// import 'package:flutter/material.dart';
// import 'package:mafia_killer/components/my_outlined_button.dart';
// import 'package:mafia_killer/components/night_player_tile.dart';
// import 'package:mafia_killer/components/page_frame.dart';
// import 'package:mafia_killer/themes/app_color.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageFrame(
//         pageTitle: "تنظیمات این دست",
//         rightButtonText: "بعدی",
//         leftButtonText: "قبلی",
//         leftButtonOnTap: () => Navigator.pop(context),
//         rightButtonOnTap: () =>
//             Navigator.pushNamed(context, '/role_selection_page'),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 15,
//                 child: Directionality(
//                   textDirection: TextDirection.ltr,
//                   child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, // Number of tiles per row
//                       childAspectRatio: 1, // Width/height ratio of tiles
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                     ),
//                     itemCount: 11,
//                     itemBuilder: (context, index) {
//                       return const NightPlayerTile();
//                     },
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 4,
//                 child: Container(
//                   margin: const EdgeInsets.only(top: 25),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           const Image(
//                             image: AssetImage(
//                               'lib/images/backgrounds/wood-plank.png',
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(top: 7),
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   "تیم مافیا بخوابه",
//                                   style: TextStyle(
//                                     color: AppColors.brownColor,
//                                   ),
//                                 ),
//                                 OutlinedButton(
//                                   style: OutlinedButton.styleFrom(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 30),
//                                     foregroundColor: AppColors.brownColor,
//                                     side: const BorderSide(
//                                       width: 3,
//                                       color: AppColors.brownColor,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                         8,
//                                       ),
//                                     ),
//                                   ),
//                                   onPressed: () {},
//                                   child: const Text("خوابید"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
