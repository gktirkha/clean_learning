import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/theme/app_palette.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static Route<Object?> get route =>
      MaterialPageRoute(builder: (context) => const SignInPage());

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Loader(),
              orElse: () => Form(
                key: _formKey,
                child: Column(
                  spacing: 15,
                  mainAxisAlignment: .center,
                  children: [
                    const Text(
                      'SignIn Page',
                      style: TextStyle(fontSize: 50, fontWeight: .bold),
                    ),
                    const SizedBox(height: 15),
                    AuthField(hintText: 'Email', controller: _emailController),
                    AuthField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 5),
                    AuthGradientButton(
                      label: 'Sign In',
                      onPressed: () {
                        final isValid =
                            _formKey.currentState?.validate() ?? false;

                        if (isValid) {
                          context.read<AuthBloc>().add(
                            AuthEvent.signIn(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, SignupPage.route);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Don\'t Have An Account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppPalette.gradient2,
                                    fontWeight: .bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
