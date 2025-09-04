import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _Loader {
  _Loader._();

  static final _Loader _instance = _Loader._();

  static _Loader get instance => _instance;

  DialogRoute? _textLoader;
  DialogRoute? _loader;

  void showTextLoader({required BuildContext context, required String title}) {
    _textLoader = DialogRoute(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.transparent,
          child: PopScope(
            canPop: false,
            child: Container(
              color: context.colorScheme.surface,
              width: context.width * 0.15,
              child: Padding(
                padding: EdgeInsets.all(context.height * 0.04),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: context.height * 0.07,
                      width: context.height * 0.07,
                      child: CircularProgressIndicator(
                        color: context.colorScheme.primary,
                        backgroundColor: context.colorScheme.primary.withValues(
                          alpha: 0.4,
                        ),
                        strokeCap: StrokeCap.round,
                        strokeWidth: 4,
                      ),
                    ),
                    0.0215.verticalSpace,
                    Text(
                      title,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    context.navigator.push(_textLoader!);
  }

  void closeTextLoader(BuildContext context) {
    if (_textLoader?.isActive ?? false) {
      context.navigator.removeRoute(_textLoader!);
    }
  }

  void showLoader(BuildContext context) {
    _loader =
        _loader = DialogRoute(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black26,
          builder: (context) {
            return PopScope(
              canPop: false,
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: const CircularProgressIndicator(),
                // child: Assets.animations.dotsLoader.lottie(
                //   height: context.height * 0.18,
                // ),
              ),
            );
          },
        );
    if (!(_loader?.isCurrent ?? false)) {
      context.navigator.push(_loader!);
    }
  }

  void closeLoader(BuildContext context) {
    // context.navigator.pop();
    if (_loader?.isActive ?? false) {
      context.navigator.removeRoute(_loader!);
    }
  }
}

class LoaderHelper {
  LoaderHelper._();

  static final LoaderHelper _instance = LoaderHelper._();

  static LoaderHelper get instance => _instance;
  final _Loader _loader = _Loader.instance;

  void handleTextLoader({
    required BuildContext context,
    String? title,
    required bool show,
  }) {
    if (show) {
      _loader.showTextLoader(context: context, title: title ?? "");
    } else {
      _loader.closeTextLoader(context);
    }
  }

  void handleLoader({required BuildContext context, required bool show}) {
    if (show) {
      _loader.showLoader(context);
    } else {
      _loader.closeLoader(context);
    }
  }
}
