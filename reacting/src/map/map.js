import { useEffect, useRef } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import WorldMap from 'react-svg-worldmap'

const _ = require('lodash')

const Map = () => {
  const dispatch = useDispatch()
  const { data } = useSelector(state => state.map)
  const { user } = useSelector(state => state.auth)
  const initialized = useRef(false)

  useEffect(() => {
    if (!initialized.current) {
      initialized.current = true
      let eventSource = new EventSource('http://localhost:3000/v1/countries/map', { headers: {'authorization': _.get(user, 'authorization')} })
      eventSource.onmessage = (e) => dispatch(JSON.parse(e.data))
      eventSource.onerror = (e) => eventSource.close()
    }
  }, [])

  return (
    <WorldMap
      title={'Demographic Density'}
      color='black'
      valueSuffix='hab/km²'
      size='xxl'
      data={data}
      richInteraction={true}
    />
  )
}

export default Map
