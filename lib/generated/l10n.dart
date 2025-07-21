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

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
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

  /// `Ongoing`
  String get ongoing {
    return Intl.message(
      'Ongoing',
      name: 'ongoing',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Scan the Seed Lot codes to start Seeding of trays.`
  String get scanTheSeedLotCodesToStartSeedingOfTrays {
    return Intl.message(
      'Scan the Seed Lot codes to start Seeding of trays.',
      name: 'scanTheSeedLotCodesToStartSeedingOfTrays',
      desc: '',
      args: [],
    );
  }

  /// `You can scan multiple seed lot codes at once.`
  String get youCanScanMultipleSeedLotCodesAtOnce {
    return Intl.message(
      'You can scan multiple seed lot codes at once.',
      name: 'youCanScanMultipleSeedLotCodesAtOnce',
      desc: '',
      args: [],
    );
  }

  /// `See how to do it ?`
  String get seeHowToDoIt {
    return Intl.message(
      'See how to do it ?',
      name: 'seeHowToDoIt',
      desc: '',
      args: [],
    );
  }

  /// `Tap to Scan`
  String get tapToScan {
    return Intl.message(
      'Tap to Scan',
      name: 'tapToScan',
      desc: '',
      args: [],
    );
  }

  /// `Scan More`
  String get scanMore {
    return Intl.message(
      'Scan More',
      name: 'scanMore',
      desc: '',
      args: [],
    );
  }

  /// `Add Detail`
  String get addDetail {
    return Intl.message(
      'Add Detail',
      name: 'addDetail',
      desc: '',
      args: [],
    );
  }

  /// `Number of Full Trays`
  String get numberOfFullTrays {
    return Intl.message(
      'Number of Full Trays',
      name: 'numberOfFullTrays',
      desc: '',
      args: [],
    );
  }

  /// `Number of Half Trays`
  String get numberOfHalfTrays {
    return Intl.message(
      'Number of Half Trays',
      name: 'numberOfHalfTrays',
      desc: '',
      args: [],
    );
  }

  /// `Seeds Name`
  String get seedsName {
    return Intl.message(
      'Seeds Name',
      name: 'seedsName',
      desc: '',
      args: [],
    );
  }

  /// `Seed Lot Code`
  String get seedLotCode {
    return Intl.message(
      'Seed Lot Code',
      name: 'seedLotCode',
      desc: '',
      args: [],
    );
  }

  /// `Seed Weight/Tray`
  String get seedWeighttray {
    return Intl.message(
      'Seed Weight/Tray',
      name: 'seedWeighttray',
      desc: '',
      args: [],
    );
  }

  /// `Core Weight`
  String get coreWeight {
    return Intl.message(
      'Core Weight',
      name: 'coreWeight',
      desc: '',
      args: [],
    );
  }

  /// `gms`
  String get gms {
    return Intl.message(
      'gms',
      name: 'gms',
      desc: '',
      args: [],
    );
  }

  /// `Scan now`
  String get scanNow {
    return Intl.message(
      'Scan now',
      name: 'scanNow',
      desc: '',
      args: [],
    );
  }

  /// `Remove a Lot Code?`
  String get removeALotCode {
    return Intl.message(
      'Remove a Lot Code?',
      name: 'removeALotCode',
      desc: '',
      args: [],
    );
  }

  /// `Add People`
  String get addPeople {
    return Intl.message(
      'Add People',
      name: 'addPeople',
      desc: '',
      args: [],
    );
  }

  /// `Seeding Date`
  String get seedingDate {
    return Intl.message(
      'Seeding Date',
      name: 'seedingDate',
      desc: '',
      args: [],
    );
  }

  /// `scanTheSeedLotCodesToStartSeedingOfTrays`
  String get scantheseedlotcodestostartseedingoftrays {
    return Intl.message(
      'scanTheSeedLotCodesToStartSeedingOfTrays',
      name: 'scantheseedlotcodestostartseedingoftrays',
      desc: '',
      args: [],
    );
  }

  /// `seeHowToDoIt`
  String get seehowtodoit {
    return Intl.message(
      'seeHowToDoIt',
      name: 'seehowtodoit',
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
