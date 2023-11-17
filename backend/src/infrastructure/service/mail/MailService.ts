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

        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL,
                pass: process.env.EMAIL_PASSWORD
            }
        });

        
        const handlebarOptions: hbs.NodemailerExpressHandlebarsOptions = {
            viewEngine: {
                extname: '.handlebars',
                partialsDir: path.resolve('./'),
                defaultLayout: false,
            },
            viewPath: path.resolve('./'),
            extName: '.handlebars',
        };

        
        transporter.use('compile', hbs(handlebarOptions));
        var isSent = false;
        transporter.sendMail(mailOptions, function(error, info){
            if (error) {
              console.log(error);
              throw error;
            } else {
              console.log('Email sent: ' + info.response);
              isSent = true;    
            }
          });
        
        return isSent;
    }
}
 




