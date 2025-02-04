import 'package:ojembaa_courier/utils/constants.dart';

const Map<String, String> URL_TEST = {
  "baseUrl": "https://api.ojembaa.com/api/v1/",
  "placesAPIKey": placesAPI
};

const Map<String, String> URL_PROD = {
  "baseUrl": "https://api.ojembaa.com/api/v1/",
  "placesAPIKey": placesAPI
};

class OjembaaUrls {
  static String? getUrl(String url) {
    return URL_TEST[url];
    // switch (flavour) {
    //   case Flavor.Development:
    //     return Earnipay_URL_TEST[url];
    //   case Flavor.Staging:
    //     return Earnipay_URL_PROD[url];
    //   case Flavor.Production:
    //     return Earnipay_URL_PROD[url];
    //   default:
    //     return Earnipay_URL_PROD[url];
    // }
  }
}
