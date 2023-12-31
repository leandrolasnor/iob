import { useDispatch, useSelector } from 'react-redux'
import {Container, Button, Row, Col} from 'react-bootstrap'
import { NativeEventSource, EventSourcePolyfill } from 'event-source-polyfill'
import {logout} from './auth/actions'
import axios from 'axios'
import Map from './map/map'
global.EventSource =  EventSourcePolyfill

const _ = require('lodash')

const App = () => {
  const dispatch = useDispatch()
  const { user } = useSelector(state => state.auth)
  axios.defaults.headers.common['Authorization'] = _.get(user, "authorization")

  return (
    <Container fluid>
      <Row className='mt-2'>
        <Col sm={12}>
            <Button variant='link danger' size='sm' onClick={() => dispatch(logout())}>Logout</Button>
            <Map/>
        </Col>
      </Row>
    </Container>
  );
}

export default App
