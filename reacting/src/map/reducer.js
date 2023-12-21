const INITIAL_STATE = {
  data: []
}

var reducer = (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case "COUNTRY_FETCHED":
      return {
        ...state,
        data: [
          ...state.data,
          ...action.payload
        ]
      }
    default:
      return state;
  }
};

export default reducer;
