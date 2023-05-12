export interface CafPlugin {
  setApiKey(options: {api_key:string}): Promise<void>
}
