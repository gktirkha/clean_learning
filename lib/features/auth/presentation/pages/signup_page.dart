import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/theme/app_palette.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';
import 'sign_in_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static Route<Object?> get route =>
      MaterialPageRoute(builder: (context) => const SignupPage());

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const .all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
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
                      'Signup Page',
                      style: TextStyle(fontSize: 50, fontWeight: .bold),
                    ),
                    const SizedBox(height: 15),
                    AuthField(hintText: 'Name', controller: _nameController),
                    AuthField(hintText: 'Email', controller: _emailController),
                    AuthField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 5),
                    AuthGradientButton(
                      label: 'Sign Up',
                      onPressed: () {
                        final isValid =
                            _formKey.currentState?.validate() ?? false;
                        if (!isValid) {
                          return;
                        }
                        context.read<AuthBloc>().add(
                          AuthEvent.signup(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, SignInPage.route);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Already Have An Account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign In',
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
          listener: (context, state) {},
        ),
      ),
    );
  }
}
