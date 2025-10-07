import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      width: 43,
                      height: 43,
                      color: Palette.primaryLime,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Palette.white,
                          size: 24,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text("Оплата", style: Styles.h4),
                  const SizedBox(width: 40),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                decoration: Decor.base,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Имя плательщика*",
                      style: Styles.b3,
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: SizedBox(
                        height: 43,
                        child: TextField(
                          style: Styles.b2,
                          onChanged: (query) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Palette.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Palette.stroke, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Palette.stroke, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Palette.primaryLime, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Palette.error, width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Palette.error, width: 1)),
                            hintText: "Иванов Иван Иванович",
                            hintStyle: Styles.b2,
                            contentPadding: const EdgeInsets.only(
                                left: 16, top: 13, bottom: 13),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email*",
                                style: Styles.b3,
                              ),
                              SizedBox(
                                height: 43,
                                child: TextField(
                                  style: Styles.b2,
                                  onChanged: (query) {},
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Palette.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.stroke, width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.stroke, width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.primaryLime,
                                            width: 1)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.error, width: 1)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.error, width: 1)),
                                    hintText: "Иванов Иван Иванович",
                                    hintStyle: Styles.b2,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 13, bottom: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Номер телефона*",
                                style: Styles.b3,
                              ),
                              SizedBox(
                                height: 43,
                                child: TextField(
                                  style: Styles.b2,
                                  onChanged: (query) {},
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Palette.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.stroke, width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.stroke, width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.primaryLime,
                                            width: 1)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.error, width: 1)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Palette.error, width: 1)),
                                    hintText: "Номер телефона*",
                                    hintStyle: Styles.b2,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 13, bottom: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Название коллектива*",
                      style: Styles.b3,
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: SizedBox(
                        height: 43,
                        child: TextField(
                          style: Styles.b2,
                          onChanged: (query) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Palette.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Palette.stroke, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Palette.stroke, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Palette.primaryLime, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Palette.error, width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Palette.error, width: 1)),
                            hintText: "Коллектив",
                            hintStyle: Styles.b2,
                            contentPadding: const EdgeInsets.only(
                                left: 16, top: 13, bottom: 13),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: Decor.base,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Карта лояльности",
                    style: Styles.b3,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 43,
                          child: TextField(
                            style: Styles.b2,
                            onChanged: (query) {},
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Palette.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.stroke, width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.stroke, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.primaryLime, width: 1)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.error, width: 1)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.error, width: 1)),
                              hintText: "Введите номер карты",
                              hintStyle: Styles.b2,
                              contentPadding: const EdgeInsets.only(
                                  left: 16, top: 13, bottom: 13),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          color: Palette.primaryLime,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Стоимость заказа",
                        style: Styles.b2,
                      ),
                      Text("10 000 руб", style: Styles.h4)
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Скидка",
                        style: Styles.b2.copyWith(color: Palette.secondary),
                      ),
                      Text(
                        "-0 руб",
                        style: Styles.h4.copyWith(color: Palette.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Итого",
                        style: Styles.h4,
                      ),
                      Text("10 000 руб", style: Styles.h3)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Container(
              decoration: Decor.base,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: LTButtons.elevatedButton(
                onPressed: () {},
                child: Text(
                  "Оплатить",
                  style: Styles.button1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
