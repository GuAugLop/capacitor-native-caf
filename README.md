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

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### verifyPolicy(...)

```typescript
verifyPolicy(options: { personId: string; jwt: string; policyId: string; }) => Promise<{ isAuthorized: boolean; attestation?: string; registered: boolean; }>
```

| Param         | Type                                                              |
| ------------- | ----------------------------------------------------------------- |
| **`options`** | <code>{ personId: string; jwt: string; policyId: string; }</code> |

**Returns:** <code>Promise&lt;{ isAuthorized: boolean; attestation?: string; registered: boolean; }&gt;</code>

--------------------

</docgen-api>
