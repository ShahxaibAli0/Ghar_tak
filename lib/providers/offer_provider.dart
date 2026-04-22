import 'package:flutter/material.dart';
import '../models/offer_model.dart';
import '../data/dummy_offers_data.dart';

class OfferProvider extends ChangeNotifier {
  final List<Offer> _offers;

  OfferProvider() : _offers = List.from(dummyOffers);

  List<Offer> get offers => List.unmodifiable(_offers);

  bool get hasAcceptedOffer => _offers.any((o) => o.status == "accepted");

  void acceptOffer(int index) {
    _offers[index].status = "accepted";
    for (int i = 0; i < _offers.length; i++) {
      if (i != index && _offers[i].status == "pending") {
        _offers[i].status = "invalidated";
      }
    }
    notifyListeners();
  }

  void rejectOffer(int index) {
    if (_offers[index].status == "pending") {
      _offers[index].status = "rejected";
      notifyListeners();
    }
  }
}
