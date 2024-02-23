# dev_kit


Flutter 应用内调试工具平台


[![pub package](https://img.shields.io/pub/v/dev_kit.svg)](https://pub.dev/packages/dev_kit)
[![pub package](https://img.shields.io/pub/likes/dev_kit.svg)](https://pub.dev/packages/dev_kit)
[![pub package](https://img.shields.io/pub/points/dev_kit.svg)](https://pub.dev/packages/dev_kit)
[![pub package](https://img.shields.io/pub/popularity/dev_kit.svg)](https://pub.dev/packages/dev_kit)
[![pub package](https://img.shields.io/pub/publisher/dev_kit.svg)](https://pub.dev/packages/dev_kit)


- [dev\_kit](#dev_kit)
  - [快速接入](#快速接入)
  - [开发自定义插件](#开发自定义插件)
  - [与原生通信](#与原生通信)
  - [开源协议](#开源协议)
  - [联系开发者](#联系开发者)

## 快速接入

1. 修改 `pubspec.yaml`，添加
    ``` yaml
    dev_dependencies:
      dev_kit: <version>
    ```
2. 执行 `flutter pub get`
3. 引入包

    ``` dart
    import 'package:dev_kit/dev_kit.dart'; 
    ```

4. 修改程序入口，增加初始化方法及注册插件代码

    ``` dart
    void main() async {
        WidgetsFlutterBinding.ensureInitialized();
        await logInit();
        runApp(MyApp());
    }

    Future logInit() async {
        await KitAppLog.init();
    }
    ...
    DevKit(
      enable: true,
      pluginsList: [],
      child: MaterialApp()
    )
    ```

5. `flutter run` 运行代码
   或 `flutter build apk --debug`、`flutter build ios --debug` 构建




## 开发自定义插件


1. 创建插件配置，实现 `Pluggable` 虚类

    ``` dart
    import 'package:dev_kit/core/pluggable.dart';

    class CustomPlugin implements Pluggable {
      CustomPlugin({Key key});

      @override
      Widget buildWidget(BuildContext context) => Container(
        color: Colors.white
        width: 100,
        height: 100,
        child: Center(
          child: Text('Custom Plugin')
        ),
      ); // 返回插件面板

      @override
      String get name => 'CustomPlugin'; // 插件名称

      @override
      String get displayName => 'CustomPlugin';

      @override
      void onTrigger() {} // 点击插件面板图标时调用

      @override
      int get index => 9999; // 默认排序index越大越前

      @override
      ImageProvider<Object> get iconImageProvider => NetworkImage('url'); // 插件图标
    }
    ```


2. 在工程中注册插件

    ``` dart
    DevKit(
      enable: true,
      pluginsList: [
        CustomPluggable(),
      ],
      child: MaterialApp(
        ...
      )
    )
    ```

3. 重新运行代码

## 与原生通信


  kotlin 版本：
  ``` kotlin
    import io.flutter.embedding.engine.FlutterEngine
    import io.flutter.plugin.common.MethodChannel

    class MainActivity: FlutterActivity(){
        private val Method_Channel = "example/methodChannel"
        private var currentMethodChannel: MethodChannel? = null

        override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
            super.configureFlutterEngine(flutterEngine)

            currentMethodChannel = MethodChannel(flutterEngine.dartExecutor, Method_Channel)
            currentMethodChannel?.setMethodCallHandler { call, result ->
                run {
                  if(call.method.equals("test")){
                    result.success(BuildConfig.DEBUG.toString() + " " +"yes")
                  }
                  result.success("yes")
                }
            }
        }
    }
  ```

  ios swift 版本：
  ``` swift
    public class MethodChannel {
    init(messenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(name: "example/methodChannel", binaryMessenger: messenger)
        channel.setMethodCallHandler { (call:FlutterMethodCall, result:@escaping FlutterResult) in
            // if (call.method == "test") {
            //     if let dict = call.arguments as? Dictionary<String, Any> {
            //         let name:String = dict["name"] as? String ?? ""
            //         let age:Int = dict["age"] as? Int ?? -1
            //         result(["name":"hello,\(name)","age":age])
            //     }
            // }
            result("yes")
        }
      }
    }

  ```

  Flutter代码：
  ``` dart
    String methodChannel = "nian_an/methodChannel";
    Future<void> testMethodCall() async {
      //1.创建Flutter端的MethodChannel
      MethodChannel method = MethodChannel(
        methodChannel,
        const StandardMethodCodec(),
        DevKitBinaryMessenger.binaryMessenger,
      );
      //2.通过invokeMethod调用Native方法，拿到返回值
      String debugString = await method.invokeMethod(
          "give",
          Platform.isAndroid
              ? "give me debug info"
              : "ios give me debug info");
      print('test debugString=$debugString');
    }
  ```

## 开源协议

该项目遵循 MIT 协议，详情请见 [LICENSE](./LICENSE)。

## 联系开发者

[联系开发者](mailto:nephkis@163.com)