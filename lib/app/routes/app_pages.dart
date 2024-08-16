import 'package:get/get.dart';

import '../modules/bottom/bindings/bottom_binding.dart';
import '../modules/bottom/views/bottom_view.dart';
import '../modules/budget/bindings/budget_binding.dart';
import '../modules/budget/views/budget_view.dart';
import '../modules/expense/bindings/expense_binding.dart';
import '../modules/expense/views/expense_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/setup_account_bank/bindings/setup_account_bank_binding.dart';
import '../modules/setup_account_bank/views/setup_account_bank_view.dart';
import '../modules/setup_bank/bindings/setup_bank_binding.dart';
import '../modules/setup_bank/views/setup_bank_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/successfull_added_account_bank/bindings/successfull_added_account_bank_binding.dart';
import '../modules/successfull_added_account_bank/views/successfull_added_account_bank_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/wallet_account/bindings/wallet_account_binding.dart';
import '../modules/wallet_account/views/wallet_account_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.SETUP_BANK,
      page: () => const SetupBankView(),
      binding: SetupBankBinding(),
    ),
    GetPage(
      name: _Paths.SETUP_ACCOUNT_BANK,
      page: () => const SetupAccountBankView(),
      binding: SetupAccountBankBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESSFULL_ADDED_ACCOUNT_BANK,
      page: () => const SuccessfullAddedAccountBankView(),
      binding: SuccessfullAddedAccountBankBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_ACCOUNT,
      page: () => const WalletAccountView(),
      binding: WalletAccountBinding(),
    ),
    GetPage(
      name: _Paths.EXPENSE,
      page: () => const ExpenseView(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM,
      page: () => const BottomView(),
      binding: BottomBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.BUDGET,
      page: () => const BudgetView(),
      binding: BudgetBinding(),
    ),
  ];
}
