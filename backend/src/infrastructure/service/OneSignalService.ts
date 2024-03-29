import { IOneSignalService } from "@interfaces/services/IOneSignalService";
import fetch from "node-fetch";
import * as OneSignal from "@onesignal/node-onesignal";

export class OneSignalService implements IOneSignalService {
    constructor() {}
  async getNotification(id: string): Promise<OneSignal.NotificationWithMeta> {
    const response = await this.getClient().getNotification(
      process.env.ONE_SIGNAL_APP_ID,
      id
    );
    return response;
  }
  async createNotification(): Promise<OneSignal.CreateNotificationSuccessResponse> {
    const notification = new OneSignal.Notification();
    notification.app_id = process.env.ONE_SIGNAL_APP_ID;
    // notification.included_segments = ["All"];
    notification.contents = { en: "Hello World" };
    notification.headings = { en: "Baby comeone" };
    notification.target_channel = "push";
    notification.is_android = true;
    // notification.include_aliases = {
    //   alias_label: ["user_id1", "user_id2", "user_id3"],
    // };
    notification.include_external_user_ids = ["user_id1"];

    // notification.external_id = "user_id1";
    console.log("notification  ", notification);

    const createNotificationSuccessResponse = await this.getClient().createNotification(notification);
    console.log(
      "Tamirat Dereje before sending notification to all users\n\n\n\n\n\n\n\n"
    );
    console.log(`what ${createNotificationSuccessResponse.id} `);
    console.log(
      "Tamirat Dereje after sending notification to all users\n\n\n\n\n\n\n\n"
    );
    return createNotificationSuccessResponse;
  }
  public getClient(): OneSignal.DefaultApi {
    const app_key_provider = {
      getToken() {
        return process.env.ONE_SIGNAL_REST_API_KEY;
      },
    };
    const user_key_provider = {
      getToken() {
        return process.env.ONE_SIGNAL_USER_AUTH_KEY;
      },
    };

    const configuration = OneSignal.createConfiguration({
      authMethods: {
        user_key: { tokenProvider: user_key_provider },
        app_key: { tokenProvider: app_key_provider },
      },
    });
    const client = new OneSignal.DefaultApi(configuration);
    return client;
  }
  public async createUser(): Promise<object> {
    const url: string = `https://api.onesignal.com/apps/${process.env.ONE_SIGNAL_APP_ID}/users`;
    const externalIdLabel = "external_id";
    const externalId = "user_id1";
    const options = {
      method: "POST",
      headers: {
        accept: "application/json",
        "content-type": "application/json",
        authorization: `Basic ${process.env.ONE_SIGNAL_REST_API_KEY}`,
      },
      body: JSON.stringify({
        identity: { [externalIdLabel]: externalId },
        subscriptions: [
          { type: "AndroidPush", token: "abcd1234", enabled: true },
        ],
        properties: {},
      }),
    };

    fetch(url, options)
      .then((res: fetch.Response) => {
        // console.log(res);
        res.json();
      })
      .then((json: any) => console.log(json))
      .catch((err: Error) => console.error("error:" + err));

    return {};
  }

  public async deleteUser(): Promise<void> {
    return;
  }

  public async sendNotification(): Promise<void> {
    return;
  }

  public async sendNotificationToUser(): Promise<void> {
    return;
  }

  public async sendNotificationToAllUsers(): Promise<void> {
    return;
  }

  public async sendNotificationToSegment(): Promise<void> {
    return;
  }
}
