class EndPoints {
  static const baseUrl = 'https://food-api-omega.vercel.app/api/v1/';
  static const signIn = 'user/signin';
  static const signUp = 'user/signup';
  static getUserDataEndPoint(String id) => 'user/get-user/$id';
}
