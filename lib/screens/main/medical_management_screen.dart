import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_city/controllers/medical_management_controller.dart';
import 'package:medical_city/models/user_model.dart';

class MedicalManagementScreen extends StatelessWidget {
  const MedicalManagementScreen({super.key});

  // Local filters state
  static final RxString _query = ''.obs;
  static final RxBool _adminsOnly = false.obs;
  static final RxBool _activeOnly = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalManagementController>(
      init: MedicalManagementController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Medical Management'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.fetchUsers,
              ),
            ],
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.users.isEmpty) {
              return const Center(child: Text('No doctors found'));
            }
            final String q = _query.value.toLowerCase().trim();
            final List<UserModel> filtered = controller.users.where((u) {
              bool ok = true;
              if (q.isNotEmpty) {
                ok =
                    (u.name.toLowerCase().contains(q)) ||
                    (u.email.toLowerCase().contains(q)) ||
                    (u.phone.toLowerCase().contains(q));
              }
              if (_adminsOnly.value) ok = ok && u.isAdmin;
              if (_activeOnly.value) ok = ok && u.isActive;
              return ok;
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search by name, email or phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: true,
                    ),
                    onChanged: (v) => _query.value = v,
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Obx(
                        () => FilterChip(
                          label: const Text('Admins only'),
                          selected: _adminsOnly.value,
                          onSelected: (v) => _adminsOnly.value = v,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => FilterChip(
                          label: const Text('Active only'),
                          selected: _activeOnly.value,
                          onSelected: (v) => _activeOnly.value = v,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          _query.value = '';
                          _adminsOnly.value = false;
                          _activeOnly.value = false;
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final user = filtered[index];
                      return _DoctorCard(
                        user: user,
                        onTap: () =>
                            _showDoctorDetails(context, controller, user),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  void _showDoctorDetails(
    BuildContext context,
    MedicalManagementController controller,
    UserModel user,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: user.imageUrl.isNotEmpty
                              ? NetworkImage(user.imageUrl) as ImageProvider
                              : const AssetImage('assets/images/app_icon.png'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(user.email),
                              Text(user.phone),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Info',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _InfoRow(
                              label: 'Birth date',
                              value: user.birthDate
                                  .toIso8601String()
                                  .split('T')
                                  .first,
                            ),
                            _InfoRow(
                              label: 'Joined at',
                              value: user.joinAt
                                  .toIso8601String()
                                  .split('T')
                                  .first,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Permissions',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() {
                              final current = controller.users.firstWhere(
                                (u) => u.id == user.id,
                              );
                              return Column(
                                children: [
                                  SwitchListTile(
                                    title: const Text('Active'),
                                    value: current.isActive,
                                    onChanged: (v) =>
                                        controller.updateIsActive(current, v),
                                  ),
                                  SwitchListTile(
                                    title: const Text('Admin'),
                                    value: current.isAdmin,
                                    onChanged: (v) =>
                                        controller.updateIsAdmin(current, v),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  const _DoctorCard({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.imageUrl.isNotEmpty
            ? NetworkImage(user.imageUrl) as ImageProvider
            : const AssetImage('assets/images/app_icon.png'),
      ),
      title: Text(user.name.isEmpty ? 'Unnamed' : user.name),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            user.isActive ? Icons.check_circle : Icons.cancel,
            color: user.isActive ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          if (user.isAdmin) const Icon(Icons.verified, color: Colors.amber),
        ],
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
