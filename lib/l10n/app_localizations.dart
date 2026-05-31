import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
    Locale('ja')
  ];

  String get home;
  String get favorite;
  String get profile;
  String get settings;
  String get language;
  String get chooseLanguage;
  String get english;
  String get indonesian;
  String get japanese;
  String get menu;
  String get about;
  String get trending;
  String get popular;
  String get topRated;
  String get upcoming;
  String get horror;
  String get comedy;
  String get searchMovies;
  String get editProfile;
  String get darkMode;
  String get changePassword;
  String get username;
  String get fullnameLabel;
  String get bio;
  String get favoriteMovies;
  String get noFavoriteMovie;
  String get confirm;
  String get cancel;
  String get logout;
  String get logoutMessage;
  String get save;
  String get signIn;
  String get signUp;
  String get email;
  String get password;
  String get oldPassword;
  String get newPassword;
  String get confirmPassword;
  String get welcomeBack;
  String get register;
  String get dontHaveAccount;
  String get alreadyHaveAccount;
  String get saveChanges;
  String get writeReview;
  String get addReview;
  String get addImage;
  String get location;
  String get addLocation;
  String get director;
  String get cast;
  String get synopsis;
  String get gallery;
  String get reviews;
  String get rating;
  String get trailer;
  String get images;
  String get information;
  String get delete;
  String get edit;
  String get reviewInformation;
  String get flickReview;
  String get aboutApp;
  String get appVersion;
  String get registrationSuccess;
  String get emailPasswordRequired;
  String get userNotFound;
  String get wrongPassword;
  String get invalidEmail;
  String get invalidCredential;
  String get loginFailed;
  String get somethingWentWrong;
  String get allFieldsRequired;
  String get usernameFormat;
  String get passwordMismatch;
  String get passwordRequirements;
  String get registrationFailed;
  String get emailAlreadyRegistered;
  String get invalidEmailFormat;
  String get weakPassword;
  String get usernameAlreadyInUse;
  String get fullnameRequired;
  String get profileImageUpdated;
  String get profileImageUploadFailed;
  String get profileImageDeleted;
  String get profileImageDeleteFailed;
  String get profileUpdated;
  String get failedToUpdateProfile;
  String get takeFromCamera;
  String get chooseFromGallery;
  String get deleteProfilePhoto;
  String get favoritesCount;
  String get trailerNotAvailable;
  String get imdb;
  String get critics;
  String get flickreviewRating;
  String get noReviewsYet;
  String get unknownUser;
  String get edited;
  String get reviewer;
  String get date;
  String get deleteReview;
  String get confirmDeleteReview;
  String get ratingAndReviewRequired;
  String get reviewSubmittedSuccessfully;
  String get failedToSubmitReview;
  String get reviewUpdated;
  String get failedToUpdateReview;
  String get giveYourRating;
  String get writeYourThoughts;
  String get submitReview;
  String get updateYourReview;
  String get editRating;
  String get editReview;
  String get searchMovie;
  String get searchMovieHint;
  String get locationNotFound;
  String get failedToGetLocation;
  String get useCurrentLocation;
  String get searchLocation;
  String get addImages;
  String get movieImages;
  String get failedToLoadMovie;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale".'
  );
}