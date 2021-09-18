import { GoogleAuthProvider, getAuth, signInWithPopup } from "firebase/auth";
import { initializeApp } from 'firebase/app';

const firebaseConfig = {
    apiKey: "AIzaSyA5Zg0VnDMhYPbJ9tk43TRYTVgZ-DCV11U",
    authDomain: "fiha-1876b.firebaseapp.com",
    projectId: "fiha-1876b",
    storageBucket: "fiha-1876b.appspot.com",
    messagingSenderId: "277175449891",
    appId: "1:277175449891:web:ad9ae4b9758299d1fbb496",
    measurementId: "G-RPHMETV8YR"
  };
  
  
  const app = initializeApp(firebaseConfig);
  const auth = getAuth();


  export {app, auth};
  