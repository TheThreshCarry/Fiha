import React from 'react';
import { GoogleAuthProvider, getAuth, signInWithPopup } from "firebase/auth";
import { useHistory } from 'react-router';


const handleGoogleLogin = (history) => {
    const auth = getAuth();
  const provider = new GoogleAuthProvider();

  
    signInWithPopup(auth, provider)
    .then((result) => {
      // This gives you a Google Access Token. You can use it to access the Google API.
      const credential = GoogleAuthProvider.credentialFromResult(result);
      const token = credential.accessToken;
      // The signed-in user info.
      const user = result.user;
      console.log("Logged In");
      console.log(user);
      history.push("/home");
      // ...
    }).catch((error) => {
      // Handle Errors here.
      const errorCode = error.code;
      const errorMessage = error.message;
      // The email of the user's account used.
      const email = error.email;
      // The AuthCredential type that was used.
      const credential = GoogleAuthProvider.credentialFromError(error);
      // ...
    });
  };

const LoginPage = () => {
    let history = useHistory();
    const auth = getAuth();
    let user = auth.currentUser;
    if(user){
      history.push('/home');
      return (<div></div>);
    }else{
    return (
        <div className="flex-container-home-page">
        <div className="google-button" onClick={() => {handleGoogleLogin(history)}}>Login With Google</div>
    </div>
    )}
}

export default LoginPage
