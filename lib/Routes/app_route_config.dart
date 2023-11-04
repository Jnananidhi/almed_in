// import 'package:almed_in/Screens/Home/about_screen.dart';
// import 'package:almed_in/Screens/Home/contact_screen.dart';
// import 'package:almed_in/Screens/Home/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import 'app_route_constants.dart';
//
//
// class NyAppRouter {
//   static GoRouter returnRouter(bool isAuth) {
//     GoRouter router = GoRouter(
//       routes: [
//         GoRoute(
//           name: MyAppRouteConstants.homeRouteName,
//           path: '/',
//           pageBuilder: (context, state) {
//             return MaterialPage(child: HomeScreen());
//           },
//         ),
//         // GoRoute(
//         //   name: MyAppRouteConstants.profileRouteName,
//         //   path: '/profile/:username/:userid',
//         //   pageBuilder: (context, state) {
//         //     return MaterialPage(
//         //         child: Profile(
//         //           userid: state.params['userid']!,
//         //           username: state.params['username']!,
//         //         ));
//         //   },
//         // ),
//         GoRoute(
//           name: MyAppRouteConstants.aboutRouteName,
//           path: '/about',
//           pageBuilder: (context, state) {
//             return MaterialPage(child: AboutScreen());
//           },
//         ),
//         GoRoute(
//           name: MyAppRouteConstants.contactUsRouteName,
//           path: '/contact_us',
//           pageBuilder: (context, state) {
//             return MaterialPage(child: ContactUsApp());
//           },
//         )
//       ],
//       // errorPageBuilder: (context, state) {
//       //   return MaterialPage(child: ErrorPage());
//       // },
//       redirect: (context, state) {
//         if (!isAuth &&
//             state.location
//                 .startsWith('/${MyAppRouteConstants.profileRouteName}')) {
//           return context.namedLocation(MyAppRouteConstants.contactUsRouteName);
//         } else {
//           return null;
//         }
//       },
//     );
//     return router;
//   }
// }