import { DropInOptions, DropInResult, DropInToken, IBraintreePlugin } from "./definitions";
export declare class Braintree implements IBraintreePlugin {
    setToken(options: DropInToken): Promise<any>;
    showDropIn(options: DropInOptions): Promise<DropInResult>;
}
