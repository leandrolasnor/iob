import { combineReducers } from 'redux'
import auth from '../auth/reducer'
import map from '../map/reducer'
import {reducer as toastr} from 'react-redux-toastr'

const rootReducer = combineReducers({
  auth,
  map,
  toastr
})

export default rootReducer
