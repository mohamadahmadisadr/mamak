import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamak/data/serializer/subscribe/SubscribesResponse.dart';
import 'package:mamak/presentation/state/app_state.dart';
import 'package:mamak/presentation/ui/Home/HomeAppbar.dart';
import 'package:mamak/presentation/ui/main/ConditionalUI.dart';
import 'package:mamak/presentation/ui/main/CubitProvider.dart';
import 'package:mamak/presentation/ui/main/UiExtension.dart';
import 'package:mamak/presentation/viewModel/subscription/SubscriptionViewModel.dart';

class SubscriptionUI extends StatelessWidget {
  const SubscriptionUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => SubscriptionViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<List<SubscribeItem>>(
          state: state,
          onSuccess: (data) {
            return Scaffold(
              appBar: AppBar(
                flexibleSpace: const HomeAppBar(),
              ),
              body: Padding(
                padding: 8.dpe,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          width: 10,
                          height: 10,
                          margin: 2.dpeh,
                        ),
                        const Text('برای تغییر اشتراک کلیک کنید'),
                      ],
                    ),
                    const Divider(),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('مرحله یعد'),
                    ),
                    16.dpv,
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          width: 10,
                          height: 10,
                          margin: 2.dpeh,
                        ),
                        const Text('برای تغییر اشتراک کلیک کنید'),
                      ],
                    ),
                    4.dpv,
                    ListView.builder(
                      itemExtent: 150,
                      itemCount: data.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => PackageItemUi(
                        color: Colors.yellow,
                        item: data[index],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PackageItemUi extends StatelessWidget {
  const PackageItemUi({
    Key? key,
    required this.color,
    required this.item,
  }) : super(key: key);
  final SubscribeItem item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 8.dpe,
      margin: 8.dpe,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.title ?? '',
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: Colors.white)),
              const SizedBox.shrink()
            ],
          ),
          8.dpv,
          const Divider(color: Colors.white, height: 2),
          Text(item.price?.toString() ?? '',
              style:
                  context.textTheme.titleMedium?.copyWith(color: Colors.white))
        ],
      ),
    );
  }
}
