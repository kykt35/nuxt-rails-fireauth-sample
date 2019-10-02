<template>
  <div>
    <div v-if="isWaiting">
      <p>読み込み中</p>
    </div>
    <div v-else>
      <h1>sign in</h1>
      <div v-if="isAuthenticated">
        {{ user.email }}でログイン中<br>
        <button @click="logout">
          ログアウト
        </button>
      </div>
      <div v-else>
        メール<br>
        <v-text-field v-model="email" />
        パスワード<br>
        <v-text-field v-model="password" type="password" />
        <v-btn @click="login">
          ログイン
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState, mapGetters } from 'vuex'
import firebase from '~/plugins/firebase'

export default {
  data () {
    return {
      email: '',
      password: '',
      isWaiting: false
    }
  },
  computed: {
    ...mapState(['user']),
    ...mapGetters(['isAuthenticated'])
  },
  mounted () {
    firebase.auth().onAuthStateChanged((user) => {
      if (user) {
        this.setUser(user)
      }
    })
  },
  methods: {
    ...mapActions(['setUser']),
    async login () {
      await firebase.auth().signInWithEmailAndPassword(this.email, this.password)
        .catch((err) => {
          alert(err)
          return err.responce
        })

      const token = await firebase.auth().currentUser.getIdToken(true)
      localStorage.setItem('token', token)
      this.$router.push('/')
    },
    logout () {
      firebase.auth().signOut()
        .then(() => {
          this.setUser(null)
        }).catch((error) => {
          alert(error)
        })
    }
  }
}
</script>
