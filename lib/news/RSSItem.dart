// ignore_for_file: file_names

abstract class RSSItem {
  String? title;
  String? date;
  String? description;
  String? url;
  String? imageUrl;
  Map<String, dynamic> toJson() {
    return {
      "title" : title,
      "date" : date,
      "description" : description,
      "url" : url,
      "imageUrl" : imageUrl
    };
  }
  RSSItem getRSSFromJson(Map<String, dynamic> json) {
    title = json["title"];
    date = json["date"];
    description = _getDescription(json["description"]);
    url = json["url"];
    imageUrl = _getImageUrl(json["description"]);
    return this;
  }
  // ignore: unused_element
  String _getDescription(String rawDescription);
  // ignore: unused_element
  String? _getImageUrl(String rawImage);
}

class VNExpressRSSItem extends RSSItem {
  @override
  String _getDescription(String rawDescription){
    int start = rawDescription.indexOf('<a><br/>')+9;
    if(start > 9) {
      return rawDescription.substring(start);
    }
    return "";
  }

  @override
  // ignore: avoid_renaming_method_parameters
  String? _getImageUrl(String rawDescription){
    int start = rawDescription.indexOf('img src="')+9;
    if(start > 9) {
      int end = rawDescription.indexOf('"',start);
      return rawDescription.substring(start, end);  
    }
    return null;
  }
}