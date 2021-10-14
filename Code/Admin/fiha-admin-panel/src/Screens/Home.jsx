import React from 'react'
import { useHistory } from 'react-router';
import { useState, useEffect } from 'react';
import { auth, db } from '../handelers/firebase';
import {Avatar} from '@material-ui/core';
import {doc, onSnapshot, query, collection, addDoc, orderBy, Timestamp} from "firebase/firestore";
import { FormControl, TextField, InputLabel, InputAdornment, IconButton, OutlinedInput } from '@material-ui/core';
import {FiberSmartRecordRounded, Send} from '@material-ui/icons';



const logOut = (history) => {
    auth.signOut().then(() => {history.push("/")});
  }



const HomePage = () => {
   const [user, setUser] = useState(auth.currentUser);
   const [msgs, setMsgs] = useState([]);
   const [inputMsg, setInputMsg] = useState("");
   const sendMsg = async () => {
     var timestamp = Timestamp.fromMillis(Date.now());
    if(inputMsg == "") return;
    await addDoc(collection(db, "messages"), {
      content: inputMsg,
      UID: user.uid,
      photoURL: user.providerData[0].photoURL,
      createdAt: timestamp,
    }).then(()=>{
      setInputMsg("");
    })
  
  }

  function scrollToTestDiv(){
    const divElement = document.getElementById('test');
    divElement.scrollIntoView({ behavior: 'smooth' });
  }

   useEffect(() => {
     //Get Msgs Stream
     const q = query(collection(db, "messages"), orderBy("createdAt"));
 
     onSnapshot(q, (snapshot) => {
       const messages = [];
       snapshot.forEach(doc => {
         messages.push(doc.data());
         
       });
       console.log(messages);
       scrollToTestDiv();
       setMsgs(messages);
     }) 

   }, [])
   let history = useHistory();
    if(user == null){
      history.push("/");
      return(<div></div>);
      }else{
    return (
        <div className="msg-container">
<div className="flex-container">
          <Avatar src={user.providerData[0].photoURL} id="Avatar"/>
            <h2> Hello <b>{user.displayName}</b> !</h2>
            <div className="google-button" onClick={() => {logOut(history)}}>LogOut</div>
          </div>
          <div>
            {msgs.map((msg) => 
         
            (
              
              <div className={msg.UID == user.uid ? "msg sender" : "msg recive"} >
              <Avatar src={msg.photoURL} className="msgAvatar" />
            <div className={msg.UID == user.uid ? "msgsender" : "msgrecive"} >{msg.content}</div>
            <div className="timestamp">{msg.createdAt.toDate().toString().substr(0,21)}</div>
            </div>
            )
            )}
             <div id="test"></div>
          </div>
         
          <div className="inputform">
          <FormControl fullWidth variant="outlined">
          <InputLabel htmlFor="outlined-adornment-password" className="hint">Messages...</InputLabel>
          <OutlinedInput
            id="outlined-adornment-password"
            type='text'
            value={inputMsg}
            onChange={(event)=>{setInputMsg(event.target.value)}}
            endAdornment={
              <InputAdornment position="end">
                <IconButton
                  aria-label="Send Message"
                  onClick={sendMsg}
                  edge="end"
                >
           <Send/>
                </IconButton>
              </InputAdornment>
            }
            label="Password"
          />
          </FormControl>
          </div>
         
        
          </div>
    )}
}

export default HomePage
