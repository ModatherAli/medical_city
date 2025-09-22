import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/loading_view.dart';

class RedirectScreen extends StatelessWidget {
  const RedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingView();
    return BlocBuilder(
      builder: (context, state) {
        // if (state is AuthInitial) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     context.read<AuthBloc>().add(AuthCheckRequested());
        //   });
        // }

        // if (state is AuthLoggedOut) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     // Reset UserBloc when logout is detected
        //     context.read<UserBloc>().add(UserLogout());
        //     context.replace(NavigationRoutes.intro);
        //   });
        // }
        // if (state is AuthAuthenticated) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     // Ensure UserBloc loads fresh data for the authenticated user
        //     context.read<UserBloc>().add(LoadUser());
        //     context.go(NavigationRoutes.main);
        //   });
        // }
        // if (state is AuthError) {
        //   return ErrorScreen(message: state.message);
        // }
        return const LoadingView();
      },
    );
  }
}
