import { registerPlugin } from '@capacitor/core';

import type { CafPlugin } from './definitions';

const Caf = registerPlugin<CafPlugin>('Caf', {
  web: () => import('./web').then(m => new m.CafWeb()),
});

export * from './definitions';
export { Caf };
