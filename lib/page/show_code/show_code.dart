import 'package:flutter/material.dart';
import '../../core/pluggable.dart';
import 'icon.dart' as icon;
import 'page_info_helper.dart';
import 'syntax_highlighter.dart';

class ShowCode extends StatefulWidget implements Pluggable {
  const ShowCode({super.key});

  @override
  ShowCodeState createState() => ShowCodeState();

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(icon.iconBytes);

  @override
  String get name => '代码查看';

  @override
  String get displayName => '代码查看';

  @override
  void onTrigger() {}

  @override
  int get index => 11;
}

class ShowCodeState extends State<ShowCode> with WidgetsBindingObserver {
  late PageInfoHelper pageInfoHelper;
  String? code;
  String? filePath;

  Map<String?, String>? _codeList;
  late bool showCodeList;
  late bool isSearching;
  TextEditingController? textEditingController;

  @override
  void initState() {
    pageInfoHelper = PageInfoHelper();
    filePath = pageInfoHelper.packagePathConvertFromFilePath(pageInfoHelper.filePath!);
    pageInfoHelper.getCode().then((c) {
      code = c;
      setState(() {});
    });
    showCodeList = false;
    isSearching = false;
    textEditingController = TextEditingController(text: filePath);
    super.initState();
  }

  Widget _codeView() {
    String codeContent = code ?? '';
    if (_codeList != null && _codeList!.isNotEmpty && codeContent.isEmpty) {
      codeContent = '已找到匹配项，请点击菜单选择';
    }
    double textScaleFactor = 1.0;
    final SyntaxHighlighterStyle style = Theme.of(context).brightness == Brightness.dark ? SyntaxHighlighterStyle.darkThemeStyle() : SyntaxHighlighterStyle.lightThemeStyle();
    return SizedBox(
      width: View.of(context).display.size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectableText.rich(
            // enableInteractiveSelection: false,
            TextSpan(
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
              ).apply(fontSizeFactor: textScaleFactor),
              children: <TextSpan>[
                DartSyntaxHighlighter(style).format(codeContent),
              ],
            ),
            style: DefaultTextStyle.of(context).style.apply(
                  fontSizeFactor: textScaleFactor,
                ),
          ),
        ),
      ),
    );
  }

  Widget _infoView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "当前路径（点击以编辑，支持部分匹配）：",
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "请输入路径",
                    border: const UnderlineInputBorder(),
                    prefixIcon: isSearching
                        ? const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              )
                            ],
                          )
                        : showCodeList && _codeList != null && _codeList!.isNotEmpty
                            ? PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String codepath) {
                                  debugPrint(codepath);
                                  setState(() {
                                    code = _codeList![codepath];
                                    filePath = codepath;
                                    textEditingController!.text = filePath!;
                                  });
                                },
                                itemBuilder: (BuildContext context) => _codeList!
                                    .map((codepath, codeid) {
                                      return MapEntry(
                                        codepath,
                                        PopupMenuItem<String>(
                                          value: codepath,
                                          child: ListTile(
                                            title: Text(
                                              codepath!,
                                              style: const TextStyle(
                                                color: Colors.teal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                    .values
                                    .toList(),
                              )
                            : const Icon(Icons.arrow_drop_down),
                    suffixIcon: IconButton(
                      onPressed: () => textEditingController!.clear(),
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  controller: textEditingController,
                  style: const TextStyle(color: Colors.teal, fontSize: 14, height: 1.5),
                  maxLines: 5,
                  minLines: 1,
                  // decoration: null,
                  autocorrect: false,
                  enableSuggestions: false,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    if (value.length < 2) {
                      return;
                    }
                    setState(() {
                      isSearching = true;
                      filePath = value;
                    });
                    pageInfoHelper.getCodeListByKeyword(value).then(
                      (codeList) {
                        if (codeList.isNotEmpty) {
                          showCodeList = true;
                          _codeList = codeList;
                        } else {
                          showCodeList = false;
                        }
                        isSearching = false;
                        code = null;
                        filePath = null;
                        setState(() {});
                        debugPrint(codeList.length.toString());
                      },
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("页面代码"),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              _infoView(),
              Expanded(
                child: _codeView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
