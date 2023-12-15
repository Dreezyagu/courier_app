const Map<String, String> URL_TEST = {
  "baseUrl": "http://api-staging.ojembaa.com/api/v1/",
  "placesAPIKey": "AIzaSyADKIDZ_aYQaVYtCsD13_cHrlU8BKv0cA0",
};

const Map<String, String> URL_PROD = {
  "baseUrl": "http://api-staging.ojembaa.com/api/v1/",
  "placesAPIKey": "AIzaSyADKIDZ_aYQaVYtCsD13_cHrlU8BKv0cA0",
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
