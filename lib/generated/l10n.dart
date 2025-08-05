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

  /// `Cycle 8`
  String get cycle8 {
    return Intl.message(
      'Cycle 8',
      name: 'cycle8',
      desc: '',
      args: [],
    );
  }

  /// `Moving to germination`
  String get movingToGermination {
    return Intl.message(
      'Moving to germination',
      name: 'movingToGermination',
      desc: '',
      args: [],
    );
  }

  /// `Action Required`
  String get actionRequired {
    return Intl.message(
      'Action Required',
      name: 'actionRequired',
      desc: '',
      args: [],
    );
  }

  /// `You are trying to add trays beyond the available tray space on the scanned level.`
  String get youAreTryingToAddTraysBeyondTheAvailableTray {
    return Intl.message(
      'You are trying to add trays beyond the available tray space on the scanned level.',
      name: 'youAreTryingToAddTraysBeyondTheAvailableTray',
      desc: '',
      args: [],
    );
  }

  /// `Confirm & Scan next Level QR`
  String get confirmScanNextLevelQr {
    return Intl.message(
      'Confirm & Scan next Level QR',
      name: 'confirmScanNextLevelQr',
      desc: '',
      args: [],
    );
  }

  /// `scanned Trays and scan a new level QR for remaining`
  String get scannedTraysAndScanANewLevelQrForRemaining {
    return Intl.message(
      'scanned Trays and scan a new level QR for remaining',
      name: 'scannedTraysAndScanANewLevelQrForRemaining',
      desc: '',
      args: [],
    );
  }

  /// `3 Trays.`
  String get threetrays {
    return Intl.message(
      '3 Trays.',
      name: 'threetrays',
      desc: '',
      args: [],
    );
  }

  /// `5`
  String get five {
    return Intl.message(
      '5',
      name: 'five',
      desc: '',
      args: [],
    );
  }

  /// `This Level has only`
  String get thisLevelHasOnly {
    return Intl.message(
      'This Level has only',
      name: 'thisLevelHasOnly',
      desc: '',
      args: [],
    );
  }

  /// `5 available`
  String get fiveAvailable {
    return Intl.message(
      '5 available',
      name: 'fiveAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Tray space. You can Confirm this position for first`
  String get traySpaceYouCanConfirmThisPositionForFirst {
    return Intl.message(
      'Tray space. You can Confirm this position for first',
      name: 'traySpaceYouCanConfirmThisPositionForFirst',
      desc: '',
      args: [],
    );
  }

  /// `Seeding Trays`
  String get seedingTrays {
    return Intl.message(
      'Seeding Trays',
      name: 'seedingTrays',
      desc: '',
      args: [],
    );
  }

  /// `Scan Level QR`
  String get scanLevelQr {
    return Intl.message(
      'Scan Level QR',
      name: 'scanLevelQr',
      desc: '',
      args: [],
    );
  }

  /// `Scan seed Lot`
  String get scanSeedLot {
    return Intl.message(
      'Scan seed Lot',
      name: 'scanSeedLot',
      desc: '',
      args: [],
    );
  }

  /// `Add Details`
  String get addDetails {
    return Intl.message(
      'Add Details',
      name: 'addDetails',
      desc: '',
      args: [],
    );
  }

  /// `Scan the level QR where you want to Place the trays`
  String get scanTheLevelQrWhereYouWantToPlaceThe {
    return Intl.message(
      'Scan the level QR where you want to Place the trays',
      name: 'scanTheLevelQrWhereYouWantToPlaceThe',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Manual Check`
  String get manualCheck {
    return Intl.message(
      'Manual Check',
      name: 'manualCheck',
      desc: '',
      args: [],
    );
  }

  /// `Tray Position:`
  String get trayPosition {
    return Intl.message(
      'Tray Position:',
      name: 'trayPosition',
      desc: '',
      args: [],
    );
  }

  /// `Zone 5 | Section 4 |`
  String get zone5Section4 {
    return Intl.message(
      'Zone 5 | Section 4 |',
      name: 'zone5Section4',
      desc: '',
      args: [],
    );
  }

  /// `Level 3`
  String get level3 {
    return Intl.message(
      'Level 3',
      name: 'level3',
      desc: '',
      args: [],
    );
  }

  /// `Current Status:`
  String get currentStatus {
    return Intl.message(
      'Current Status:',
      name: 'currentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Germination`
  String get germination {
    return Intl.message(
      'Germination',
      name: 'germination',
      desc: '',
      args: [],
    );
  }

  /// `Since 25/05/2025`
  String get since25052025 {
    return Intl.message(
      'Since 25/05/2025',
      name: 'since25052025',
      desc: '',
      args: [],
    );
  }

  /// `Complete Harvest before • 22:00 Today`
  String get completeHarvestBefore2200Today {
    return Intl.message(
      'Complete Harvest before • 22:00 Today',
      name: 'completeHarvestBefore2200Today',
      desc: '',
      args: [],
    );
  }

  /// `Tray Information`
  String get trayInformation {
    return Intl.message(
      'Tray Information',
      name: 'trayInformation',
      desc: '',
      args: [],
    );
  }

  /// `Tray Details:`
  String get trayDetails {
    return Intl.message(
      'Tray Details:',
      name: 'trayDetails',
      desc: '',
      args: [],
    );
  }

  /// `8 Arugula Tray | 9 Gms`
  String get ArugulaTrayGms {
    return Intl.message(
      '8 Arugula Tray | 9 Gms',
      name: 'ArugulaTrayGms',
      desc: '',
      args: [],
    );
  }

  /// `seedWeightTray`
  String get seedweighttray {
    return Intl.message(
      'seedWeightTray',
      name: 'seedweighttray',
      desc: '',
      args: [],
    );
  }

  /// `Move to Fertigation`
  String get moveToFertigation {
    return Intl.message(
      'Move to Fertigation',
      name: 'moveToFertigation',
      desc: '',
      args: [],
    );
  }

  /// `Mark this as Bad Trays`
  String get markThisAsBadTrays {
    return Intl.message(
      'Mark this as Bad Trays',
      name: 'markThisAsBadTrays',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed {
    return Intl.message(
      'Proceed',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  /// `Issue`
  String get issue {
    return Intl.message(
      'Issue',
      name: 'issue',
      desc: '',
      args: [],
    );
  }

  /// `Select an issue`
  String get selectAnIssue {
    return Intl.message(
      'Select an issue',
      name: 'selectAnIssue',
      desc: '',
      args: [],
    );
  }

  /// `Mark as a Bad Tray !`
  String get markAsABadTray {
    return Intl.message(
      'Mark as a Bad Tray !',
      name: 'markAsABadTray',
      desc: '',
      args: [],
    );
  }

  /// `Tray Broken`
  String get trayBroken {
    return Intl.message(
      'Tray Broken',
      name: 'trayBroken',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Bad Tray`
  String get markAsBadTray {
    return Intl.message(
      'Mark as Bad Tray',
      name: 'markAsBadTray',
      desc: '',
      args: [],
    );
  }

  /// `Harvesting Trays`
  String get harvestingTrays {
    return Intl.message(
      'Harvesting Trays',
      name: 'harvestingTrays',
      desc: '',
      args: [],
    );
  }

  /// `Harvest`
  String get harvest {
    return Intl.message(
      'Harvest',
      name: 'harvest',
      desc: '',
      args: [],
    );
  }

  /// `Update Today`
  String get updateToday {
    return Intl.message(
      'Update Today',
      name: 'updateToday',
      desc: '',
      args: [],
    );
  }

  /// `Harvested Qty:`
  String get harvestedQty {
    return Intl.message(
      'Harvested Qty:',
      name: 'harvestedQty',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Harvest`
  String get confirmHarvest {
    return Intl.message(
      'Confirm Harvest',
      name: 'confirmHarvest',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Seeding in`
  String get upcomingSeedingIn {
    return Intl.message(
      'Upcoming Seeding in',
      name: 'upcomingSeedingIn',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Total Yield`
  String get totalYield {
    return Intl.message(
      'Total Yield',
      name: 'totalYield',
      desc: '',
      args: [],
    );
  }

  /// `Updated on`
  String get updatedOn {
    return Intl.message(
      'Updated on',
      name: 'updatedOn',
      desc: '',
      args: [],
    );
  }

  /// `Available Trays`
  String get availableTrays {
    return Intl.message(
      'Available Trays',
      name: 'availableTrays',
      desc: '',
      args: [],
    );
  }

  /// `Last updated on`
  String get lastUpdatedOn {
    return Intl.message(
      'Last updated on',
      name: 'lastUpdatedOn',
      desc: '',
      args: [],
    );
  }

  /// `You need to take action on pending seeding tasks.`
  String get youNeedToTakeActionOnPendingSeedingTasks {
    return Intl.message(
      'You need to take action on pending seeding tasks.',
      name: 'youNeedToTakeActionOnPendingSeedingTasks',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Notes/Remarks`
  String get notesremarks {
    return Intl.message(
      'Notes/Remarks',
      name: 'notesremarks',
      desc: '',
      args: [],
    );
  }

  /// `Move Trays`
  String get moveTrays {
    return Intl.message(
      'Move Trays',
      name: 'moveTrays',
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
