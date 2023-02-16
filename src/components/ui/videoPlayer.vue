<template>
	<ion-content v-if="cameraActive" class="my-custom-camera-preview-content" :fullscreen="false">
		<div id="cameraPreview" class="cameraPreview">
			<div>
				<ion-button color="light" size="small" @click="stopCamera" fill="clear" class="image-overlay" id="closeCamera">
					<ion-icon :icon="closeOutline"></ion-icon>
				</ion-button>

				<ion-button color="light" size="small" @click="flipCamera" fill="clear" class="image-overlay" id="flipCamera">
					<ion-icon :icon="cameraReverseOutline"></ion-icon>
				</ion-button>
			</div>
		</div>
	</ion-content>
</template>

<script>
import { IonPage, IonContent, IonImg, IonButton, IonIcon } from '@ionic/vue';
import { closeOutline, ellipseOutline, flashOutline, flashOffOutline, cameraReverseOutline } from 'ionicons/icons';
import { CameraPreview } from '@capacitor-community/camera-preview';
export default {
	name: 'CameraPage',
	components: { IonContent, IonPage, IonImg, IonButton, IonIcon },
	data: () => {
		return {
			image: null,
			cameraActive: false
		};
	},
	async mounted() {
		await this.openCamera();
	},
	methods: {
		async openCamera() {
			const cameraPreviewPictureOptions = {
				position: 'front',
				height: 400,
				width: 400,
				parent: 'cameraPreview',
				className: 'cameraPreview'
			};
			await CameraPreview.start(cameraPreviewPictureOptions);
			this.cameraActive = true;
		},
		async stopCamera() {
			await CameraPreview.stopCamera();
			this.cameraActive = false;
		},
		async flipCamera() {
			await CameraPreview.flip();
		}
	},
	setup() {
		return {
			closeOutline,
			cameraReverseOutline
		};
	}
};
</script>

<style scoped>
.my-custom-camera-preview-content {
	--background: transparent;
}
#cameraPreview {
	display: flex;
	width: 100%;
	height: 100%;
	position: absolute;
}
.overlay {
	position: absolute;
	width: 100%;
	height: 100%;
	z-index: 10;
}
.image-overlay {
	z-index: 1;
	position: absolute;
	width: 50px;
	height: 50px;
}
#flashCamera {
	position: absolute;
	right: 1%;
	--ionicon-stroke-width: 36px;
}
#flipCamera {
	position: absolute;
	bottom: 3%;
	right: 3%;
	--ionicon-stroke-width: 46px;
}
#closeCamera {
	position: absolute;
	left: 1%;
	--ionicon-stroke-width: 46px;
}
#cameraCapture {
	position: absolute;
	left: 50%;
	bottom: 3%;
	--ionicon-stroke-width: 46px;
}
ion-icon {
	font-size: 64px;
	color: white;
}
</style>
