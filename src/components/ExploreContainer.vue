<template>
  <div>
    <video autoplay muted loop width="320" height="240">
      <source src="./video.mp4" type="video/mp4">
    </video>
    <div id="container">
      <div>
        <h3>Welcome to <br />Climate Gains</h3>
      </div>
      <div class="menu">
        <ion-button>I want to complete a Climate Action</ion-button>
        <ion-button>I want to verify an action</ion-button>
        <ion-button>I want to become a supplier</ion-button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { IonButton } from '@ionic/vue';

export default defineComponent({
  name: 'ExploreContainer',
  props: {
    name: String
  },
  components: { IonButton },
});
</script>

<style scoped>
h3 {
  font-family: Helvetica, sans-serif;
  font-size: 3.3rem;
  font-weight: bolder;
  margin-left: 2REM;
  margin-bottom: 2rem;
  text-shadow: 0px 1px 40px #000;
  line-height: 3rem;
  text-align: left;
}

video {
  height: 100vh;
  object-fit: cover;
  width: 100%;
  height: 100%;
  display: inline-block;
  position: absolute;
  top: 0;

}

.menu {
  display: flex;
  flex-direction: column;
  width: 90%;
  margin: 0 auto;
  max-width: 600px;
}

ion-button {
  --background: white;
  --background-hover: #9ce0be;
  --background-activated: #88f4be;
  --background-focused: #88f4be;

  --color: black;
  --border-radius: 0;
  --border-style: solid;
  --border-width: 1px;
  text-transform: capitalize;
  text-align: left;
  --box-shadow: 0 2px 6px 0 rgb(0, 0, 0, 0.25);

  --ripple-color: deeppink;

  --padding-top: 35px;
  margin-bottom: 60px;
  --padding-bottom: 40px;
}

#container {
  text-align: center;
  position: relative;
  left: 0;
  right: 0;
  top: 60px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  height: 90%;
  z-index: 8;
}

#container strong {
  font-size: 20px;
  line-height: 26px;
}

#container p {
  font-size: 16px;
  line-height: 22px;
  color: #8c8c8c;
  margin: 0;
}

#container a {
  text-decoration: none;
}
</style>
