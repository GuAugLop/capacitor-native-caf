import { WebPlugin } from '@capacitor/core';

import type { CafPlugin } from './definitions';

export class CafWeb extends WebPlugin implements CafPlugin {
  verifyPolicy(): Promise<any> {
    throw new Error('Method not implemented.');
  }
}
