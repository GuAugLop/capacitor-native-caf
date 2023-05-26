export interface CafPlugin {
  verifyPolicy(options: { personId: string; jwt: string }): Promise<any>;
}
