import { IMailOptions } from "infrastructure/service/mail/MailService";

export interface IMailService {
    sendEmail(mailOptions: IMailOptions): Promise<boolean>;
}