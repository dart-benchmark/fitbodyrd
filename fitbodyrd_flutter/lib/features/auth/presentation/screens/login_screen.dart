import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fitbodyrd_flutter/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_text_field.dart';
import 'package:fitbodyrd_flutter/src/core/gen/assets.gen.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/style/style_constants.dart';
import 'package:fitbodyrd_flutter/src/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShowingPassword = false;

  void togglePasswordVisibility() {
    setState(() {
      isShowingPassword = !isShowingPassword;
    });
  }

  void loseFocus() {
    FocusScope.of(context).unfocus();
  }

  Future<void> login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await context.read<AuthCubit>().signIn(
            email: email,
            password: password,
          );
    }
  }

  Future<void> signInWithGoogle() async {
    await context.read<AuthCubit>().signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        if (previous is AuthLoading && current is! AuthLoading) {
          if (current is! AuthSuccess) {
            context.pop();
          }
        }

        return previous != current;
      },
      listener: (context, state) async {
        if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.failure.message);
        }
        if (state is AuthLoading) {
          await CoreUtils.showLoadingDialog(context);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: StyleConstants.screenPadding,
                child: ListView(
                  children: [
                    Center(
                      child: Assets.appIcon.image(
                        width: 125.w,
                        height: 125.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    KSizedBox.s5(),
                    Center(child: KText.headlineLarge('FitBody RD')),
                    KSizedBox.s5(),
                    KText.headlineSmall('Iniciar sesión'),
                    KSizedBox.s10(),
                    CTextField(
                      leadingIcon: Icon(Icons.email_outlined),
                      placeholderText: 'Correo electrónico',
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (_) => loseFocus(),
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu correo electrónico';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor ingresa un correo'
                              ' electrónico válido';
                        }
                        return null;
                      },
                    ),
                    KSizedBox.s10(),
                    CTextField(
                      leadingIcon: Icon(Icons.lock_outline),
                      placeholderText: 'Contraseña',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isShowingPassword,
                      trailingIcon: IconButton(
                        icon: Icon(
                          isShowingPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: togglePasswordVisibility,
                      ),
                      onTapOutside: (_) => loseFocus(),
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe tener'
                              ' al menos 6 caracteres';
                        }
                        return null;
                      },
                      onSubmitted: (_) => login(),
                    ),
                    KSizedBox.s10(),
                    Row(
                      children: [
                        KText.bodyMedium('¿No tienes una cuenta?'),
                        KSizedBox.s5(),
                        CButton(
                          onPressed: () async {
                            await context.pushNamed(
                              AppRoutes.register.name,
                            );
                          },
                          widget: KText.bodySmall(
                            'Regístrate',
                            color: KColors.greyScale.g1000,
                          ),
                          // width: 80.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                          ),
                        ),
                      ],
                    ),
                    KSizedBox.s20(),
                    CButton.primary(
                      text: 'Iniciar sesión',
                      onPressed: login,
                    ),
                    KSizedBox.s15(),
                    Center(child: KText.bodyMedium('o continúa con')),
                    KSizedBox.s15(),
                    CGoogleSignInButton(
                      onPressed: signInWithGoogle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
