import 'dart:async';
import 'package:flutter/material.dart';
import 'pagination.dart';

/// A robust image/widget carousel with optional auto-play and pagination.
class Ux4gCarousel extends StatefulWidget {
  final List<Widget> items;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final bool showPagination;
  final double height;
  final double viewportFraction;

  const Ux4gCarousel({
    super.key,
    required this.items,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.showPagination = true,
    this.height = 200.0,
    this.viewportFraction = 1.0,
  });

  @override
  State<Ux4gCarousel> createState() => _Ux4gCarouselState();
}

class _Ux4gCarouselState extends State<Ux4gCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: widget.viewportFraction,
    );
    _startTimer();
  }

  @override
  void didUpdateWidget(Ux4gCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.autoPlayInterval != widget.autoPlayInterval) {
      _stopTimer();
      _startTimer();
    }
  }

  void _startTimer() {
    if (!widget.autoPlay || widget.items.isEmpty) return;
    _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (_pageController.hasClients) {
        final nextIndex = (_currentIndex + 1) % widget.items.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleManualPageChange(int index) {
    _stopTimer();
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ).then((_) => _startTimer());
  }

  @override
  void dispose() {
    _stopTimer();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return SizedBox(height: widget.height);
    }

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: widget.items,
          ),
          if (widget.showPagination)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Ux4gPaginationIndicator(
                  totalPageCount: widget.items.length,
                  currentPageIndex: _currentIndex,
                  onPageChange: _handleManualPageChange,
                  variant: Ux4gPaginationVariant.defaultVariant,
                  size: Ux4gPaginationSize.small,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
