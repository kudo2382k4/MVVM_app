import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/usermanagement/user_viewmodel.dart';
import 'user_management_header.dart';
import 'user_item_card.dart';
import 'user_detail_page.dart';
import 'user_form_page.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewmodel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: const UserManagementHeader(
        title: 'Quản lý người dùng',
        subtitle: 'Danh sách • Thêm/Sửa/Xóa',
      ),
      body: Consumer<UserViewmodel>(
        builder: (context, vm, _) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.error != null) {
            return Center(child: Text('Lỗi: ${vm.error}', style: const TextStyle(color: Colors.red)));
          }
          if (vm.users.isEmpty) {
            return const Center(child: Text('Chưa có người dùng nào.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 16, bottom: 80),
            itemCount: vm.users.length,
            itemBuilder: (context, index) {
              final user = vm.users[index];
              return UserItemCard(
                user: user,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailPage(user: user),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E8CFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserFormPage(),
            ),
          ).then((_) => context.read<UserViewmodel>().refresh());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}