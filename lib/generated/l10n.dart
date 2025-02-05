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

  /// `Gets things done with Tadween`
  String get welcom0Title {
    return Intl.message(
      'Gets things done with Tadween',
      name: 'welcom0Title',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet`
  String get welcom1Title {
    return Intl.message(
      'Lorem ipsum dolor sit amet',
      name: 'welcom1Title',
      desc: '',
      args: [],
    );
  }

  /// `consectetur adipiscing elit. Interdum`
  String get welcom2Title {
    return Intl.message(
      'consectetur adipiscing elit. Interdum',
      name: 'welcom2Title',
      desc: '',
      args: [],
    );
  }

  /// `dictum tempus, interdum at dignissim`
  String get welcom3Title {
    return Intl.message(
      'dictum tempus, interdum at dignissim',
      name: 'welcom3Title',
      desc: '',
      args: [],
    );
  }

  /// `metus. Ultricies sed nunc.`
  String get welcom4Title {
    return Intl.message(
      'metus. Ultricies sed nunc.',
      name: 'welcom4Title',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get started {
    return Intl.message(
      'Get started',
      name: 'started',
      desc: '',
      args: [],
    );
  }

  /// `Welcome in Tadween!`
  String get signUp1 {
    return Intl.message(
      'Welcome in Tadween!',
      name: 'signUp1',
      desc: '',
      args: [],
    );
  }

  /// `Let’s help you meet up your tasks`
  String get signUp2 {
    return Intl.message(
      'Let’s help you meet up your tasks',
      name: 'signUp2',
      desc: '',
      args: [],
    );
  }

  /// `Enter your full name`
  String get Name {
    return Intl.message(
      'Enter your full name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get email {
    return Intl.message(
      'Enter your email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get password {
    return Intl.message(
      'Enter password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `phone`
  String get phone {
    return Intl.message(
      'phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?`
  String get Haveaccount {
    return Intl.message(
      'Already have an account ?',
      name: 'Haveaccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get signInTitel {
    return Intl.message(
      'Welcome Back!',
      name: 'signInTitel',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Dont't have an account ?`
  String get dontHave {
    return Intl.message(
      'Dont\'t have an account ?',
      name: 'dontHave',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `This field can't be empty`
  String get empty {
    return Intl.message(
      'This field can\'t be empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `The password can't be less than 6 letters`
  String get lessPassword {
    return Intl.message(
      'The password can\'t be less than 6 letters',
      name: 'lessPassword',
      desc: '',
      args: [],
    );
  }

  /// `Verified your email`
  String get Verification {
    return Intl.message(
      'Verified your email',
      name: 'Verification',
      desc: '',
      args: [],
    );
  }

  /// `Your Notes`
  String get notes {
    return Intl.message(
      'Your Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get Content {
    return Intl.message(
      'Content',
      name: 'Content',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get Title {
    return Intl.message(
      'Title',
      name: 'Title',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get Add {
    return Intl.message(
      'Add',
      name: 'Add',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorTitle {
    return Intl.message(
      'Error',
      name: 'errorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add to favorite`
  String get AddToFav {
    return Intl.message(
      'Add to favorite',
      name: 'AddToFav',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add`
  String get add_failed {
    return Intl.message(
      'Failed to add',
      name: 'add_failed',
      desc: '',
      args: [],
    );
  }

  /// `Added successfully`
  String get add_success {
    return Intl.message(
      'Added successfully',
      name: 'add_success',
      desc: '',
      args: [],
    );
  }

  /// `FirstName`
  String get firstName {
    return Intl.message(
      'FirstName',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `LastName`
  String get lastName {
    return Intl.message(
      'LastName',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `profile Added Successfully`
  String get profileAddedSuccessfully {
    return Intl.message(
      'profile Added Successfully',
      name: 'profileAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
