import { GoogleAuthProvider, getAuth, signInWithPopup } from "firebase/auth";
import { initializeApp } from 'firebase/app';
import {getFirestore} from "firebase/firestore"

const firebaseConfig = {
  apiKey: "AIzaSyCPfiNsVIKlXIGQNzd4lcXlknVUF2MT4XE",
  authDomain: "hwayji-f20ad.firebaseapp.com",
  projectId: "hwayji-f20ad",
  storageBucket: "hwayji-f20ad.appspot.com",
  messagingSenderId: "734027596794",
  appId: "1:734027596794:web:74fc94b48b55f319169a43",
  measurementId: "G-PVVWGY117L"
};
  
  
  const app = initializeApp(firebaseConfig);
  const auth = getAuth();
  const db = getFirestore();


  export {app, auth, db};
  