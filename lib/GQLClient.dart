import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink('https://rickandmortyapi.com/graphql');

  GraphQLClient myGQLClient() {
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}
