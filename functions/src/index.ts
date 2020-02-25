import * as functions from 'firebase-functions';

import * as admin from "firebase-admin";

admin.initializeApp();

// const db = admin.firestore();
const fcm = admin.messaging();

export const sendToTopic = functions.firestore.document('notifications/{notificationId}').onCreate(
    async snapshot => {
        const notif = snapshot.data();
        const payload: admin.messaging.MessagingPayload = {
            notification: {
                title: `${notif?.title}`,
                body: `${notif?.message}`,
                icon: "https://image.flaticon.com/icons/svg/2097/2097743.svg",
                click_action: 'FLUTTER_NOTIFICATION_CLICK'
            }
        };


        return fcm.sendToTopic("notifications", payload);
    }
);
