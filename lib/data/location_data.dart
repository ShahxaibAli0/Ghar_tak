class City {
  final String name;
  final List<String> areas;

  City({
    required this.name,
    required this.areas,
  });
}

List<City> cities = [

  // ✅ Pattoki
  City(
    name: "Pattoki",
    areas: [
      "Shadman City",
      "Kashif Choak",
      "Badar Colony",
      "Habib Town",
      "Gulshan-e-Subhan",
      "Nawab City",
      "Muhalla Malik Pura",
    ],
  ),

  // ✅ Lahore
  City(
    name: "Lahore",
    areas: [
      "Johar Town",
      "DHA",
      "Bahria Town",
      "Model Town",
      "Gulberg",
      "Wapda Town",
    ],
  ),

  // ✅ Karachi
  City(
    name: "Karachi",
    areas: [
      "Clifton",
      "Defence",
      "Gulshan-e-Iqbal",
      "North Nazimabad",
      "PECHS",
    ],
  ),

  // ✅ Islamabad
  City(
    name: "Islamabad",
    areas: [
      "F-10",
      "F-11",
      "G-11",
      "G-13",
      "Bahria Town",
    ],
  ),

  // ✅ Faisalabad
  City(
    name: "Faisalabad",
    areas: [
      "D Ground",
      "Peoples Colony",
      "Madina Town",
      "Satiana Road",
    ],
  ),

  // ✅ Multan
  City(
    name: "Multan",
    areas: [
      "Cantt",
      "Bosan Road",
      "Shah Rukn-e-Alam",
      "Gulgasht Colony",
    ],
  ),

  // ✅ Rawalpindi
  City(
    name: "Rawalpindi",
    areas: [
      "Saddar",
      "Chaklala",
      "Bahria Town",
      "Satellite Town",
    ],
  ),

  // ✅ Sialkot
  City(
    name: "Sialkot",
    areas: [
      "Cantt",
      "Model Town",
      "Kashmir Road",
      "Defence Road",
    ],
  ),
];