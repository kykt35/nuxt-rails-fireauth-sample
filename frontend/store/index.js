import firebase from '~/plugins/firebase'

export const strict = false

export const state = () => ({
  user: null
})

export const mutations = {
  setUser (state, user) {
    state.user = user
  }
}

export const actions = {
  setUser ({ commit }, user) {
    commit('setUser', user)
  },
  logout ({ commit }) {
    firebase.auth().signOut()
      .then(() => {
        commit('setUser', null)
      })
  }
}

export const getters = {
  isAuthenticated (state) {
    return !!state.user
  },
  user (state) {
    return state.user
  }
}
