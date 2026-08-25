enum OnboardingVisualType { charging, stations, features }

class OnboardingData {
  const OnboardingData({
    required this.title,
    required this.description,
    required this.visualType,
  });

  final String title;
  final String description;
  final OnboardingVisualType visualType;
}

const onboardingPages = <OnboardingData>[
  OnboardingData(
    title: 'Find nearby charging,\npower up with ease',
    description: 'Locate available EV chargers, compare speeds, and start charging in seconds.',
    visualType: OnboardingVisualType.charging,
  ),
  OnboardingData(
    title: 'Choose trusted stations\nand plan every stop',
    description: 'See live port availability, station ratings, and everything you need before arriving.',
    visualType: OnboardingVisualType.stations,
  ),
  OnboardingData(
    title: 'Everything you need\nfor every journey',
    description: 'Filter by connector and speed, save favorite stations, and plan routes with confidence.',
    visualType: OnboardingVisualType.features,
  ),
];
