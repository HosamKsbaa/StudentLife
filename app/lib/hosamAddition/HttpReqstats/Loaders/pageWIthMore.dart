import 'package:flutter/material.dart';
import 'package:nu_ra_stu_jur/hosamAddition/HttpReqstats/Loaders/sorce.dart';
import '../httpStats.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

class ApiInfiniteList<ResponseObj> extends StatefulWidget {
  final Future<retrofit.HttpResponse<List<ResponseObj>>> Function(int pageNumber, int pageSize) requestFunction;
  final HDMHttpRequestsStates<List<ResponseObj>>? httpRequestsStates;
  final Widget Function(BuildContext context, List<ResponseObj> items) listViewBuilder;
  final int initialPageNumber;
  final int pageSize;

  const ApiInfiniteList({
    Key? key,
    required this.requestFunction,
    this.httpRequestsStates,
    required this.listViewBuilder,
    this.initialPageNumber = 1,
    this.pageSize = 20,
  }) : super(key: key);

  @override
  _ApiInfiniteListState<ResponseObj> createState() => _ApiInfiniteListState<ResponseObj>();
}

class _ApiInfiniteListState<ResponseObj> extends State<ApiInfiniteList<ResponseObj>> {
  late int pageNumber;
  late List<ResponseObj> items;
  late HDMHttpRequestsStates<List<ResponseObj>> httpRequestsStates;
  bool isFinished = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    pageNumber = widget.initialPageNumber;
    items = [];
    httpRequestsStates = widget.httpRequestsStates ?? HDMHttpRequestsStates<List<ResponseObj>>();
    httpRequestsStates.set = () {
      if (mounted) {
        setState(() {});
      }
    };
    _makeRequest();
  }

  Future<void> _makeRequest() async {
    if (isLoading) return;
    setState(() => isLoading = true);
    httpRequestsStates.setLoading();
    try {
      retrofit.HttpResponse<List<ResponseObj>> req = await widget.requestFunction(pageNumber, widget.pageSize);
      List<ResponseObj> response = req.data;
      if (response.isEmpty) {
        isFinished = true;
      } else {
        setState(() {
          items.addAll(response);
          pageNumber++;
        });
      }
      httpRequestsStates.setSuccess(items);
    } catch (e) {
      httpRequestsStates.setErr(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<bool> _loadMore() async {
    if (!isFinished) {
      await _makeRequest();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    switch (httpRequestsStates.states) {
      case HDMHttpRequestsStatesEnum.loading:
        return _buildLoading();
      case HDMHttpRequestsStatesEnum.fail:
        return _buildError();
      case HDMHttpRequestsStatesEnum.success:
        return _buildSuccess(context, items);
      case HDMHttpRequestsStatesEnum.successButEmpty:
        return _buildEmptySuccess();
      default:
        return _buildIdle();
    }
  }

  Widget _buildIdle() {
    return Center(child: Icon(Icons.error));
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    return Center(child: Icon(Icons.error));
  }

  Widget _buildEmptySuccess() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccess(BuildContext context, List<ResponseObj> data) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          _loadMore();
        }
        return false;
      },
      child: LoadMore(
        isFinish: isFinished,
        onLoadMore: _loadMore,
        child: widget.listViewBuilder(context, data),
      ),
    );
  }
}
