import 'package:ambeego_test/core/utils/helpers.dart';
import 'package:ambeego_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ambeego_test/features/navigation/screens/bottom_navigation.screen.dart';
import 'package:ambeego_test/utilities/colors.dart';
import 'package:ambeego_test/utilities/navigator.util.dart';
import 'package:ambeego_test/utilities/snack_bar_util.dart';
import 'package:ambeego_test/utilities/spacing_util.dart';
import 'package:ambeego_test/utilities/widgets/custom_textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends HookWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());

    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is LoginError) {
            SnackbarUtil.showErrorSnack(context, state.error);
          }

          if (state is LoginSuccess) {
            CustomNavigator.routeForEver(context, BottomNavigationScreen.routeName);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const YMargin(20),
                    Text(
                      "Welcome back!",
                      style: GoogleFonts.familjenGrotesk(
                        color: AppColors.brandBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Please enter your email and password",
                      style: GoogleFonts.familjenGrotesk(
                        color: AppColors.textLight.withOpacity(0.50),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const YMargin(40),
                    CustomTextFieldWidget(
                      controller: emailController,
                      hintText: "Email",
                      validator: (_) {
                        if (_ != null) {
                          if (_.isEmpty) {
                            return "Please enter your email";
                          }
                        }
                        return null;
                      },
                      prefix: const Icon(
                        Icons.email_outlined,
                        size: 24,
                        color: Color(0xff636975),
                      ),
                    ),
                    const YMargin(20),
                    CustomTextFieldWidget(
                      controller: passwordController,
                      obscureText: true,
                      hintText: "Password",
                      validator: (_) {
                        if (_ != null) {
                          if (_.isEmpty) {
                            return "Please enter your password";
                          }
                        }
                        return null;
                      },
                      prefix: const Icon(
                        Icons.lock_outline,
                        size: 24,
                        color: Color(0xff636975),
                      ),
                    ),
                    const YMargin(40),
                    MaterialButton(
                      onPressed: () {
                        if (!formKey.value.currentState!.validate()) {
                          SnackbarUtil.showErrorSnack(context, 'please enter required fields');
                        }

                        final data = {
                          'EmailAddress': emailController.value.text,
                          'Password': passwordController.value.text,
                        };

                        authBloc.add(LoginUserEvent(data: data));
                      },
                      padding: EdgeInsets.zero,
                      child: Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.brandBlue500,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: state is LoginLoading
                            ? Center(child: Helper.getProgressLoader())
                            : Center(
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.familjenGrotesk(
                                    color: AppColors.brandWhite,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
