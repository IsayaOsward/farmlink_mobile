class PageObject {
  final int number;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int nextPageNumber;
  final int previousPageNumber;

  PageObject({
    required this.number,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.nextPageNumber,
    required this.previousPageNumber,
  });

  factory PageObject.fromJson(Map<String, dynamic> json) {
    return PageObject(
      number: json['number'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
      nextPageNumber: json['nextPageNumber'],
      previousPageNumber: json['previousPageNumber'],
    );
  }

  factory PageObject.error() {
    return PageObject(
      number: 0,
      hasNextPage: false,
      hasPreviousPage: false,
      nextPageNumber: 0,
      previousPageNumber: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
      'nextPageNumber': nextPageNumber,
      'previousPageNumber': previousPageNumber,
    };
  }
}
