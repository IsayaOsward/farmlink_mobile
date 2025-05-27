import '../defaults/default_page_model.dart';
import '../defaults/default_response_model.dart';

class GetAllFaqsResponse {
  final DefaultResponseModel response;
  final PageObject page;
  final List<FaqData> data;

  GetAllFaqsResponse({
    required this.response,
    required this.page,
    required this.data,
  });

  factory GetAllFaqsResponse.fromJson(Map<String, dynamic> json) {
    return GetAllFaqsResponse(
      response: DefaultResponseModel.fromJson(json['response']),
      page: PageObject.fromJson(json['page']),
      data: (json['data'] as List<dynamic>)
          .map((e) => FaqData.fromJson(e))
          .toList(),
    );
  }

  factory GetAllFaqsResponse.error() {
    return GetAllFaqsResponse(
      response: DefaultResponseModel(
        id: '0',
        status: false,
        code: 4000,
        message: 'No data',
      ),
      page: PageObject.error(),
      data: [],
    );
  }

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
        'page': page.toJson(),
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class FaqData {
  final String id;
  final String uniqueId;
  final String question;
  final String answer;
  final String createdAt;

  FaqData({
    required this.id,
    required this.uniqueId,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  factory FaqData.fromJson(Map<String, dynamic> json) {
    return FaqData(
      id: json['id'],
      uniqueId: json['uniqueId'],
      question: json['question'],
      answer: json['answer'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uniqueId': uniqueId,
        'question': question,
        'answer': answer,
        'createdAt': createdAt,
      };
}
