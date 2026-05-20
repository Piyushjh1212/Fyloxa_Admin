class ApiConfig {

  // ================= NETWORK =================
  static const String protocol = "http";
  static const String ip = "10.34.204.36";
  static const String port = "5000";

  // ================= API PREFIX =================
  static const String apiVersion =
      "api/v1/a7x20261/fyloxa";

  // ================= BASE URL =================
  static const String baseUrl =
      "$protocol://$ip:$port/$apiVersion";

  // ================= ENDPOINT BUILDER =================
  static String endpoint(String path) {
    return "$baseUrl/$path";
  }

  // ================= AUTH ROUTES =================
  static String get register =>
      endpoint("register");

  static String get login =>
      endpoint("login");

  static String get forgotPassword =>
      endpoint("forgot-password");

  // ================= PROFILE =================
  static String get updateProfile =>
      endpoint("login_email_get");

  // ================= GYM ROUTES =================
  static String get createGym =>
      endpoint("create-gym");

  static String get getGymDetails =>
      endpoint("get-gym-details");

  static String get updateGymDetails =>
      endpoint("addgymdetail");
}