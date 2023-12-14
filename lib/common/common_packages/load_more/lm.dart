

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class LM extends StatefulWidget {

  /// Callback function on pull up to load more data | 上拉以加载更多数据的回调函数
  final Future<void> Function() onLoadMore;

  final Future<void> Function()? onRefresh;


  /// Whether it is the last page, if it is true, you can not load more | 是否为最后一页，如果为true，则无法加载更多
  final bool isLastPage;

  /// Child widget | 子组件
  final Widget child;

  /// Prompt text widget when there is no more data at the bottom | 底部没有更多数据时的提示文字组件
  final Widget? noMoreWidget;

  bool wantLoadMore=false;

  ScrollPhysics? physics=const AlwaysScrollableScrollPhysics();


  LM({
    Key? key,
    required this.child,
    required this.isLastPage,
    required this.onLoadMore,
    this.wantLoadMore=true,
    this.onRefresh,
    this.noMoreWidget,
    this.physics
  }) : super(key: key);

  @override
  LMState createState() => LMState();
}

class LMState extends State<LM> {
  ScrollController scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (_isLoading) {
          return;
        }

        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }

        if (!widget.isLastPage) {
          await widget.onLoadMore();
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      child: Column(
        children: [
          widget.child,
          if(widget.wantLoadMore)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.px,right: 16.px,bottom: 40.px,top: 16.px),
                  child: _isLoading
                      ? const CupertinoActivityIndicator()
                      : widget.isLastPage
                      ? widget.noMoreWidget ??
                      Text(
                        'No more data',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme
                              .of(context)
                              .disabledColor,
                        ),
                      )
                      : Container(),
                )
              ],
            )
        ],
      ),
    );


    /*if (widget.onRefresh == null) {
      return Scrollbar(child: mainWidget);
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        if (_isLoading) return;
        await widget.onRefresh!();
      },
      child: mainWidget,
    );*/

    return mainWidget;
  }
}

// ignore: must_be_immutable
class LMC extends StatefulWidget {

  /// Callback function on pull up to load more data | 上拉以加载更多数据的回调函数
  final Future<void> Function() onLoadMore;

  final Future<void> Function()? onRefresh;

  final void Function(bool)? onValueUpdate;


  /// Whether it is the last page, if it is true, you can not load more | 是否为最后一页，如果为true，则无法加载更多
  final bool isLastPage;

  /// Child widget | 子组件
  final Widget child;

   ScrollController? scrollControllerMain=ScrollController();

  /// Prompt text widget when there is no more data at the bottom | 底部没有更多数据时的提示文字组件
  final Widget? noMoreWidget;

  bool wantLoadMore=false;

  bool wantValueUpdate=false;

  ScrollPhysics? physics=const AlwaysScrollableScrollPhysics();


  LMC({
    Key? key,
    required this.child,
        this.wantValueUpdate=false,
    required this.isLastPage,
    required this.onLoadMore,
    this.wantLoadMore=true,
        this.onRefresh,
        this.onValueUpdate,
        this.scrollControllerMain ,
    this.noMoreWidget,
        this.physics
  }) : super(key: key);

  @override
  LMCState createState() => LMCState();
}

class LMCState extends State<LMC> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.scrollControllerMain?.addListener(() async {
      double showOffset=800.0;

      if(widget.wantValueUpdate)
        {
          if(widget.scrollControllerMain!.offset>showOffset)
          {
            widget.onValueUpdate?.call(true);
          }
          else
          {
            widget.onValueUpdate?.call(false);
          }
        }


      if (widget.scrollControllerMain!.position.pixels >=
          widget.scrollControllerMain!.position.maxScrollExtent) {
        if (_isLoading) {
          return;
        }

        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }

        if (!widget.isLastPage) {
          await widget.onLoadMore();
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
    controller: widget.scrollControllerMain,
      child: Column(
        children: [
          widget.child,
          if(widget.wantLoadMore)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.px,right: 16.px,bottom: 40.px,top: 16.px),
                child: _isLoading
                    ? const CupertinoActivityIndicator()
                    : widget.isLastPage
                    ? widget.noMoreWidget ??
                    Text(
                      'No more data',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme
                            .of(context)
                            .disabledColor,
                      ),
                    )
                    : Container(),
              )
            ],
          )
        ],
      ),
    );


    /*if (widget.onRefresh == null) {
      return Scrollbar(child: mainWidget);
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        if (_isLoading) return;
        await widget.onRefresh!();
      },
      child: mainWidget,
    );*/

    return mainWidget;
  }
}