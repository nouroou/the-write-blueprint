import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_write_blueprint/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:the_write_blueprint/core/theme/app_theme.dart';
import 'package:the_write_blueprint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_write_blueprint/features/auth/presentation/pages/signin_page.dart';
import 'package:the_write_blueprint/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:the_write_blueprint/home_page.dart';
import 'package:the_write_blueprint/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Write Blueprint',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const HomePage();
          }
          return const SigninPage();
        },
      ),
    );
  }
}
