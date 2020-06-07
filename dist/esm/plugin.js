import { Plugins } from "@capacitor/core";
const { BraintreePlugin } = Plugins;
export class Braintree {
    setToken(options) {
        return BraintreePlugin.setToken(options);
    }
    showDropIn(options) {
        return BraintreePlugin.showDropIn(options);
    }
}
//# sourceMappingURL=plugin.js.map