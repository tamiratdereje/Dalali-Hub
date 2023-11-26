import * as path from 'path';
import * as nodemailer from 'nodemailer';
import * as hbs from 'nodemailer-express-handlebars';
import { IMailService } from '@interfaces/services/IMailService';
import { dot } from 'node:test/reporters';


export interface IMailOptions {
    from: string;
    to: string;
    subject: string;
    template: string;
    context: any;
}
export class MailService implements IMailService {
    async sendEmail(mailOptions: IMailOptions) : Promise<boolean> {
        
        // create reusable transporter object using the default SMTP transport
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            host: 'smtp.gmail.com',
            port: 465,
            secure: true,
            auth: {
                user: process.env.EMAIL,
                pass: process.env.EMAIL_PASSWORD
            }
        });

        // define mail template
        const templatePath = path.resolve('./', 'src', 'infrastructure', 'service', 'mail');
        const handlebarOptions: hbs.NodemailerExpressHandlebarsOptions = {
            viewEngine: {
                extname: '.handlebars',
                partialsDir: templatePath,
                defaultLayout: false,
            },
            viewPath: templatePath,
            extName: '.handlebars',
        };

        // send mail with defined transport object
        transporter.use('compile', hbs(handlebarOptions));
        transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
                transporter.close();
                throw error;
            } else {
                transporter.close();
            }

        }); 
        return true;
    }
}
 




