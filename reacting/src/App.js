import { useSelector } from 'react-redux'
import {Container, Row, Col} from 'react-bootstrap'
import axios from 'axios'
import Map from './map/map'

const _ = require('lodash')

const App = () => {
  const { user } = useSelector(state => state.auth)
  axios.defaults.headers.common['Authorization'] = _.get(user, "authorization")

  return (
    <Container>
      <Row className='ml-0'>
        <Col sm={12}>
          <Map/>
        </Col>
      </Row>
    </Container>
  );
}

export default App
