import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'constants.dart';
import 'interceptor.dart';

class Request {
  static final Request _instance = Request._internal();
  static late CookieManager cookieManager;
  static late final Dio dio;

  factory Request() => _instance;

  /*
   * config it and create
   */
  Request._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: HttpString.apiBaseUrl,
      //连接服务器超时时间
      connectTimeout: const Duration(milliseconds: 12000),
      //响应流上前后两次接受到数据的间隔
      receiveTimeout: const Duration(milliseconds: 12000),
      //Http请求头.
      headers: {
        'Host': 'api.bgm.tv',
        'User-Agent':
            'YangSuGuo/HeLe/1.0.0 (https://github.com/YangSuGuo/HeLe_app)',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'app-id': 'bgm3063662e1d8747988',
        'app-secret': '427cfed140895351b35c06d45c1ef6e6',
        // 'Authorization': 'Bearer 427cfed140895351b35c06d45c1ef6e6',
      },
    );
    dio = Dio(options);
    //添加拦截器
    dio.interceptors.add(ApiInterceptor());

    // 日志拦截器 输出请求、响应内容
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      responseHeader: true,
    ));

    dio.transformer = BackgroundTransformer();
    dio.options.validateStatus = (int? status) {
      return status! >= 200 && status < 300 ||
          HttpString.validateStatusCodes.contains(status);
    };
  }

  /*
   * get请求
   */
  get(url, {data, options, cancelToken, extra}) async {
    Response response;
    final Options options = Options();
    ResponseType resType = ResponseType.json;
    if (extra != null) {
      resType = extra!['resType'] ?? ResponseType.json;
      if (extra['ua'] != null) {
        options.headers = {'User-Agent': headerUa(type: extra['ua'])};
      }
    }
    options.headers = {
      'Host': 'api.bgm.tv',
      'User-Agent':
          'YangSuGuo/HeLe/1.0.0 (https://github.com/YangSuGuo/HeLe_app)',
      'Accept': 'application/json',
      // 'app-id': 'bgm3063662e1d8747988',
      // 'app-secret': '427cfed140895351b35c06d45c1ef6e6',
      // 'Authorization': 'Bearer 427cfed140895351b35c06d45c1ef6e6',
    };
    options.responseType = resType;

    print(options.headers.toString());

    try {
      response = await dio.get(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      Response errResponse = Response(
        data: {'message': await ApiInterceptor.dioError(e)},
        statusCode: 200,
        requestOptions: RequestOptions(),
      );
      return errResponse;
    }
  }

  /*
   * post请求
   */
  post(url, {data, queryParameters, options, cancelToken, extra}) async {
    // print('post-data: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      // print('post success: ${response.data}');
      return response;
    } on DioException catch (e) {
      Response errResponse = Response(
        data: {
          'message': await ApiInterceptor.dioError(e)
        }, // 将自定义 Map 数据赋值给 Response 的 data 属性
        statusCode: 200,
        requestOptions: RequestOptions(),
      );
      return errResponse;
    }
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        // print("$count $total");
      });
      print('下载文件成功: ${response.data}');

      return response.data;
    } on DioException catch (e) {
      print('downloadFile 错误: $e');
      return Future.error(ApiInterceptor.dioError(e));
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  String headerUa({type = 'mob'}) {
    String headerUa = '';
    if (type == 'mob') {
      if (Platform.isIOS) {
        headerUa =
            'YangSuGuo/HeLe/1.0.0 (https://github.com/YangSuGuo/HeLe_app)';
      } else {
        headerUa =
            'YangSuGuo/HeLe/1.0.0 (https://github.com/YangSuGuo/HeLe_app)';
      }
    } else {
      headerUa = 'YangSuGuo/HeLe/1.0.0 (https://github.com/YangSuGuo/HeLe_app)';
    }
    return headerUa;
  }
}
