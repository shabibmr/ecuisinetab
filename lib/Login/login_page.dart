import 'package:ecuisinetab/Screens/POS/widgets/Configurations/configurations.dart';
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
    return LoginPage();
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
    print('Rebuilding Login Page');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('eCuisineTab'),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConfigurationPage(),
                ));
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: 350,
                  height: 350,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(180)),
                    child: Center(
                      child: Image.asset(
                        'assets/algoLogo.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                )),
            const Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
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
                          UserName(),
                          LoginPassword(),
                          LoginButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(builder: (context) {
        String? text =
            context.select((AuthenticationBloc bloc) => bloc.state.username);
        print('user : $text');
        return MTextField(
          autoFocus: true,
          inputDecoration: InputDecoration(
              // hintText: 'Username',
              label: Text('Username'),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          initialText: text,
          onChanged: (value) {
            context
                .read<AuthenticationBloc>()
                .add(AuthSetUser(username: value));
          },
        );
      }),
    );
  }
}

class LoginPassword extends StatelessWidget {
  const LoginPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(builder: (context) {
        String? text =
            context.select((AuthenticationBloc bloc) => bloc.state.password);
        print('Passwotd : $text   ');
        return MTextField(
          initialText: text,
          obscureText: true,
          inputDecoration: InputDecoration(
              // hintText: 'Username',
              label: Text('Password'),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          onChanged: (value) => context
              .read<AuthenticationBloc>()
              .add(AuthSetPass(password: value)),
        );
      }),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const SizedBox(
        height: 40,
        width: 100,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationStarted());
      },
    );
  }
}
