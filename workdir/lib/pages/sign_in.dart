import 'dependencies.dart';

class SignInRoute extends StatelessWidget {
  const SignInRoute({super.key});

  @override
  Widget build(BuildContext context) {
    //used to store user input
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await loginFirebaseAccount(
                  usernameController.text,
                  passwordController.text,
                );

                if (result == 'Logged in successfully') {
                  Navigator.pushNamed(context, '/home');
                } else {
                  SnackBar thisSnackBar = SnackBar(content: Text(result));
                  ScaffoldMessenger.of(context).showSnackBar(thisSnackBar);
                  //Navigator.pushNamed(context, '/home');
                }
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
