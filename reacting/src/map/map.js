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
      let eventSource = new EventSource(
        `${process.env.REACT_APP_API_URL}${process.env.REACT_APP_MAP_URI}`,
        { headers: {'authorization': _.get(user, 'authorization')} }
      )
      eventSource.onmessage = (e) => dispatch(JSON.parse(e.data))
      eventSource.onerror = (e) => eventSource.close()
    }
  }, [dispatch, user])

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
