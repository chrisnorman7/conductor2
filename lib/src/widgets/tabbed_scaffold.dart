import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The directions for the [SwitchPageIntent] class.
enum SwitchPageDirections {
  /// Go to the next page.
  forwards,

  /// Go to the previous page.
  backwards,
}

/// An intent to switch pages.
class SwitchPageIntent extends Intent {
  /// Create an instance.
  const SwitchPageIntent(this.direction);

  /// The direction to switch in.
  final SwitchPageDirections direction;
}

/// The intent to change pages in a [TabbedScaffold].
class GotoPageIntent extends Intent {
  /// Create an instance.
  const GotoPageIntent(this.page);

  /// The page number to go to.
  final int page;
}

const _pageNumbers = [
  LogicalKeyboardKey.digit1,
  LogicalKeyboardKey.digit2,
  LogicalKeyboardKey.digit3,
  LogicalKeyboardKey.digit4,
  LogicalKeyboardKey.digit5,
  LogicalKeyboardKey.digit6,
  LogicalKeyboardKey.digit7,
  LogicalKeyboardKey.digit8,
  LogicalKeyboardKey.digit9,
  LogicalKeyboardKey.digit0,
];

/// A top tab.
///
/// Instances of this class are used to create a [TabBar] and associated
/// [TabBarView].
class TopTab {
  /// Create an instance.
  const TopTab({
    required this.builder,
    this.text,
    this.icon,
    this.child,
  });

  /// The text to use for the resulting [Tab].
  final String? text;

  /// The icon to use for the resulting [Tab].
  final Widget? icon;

  /// The child of the resulting [Tab].
  final Widget? child;

  /// The builder to use in the resulting [TabBarView].
  final WidgetBuilder builder;
}

/// A tab for a [TabbedScaffold].
class TabbedScaffoldTab {
  /// Create an instance.
  const TabbedScaffoldTab({
    required this.title,
    required this.icon,
    this.builder,
    this.topTabs,
    this.actions,
    this.floatingActionButton,
  }) : assert(
          builder != null || topTabs != null,
          'One of `builder` or `topTabs` must not be `null`.',
        );

  /// The title of the scaffold.
  final String title;

  /// The icon to use for the [BottomNavigationBarItem] that shows this tab.
  final Widget icon;

  /// The child to use.
  final WidgetBuilder? builder;

  /// A list of top tabs to use.
  final List<TopTab>? topTabs;

  /// The actions to use for the app bar.
  final List<Widget>? actions;

  /// The floating action button to use.
  final FloatingActionButton? floatingActionButton;
}

/// A scaffold with multiple tabs.
class TabbedScaffold extends StatefulWidget {
  /// Create an instance.
  const TabbedScaffold({
    required this.tabs,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The tabs to use.
  final List<TabbedScaffoldTab> tabs;

  /// Create state for this widget.
  @override
  TabbedScaffoldState createState() => TabbedScaffoldState();
}

/// State for [TabbedScaffold].
class TabbedScaffoldState extends State<TabbedScaffold> {
  late int _index;

  /// Set the initial index.
  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final gotoPageAction = CallbackAction<GotoPageIntent>(
      onInvoke: (final intent) {
        final page = intent.page;
        if (page < widget.tabs.length) {
          setState(() {
            _index = page;
          });
        }
        return null;
      },
    );
    final switchPageAction = CallbackAction<SwitchPageIntent>(
      onInvoke: (final intent) {
        final direction = intent.direction;
        var index = _index;
        switch (direction) {
          case SwitchPageDirections.forwards:
            index += 1;
            if (index >= widget.tabs.length) {
              index = 0;
            }
            break;
          case SwitchPageDirections.backwards:
            index -= 1;
            if (index < 0) {
              index = widget.tabs.length - 1;
            }
            break;
        }
        setState(() => _index = index);
        return null;
      },
    );
    final tab = widget.tabs[_index];
    final builder = tab.builder;
    final topTabs = tab.topTabs;
    final scaffold = Scaffold(
      appBar: AppBar(
        actions: tab.actions,
        bottom: topTabs == null
            ? null
            : TabBar(
                tabs: topTabs
                    .map<Tab>(
                      (final e) => Tab(
                        icon: e.icon,
                        text: e.text,
                        child: e.child,
                      ),
                    )
                    .toList(),
              ),
        title: Text(tab.title),
      ),
      body: topTabs == null
          ? Builder(builder: builder!)
          : TabBarView(
              children: topTabs
                  .map<Widget>(
                    (final e) => Builder(
                      builder: e.builder,
                    ),
                  )
                  .toList(),
            ),
      floatingActionButton: tab.floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(
        items: widget.tabs
            .map(
              (final e) => BottomNavigationBarItem(
                icon: e.icon,
                label: e.title,
              ),
            )
            .toList(),
        currentIndex: _index,
        onTap: (final index) => setState(() => _index = index),
      ),
    );
    return Shortcuts(
      shortcuts: {
        for (var i = 0; i < _pageNumbers.length; i++)
          SingleActivator(_pageNumbers[i], control: true): GotoPageIntent(i),
        SingleActivator(
          LogicalKeyboardKey.tab,
          control: Platform.isMacOS == false,
          meta: Platform.isMacOS == true,
        ): const SwitchPageIntent(SwitchPageDirections.forwards),
        const SingleActivator(
          LogicalKeyboardKey.tab,
          control: true,
          shift: true,
        ): const SwitchPageIntent(SwitchPageDirections.backwards)
      },
      child: Actions(
        actions: {
          GotoPageIntent: gotoPageAction,
          SwitchPageIntent: switchPageAction
        },
        child: topTabs == null
            ? scaffold
            : DefaultTabController(
                length: topTabs.length,
                child: scaffold,
              ),
      ),
    );
  }
}
