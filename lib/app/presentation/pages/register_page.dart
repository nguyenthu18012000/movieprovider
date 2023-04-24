import 'package:flutter/material.dart';
import 'package:movie_provider/app/datasource/provider/providers.dart';
import 'package:movie_provider/constants/constants.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: RegisterView(),
          )
        )
      ),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formLoginKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back)
              ),
              Text(
                  context.watch<RegisterProvider>().success.toString()
              )

            ]
          ),
          const LogoRegisterWidget(),
          UIConstants.verticalSpace24,
          const Center(
            child: Text(
              "Create Your Account",
              style: ThemeConstants.textTitleStyle
            ),
          ),
          UIConstants.verticalSpace24,
          RegisterInputForm(
            formLoginKey: formLoginKey,
            email: email,
            password: password,
          ),
          UIConstants.verticalSpace10,
          // const RememberCheckboxWidget(),
          UIConstants.verticalSpace10,
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15)
              ),
              onPressed: () {
                formLoginKey.currentState!.validate();
                context.read<RegisterProvider>().register(email.text, password.text);
              },
              child: const Text(
                "Sign up",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                ),
              )
          ),
          UIConstants.verticalSpace16,
          // const ForgotPasswordWidget(),
          UIConstants.verticalSpace24,
          const RegisterOtherLoginTitleWidget(),
          UIConstants.verticalSpace24,
          const RegisterOtherLoginMethodWidget(),
          UIConstants.verticalSpace10,
          // const SignUpWidget()
        ],
      ),
    );
  }
}

class LogoRegisterWidget extends StatelessWidget {
  const LogoRegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Image.asset(
        "assets/images/logo.png",
        scale: 0.7,
      ),
    );
  }
}

class RegisterInputForm extends StatefulWidget {
  final GlobalKey<FormState> formLoginKey;
  final TextEditingController email;
  final TextEditingController password;

  const RegisterInputForm({
    super.key,
    required this.formLoginKey,
    required this.email,
    required this.password
  });

  @override
  State<RegisterInputForm> createState() => _RegisterInputForm();
}

class _RegisterInputForm extends State<RegisterInputForm> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formLoginKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: widget.email,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: ColorConstants.inputColor,
                focusColor: Colors.black,
                enabledBorder: ThemeConstants.inputBorder,
                focusedBorder: ThemeConstants.inputBorder,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)){
                  return 'Email error';
                }
                return null;
              },
            ),
            UIConstants.verticalSpace16,
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: widget.password,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(
                  Icons.lock_rounded,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                    icon: _hidePassword
                        ? const Icon(
                      Icons.visibility_off_rounded,
                      color: Colors.grey,
                    )
                        : const Icon(
                      Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                    )
                ),
                filled: true,
                fillColor: ColorConstants.inputColor,
                focusColor: Colors.black,
                enabledBorder: ThemeConstants.inputBorder,
                focusedBorder: ThemeConstants.inputBorder,
              ),
              obscureText: _hidePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            )
          ],
        )
    );
  }
}

class RegisterOtherLoginTitleWidget extends StatelessWidget {
  const RegisterOtherLoginTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: ColorConstants.inputColor,
          ),
        ),
        const Text(
          "or continue with",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: ColorConstants.inputColor,
          ),
        ),
      ],
    );
  }
}

class RegisterOtherLoginMethodWidget extends StatelessWidget {
  const RegisterOtherLoginMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        SizedBox(width: 20),
        RegisterOtherLoginMethodButton(nameMethod: "facebook"),
        RegisterOtherLoginMethodButton(nameMethod: "google"),
        RegisterOtherLoginMethodButton(nameMethod: "apple"),
        SizedBox(width: 20)
      ],
    );
  }
}

class RegisterOtherLoginMethodButton extends StatelessWidget {
  final String nameMethod;
  const RegisterOtherLoginMethodButton({super.key, required this.nameMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.inputColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/${nameMethod}_logo.png",
        height: 25,
      ),
    );
  }
}
//
// class SignUpWidget extends StatelessWidget {
//   const SignUpWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Don't have an account? ",
//           style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey
//           ),
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: const Text(
//             "Sign up",
//             style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.red,
//                 fontWeight: FontWeight.w700
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//

