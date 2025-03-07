import 'package:ecuisinetab/Screens/POS/widgets/Configurations/configurations.dart';
import 'package:ecuisinetab/auth/bloc/authentication_bloc.dart';
import 'package:ecuisinetab/widgets/Basic/MStringText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('eCuisineTab'),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ConfigurationPage(),
                ));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                width: 250,
                height: 250,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(180)),
                  child: Center(
                    child: Image.asset(
                      'assets/algoLogo.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 4.0, 8, 4),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              UserNameWidget(),
                              PasswordWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  LoginButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: "user",
        onChanged: (value) => context.read<AuthenticationBloc>().add(
              AuthSetUser(username: value),
            ),
        autofocus: true,
        decoration: const InputDecoration(
          label: Text('Username'),
        ),
      ),
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: "123456",
        onFieldSubmitted: (value) {
          context.read<AuthenticationBloc>().add(AuthenticationStarted());
        },
        onChanged: (value) => context.read<AuthenticationBloc>().add(
              AuthSetPass(password: value),
            ),
        autofocus: true,
        obscureText: true,
        decoration: const InputDecoration(
          label: Text('Password'),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            // width: 100,
            child: Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        onPressed: () {
          context.read<AuthenticationBloc>().add(AuthenticationStarted());
        },
      ),
    );
  }
}
