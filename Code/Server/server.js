import {getFirestore, addDoc, collection, GeoPoint, Timestamp} from 'firebase/firestore' ;
import * as firebase from 'firebase/app' ;
// Required for side-effects


import fs from "fs";
import Geohash from 'latlon-geohash';

// Initialize Cloud Firestore through Firebase
const app = firebase.initializeApp({
    apiKey: "AIzaSyA5Zg0VnDMhYPbJ9tk43TRYTVgZ-DCV11U",
    authDomain: "fiha-1876b.firebaseapp.com",
    projectId: "fiha-1876b"
  });
  
var db = getFirestore(app);

var menu = JSON.parse(fs.readFileSync('data.json'));
var events = collection(db, "events");
menu.forEach(function(event){
    addDoc(events, {
        name: event.name,
        description: event.description,
        price: event.price,
        type: event.type,
        position: {
            "geohash" : Geohash.encode(event.position.lat, event.position.long),
            "geopoint" : new GeoPoint(event.position.lat, event.position.long),
        },
        phoneNumber : event.phoneNumber,
        startDate : new Timestamp(Date.parse(event.startDate)/1000),
        endDate : new Timestamp(Date.parse(event.endDate)/1000),
        imgs : event.imgs,
        remainingPlaces : event.remainingPlaces,
        submitedAction : event.submitedAction,
        totalPlaces : event.totalPlaces,

    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
})
    /*
    await firestore.addDoc(firestore.collection('events'),{
        name: event.name,
        description: event.description,
        price: event.price,
        type: event.type,
        position: {
            "geohash" : geohash.encode(event.position.lat, event.position.long),
            "geopoint" : new firestore.geopoint(event.position.lat, event.position.long),
        },
        phoneNumber : event.phoneNumber,
        startDate : EventTarget.startDate,
    }).then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });*/
