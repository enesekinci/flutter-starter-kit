import 'package:flutter/material.dart';
import 'package:flutterstarterkit/core/constants/app/theme/theme_constant.dart';
import 'package:flutterstarterkit/core/controller/auth_controller.dart';
import 'package:flutterstarterkit/core/controller/main_controller.dart';
import 'package:flutterstarterkit/core/view/base_view.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("login page loading...");
    return LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _mainController = MainController.instance;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    email.addListener(() => null);
    password.addListener(() => null);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AuthController.instance.isLogin) {
      return LoginPage();
    }
    return Scaffold(
      body: BaseView(
        onPageBuilder: (context, controller, authController, mainController) {
          return buildBody();
        },
        // controller: Get.put(AuthController.instance),
        onModelReady: (controller) => controller = AuthController.instance,
      ),
    );
  }

  Widget buildBody() {
    return Stack(
      children: <Widget>[
        buildBackground(),
        buildForm(),
      ],
    );
  }

  Container buildForm() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 75.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildsignIn(),
              SizedBox(height: 30.0),
              buildEmail(),
              SizedBox(
                height: 30.0,
              ),
              buildPassword(),
              buildForgotPassword(),
              buildRememberMe(),
              buildLoginButton(),
              buildSignInWithText(),
              buildSocialButtons(),
              buildSignUpText(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton buildSignUpText() {
    return TextButton(
      onPressed: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildSocialButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          this.buildSocialBtn(
            onTap: () => print('Login with Facebook'),
            logo: AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          this.buildSocialBtn(
            onTap: () => print('Login with Google'),
            logo: AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Column buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: ThemeConstant.instance.labelStyle,
        ),
      ],
    );
  }

  Container buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: login,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState.validate()) {
      print("_rememberMe");
      print(_rememberMe);

      dynamic result = await AuthController.instance.login(email: email.text, password: password.text, rememberMe: _rememberMe);

      print("login =>" + result.toString());

      if (result is bool && result == true) {
        print("login true");
        Get.offAllNamed('/');
      } else {
        _mainController.showSnackBar(
          position: SnackPosition.BOTTOM,
          text: result,
          textColor: Colors.white,
          backgroundColor: Colors.grey,
          title: "Hata!",
        );
      }
    } else {
      _mainController.showSnackBar(
        position: SnackPosition.BOTTOM,
        text: "Lütfen bilgileri doldurunuz.",
        textColor: Colors.white,
        backgroundColor: Colors.grey,
        title: "Hata!",
      );
    }
  }

  Container buildRememberMe() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: ThemeConstant.instance.labelStyle,
          ),
        ],
      ),
    );
  }

  Container buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: ThemeConstant.instance.labelStyle,
        ),
      ),
    );
  }

  Column buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: ThemeConstant.instance.boxDecorationStyle,
          child: TextFormField(
            controller: email,
            // ignore: deprecated_member_use
            autovalidate: true,
            validator: (String value) {
              if (value.isEmpty || !GetUtils.isEmail(value)) {
                return "please your email adress";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorStyle: ThemeConstant.instance.errorStyle,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              hintText: 'Enter your email address',
              hintStyle: ThemeConstant.instance.hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Column buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: ThemeConstant.instance.labelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: ThemeConstant.instance.boxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: password,
            // ignore: deprecated_member_use
            autovalidate: true,
            validator: (String value) {
              if (value.isEmpty || value.length < 6) {
                return "parola uzunlugu 6 karakterden fazla olmalı";
              } else {
                return null;
              }
            },
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorStyle: ThemeConstant.instance.errorStyle,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: ThemeConstant.instance.hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Text buildsignIn() {
    return Text(
      'Sign In',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red.shade900,
            Colors.red.shade700,
            Colors.red.shade500,
            Colors.red.shade300,
          ],
        ),
      ),
    );
  }

  Widget buildSocialBtn({Function onTap, AssetImage logo}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }
}
