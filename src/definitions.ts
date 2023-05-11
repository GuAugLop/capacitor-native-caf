export interface CafPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
