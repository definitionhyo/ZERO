/**
 *  FCM을 사용하기위해 Firebase 기본 설정
 */
 
 import '@firebase/messaging';
 
const config = {
  projectId: "zero-22d6e",
  apiKey: "AIzaSyD1B1YylXCD_QWdgkL6Jh_WPydI0kVJTBE",
  messagingSenderId: "112965972906",
};

firebase.initializeApp(config);
const messaging = firebase.messaging()
messaging.usePublicVapidKey("Your Web push key");
Notification.requestPermission().then(function(permission) {
  if (permission === 'granted') {
    console.log('Notification permission granted.');
  } else {
    console.log('Unable to get permission to notify.');
  }
});