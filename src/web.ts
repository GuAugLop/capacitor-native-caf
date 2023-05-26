import { WebPlugin } from '@capacitor/core';

import type { CafPlugin } from './definitions';

export class CafWeb extends WebPlugin implements CafPlugin {
  verifyPolicy(): Promise<any> {
    return Promise.resolve(console.log('Not implemented in Web'));
  }
}
