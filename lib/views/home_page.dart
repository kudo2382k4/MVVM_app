import 'package:flutter/material.dart';
import 'package:mvvm_project/views/login_page.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login/login_viewmodel.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text(
          'Hệ thống quản lý cá nhân',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Chào mừng $username đến với hệ thống quản lý cá nhân',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children: [
                _buildMenuButton(
                  icon: Icons.manage_accounts,
                  label: 'Quản lý người dùng',
                  iconColor: Colors.blue,
                  onTap: () {},
                ),
                _buildMenuButton(
                  icon: Icons.assignment,
                  label: 'Quản lý nhắc việc',
                  iconColor: Colors.orange,
                  onTap: () {},
                ),
                _buildMenuButton(
                  icon: Icons.shopping_cart_outlined,
                  label: 'Đặt hàng',
                  iconColor: Colors.blueAccent,
                  onTap: () {},
                ),
                _buildMenuButton(
                  icon: Icons.map_outlined,
                  label: 'Xem Bản Đồ',
                  iconColor: Colors.redAccent,
                  onTap: () {},
                ),
                _buildMenuButton(
                  icon: Icons.flutter_dash_rounded,
                  label: 'Tổng quan Flutter',
                  iconColor: Colors.lightBlue,
                  onTap: () {},
                ),
                _buildMenuButton(
                  icon: Icons.power_settings_new_outlined,
                  label: 'Đăng xuất',
                  iconColor: Colors.red,
                  onTap: () async{
                    await context.read<LoginViewmodel>().logout();
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

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor, size: 28),
          title: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
