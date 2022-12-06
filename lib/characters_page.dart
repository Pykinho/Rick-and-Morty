import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
//import 'package:flutter_development_assignment/GQLClient.dart';
import 'package:flutter_development_assignment/queries.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage(
      {super.key, required this.episode, required this.characters});

  final episode;
  final characters;
  // @override
  // State<CharactersPage> createState() => _CharactersPageState();
//}

//class _CharactersPageState extends State<CharactersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters in $episode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '$characters',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
