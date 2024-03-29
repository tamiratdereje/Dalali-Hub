import * as OneSignal from "@onesignal/node-onesignal";

export interface IOneSignalService {
  getClient(): OneSignal.DefaultApi;
  createUser(): Promise<object>;
  deleteUser(): Promise<void>;
  createNotification(): Promise<OneSignal.CreateNotificationSuccessResponse>;
  getNotification(id: string): Promise<OneSignal.NotificationWithMeta>;
  sendNotification(): Promise<void>;
  sendNotificationToUser(): Promise<void>;
  sendNotificationToAllUsers(): Promise<void>;
  sendNotificationToSegment(): Promise<void>;
}
