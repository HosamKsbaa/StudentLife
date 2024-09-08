import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as FirebaseUIAuth;
// import 'package:google_sign_in/google_sign_in.dart';

/// Service for managing user authentication.
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static late final AuthService _instance;
  static AuthService get instance => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _init() {
    print('Initializing AuthService...');
    _auth.authStateChanges().listen((User? user) {
      print('Auth state changed. User: $user');
      _onAuthStateChanged(user);
    });
    print('AuthService initialized.');
  }

  void _onAuthStateChanged(User? user) {
    if (user == null) {
      print('User is null. Navigating to sign in page.');
      GlobalNavigator.showSignInPage();
    } else {
      print('User is not null. Navigating to appropriate page.');
      GlobalNavigator.navigateToAppropriatePage(true);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user;
  }
}

/// Class for managing navigation within the app.
class GlobalNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static BuildContext? get context => navigatorKey.currentContext;

  static Widget Function()? _loggedInScreenBuilder;
  static Widget Function()? _afterLoggedInScreenBuilder;

  /// Sets the screen builders for logged-in and after-logged-in states.
  static void setScreenBuilders(Widget Function() loggedInScreenBuilder,
      Widget Function() afterLoggedInScreenBuilder) {
    _loggedInScreenBuilder = loggedInScreenBuilder;
    _afterLoggedInScreenBuilder = afterLoggedInScreenBuilder;
  }

  /// Shows the sign-in page.
  static void showSignInPage() {
    if (context == null) return;
    Navigator.pushAndRemoveUntil(
      context!,
      MaterialPageRoute(
        builder: (context) => FirebaseUIAuth.SignInScreen(
          footerBuilder: (context, action) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Form 1 ",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          },
          headerBuilder: (context, constraints, shrinkOffset) => const Padding(
            padding: EdgeInsets.all(20.0),
            child: FlutterLogo(size: 100),
          ),
          providers: [FirebaseUIAuth.EmailAuthProvider()],
          actions: [
            FirebaseUIAuth.AuthStateChangeAction<FirebaseUIAuth.SignedIn>(
                (context, state) {
              User? user = state.user;
              if (user != null) {
                navigateToAppropriatePage(true);
              }
            }),
          ],
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  /// Navigates to the appropriate page based on the user's state.
  static void navigateToAppropriatePage(bool hasJustLoggedIn) {
    if (context == null) return;

    Widget Function()? screenBuilder =
        hasJustLoggedIn ? _afterLoggedInScreenBuilder : _loggedInScreenBuilder;

    if (screenBuilder != null) {
      Navigator.pushAndRemoveUntil(
        context!,
        MaterialPageRoute(builder: (context) => screenBuilder!()),
        (Route<dynamic> route) => false,
      );
    }
  }

  /// Shows the email verification page.
  static void showEmailVerificationPage() {
    if (context == null) return;
    Navigator.pushAndRemoveUntil(
      context!,
      MaterialPageRoute(
        builder: (context) => FirebaseUIAuth.EmailVerificationScreen(
          actions: [
            FirebaseUIAuth.EmailVerifiedAction(_afterLoggedInScreenBuilder!),
            FirebaseUIAuth.AuthCancelledAction((context) {
              FirebaseUIAuth.FirebaseUIAuth.signOut(context: context);
              Navigator.pop(context);
            }),
          ],
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }
}

/// Widget for starting the authentication process.
class AuthStart extends StatefulWidget {
  final Widget Function() loggedInScreenBuilder;
  final Widget Function() afterLoggedInScreenBuilder;

  const AuthStart({
    Key? key,
    required this.loggedInScreenBuilder,
    required this.afterLoggedInScreenBuilder,
  }) : super(key: key);

  @override
  _AuthStartState createState() => _AuthStartState();
}

class _AuthStartState extends State<AuthStart> {
  @override
  void initState() {
    AuthService._instance = AuthService();
    AuthService.instance._init();
    GlobalNavigator.setScreenBuilders(
      widget.loggedInScreenBuilder,
      widget.afterLoggedInScreenBuilder,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Initial view while authentication state is being determined
      ),
    );
  }
}
