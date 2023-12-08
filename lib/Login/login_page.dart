import 'package:ecuisinetab/auth/bloc/authentication_bloc.dart';
import 'package:ecuisinetab/widgets/Basic/MStringText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Login Page')),
          body: Column(
            children: [
              Expanded(flex: 2, child: Container()),
              const Expanded(
                flex: 1,
                child: Column(
                  children: [
                    UserName(),
                    LoginPassword(),
                    LoginButton(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MTextField(
        label: 'Username',
        onChanged: (value) => context
            .read<AuthenticationBloc>()
            .add(AuthSetUser(username: value)),
      ),
    );
  }
}

class LoginPassword extends StatelessWidget {
  const LoginPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MTextField(
        obscureText: true,
        label: 'Password',
        onChanged: (value) => context
            .read<AuthenticationBloc>()
            .add(AuthSetPass(password: value)),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Login'),
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationStarted());
      },
    );
  }
}
