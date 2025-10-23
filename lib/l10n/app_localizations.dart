import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @invitations.
  ///
  /// In en, this message translates to:
  /// **'Invitations'**
  String get invitations;

  /// No description provided for @create_invitation.
  ///
  /// In en, this message translates to:
  /// **'Create Invitation'**
  String get create_invitation;

  /// No description provided for @add_member.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get add_member;

  /// No description provided for @add_security_guard.
  ///
  /// In en, this message translates to:
  /// **'Add Security Guard'**
  String get add_security_guard;

  /// No description provided for @account_management.
  ///
  /// In en, this message translates to:
  /// **'Account Management'**
  String get account_management;

  /// No description provided for @user_management.
  ///
  /// In en, this message translates to:
  /// **'User Management'**
  String get user_management;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chat;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @did_you_forget_your_password.
  ///
  /// In en, this message translates to:
  /// **'Did you forget your password?'**
  String get did_you_forget_your_password;

  /// No description provided for @please.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password'**
  String get please;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @please_enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get please_enter_your_email;

  /// No description provided for @please_enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get please_enter_your_password;

  /// No description provided for @villa_number.
  ///
  /// In en, this message translates to:
  /// **'Villa Number'**
  String get villa_number;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @reason_for_visit.
  ///
  /// In en, this message translates to:
  /// **'Reason for Visit'**
  String get reason_for_visit;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @refuse.
  ///
  /// In en, this message translates to:
  /// **'Refuse'**
  String get refuse;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @please_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get please_enter_name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enter_phone_number;

  /// No description provided for @please_enter_villa_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter villa number'**
  String get please_enter_villa_number;

  /// No description provided for @please_enter_reason_for_visit.
  ///
  /// In en, this message translates to:
  /// **'Please enter reason for visit'**
  String get please_enter_reason_for_visit;

  /// No description provided for @please_enter_number_of_persons.
  ///
  /// In en, this message translates to:
  /// **'Please enter number of persons'**
  String get please_enter_number_of_persons;

  /// No description provided for @please_select_date.
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get please_select_date;

  /// No description provided for @upload_new_member_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload new member photo'**
  String get upload_new_member_photo;

  /// No description provided for @villa_address.
  ///
  /// In en, this message translates to:
  /// **'Villa Address'**
  String get villa_address;

  /// No description provided for @enter_villa_address.
  ///
  /// In en, this message translates to:
  /// **'Enter villa address'**
  String get enter_villa_address;

  /// No description provided for @villa_location.
  ///
  /// In en, this message translates to:
  /// **'Villa Location'**
  String get villa_location;

  /// No description provided for @enter_villa_location.
  ///
  /// In en, this message translates to:
  /// **'Enter villa location'**
  String get enter_villa_location;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @select_street.
  ///
  /// In en, this message translates to:
  /// **'Select street'**
  String get select_street;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @enter_area.
  ///
  /// In en, this message translates to:
  /// **'Enter area'**
  String get enter_area;

  /// No description provided for @number_of_floors.
  ///
  /// In en, this message translates to:
  /// **'Number of Floors'**
  String get number_of_floors;

  /// No description provided for @enter_number_of_floors.
  ///
  /// In en, this message translates to:
  /// **'Enter number of floors'**
  String get enter_number_of_floors;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @street_must_be_at_least_3_characters.
  ///
  /// In en, this message translates to:
  /// **'Street must be at least 3 characters'**
  String get street_must_be_at_least_3_characters;

  /// No description provided for @form_valid.
  ///
  /// In en, this message translates to:
  /// **'Form is valid'**
  String get form_valid;

  /// No description provided for @please_fix_form_errors.
  ///
  /// In en, this message translates to:
  /// **'Please fix the form errors'**
  String get please_fix_form_errors;

  /// No description provided for @name_must_be_at_least_2_characters.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get name_must_be_at_least_2_characters;

  /// No description provided for @enter_valid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get enter_valid_phone_number;

  /// No description provided for @enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get enter_valid_email;

  /// No description provided for @password_must_be_at_least_8_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get password_must_be_at_least_8_characters;

  /// No description provided for @villa_address_must_be_at_least_5_characters.
  ///
  /// In en, this message translates to:
  /// **'Villa address must be at least 5 characters'**
  String get villa_address_must_be_at_least_5_characters;

  /// No description provided for @villa_number_must_be_numeric.
  ///
  /// In en, this message translates to:
  /// **'Villa number must be numeric'**
  String get villa_number_must_be_numeric;

  /// No description provided for @villa_location_must_be_at_least_5_characters.
  ///
  /// In en, this message translates to:
  /// **'Villa location must be at least 5 characters'**
  String get villa_location_must_be_at_least_5_characters;

  /// No description provided for @area_must_be_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Area must be a valid number'**
  String get area_must_be_valid_number;

  /// No description provided for @number_of_floors_must_be_numeric.
  ///
  /// In en, this message translates to:
  /// **'Number of floors must be numeric'**
  String get number_of_floors_must_be_numeric;

  /// No description provided for @security_guard_photo_upload.
  ///
  /// In en, this message translates to:
  /// **'Upload Security Guard Photo'**
  String get security_guard_photo_upload;

  /// No description provided for @enter_security_guard_name.
  ///
  /// In en, this message translates to:
  /// **'Enter security guard name'**
  String get enter_security_guard_name;

  /// No description provided for @enter_security_guard_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter security guard phone'**
  String get enter_security_guard_phone;

  /// No description provided for @enter_security_guard_email.
  ///
  /// In en, this message translates to:
  /// **'Enter security guard email'**
  String get enter_security_guard_email;

  /// No description provided for @enter_security_guard_password.
  ///
  /// In en, this message translates to:
  /// **'Enter security guard password'**
  String get enter_security_guard_password;

  /// No description provided for @enter_gate_number.
  ///
  /// In en, this message translates to:
  /// **'Enter gate number'**
  String get enter_gate_number;

  /// No description provided for @gate_number_must_be_numeric.
  ///
  /// In en, this message translates to:
  /// **'Gate number must be numeric'**
  String get gate_number_must_be_numeric;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @members_account_statement.
  ///
  /// In en, this message translates to:
  /// **'Members Account Statement'**
  String get members_account_statement;

  /// No description provided for @single_member_account_statement.
  ///
  /// In en, this message translates to:
  /// **'Single Member Account Statement'**
  String get single_member_account_statement;

  /// No description provided for @create_voucher.
  ///
  /// In en, this message translates to:
  /// **'Create Voucher'**
  String get create_voucher;

  /// No description provided for @payment_vouchers.
  ///
  /// In en, this message translates to:
  /// **'Payment Vouchers'**
  String get payment_vouchers;

  /// No description provided for @receipt_vouchers.
  ///
  /// In en, this message translates to:
  /// **'Receipt Vouchers'**
  String get receipt_vouchers;

  /// No description provided for @enter_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get enter_name;

  /// No description provided for @enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone'**
  String get enter_phone;

  /// No description provided for @enter_address.
  ///
  /// In en, this message translates to:
  /// **'Please enter address'**
  String get enter_address;

  /// No description provided for @enter_status.
  ///
  /// In en, this message translates to:
  /// **'Please enter status'**
  String get enter_status;

  /// No description provided for @please_enter_date.
  ///
  /// In en, this message translates to:
  /// **'Please enter the date'**
  String get please_enter_date;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @residual.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get residual;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @voucher_date.
  ///
  /// In en, this message translates to:
  /// **'Voucher Date'**
  String get voucher_date;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @account_num.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get account_num;

  /// No description provided for @creditor.
  ///
  /// In en, this message translates to:
  /// **'Creditor'**
  String get creditor;

  /// No description provided for @debtor.
  ///
  /// In en, this message translates to:
  /// **'Debtor'**
  String get debtor;

  /// No description provided for @bond_explain.
  ///
  /// In en, this message translates to:
  /// **'Bond Explain'**
  String get bond_explain;

  /// No description provided for @bond_type.
  ///
  /// In en, this message translates to:
  /// **'Bond Type'**
  String get bond_type;

  /// No description provided for @receipt_bond.
  ///
  /// In en, this message translates to:
  /// **'Receipt Bond'**
  String get receipt_bond;

  /// No description provided for @payment_bond.
  ///
  /// In en, this message translates to:
  /// **'Payment Bond'**
  String get payment_bond;

  /// No description provided for @bond_saved_successfully.
  ///
  /// In en, this message translates to:
  /// **'Bond saved successfully'**
  String get bond_saved_successfully;

  /// No description provided for @please_fill_required_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the required fields'**
  String get please_fill_required_fields;

  /// No description provided for @please_enter_bond_date.
  ///
  /// In en, this message translates to:
  /// **'Please enter the bond date'**
  String get please_enter_bond_date;

  /// No description provided for @please_enter_currency.
  ///
  /// In en, this message translates to:
  /// **'Please enter the currency'**
  String get please_enter_currency;

  /// No description provided for @please_enter_creditor.
  ///
  /// In en, this message translates to:
  /// **'Please enter creditor name'**
  String get please_enter_creditor;

  /// No description provided for @please_enter_account_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter account number'**
  String get please_enter_account_number;

  /// No description provided for @please_enter_bond_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter bond description'**
  String get please_enter_bond_description;

  /// No description provided for @create_bond.
  ///
  /// In en, this message translates to:
  /// **'Create Bond'**
  String get create_bond;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalid_email;

  /// No description provided for @we_send_you_reset_link.
  ///
  /// In en, this message translates to:
  /// **'We send you Reset link'**
  String get we_send_you_reset_link;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @please_enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Email'**
  String get please_enter_valid_email;

  /// No description provided for @send_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Password'**
  String get send_reset_password;

  /// No description provided for @confirm_change_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Change Password'**
  String get confirm_change_password;

  /// No description provided for @email_is_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get email_is_required;

  /// No description provided for @invalid_email_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalid_email_format;

  /// No description provided for @token_is_required.
  ///
  /// In en, this message translates to:
  /// **'Verification code is required'**
  String get token_is_required;

  /// No description provided for @password_is_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_is_required;

  /// No description provided for @password_validation_message.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters, include upper and lower case letters, numbers, and special characters'**
  String get password_validation_message;

  /// No description provided for @token.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get token;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @from_time_required.
  ///
  /// In en, this message translates to:
  /// **'From time must be later than the current time.'**
  String get from_time_required;

  /// No description provided for @from_before_to.
  ///
  /// In en, this message translates to:
  /// **'From time must be earlier than To time.'**
  String get from_before_to;

  /// No description provided for @to_after_now.
  ///
  /// In en, this message translates to:
  /// **'To time must be later than the current time.'**
  String get to_after_now;

  /// No description provided for @to_after_from_or_now.
  ///
  /// In en, this message translates to:
  /// **'To time must be after the selected \'From\' time or current time.'**
  String get to_after_from_or_now;

  /// No description provided for @to_after_from.
  ///
  /// In en, this message translates to:
  /// **'To time must be after From time.'**
  String get to_after_from;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @please_select_date_and_time.
  ///
  /// In en, this message translates to:
  /// **'Please Select Date And Time'**
  String get please_select_date_and_time;

  /// No description provided for @picture.
  ///
  /// In en, this message translates to:
  /// **'Picture'**
  String get picture;

  /// No description provided for @add_photo.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get add_photo;

  /// No description provided for @gate_number.
  ///
  /// In en, this message translates to:
  /// **'Gate Number'**
  String get gate_number;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Edit & Delete'**
  String get action;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @single.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get single;

  /// No description provided for @married.
  ///
  /// In en, this message translates to:
  /// **'Married'**
  String get married;

  /// No description provided for @edit_security_guard_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Security Guard Information'**
  String get edit_security_guard_title;

  /// No description provided for @please_enter_numbers_only.
  ///
  /// In en, this message translates to:
  /// **'Please enter numbers only'**
  String get please_enter_numbers_only;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'example@gmail.com'**
  String get email_hint;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'********'**
  String get password_hint;

  /// No description provided for @password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_required;

  /// No description provided for @password_too_short.
  ///
  /// In en, this message translates to:
  /// **'Password is too short (must be at least 6 characters)'**
  String get password_too_short;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @phone_number_hint.
  ///
  /// In en, this message translates to:
  /// **'01000000000'**
  String get phone_number_hint;

  /// No description provided for @invalid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number (must contain only digits and be between 10–15 digits)'**
  String get invalid_phone_number;

  /// No description provided for @invalid_gate_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid gate number (must contain only digits)'**
  String get invalid_gate_number;

  /// No description provided for @password_complexity_error.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character (e.g. ! @ # \$ & * ~)'**
  String get password_complexity_error;

  /// No description provided for @villa_number_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Villa Number Is Empty'**
  String get villa_number_is_empty;

  /// No description provided for @edit_member_account_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Member Account Title'**
  String get edit_member_account_title;

  /// No description provided for @update_success.
  ///
  /// In en, this message translates to:
  /// **'Member account updated successfully'**
  String get update_success;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @please_enter_amount.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount'**
  String get please_enter_amount;

  /// No description provided for @amount_must_be_numeric.
  ///
  /// In en, this message translates to:
  /// **'Amount must be a number'**
  String get amount_must_be_numeric;

  /// No description provided for @please_select_bond_type_and_currency.
  ///
  /// In en, this message translates to:
  /// **'Please select bond type and currency'**
  String get please_select_bond_type_and_currency;

  /// No description provided for @villa_number_not_found.
  ///
  /// In en, this message translates to:
  /// **'Villa number not found'**
  String get villa_number_not_found;

  /// No description provided for @bond_created_successfully.
  ///
  /// In en, this message translates to:
  /// **'Bond created successfully'**
  String get bond_created_successfully;

  /// No description provided for @receipt_bond_for_compound.
  ///
  /// In en, this message translates to:
  /// **'Create Receipt Bond for the Compound'**
  String get receipt_bond_for_compound;

  /// No description provided for @owner_disbursement_bond_created.
  ///
  /// In en, this message translates to:
  /// **'Owner Disbursement Bond Created Successfully'**
  String get owner_disbursement_bond_created;

  /// No description provided for @disbursement_bond_for_compound.
  ///
  /// In en, this message translates to:
  /// **'Disbursement Bond for Compound'**
  String get disbursement_bond_for_compound;

  /// No description provided for @create_disbursement_bond_for_compound.
  ///
  /// In en, this message translates to:
  /// **'Create Disbursement Bond for Compound'**
  String get create_disbursement_bond_for_compound;

  /// No description provided for @job.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get job;

  /// No description provided for @account_manager.
  ///
  /// In en, this message translates to:
  /// **'Account Manager'**
  String get account_manager;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @please_choose_job.
  ///
  /// In en, this message translates to:
  /// **'Please choose job'**
  String get please_choose_job;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @disbursement.
  ///
  /// In en, this message translates to:
  /// **'Disbursement Bond'**
  String get disbursement;

  /// No description provided for @receipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt Bond'**
  String get receipt;

  /// No description provided for @invalid_email_password.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email or Password'**
  String get invalid_email_password;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @enter_villa_number.
  ///
  /// In en, this message translates to:
  /// **'Enter villa number'**
  String get enter_villa_number;

  /// No description provided for @login_successfully.
  ///
  /// In en, this message translates to:
  /// **'Login successfully'**
  String get login_successfully;

  /// No description provided for @add_user_successfully.
  ///
  /// In en, this message translates to:
  /// **'User added successfully'**
  String get add_user_successfully;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
