import { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { ReactWorldCountriesMap } from "react-world-countries-map"
import { get_countries } from './actions'

const _ = require('lodash')

const Map = () => {
  const dispatch = useDispatch()
  const { data } = useSelector(state => state.map)
  const { user } = useSelector(state => state.auth)

  useEffect(() => {
    const eventSource = new EventSource("http://localhost:3000/v1/countries/map", { headers: {Authorization: _.get(user, "authorization")}})
    eventSource.onmessage = (event) => {
      console.log(event)
    }
    return () => eventSource.close();
  })

  return (
    // <ReactWorldCountriesMap
    //   color="black"
    //   value-suffix="Hab/km²"
    //   size="xlg"
    //   data={data}
    // />
    <div></div>
  )
}

export default Map
