# capacitor-native-caf

CAF SDKs with Capacitor

## Install

```bash
npm install capacitor-native-caf
npx cap sync
```

## API

<docgen-index>

* [`verifyPolicy(...)`](#verifypolicy)
* [`faceAuthenticator(...)`](#faceauthenticator)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### verifyPolicy(...)

```typescript
verifyPolicy(options: { personId: string; jwt: string; policyId: string; }) => Promise<{ isAuthorized: boolean; attestation?: string; }>
```

| Param         | Type                                                              |
| ------------- | ----------------------------------------------------------------- |
| **`options`** | <code>{ personId: string; jwt: string; policyId: string; }</code> |

**Returns:** <code>Promise&lt;{ isAuthorized: boolean; attestation?: string; }&gt;</code>

--------------------


### faceAuthenticator(...)

```typescript
faceAuthenticator(options: { cpf: string; jwt: string; }) => Promise<any>
```

| Param         | Type                                       |
| ------------- | ------------------------------------------ |
| **`options`** | <code>{ cpf: string; jwt: string; }</code> |

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------

</docgen-api>
