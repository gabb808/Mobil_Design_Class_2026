import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/repositories/neighbordrop_repository.dart';
import 'screens/articles_list/articles_list_controller.dart';
import 'screens/articles_list/articles_list_screen.dart';
import 'screens/article_detail/article_detail_controller.dart';
import 'screens/article_detail/article_detail_screen.dart';
import 'screens/post_article/post_article_controller.dart';
import 'screens/post_article/post_article_screen.dart';
import 'screens/user_profile/user_profile_controller.dart';
import 'screens/user_profile/user_profile_screen.dart';
import 'screens/messages/messages_controller.dart';
import 'screens/messages/messages_screen.dart';
import 'shared/theme/app_colors.dart';

void main() {
  runApp(const NeighborDropApp());
}

class NeighborDropApp extends StatelessWidget {
  const NeighborDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NeighborDrop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      initialBinding: AppBindings(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const ArticlesListScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => ArticlesListController());
          }),
        ),
        GetPage(
          name: '/article-detail',
          page: () => const ArticleDetailScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => ArticleDetailController());
          }),
        ),
        GetPage(
          name: '/post-article',
          page: () => const PostArticleScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => PostArticleController());
          }),
        ),
        GetPage(
          name: '/profile',
          page: () => const UserProfileScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => UserProfileController());
          }),
        ),
        GetPage(
          name: '/messages',
          page: () => const MessagesScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => MessagesController());
          }),
        ),
      ],
    );
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NeighbordropRepository());
  }
}
