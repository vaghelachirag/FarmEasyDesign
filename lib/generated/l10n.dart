// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `pleaseEnterPassword`
  String get pleaseenterpassword {
    return Intl.message(
      'pleaseEnterPassword',
      name: 'pleaseenterpassword',
      desc: '',
      args: [],
    );
  }

  /// `signIn`
  String get signin {
    return Intl.message(
      'signIn',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `continueText`
  String get continuetext {
    return Intl.message(
      'continueText',
      name: 'continuetext',
      desc: '',
      args: [],
    );
  }

  /// `forgotPassword`
  String get forgotpassword {
    return Intl.message(
      'forgotPassword',
      name: 'forgotpassword',
      desc: '',
      args: [],
    );
  }

  /// `enterYourEmail`
  String get enteryouremail {
    return Intl.message(
      'enterYourEmail',
      name: 'enteryouremail',
      desc: '',
      args: [],
    );
  }

  /// `pleaseEnterEmail`
  String get pleaseenteremail {
    return Intl.message(
      'pleaseEnterEmail',
      name: 'pleaseenteremail',
      desc: '',
      args: [],
    );
  }

  /// `pleaseEnterCorrectEmail`
  String get pleaseentercorrectemail {
    return Intl.message(
      'pleaseEnterCorrectEmail',
      name: 'pleaseentercorrectemail',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `enterPassword`
  String get enterpassword {
    return Intl.message(
      'enterPassword',
      name: 'enterpassword',
      desc: '',
      args: [],
    );
  }

  /// `remembered`
  String get remembered {
    return Intl.message(
      'remembered',
      name: 'remembered',
      desc: '',
      args: [],
    );
  }

  /// `continuewithgoogle`
  String get continuewithgoogle {
    return Intl.message(
      'continuewithgoogle',
      name: 'continuewithgoogle',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Cycles`
  String get cycles {
    return Intl.message(
      'Cycles',
      name: 'cycles',
      desc: '',
      args: [],
    );
  }

  /// `Handbook`
  String get handbook {
    return Intl.message(
      'Handbook',
      name: 'handbook',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
