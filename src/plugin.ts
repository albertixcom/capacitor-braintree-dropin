import {Plugins} from "@capacitor/core";
import {
    DropInOptions,
    DropInResult,
    DropInToken,
    IBraintreePlugin
} from "./definitions";

const {BraintreePlugin} = Plugins;

export class Braintree implements IBraintreePlugin {
    setToken(options: DropInToken): Promise<any> {
        return BraintreePlugin.setToken(options);
    }

    showDropIn(options: DropInOptions): Promise<DropInResult> {
        return BraintreePlugin.showDropIn(options);
    }
}
