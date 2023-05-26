export interface CafPlugin {
  verifyPolicy(options: {
    personId: string;
    jwt: string;
    policyId: string;
  }): Promise<{ isAuthorized: boolean; attestation?: string }>;
}
