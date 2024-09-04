import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_login/cubit/auth_cubit.dart';
import 'package:flutter_cubit_login/cubit/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authentication")),
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  late AuthCubit _authCubit;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<AuthCubit, AuthState>
      (
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (kDebugMode) {
              // log de check data khi state la AuthSuccess
              print('Authentication successful for user: ${state.user.username} ${state.user.password}');
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
            return Padding(padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: "Username"),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          _authCubit.login(
                              _usernameController.text, _passwordController.text);
                        }, child: const Text("Login")
                    ),
                    const SizedBox(height: 8),
                  ],
                )
            );
        }
    );
  }
}
