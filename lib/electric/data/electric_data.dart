class ElectricShop {
  final String name;
  final List<String> services;

  ElectricShop({
    required this.name,
    required this.services,
  });
}

List<ElectricShop> electricShops = [
  ElectricShop(
    name: "Power House Electric",
    services: [
      "Fan Installation",
      "Switch Repair",
      "Wiring Setup",
      "AC Wiring",
      "MCB Installation",
      "Light Fitting",
    ],
  ),
  ElectricShop(
    name: "Bright Light Store",
    services: [
      "Tube Light Repair",
      "Ceiling Fan Fix",
      "New Wiring",
      "UPS Wiring",
      "Breaker Setup",
    ],
  ),
  ElectricShop(
    name: "Voltage Center",
    services: [
      "Complete House Wiring",
      "Inverter Setup",
      "LED Installation",
      "Switch Board Change",
      "Short Circuit Repair",
    ],
  ),
];