import * as jose from 'node-jose';
import * as fs from 'fs';
import { json } from 'body-parser';

export const createKeyStore = async () => {
    const keyStore = jose.JWK.createKeyStore()
    await keyStore.generate('RSA', 2048, {alg: 'RS256', use: 'sig' })
    fs.writeFileSync(
        'keys.json', 
        JSON.stringify(keyStore.toJSON(true), null, '  ')
    )
};

export const getKeyStore = async () => {
    const ks = fs.readFileSync('keys.json')
    const keyStore = await jose.JWK.asKeyStore(ks.toString())
    return keyStore;
};
