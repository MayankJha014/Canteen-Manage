import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/common/widgets/custom_button.dart';
import 'package:zomato_clone/constants/global_variables.dart';
import 'package:zomato_clone/features/admin/services/admin_services.dart';
import 'package:zomato_clone/features/search/screens/search_screen.dart';
import 'package:zomato_clone/models/order.dart';
import 'package:zomato_clone/providers/user_provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  // !!! ONLY FOR ADMIN!!!
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: currentStep,
      order: widget.order,
      onSuccess: () {
        if (currentStep < steps().length - 1) {
          setState(() {
            currentStep += 1;
          });
        } else {
          setState(() {
            currentStep = currentStep;
          });
        }
      },
    );
  }

  // ignore: prefer_final_fields
  steps() => [
        Step(
          isActive: true,
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: Text('Pending'),
          content: Text(
            'Your order is yet to be delivered',
          ),
        ),
        Step(
          title: Text('Preparing'),
          content: Text(
            'Your order has been preparing.',
          ),
          isActive: true,
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Received'),
          content: Text(
            'Your order has been delivered and signed by you.',
          ),
          isActive: true,
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Done'),
          content: Text(
            'Your order has been delivered and signed by you.',
          ),
          isActive: true,
          state: StepState.complete,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 27, 27, 27),
            ),
          ),
          leading: BackButton(color: Colors.white),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(96, 0, 0, 0),
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Your Meal',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.transparent,
              //   height: 42,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   child: const Icon(Icons.mic, color: Colors.black, size: 25),
              // ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date:      ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.order.orderedAt),
                    )}'),
                    Text('Order id:          ${widget.order.userId}'),
                    Text('Order Total:      \₹${widget.order.totalPrice}'),
                    Text('Order Name:      ${widget.order.userName}'),
                    Text(
                      'Order Address:      ${widget.order.address}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: size.height * 0.18,
                            width: size.width * 0.36,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Qty: ${widget.order.quantity[i]}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                    currentStep: currentStep,
                    controlsBuilder: (context, details) {
                      if (user.type == 'admin') {
                        return CustomButtom(
                          text: 'Done',
                          onTap: () => changeOrderStatus(details.currentStep),
                        );
                      }
                      return const SizedBox();
                    },
                    steps: steps()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
