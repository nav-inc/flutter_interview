class PokemonListResponse {
  int? count;
  String? next;
  String? previous;
  List<PokemonInfo>? results;

  PokemonListResponse({this.count, this.next, this.previous, this.results});

  PokemonListResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <PokemonInfo>[];
      json['results'].forEach((v) {
        results!.add(PokemonInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PokemonInfo {
  String? name;
  String? url;

  PokemonInfo({this.name, this.url});

  PokemonInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
