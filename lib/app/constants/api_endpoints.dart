class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";
  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String imageUrl = "http://10.0.2.2:3000/images/";
  static const String uploadImage = "auth/upload";
  static const String verifyOtp = "auth/verify-otp";

  // ====================== Skills Routes ======================
  static const String getAllSkills = "skills/";
  static const String getSkillById = "skills/";

  // ====================== Projects Routes ======================
  static const String getAllProjects = "projects/";
  static const String getProjectById = "projects/";

  // ====================== Company Routes ======================
  static const String getCompanyById = "companies/";

  // ====================== Freelancer Routes ======================
  static const String getFreelancerById = "freelancers/";
  static const String updateFreelancerById = "freelancers/";

  // ====================== Bidding Routes ======================
  static const String createBid = "biddings/create";
}
