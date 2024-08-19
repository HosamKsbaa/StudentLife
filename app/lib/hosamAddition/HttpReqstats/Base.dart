import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'httpStats.dart';
import 'package:retrofit/retrofit.dart'as retrofit ;

/// A StatefulWidget that handles API requests and displays different states (idle, loading, success, error, empty success).
class ApiBase<ResponseObj> extends StatefulWidget {
  /// Function to make the API request.
  final Future<retrofit.HttpResponse<ResponseObj>> Function() requestFunction;

  /// State management for HTTP requests.
  final HDMHttpRequestsStates<ResponseObj> httpRequestsStates;

  /// Widget builder for idle state.
  final Widget Function(BuildContext context) buildIdle;

  /// Widget builder for loading state.
  final Widget Function(BuildContext context) buildLoading;

  /// Widget builder for success state.
  final Widget Function(BuildContext context, ResponseObj response)
      buildSuccess;

  /// Widget builder for error state.
  final Widget Function(BuildContext context) buildError;

  /// Widget builder for empty success state.
  final Widget Function(BuildContext context) buildEmptySuccess;

  /// Creates an instance of ApiSinglePage.
  const ApiBase({
    Key? key,
    required this.requestFunction,
    required this.httpRequestsStates,
    required this.buildIdle,
    required this.buildLoading,
    required this.buildSuccess,
    required this.buildError,
    required this.buildEmptySuccess,
  }) : super(key: key);

  @override
  State<ApiBase> createState() => _ApiBaseState<ResponseObj>();
}

class _ApiBaseState<ResponseObj> extends State<ApiBase<ResponseObj>> {
  late Future<ResponseObj> _future;

  @override
  void initState() {
    super.initState();
    _makeRequest();
  }
void _makeRequest() {
  Future<retrofit.HttpResponse<ResponseObj>> a= widget.requestFunction();

  _future = a.then((value) => value.data);
  widget.httpRequestsStates.setLoading();
  _future.then((response) {
    if (mounted) {
      setState(() {
        widget.httpRequestsStates.setSuccess(response);
      });
    }
  }).catchError((error) {
    if (mounted) {
      setState(() {
        widget.httpRequestsStates.setErr(error.toString());
      });
    }
  });
}

  void _retryRequest() {
    _makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    widget.httpRequestsStates.context = context;

    return FutureBuilder<ResponseObj>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.buildLoading(context);
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.buildError(context),
              ElevatedButton(
                onPressed: _retryRequest,
                child: Text('Retry'),
              ),
            ],
          );
        } else if (snapshot.hasData) {
          if (widget.httpRequestsStates.states ==
              HDMHttpRequestsStatesEnum.successButEmpty) {
            return widget.buildEmptySuccess(context);
          } else {
            return widget.buildSuccess(context, snapshot.data!);
          }
        } else {
          return widget.buildIdle(context);
        }
      },
    );
  }
}
