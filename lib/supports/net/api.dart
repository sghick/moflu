import 'dart:convert';
import 'dart:io';

import 'package:rego/base_core/log/logger.dart';

enum APIMethod {
  GET,
  POST,
  PUT,
  UPDATE,
  DELETE,
  PATCH,
}

class APIParam {
  final APIMethod method;
  final String url;
  final String path;
  final dynamic params;
  final int? timeout;
  final Function? parser;

  Error? error;
  dynamic response;

  APIParam(this.method, this.url, this.path,
      {this.params, this.timeout, this.parser});

  bool get isHttp {
    return this.url.startsWith('http://');
  }

  bool get isHttps {
    return this.url.startsWith('https://');
  }

  bool get isFile {
    return this.url.startsWith('file://');
  }

  Uri? get uri {
    Uri uri = Uri.parse(this.url + this.path);
    if (this.isHttps) {
      return Uri.https(uri.host, uri.path, this.params);
    }
    if (this.isHttp) {
      return Uri.http(uri.host, uri.path, this.params);
    }
    return uri;
  }
}

abstract class API {
  final APIParam apiParam;

  API(this.apiParam);

  Future<T?> query<T extends Object>();
}

HttpClient httpClient = HttpClient();

class CommonAPI extends API {
  CommonAPI(APIParam apiParam) : super(apiParam);

  @override
  Future<T?> query<T extends Object>() async {
    try {
      Uri? uri = this.apiParam.uri;
      if (uri == null) {
        throw Exception('apiParam参数解析错误');
      }
      try {
        var request = await httpClient.getUrl(uri);
        logD('request api:${request.method},${request.uri} \nparams:${this
            .apiParam.params}');
        var response = await request.close();
        var responseBody = await response.transform(Utf8Decoder()).join();
        logD('response api:${request.method},${request.uri},$responseBody');
        try {
          var resp = json.decode(responseBody);
          if ((resp != null) && (this.apiParam.parser != null)) {
            T res = this.apiParam.parser!(resp);
            return Future.value(res);
          } else {
            return Future.value(resp);
          }
        } catch (e) {
          throw Exception('请求结果解析失败');
        }
      } catch (e) {
        throw e;
      }
    } catch (e) {
      throw e;
    }
  }
}
