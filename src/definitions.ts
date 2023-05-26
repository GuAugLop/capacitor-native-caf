export interface CafPlugin {
  verifyPolicy(options: {
    personId: string;
    jwt: string;
  }): Promise<{ isAuthorized: boolean; attestation?: string }>;
}
