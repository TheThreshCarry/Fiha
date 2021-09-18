import React from 'react'
import { useHistory } from 'react-router';
import { useState } from 'react';
import { auth } from '../handelers/firebase';
import {Avatar} from '@material-ui/core';



const logOut = (history) => {
    auth.signOut().then(() => {history.push("/")});
  }

const HomePage = () => {
   const [user, setUser] = useState(auth.currentUser);
   let history = useHistory();
    if(user == null){
      history.push("/");
      return(<div></div>);
      }else{
    return (
        <div className="flex-container">
           <Avatar src={user.providerData[0].photoURL} id="Avatar"/>
            <h2> Hello <b>{user.displayName}</b> !</h2>
            <div className="google-button" onClick={() => {logOut(history)}}>LogOut</div>
          </div>
    )}
}

export default HomePage
