import { defineStore } from 'pinia'

const useStore = defineStore('account', {
  state: () => ({
    user: null,
    token: null,
    project: null,
    projects: null,
    role: 'activist'
  }),
})

export default useStore;
