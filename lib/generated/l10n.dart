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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Invitations`
  String get invitations {
    return Intl.message('Invitations', name: 'invitations', desc: '', args: []);
  }

  /// `Create Invitation`
  String get create_invitation {
    return Intl.message(
      'Create Invitation',
      name: 'create_invitation',
      desc: '',
      args: [],
    );
  }

  /// `Add Member`
  String get add_member {
    return Intl.message('Add Member', name: 'add_member', desc: '', args: []);
  }

  /// `Add Security Guard`
  String get add_security_guard {
    return Intl.message(
      'Add Security Guard',
      name: 'add_security_guard',
      desc: '',
      args: [],
    );
  }

  /// `Account Management`
  String get account_management {
    return Intl.message(
      'Account Management',
      name: 'account_management',
      desc: '',
      args: [],
    );
  }

  /// `User Management`
  String get user_management {
    return Intl.message(
      'User Management',
      name: 'user_management',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chat {
    return Intl.message('Chats', name: 'chat', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Did you forget your password?`
  String get did_you_forget_your_password {
    return Intl.message(
      'Did you forget your password?',
      name: 'did_you_forget_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email and password`
  String get please {
    return Intl.message(
      'Please enter your email and password',
      name: 'please',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message('Remember me', name: 'remember_me', desc: '', args: []);
  }

  /// `Enter your email`
  String get please_enter_your_email {
    return Intl.message(
      'Enter your email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get please_enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'please_enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Villa Number`
  String get villa_number {
    return Intl.message(
      'Villa Number',
      name: 'villa_number',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Reason for Visit`
  String get reason_for_visit {
    return Intl.message(
      'Reason for Visit',
      name: 'reason_for_visit',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Refuse`
  String get refuse {
    return Intl.message('Refuse', name: 'refuse', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Please enter name`
  String get please_enter_name {
    return Intl.message(
      'Please enter name',
      name: 'please_enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Enter phone number`
  String get enter_phone_number {
    return Intl.message(
      'Enter phone number',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter villa number`
  String get please_enter_villa_number {
    return Intl.message(
      'Please enter villa number',
      name: 'please_enter_villa_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter reason for visit`
  String get please_enter_reason_for_visit {
    return Intl.message(
      'Please enter reason for visit',
      name: 'please_enter_reason_for_visit',
      desc: '',
      args: [],
    );
  }

  /// `Please enter number of persons`
  String get please_enter_number_of_persons {
    return Intl.message(
      'Please enter number of persons',
      name: 'please_enter_number_of_persons',
      desc: '',
      args: [],
    );
  }

  /// `Please select a date`
  String get please_select_date {
    return Intl.message(
      'Please select a date',
      name: 'please_select_date',
      desc: '',
      args: [],
    );
  }

  /// `Upload new member photo`
  String get upload_new_member_photo {
    return Intl.message(
      'Upload new member photo',
      name: 'upload_new_member_photo',
      desc: '',
      args: [],
    );
  }

  /// `Villa Address`
  String get villa_address {
    return Intl.message(
      'Villa Address',
      name: 'villa_address',
      desc: '',
      args: [],
    );
  }

  /// `Enter villa address`
  String get enter_villa_address {
    return Intl.message(
      'Enter villa address',
      name: 'enter_villa_address',
      desc: '',
      args: [],
    );
  }

  /// `Villa Location`
  String get villa_location {
    return Intl.message(
      'Villa Location',
      name: 'villa_location',
      desc: '',
      args: [],
    );
  }

  /// `Enter villa location`
  String get enter_villa_location {
    return Intl.message(
      'Enter villa location',
      name: 'enter_villa_location',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message('Street', name: 'street', desc: '', args: []);
  }

  /// `Select street`
  String get select_street {
    return Intl.message(
      'Select street',
      name: 'select_street',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message('Area', name: 'area', desc: '', args: []);
  }

  /// `Enter area`
  String get enter_area {
    return Intl.message('Enter area', name: 'enter_area', desc: '', args: []);
  }

  /// `Number of Floors`
  String get number_of_floors {
    return Intl.message(
      'Number of Floors',
      name: 'number_of_floors',
      desc: '',
      args: [],
    );
  }

  /// `Enter number of floors`
  String get enter_number_of_floors {
    return Intl.message(
      'Enter number of floors',
      name: 'enter_number_of_floors',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Street must be at least 3 characters`
  String get street_must_be_at_least_3_characters {
    return Intl.message(
      'Street must be at least 3 characters',
      name: 'street_must_be_at_least_3_characters',
      desc: '',
      args: [],
    );
  }

  /// `Form is valid`
  String get form_valid {
    return Intl.message(
      'Form is valid',
      name: 'form_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please fix the form errors`
  String get please_fix_form_errors {
    return Intl.message(
      'Please fix the form errors',
      name: 'please_fix_form_errors',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 2 characters`
  String get name_must_be_at_least_2_characters {
    return Intl.message(
      'Name must be at least 2 characters',
      name: 'name_must_be_at_least_2_characters',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid phone number`
  String get enter_valid_phone_number {
    return Intl.message(
      'Enter a valid phone number',
      name: 'enter_valid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get enter_valid_email {
    return Intl.message(
      'Enter a valid email address',
      name: 'enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get password_must_be_at_least_8_characters {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'password_must_be_at_least_8_characters',
      desc: '',
      args: [],
    );
  }

  /// `Villa address must be at least 5 characters`
  String get villa_address_must_be_at_least_5_characters {
    return Intl.message(
      'Villa address must be at least 5 characters',
      name: 'villa_address_must_be_at_least_5_characters',
      desc: '',
      args: [],
    );
  }

  /// `Villa number must be numeric`
  String get villa_number_must_be_numeric {
    return Intl.message(
      'Villa number must be numeric',
      name: 'villa_number_must_be_numeric',
      desc: '',
      args: [],
    );
  }

  /// `Villa location must be at least 5 characters`
  String get villa_location_must_be_at_least_5_characters {
    return Intl.message(
      'Villa location must be at least 5 characters',
      name: 'villa_location_must_be_at_least_5_characters',
      desc: '',
      args: [],
    );
  }

  /// `Area must be a valid number`
  String get area_must_be_valid_number {
    return Intl.message(
      'Area must be a valid number',
      name: 'area_must_be_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Number of floors must be numeric`
  String get number_of_floors_must_be_numeric {
    return Intl.message(
      'Number of floors must be numeric',
      name: 'number_of_floors_must_be_numeric',
      desc: '',
      args: [],
    );
  }

  /// `Upload Security Guard Photo`
  String get security_guard_photo_upload {
    return Intl.message(
      'Upload Security Guard Photo',
      name: 'security_guard_photo_upload',
      desc: '',
      args: [],
    );
  }

  /// `Enter security guard name`
  String get enter_security_guard_name {
    return Intl.message(
      'Enter security guard name',
      name: 'enter_security_guard_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter security guard phone`
  String get enter_security_guard_phone {
    return Intl.message(
      'Enter security guard phone',
      name: 'enter_security_guard_phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter security guard email`
  String get enter_security_guard_email {
    return Intl.message(
      'Enter security guard email',
      name: 'enter_security_guard_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter security guard password`
  String get enter_security_guard_password {
    return Intl.message(
      'Enter security guard password',
      name: 'enter_security_guard_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter gate number`
  String get enter_gate_number {
    return Intl.message(
      'Enter gate number',
      name: 'enter_gate_number',
      desc: '',
      args: [],
    );
  }

  /// `Gate number must be numeric`
  String get gate_number_must_be_numeric {
    return Intl.message(
      'Gate number must be numeric',
      name: 'gate_number_must_be_numeric',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Members Account Statement`
  String get members_account_statement {
    return Intl.message(
      'Members Account Statement',
      name: 'members_account_statement',
      desc: '',
      args: [],
    );
  }

  /// `Single Member Account Statement`
  String get single_member_account_statement {
    return Intl.message(
      'Single Member Account Statement',
      name: 'single_member_account_statement',
      desc: '',
      args: [],
    );
  }

  /// `Create Voucher`
  String get create_voucher {
    return Intl.message(
      'Create Voucher',
      name: 'create_voucher',
      desc: '',
      args: [],
    );
  }

  /// `Payment Vouchers`
  String get payment_vouchers {
    return Intl.message(
      'Payment Vouchers',
      name: 'payment_vouchers',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Vouchers`
  String get receipt_vouchers {
    return Intl.message(
      'Receipt Vouchers',
      name: 'receipt_vouchers',
      desc: '',
      args: [],
    );
  }

  /// `Please enter name`
  String get enter_name {
    return Intl.message(
      'Please enter name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone`
  String get enter_phone {
    return Intl.message(
      'Please enter phone',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter address`
  String get enter_address {
    return Intl.message(
      'Please enter address',
      name: 'enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Please enter status`
  String get enter_status {
    return Intl.message(
      'Please enter status',
      name: 'enter_status',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the date`
  String get please_enter_date {
    return Intl.message(
      'Please enter the date',
      name: 'please_enter_date',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Paid`
  String get paid {
    return Intl.message('Paid', name: 'paid', desc: '', args: []);
  }

  /// `Remaining`
  String get residual {
    return Intl.message('Remaining', name: 'residual', desc: '', args: []);
  }

  /// `Year`
  String get year {
    return Intl.message('Year', name: 'year', desc: '', args: []);
  }

  /// `Voucher Date`
  String get voucher_date {
    return Intl.message(
      'Voucher Date',
      name: 'voucher_date',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Account Number`
  String get account_num {
    return Intl.message(
      'Account Number',
      name: 'account_num',
      desc: '',
      args: [],
    );
  }

  /// `Creditor`
  String get creditor {
    return Intl.message('Creditor', name: 'creditor', desc: '', args: []);
  }

  /// `Debtor`
  String get debtor {
    return Intl.message('Debtor', name: 'debtor', desc: '', args: []);
  }

  /// `Bond Explain`
  String get bond_explain {
    return Intl.message(
      'Bond Explain',
      name: 'bond_explain',
      desc: '',
      args: [],
    );
  }

  /// `Bond Type`
  String get bond_type {
    return Intl.message('Bond Type', name: 'bond_type', desc: '', args: []);
  }

  /// `Receipt Bond`
  String get receipt_bond {
    return Intl.message(
      'Receipt Bond',
      name: 'receipt_bond',
      desc: '',
      args: [],
    );
  }

  /// `Payment Bond`
  String get payment_bond {
    return Intl.message(
      'Payment Bond',
      name: 'payment_bond',
      desc: '',
      args: [],
    );
  }

  /// `Bond saved successfully`
  String get bond_saved_successfully {
    return Intl.message(
      'Bond saved successfully',
      name: 'bond_saved_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the required fields`
  String get please_fill_required_fields {
    return Intl.message(
      'Please fill in the required fields',
      name: 'please_fill_required_fields',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the bond date`
  String get please_enter_bond_date {
    return Intl.message(
      'Please enter the bond date',
      name: 'please_enter_bond_date',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the currency`
  String get please_enter_currency {
    return Intl.message(
      'Please enter the currency',
      name: 'please_enter_currency',
      desc: '',
      args: [],
    );
  }

  /// `Please enter creditor name`
  String get please_enter_creditor {
    return Intl.message(
      'Please enter creditor name',
      name: 'please_enter_creditor',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account number`
  String get please_enter_account_number {
    return Intl.message(
      'Please enter account number',
      name: 'please_enter_account_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter bond description`
  String get please_enter_bond_description {
    return Intl.message(
      'Please enter bond description',
      name: 'please_enter_bond_description',
      desc: '',
      args: [],
    );
  }

  /// `Create Bond`
  String get create_bond {
    return Intl.message('Create Bond', name: 'create_bond', desc: '', args: []);
  }

  /// `Invalid Email`
  String get invalid_email {
    return Intl.message(
      'Invalid Email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `We send you Reset link`
  String get we_send_you_reset_link {
    return Intl.message(
      'We send you Reset link',
      name: 'we_send_you_reset_link',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Valid Email`
  String get please_enter_valid_email {
    return Intl.message(
      'Please Enter Valid Email',
      name: 'please_enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Password`
  String get send_reset_password {
    return Intl.message(
      'Send Reset Password',
      name: 'send_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Change Password`
  String get confirm_change_password {
    return Intl.message(
      'Confirm Change Password',
      name: 'confirm_change_password',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get email_is_required {
    return Intl.message(
      'Email is required',
      name: 'email_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalid_email_format {
    return Intl.message(
      'Invalid email format',
      name: 'invalid_email_format',
      desc: '',
      args: [],
    );
  }

  /// `Verification code is required`
  String get token_is_required {
    return Intl.message(
      'Verification code is required',
      name: 'token_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get password_is_required {
    return Intl.message(
      'Password is required',
      name: 'password_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters, include upper and lower case letters, numbers, and special characters`
  String get password_validation_message {
    return Intl.message(
      'Password must be at least 8 characters, include upper and lower case letters, numbers, and special characters',
      name: 'password_validation_message',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get token {
    return Intl.message('Verification Code', name: 'token', desc: '', args: []);
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `From time must be later than the current time.`
  String get from_time_required {
    return Intl.message(
      'From time must be later than the current time.',
      name: 'from_time_required',
      desc: '',
      args: [],
    );
  }

  /// `From time must be earlier than To time.`
  String get from_before_to {
    return Intl.message(
      'From time must be earlier than To time.',
      name: 'from_before_to',
      desc: '',
      args: [],
    );
  }

  /// `To time must be later than the current time.`
  String get to_after_now {
    return Intl.message(
      'To time must be later than the current time.',
      name: 'to_after_now',
      desc: '',
      args: [],
    );
  }

  /// `To time must be after the selected 'From' time or current time.`
  String get to_after_from_or_now {
    return Intl.message(
      'To time must be after the selected \'From\' time or current time.',
      name: 'to_after_from_or_now',
      desc: '',
      args: [],
    );
  }

  /// `To time must be after From time.`
  String get to_after_from {
    return Intl.message(
      'To time must be after From time.',
      name: 'to_after_from',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message('From', name: 'from', desc: '', args: []);
  }

  /// `To`
  String get to {
    return Intl.message('To', name: 'to', desc: '', args: []);
  }

  /// `Please Select Date And Time`
  String get please_select_date_and_time {
    return Intl.message(
      'Please Select Date And Time',
      name: 'please_select_date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `Picture`
  String get picture {
    return Intl.message('Picture', name: 'picture', desc: '', args: []);
  }

  /// `Add Photo`
  String get add_photo {
    return Intl.message('Add Photo', name: 'add_photo', desc: '', args: []);
  }

  /// `Gate Number`
  String get gate_number {
    return Intl.message('Gate Number', name: 'gate_number', desc: '', args: []);
  }

  /// `Image`
  String get image {
    return Intl.message('Image', name: 'image', desc: '', args: []);
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Edit & Delete`
  String get action {
    return Intl.message('Edit & Delete', name: 'action', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Single`
  String get single {
    return Intl.message('Single', name: 'single', desc: '', args: []);
  }

  /// `Married`
  String get married {
    return Intl.message('Married', name: 'married', desc: '', args: []);
  }

  /// `Edit Security Guard Information`
  String get edit_security_guard_title {
    return Intl.message(
      'Edit Security Guard Information',
      name: 'edit_security_guard_title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter numbers only`
  String get please_enter_numbers_only {
    return Intl.message(
      'Please enter numbers only',
      name: 'please_enter_numbers_only',
      desc: '',
      args: [],
    );
  }

  /// `example@gmail.com`
  String get email_hint {
    return Intl.message(
      'example@gmail.com',
      name: 'email_hint',
      desc: '',
      args: [],
    );
  }

  /// `********`
  String get password_hint {
    return Intl.message('********', name: 'password_hint', desc: '', args: []);
  }

  /// `Password is required`
  String get password_required {
    return Intl.message(
      'Password is required',
      name: 'password_required',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short (must be at least 6 characters)`
  String get password_too_short {
    return Intl.message(
      'Password is too short (must be at least 6 characters)',
      name: 'password_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `01000000000`
  String get phone_number_hint {
    return Intl.message(
      '01000000000',
      name: 'phone_number_hint',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number (must contain only digits and be between 10–15 digits)`
  String get invalid_phone_number {
    return Intl.message(
      'Invalid phone number (must contain only digits and be between 10–15 digits)',
      name: 'invalid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Invalid gate number (must contain only digits)`
  String get invalid_gate_number {
    return Intl.message(
      'Invalid gate number (must contain only digits)',
      name: 'invalid_gate_number',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character (e.g. ! @ # $ & * ~)`
  String get password_complexity_error {
    return Intl.message(
      'Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character (e.g. ! @ # \$ & * ~)',
      name: 'password_complexity_error',
      desc: '',
      args: [],
    );
  }

  /// `Villa Number Is Empty`
  String get villa_number_is_empty {
    return Intl.message(
      'Villa Number Is Empty',
      name: 'villa_number_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Edit Member Account Title`
  String get edit_member_account_title {
    return Intl.message(
      'Edit Member Account Title',
      name: 'edit_member_account_title',
      desc: '',
      args: [],
    );
  }

  /// `Member account updated successfully`
  String get update_success {
    return Intl.message(
      'Member account updated successfully',
      name: 'update_success',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Please enter the amount`
  String get please_enter_amount {
    return Intl.message(
      'Please enter the amount',
      name: 'please_enter_amount',
      desc: '',
      args: [],
    );
  }

  /// `Amount must be a number`
  String get amount_must_be_numeric {
    return Intl.message(
      'Amount must be a number',
      name: 'amount_must_be_numeric',
      desc: '',
      args: [],
    );
  }

  /// `Please select bond type and currency`
  String get please_select_bond_type_and_currency {
    return Intl.message(
      'Please select bond type and currency',
      name: 'please_select_bond_type_and_currency',
      desc: '',
      args: [],
    );
  }

  /// `Villa number not found`
  String get villa_number_not_found {
    return Intl.message(
      'Villa number not found',
      name: 'villa_number_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Bond created successfully`
  String get bond_created_successfully {
    return Intl.message(
      'Bond created successfully',
      name: 'bond_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Create Receipt Bond for the Compound`
  String get receipt_bond_for_compound {
    return Intl.message(
      'Create Receipt Bond for the Compound',
      name: 'receipt_bond_for_compound',
      desc: '',
      args: [],
    );
  }

  /// `Owner Disbursement Bond Created Successfully`
  String get owner_disbursement_bond_created {
    return Intl.message(
      'Owner Disbursement Bond Created Successfully',
      name: 'owner_disbursement_bond_created',
      desc: '',
      args: [],
    );
  }

  /// `Disbursement Bond for Compound`
  String get disbursement_bond_for_compound {
    return Intl.message(
      'Disbursement Bond for Compound',
      name: 'disbursement_bond_for_compound',
      desc: '',
      args: [],
    );
  }

  /// `Create Disbursement Bond for Compound`
  String get create_disbursement_bond_for_compound {
    return Intl.message(
      'Create Disbursement Bond for Compound',
      name: 'create_disbursement_bond_for_compound',
      desc: '',
      args: [],
    );
  }

  /// `Job`
  String get job {
    return Intl.message('Job', name: 'job', desc: '', args: []);
  }

  /// `Account Manager`
  String get account_manager {
    return Intl.message(
      'Account Manager',
      name: 'account_manager',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message('Admin', name: 'admin', desc: '', args: []);
  }

  /// `Please choose job`
  String get please_choose_job {
    return Intl.message(
      'Please choose job',
      name: 'please_choose_job',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Disbursement Bond`
  String get disbursement {
    return Intl.message(
      'Disbursement Bond',
      name: 'disbursement',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Bond`
  String get receipt {
    return Intl.message('Receipt Bond', name: 'receipt', desc: '', args: []);
  }

  /// `Invalid Email or Password`
  String get invalid_email_password {
    return Intl.message(
      'Invalid Email or Password',
      name: 'invalid_email_password',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message('Hello', name: 'hello', desc: '', args: []);
  }

  /// `Enter villa number`
  String get enter_villa_number {
    return Intl.message(
      'Enter villa number',
      name: 'enter_villa_number',
      desc: '',
      args: [],
    );
  }

  /// `Login successfully`
  String get login_successfully {
    return Intl.message(
      'Login successfully',
      name: 'login_successfully',
      desc: '',
      args: [],
    );
  }

  /// `User added successfully`
  String get add_user_successfully {
    return Intl.message(
      'User added successfully',
      name: 'add_user_successfully',
      desc: '',
      args: [],
    );
  }

  /// `No users found`
  String get no_users_found {
    return Intl.message(
      'No users found',
      name: 'no_users_found',
      desc: '',
      args: [],
    );
  }

  /// `Add Invitation`
  String get add_invitation {
    return Intl.message(
      'Add Invitation',
      name: 'add_invitation',
      desc: '',
      args: [],
    );
  }

  /// `View Invitations`
  String get view_invitations {
    return Intl.message(
      'View Invitations',
      name: 'view_invitations',
      desc: '',
      args: [],
    );
  }

  /// `Add Security`
  String get add_security {
    return Intl.message(
      'Add Security',
      name: 'add_security',
      desc: '',
      args: [],
    );
  }

  /// `View Security`
  String get view_security {
    return Intl.message(
      'View Security',
      name: 'view_security',
      desc: '',
      args: [],
    );
  }

  /// `Add Payment Voucher`
  String get add_payment_voucher {
    return Intl.message(
      'Add Payment Voucher',
      name: 'add_payment_voucher',
      desc: '',
      args: [],
    );
  }

  /// `View Payment Vouchers`
  String get view_payment_vouchers {
    return Intl.message(
      'View Payment Vouchers',
      name: 'view_payment_vouchers',
      desc: '',
      args: [],
    );
  }

  /// `Add Receipt Voucher`
  String get add_receipt_voucher {
    return Intl.message(
      'Add Receipt Voucher',
      name: 'add_receipt_voucher',
      desc: '',
      args: [],
    );
  }

  /// `View Receipt Vouchers`
  String get view_receipt_vouchers {
    return Intl.message(
      'View Receipt Vouchers',
      name: 'view_receipt_vouchers',
      desc: '',
      args: [],
    );
  }

  /// `Add Account`
  String get add_account {
    return Intl.message('Add Account', name: 'add_account', desc: '', args: []);
  }

  /// `View Accounts`
  String get view_accounts {
    return Intl.message(
      'View Accounts',
      name: 'view_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Add Member Statement`
  String get add_member_statement {
    return Intl.message(
      'Add Member Statement',
      name: 'add_member_statement',
      desc: '',
      args: [],
    );
  }

  /// `View All Members`
  String get view_all_members {
    return Intl.message(
      'View All Members',
      name: 'view_all_members',
      desc: '',
      args: [],
    );
  }

  /// `Member Type`
  String get member_type {
    return Intl.message('Member Type', name: 'member_type', desc: '', args: []);
  }

  /// `Select member type`
  String get select_member_type {
    return Intl.message(
      'Select member type',
      name: 'select_member_type',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message('Owner', name: 'owner', desc: '', args: []);
  }

  /// `Tenant`
  String get tenant {
    return Intl.message('Tenant', name: 'tenant', desc: '', args: []);
  }

  /// `Authorized`
  String get authorized {
    return Intl.message('Authorized', name: 'authorized', desc: '', args: []);
  }

  /// `Villa Type`
  String get villa_type {
    return Intl.message('Villa Type', name: 'villa_type', desc: '', args: []);
  }

  /// `Select villa type`
  String get select_villa_type {
    return Intl.message(
      'Select villa type',
      name: 'select_villa_type',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get finished {
    return Intl.message('Finished', name: 'finished', desc: '', args: []);
  }

  /// `Unfinished`
  String get unfinished {
    return Intl.message('Unfinished', name: 'unfinished', desc: '', args: []);
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
