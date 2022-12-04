import { defineStore } from 'pinia';

// https://pinia.esm.dev/introduction.html
// useStore could be anything like useUser, useCart
// the first argument is a unique id of the store across your application

const useStore = defineStore('main', {
	state: () => ({
        users: [],
    }),
    getters: {
      getUsers(state){
          return state.users
        }
    },
    actions: {
      async fetchUsers() {
        try {
          const data = await fetch('https://6343f85fb9ab4243cadbdba1.mockapi.io/api/v1/actions')
           this.users = data
          }
          catch (error) {
          
            window.console.log(error)
        }
      }
    },
});

export default useStore;
