//'https://selivery.onrender.com/';
//'http://192.168.1.122:8000/'
 const baseUri =  'http://192.168.1.5:8000/';
const authBaseUri = '${baseUri}auth/';
final loginUri = Uri.parse('${authBaseUri}login/admin');
final OtpUri = Uri.parse('${authBaseUri}login/admin/verify');
final allCategory =
    Uri.parse('${baseUri}dashboard/category');
final verifyClientPhoneCodeUrl =
Uri.parse('${authBaseUri}login/admin/verify');
final topPassengers = Uri.parse("${baseUri}dashboard/trip/top_passengers");
final topVehicles = Uri.parse("${baseUri}dashboard/trip/top_vehicles");
final topDrivers = Uri.parse("${baseUri}dashboard/driver");

final uploadCategoryUri = Uri.parse('${baseUri}dashboard/category');
final addAdsUri = Uri.parse('${baseUri}dashboard/advertisement');
final addReelUri = Uri.parse('${baseUri}dashboard/reels');
final getAllAdsUri = Uri.parse('${baseUri}dashboard/advertisement');
final getAllReelUri = Uri.parse('${baseUri}dashboard/reels');
final getAllDriverLicenseAdsUri =
Uri.parse('${baseUri}dashboard/request');

Uri driverVehicleUri(String id) =>
    Uri.parse("${baseUri}dashboard/driver/$id/vehicle");

Uri deleteDriverAccountUri(String id) =>
    Uri.parse("${baseUri}dashboard/driver/$id");

Uri deleteCategoryUri(String? id) =>
    Uri.parse('${baseUri}dashboard/category/$id');
Uri updateCategoryUri(String id) =>
    Uri.parse('${baseUri}dashboard/category/$id');
Uri deleteAdsUri(String id) =>
    Uri.parse("${baseUri}dashboard/advertisement/$id");
Uri deleteReelUri(String id) =>
    Uri.parse("${baseUri}dashboard/reels/$id");
Uri approveDriverUri(String id) =>
    Uri.parse("${baseUri}dashboard/request/$id/approve");
Uri rejectDriverUri(String id) =>
    Uri.parse("${baseUri}dashboard/request/$id/reject");

final authHeaders = {
  'Keep-Alive': 'timeout=5',
  'Connection': 'keep-alive',
  'Date': 'Fri, 18 Aug 2023 21:32:41 GMT',
  'ETag': 'W/"260-WWE610PoFt4+PMlb4uXuYqzj+4w"',
  'Content-Type': 'application/json; charset=utf-8',
  'X-Powered-By': 'Express',
  'Access-Control-Allow-Origin': '*',
};
authHeadersWithToken(String token) => {
      'Keep-Alive': 'timeout=5',
      'Connection': 'keep-alive',
      'Date': 'Fri, 18 Aug 2023 21:32:41 GMT',
      'ETag': 'W/"260-WWE610PoFt4+PMlb4uXuYqzj+4w"',
      'Content-Type': 'application/json; charset=utf-8',
      'X-Powered-By': 'Express',
      'Access-Control-Allow-Origin': '*',
      'AUTHORIZATION': 'Bearer $token',
    };
