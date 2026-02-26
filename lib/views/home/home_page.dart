import 'package:flutter/material.dart';
import 'package:mvvm_project/views/login_page.dart';
import 'package:mvvm_project/views/home/home_header.dart';
import 'package:mvvm_project/views/home/home_menu_button.dart';
import 'package:mvvm_project/views/usermanagement/user_management_page.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/login/login_viewmodel.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F4FF),
      appBar: HomeHeader(username: username),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Xin chào bạn đến với hệ thống quản lý cá nhân',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D47A1),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                HomeMenuButton(
                  icon: Icons.manage_accounts,
                  label: 'Quản lý người dùng',
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserManagementPage(),
                      ),
                    );
                  },
                ),
                HomeMenuButton(
                  icon: Icons.assignment,
                  label: 'Quản lý nhắc việc',
                  iconColor: Colors.orange,
                  onTap: () {},
                ),
                HomeMenuButton(
                  icon: Icons.shopping_cart_outlined,
                  label: 'Đặt hàng',
                  iconColor: Colors.blueAccent,
                  onTap: () {},
                ),
                HomeMenuButton(
                  icon: Icons.map_outlined,
                  label: 'Xem Bản Đồ',
                  iconColor: Colors.redAccent,
                  onTap: () {},
                ),
                HomeMenuButton(
                  icon: Icons.image_search_outlined,
                  label: 'Xem ảnh qua API',
                  iconColor: Colors.lightBlue,
                  onTap: () {},
                ),
                HomeMenuButton(
                  icon: Icons.flutter_dash_rounded,
                  label: 'Tổng quan Flutter',
                  iconColor: Colors.teal,
                  onTap: () {},
                ),
                HomeMenuButton(
                  icon: Icons.power_settings_new_outlined,
                  label: 'Đăng xuất',
                  iconColor: Colors.red,
                  onTap: () async {
                    final vm = context.read<LoginViewmodel>();
                    await vm.logout();
                    if (!context.mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (_) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
