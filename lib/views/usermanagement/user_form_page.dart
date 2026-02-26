import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/managed_user.dart';
import '../../viewmodels/usermanagement/user_viewmodel.dart';
import 'user_management_header.dart';

class UserFormPage extends StatefulWidget {
  final ManagedUser? user; // Nếu null là Thêm, có data là Sửa

  const UserFormPage({Key? key, this.user}) : super(key: key);

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _addressController;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.fullName ?? '');
    _dobController = TextEditingController(text: widget.user?.dob ?? '');
    _addressController = TextEditingController(text: widget.user?.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2E8CFF)),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final vm = context.read<UserViewmodel>();
      final name = _nameController.text.trim();
      final dob = _dobController.text.trim();
      final address = _addressController.text.trim();
      if (widget.user == null) {
        await vm.add(name, dob, address);
      } else {
        await vm.update(widget.user!.id, name, dob, address);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: UserManagementHeader(
        title: widget.user == null ? 'Thêm người dùng' : 'Sửa người dùng',
        subtitle: 'Nhập thông tin và bấm Lưu',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: _buildInputDecoration('Họ và tên'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Vui lòng nhập họ tên' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dobController,
                      decoration: _buildInputDecoration(
                        'Ngày sinh',
                        suffixIcon: const Icon(Icons.calendar_today, size: 20),
                      ),
                      readOnly: true,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Vui lòng chọn ngày sinh' : null,
                      onTap: () async {
                        final now = DateTime.now();
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(1900),
                          lastDate: now,
                        );
                        if (picked != null) {
                          _dobController.text =
                              '${picked.day.toString().padLeft(2, '0')}/'
                              '${picked.month.toString().padLeft(2, '0')}/'
                              '${picked.year}';
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: _buildInputDecoration('Địa chỉ'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Vui lòng nhập địa chỉ' : null,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _saving ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('Hủy', style: TextStyle(color: Colors.black54)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saving ? null : _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E8CFF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: _saving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text('Lưu', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}