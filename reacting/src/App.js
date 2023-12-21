import { useDispatch, useSelector } from 'react-redux'
import { logout } from './auth/actions'
import Map from './countries/map.js'
import axios from 'axios'
import logo from './logo.svg';
import './App.css';

const _ = require('lodash')

const App = props => {
  const dispatch = useDispatch()
  const { user } = useSelector(state => state.auth)
  axios.defaults.headers.common['Authorization'] = _.get(user, "authorization");

  return (
    <div>
      <Map />
    </div>
  );
}

export default App
