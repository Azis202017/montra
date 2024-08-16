class WalletHelpers {
  String? walletValidationEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Wallet name is required";
    }
    return null;
  }
}
