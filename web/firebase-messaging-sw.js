importScripts(
  "https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyCbnm3X57a3JMaQtXHYglcsXFCHSUyTWMw",
  authDomain: "rehana-dc092.firebaseapp.com",
  projectId: "rehana-dc092",
  storageBucket: "rehana-dc092.firebasestorage.app",
  messagingSenderId: "987914961227",
  appId: "1:987914961227:web:306f46d5e760a3f81568ce",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function (payload) {
  console.log(
    "[firebase-messaging-sw.js] Received background message ",
    payload
  );
});
