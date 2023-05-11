import { WebPlugin } from '@capacitor/core';

import type { CafPlugin } from './definitions';

export class CafWeb extends WebPlugin implements CafPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
