<template>
  <v-toolbar flat max-height="40px" height="40px">
    <v-toolbar-title class="headline">
      <nuxt-link to="/">
        <span class="font-weight-light">
          nuxt-rails-fireauth-sample
        </span>
      </nuxt-link>
    </v-toolbar-title>
    <v-spacer />
    <v-toolbar-items v-if="isAuthenticated">
      <v-btn>
        {{ user.displayName || user.email }}
      </v-btn>
      <v-btn @click="logout">
        ログアウト
      </v-btn>
    </v-toolbar-items>
    <v-toolbar-items v-else>
      <v-btn>
        <nuxt-link to="/signin">
          ログイン
        </nuxt-link>
      </v-btn>
      <v-btn>
        <nuxt-link to="/signup">
          新規登録
        </nuxt-link>
      </v-btn>
    </v-toolbar-items>
  </v-toolbar>
</template>

<script>
import { mapActions, mapState, mapGetters } from 'vuex'
import firebase from '~/plugins/firebase'

export default {

  computed: {
    ...mapState(['user']),
    ...mapGetters(['isAuthenticated', 'user'])
  },

  mounted () {
    firebase.auth().onAuthStateChanged((user) => {
      if (user) {
        this.setUser(user)
      }
    })
  },
  methods: {
    ...mapActions(['setUser', 'logout'])
  }
}
</script>
