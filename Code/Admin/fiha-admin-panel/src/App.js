import './index.css';
import { useAuthState } from 'react-firebase-hooks/auth';
import { auth } from './handelers/firebase';
import { useState } from 'react';
import LoginPage from './Screens/login';
import HomePage from './Screens/Home';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  useHistory
} from "react-router-dom";

// TODO: Replace the following with your app's Firebase project configuration





function  App (){


  const [user, loading, error] = useAuthState(auth);
  let history = useHistory();
      return(
      <Router>
        <Switch>
          <Route path="/home"> 
            <HomePage />
          </Route>
          <Route path="/">
            <LoginPage />
          </Route>
        </Switch>
        </Router>
);
}

export default App;
