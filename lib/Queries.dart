const String fetchEpisodes = r'''
    query episodes($nPage: Int){
        episodes(page: $nPage){
          info{
            count
            pages
            next
          }
          results{
            name
            episode
            id
            characters {
              id
            }
          }
        }
      }
      ''';

const String fetchCharacters = r'''
      query characters($characterIds:[ID!]!){
        charactersByIds(ids:$characterIds) 
            {
              name
              status
              image
              species
              origin{
                name
              }
            }
        }
    ''';
