# Fiha

## Documentation

### Event Date Model 
### {
 - **Geolocation** : { long, lat } ( there is a geopoint data type in firestore directly }
 - **Geohash** : String ( encoding of geolocation, makes geoqueries easier )
 - **Title** : String ( title of the event duh )
 - **Desc** : String ( description of the event )
 - **imgs** : String[] ( List of images urls linked to the event )
 - **places** : int ( available places for the event )
 - **remainingPlaces** : int ( well... )
 - **Type** : int ( this is gonna be an int we map to a certian enum we will define, like { 0 : "Sports", 1 : "Culture"...} )
 - **organizer** : docRef ( reference to the document of the organizer )
 - **price** : Number ( well the price of a place or reservation )
 - **submitAction** : int ( in the app, we will have multiple choice of actions for an event which the organizer will decide, same mapping system as the Type {0 : "Call", 1 : "Email"...}
 - **startDate** : TimeStamp ( start of the event )
 - **endDate** : TimeStamp ( end of the event )
 ### }
