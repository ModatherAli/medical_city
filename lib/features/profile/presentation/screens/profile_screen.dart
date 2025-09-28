import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:medical_city/features/auth/presentation/bloc/auth_event.dart';
import 'package:medical_city/features/auth/presentation/bloc/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          context.go(NavigationRoutes.login);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            final user = state.authModel;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 50,
                    // backgroundImage: NetworkImage('...'), // TODO: Add user image
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.name ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.phone ?? 'No Phone Number',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_border),
                    title: const Text('Favorite'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications_none),
                    title: const Text('Notifications'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.push(NavigationRoutes.settings),
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Help and Support'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield_outlined),
                    title: const Text('Terms and Conditions'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log Out'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content:
                                const Text('are you sure you want to log out?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Yes, Logout'),
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthLogoutRequested());
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      ),
    );
  }
}