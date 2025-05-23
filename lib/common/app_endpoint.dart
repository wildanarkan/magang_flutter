class AppEndpoint {
  // static const baseUrl = 'http://192.168.1.104:8000/';
  // static const baseUrl = 'http://192.168.1.30:8000/';
  // static const baseUrl = 'http://192.168.220.191:8000/';
  static const baseUrl = 'http://192.168.1.52:8000/';
  static const baseAppUrl = '${baseUrl}api/app/';
  static const photoUrl = '${baseUrl}storage/profile_photos/';
  static const photoProofUrl = '${baseUrl}storage/photo_proofs/';
  static const photoDocumentUrl = '${baseUrl}storage/photo_document/';
  // static const baseUrl = 'http://192.168.0.12:8000/';
  // static const photoUrl = 'http://192.168.0.12:8000';
  static const login = '${baseAppUrl}login';
  static const verifyOtp = '${baseAppUrl}otp/verify/';
  static const sendOtp = '${baseAppUrl}otp/send/';
  static const user = '${baseAppUrl}user';
  static const profile = '${baseAppUrl}profile/';
  static const updatePhoto = '${baseAppUrl}profile/photo/';
  static const changePassword = '${baseAppUrl}password';
  static const editprofile = '${baseAppUrl}edit';
  static const contract = '${baseAppUrl}contract/';
  static const payrolls = '${baseAppUrl}payrolls/user/';
  static const payroll = '${baseAppUrl}payroll/';
  static const leaveUser = '${baseAppUrl}leave/user/';
  static const leave = '${baseAppUrl}leave/';
  static const leaveUpdate = '${baseAppUrl}leave/update/';
  static const leaveCategory = '${baseAppUrl}leave/category';
  static const leaveStore = '${baseAppUrl}leave/make/';
  static const business = '${baseAppUrl}business/';
  static const tripToday = '${baseAppUrl}business/trip-today/';
  static const company = '${baseAppUrl}companycity/company/';
  static const updateExtendedDay = '${baseAppUrl}business/extend/';
  static const companyCity = '${baseAppUrl}companycity/companycity/';
  static const city = '${baseAppUrl}companycity/city/';
  static const allUser = '${baseAppUrl}user/users/fullname';
  static const percentage = '${baseAppUrl}business/percentage';
  static const calculate = '${baseAppUrl}business/calculate';
  static const nominalRealization = '${baseAppUrl}business/realization';
  static const nominalPlanning = '${baseAppUrl}business/planning';
  static const postBusinessTrip = '${baseAppUrl}business/make';
  static const postPhotoDocument = '${baseAppUrl}business/upload-file/';
  static const postTripdetail = '${baseAppUrl}business/trip';
  static const addBusiness = '${baseAppUrl}business/add';
  static const categoryExpenditure = '${baseAppUrl}business/categories';
  static const putRealization = '${baseAppUrl}business/update/';
  static const getRealizationId = '${baseAppUrl}business/realizationid/';
  static const checkInActivity = '${baseAppUrl}checkin/';
  static const checkInToday = '${baseAppUrl}checkin/today/';
  static const getFcmToken = '${baseAppUrl}user/fcm-token';
  static const deleteFcmToken = '${baseAppUrl}user/delete-fcm-token';
}
