//sign up page

import 'dependencies.dart';

class SignUpRoute extends StatelessWidget {
  const SignUpRoute({super.key});

  @override
  Widget build(BuildContext context) {
    //used to store user input
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),

            ElevatedButton(
              onPressed: () async {
                AnimatedRotation(
                  turns: 1,
                  duration: const Duration(seconds: 1),
                  child: const Icon(Icons.refresh),
                );
                var result = await createFirebaseAccount(
                  emailController.text,
                  passwordController.text,
                  usernameController.text,
                );

                if (result == 'Account created successfully') {
                  Navigator.pushNamed(context, '/home');
                } else {
                  SnackBar thisSnackBar = SnackBar(content: Text(result));
                  ScaffoldMessenger.of(context).showSnackBar(thisSnackBar);
                  //Navigator.pushNamed(context, '/home');
                }
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signIn');
              },
              child: const Text('Already have an account?'),
            ),
          ],
        ),
      ),
    );
  }
}
