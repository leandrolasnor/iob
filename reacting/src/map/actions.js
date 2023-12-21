import axios from 'axios'
import handle_errors from '../handle_errors'

export const get_countries = () => {
  return dispatch => {
    axios.get('/v1/countries/map').then(resp => {
      dispatch({type: 'COUNTRY_FETCHED', payload: resp.data})
    }).catch(e => handle_errors(e))
  }
}
