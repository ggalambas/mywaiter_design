import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mywaiter_design/config/constants.dart';
import 'package:mywaiter_design/config/theme/palette.dart';
import 'package:mywaiter_design/widgets/flexible_space_title.dart';

enum View { grid, list }

extension ViewX on View {
  IconData get swapIcon {
    switch (this) {
      case View.grid:
        return LucideIcons.layoutList;
      case View.list:
        return LucideIcons.layoutGrid;
    }
  }

  View swap() {
    switch (this) {
      case View.grid:
        return View.list;
      case View.list:
        return View.grid;
    }
  }
}

class RestaurantPage extends StatefulWidget {
  static String route = '/restaurant';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  var view = View.grid;

  final opened = true;
  final categories = [
    'All',
    'Food',
    'Beer',
    'Drinks',
    'Dessert',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: DefaultTabController(
        length: categories.length,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: kToolbarHeight + 12 + 30 + 8,
              flexibleSpace: FlexibleSpaceTitle('Bolina'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(LucideIcons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(LucideIcons.clipboardList),
                ),
                IconButton(
                  onPressed: () => setState(() => view = view.swap()),
                  icon: Icon(view.swapIcon),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {}, //! navigate to info
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kScreenPadding,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('R. Vale Formoso 9'),
                          Text.rich(
                            TextSpan(
                              children: [
                                opened
                                    ? TextSpan(
                                        text: 'Opened',
                                        style: TextStyle(color: Palette.green),
                                      )
                                    : TextSpan(
                                        text: 'Closed',
                                        style: TextStyle(color: Palette.red),
                                      ),
                                TextSpan(text: ' ∙ Closes at 23pm'),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tap for more information',
                            style:
                                TextStyle(color: theme.colorScheme.onSurface),
                          ),
                        ],
                      ),
                      Icon(LucideIcons.chevronRight, size: kSmallIconSize),
                    ],
                  ),
                ),
              ),
            ),
            SliverStickyHeader(
              header: TabBar(
                isScrollable: true,
                indicatorColor: theme.primaryColor,
                tabs: [...categories.map((category) => Tab(text: category))],
              ),
              sliver: SliverToBoxAdapter(
                  // child: TabBarView(
                  //   //* filter items by category
                  //   children: [
                  //     ...categories.map(
                  //       (_) => Wrap(
                  //         spacing: 8,
                  //         children: [
                  //           for (var i = 0; i < 5; i++) ...[
                  //             ProductItem(view: view),
                  //             SizedBox(height: 16)
                  //           ]
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
