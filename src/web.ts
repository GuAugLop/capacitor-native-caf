import { WebPlugin } from '@capacitor/core';

import type { CafPlugin } from './definitions';

export class CafWeb extends WebPlugin implements CafPlugin {
  setApiKey(): Promise<void> {
      return Promise.resolve(console.log('Not implemented in Web'))
  }
}
