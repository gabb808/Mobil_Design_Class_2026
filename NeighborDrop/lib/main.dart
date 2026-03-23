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
import 'screens/user_profile/edit_profile_controller.dart';
import 'screens/user_profile/edit_profile_screen.dart';
import 'screens/user_profile/my_articles_controller.dart';
import "screens/user_profile/my_articles_screen.dart";
import 'screens/user_profile/my_favorites_controller.dart';
import 'screens/user_profile/my_favorites_screen.dart';
import 'screens/messages/conversations_controller.dart';
import 'screens/messages/conversations_screen.dart';
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
          page: () => const MainShell(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => ArticlesListController());
            Get.lazyPut(() => ConversationsController());
            Get.lazyPut(() => UserProfileController());
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
          name: '/chat',
          page: () => const MessagesScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => MessagesController());
          }),
        ),
        // Legacy /messages route (contactVoisin depuis article detail)
        GetPage(
          name: '/messages',
          page: () => const MessagesScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => MessagesController());
          }),
        ),
        GetPage(
          name: '/profile',
          page: () {
            final String? userId = Get.arguments;
            final tag = userId?.toString() ?? 'other';
            return UserProfileScreen(tagOverride: tag);
          },
          binding: BindingsBuilder(() {
            final String? userId = Get.arguments;
            final tag = userId?.toString() ?? 'other';
            Get.lazyPut(() => UserProfileController(), tag: tag);
          }),
        ),
        GetPage(
          name: '/edit-profile',
          page: () => const EditProfileScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => EditProfileController());
          }),
        ),
        GetPage(
          name: '/my-articles',
          page: () => const MyArticlesScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => MyArticlesController());
          }),
        ),
        GetPage(
          name: '/my-favorites',
          page: () => const MyFavoritesScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => MyFavoritesController());
          }),
        ),
      ],
    );
  }
}

/// Shell avec bottom navigation: Accueil / Messages / Profil
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ArticlesListScreen(),
    ConversationsScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Obx(() {
        final convCtrl = Get.find<ConversationsController>();
        final unread = convCtrl.totalUnread;
        return BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() => _currentIndex = index);
            if (index == 1) convCtrl.loadConversations();
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: unread > 0
                  ? Badge(
                      label: Text('$unread'),
                      child: const Icon(Icons.forum_outlined),
                    )
                  : const Icon(Icons.forum_outlined),
              activeIcon: unread > 0
                  ? Badge(
                      label: Text('$unread'),
                      child: const Icon(Icons.forum),
                    )
                  : const Icon(Icons.forum),
              label: 'Messages',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        );
      }),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () => Get.toNamed('/post-article'),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NeighbordropRepository());
  }
}

