declare global {
    interface PluginRegistry {
        BraintreePlugin?: IBraintreePlugin;
    }
}

export interface DropInToken {
    token: string;
}

export interface DropInOptions {
    amount: string;
    disabled?: string[];
}

export interface DropInResult {
    cancelled: boolean;
    nonce: string;
    type: string;
    localizedDescription: string;
    card: {
        lastTwo: string;
        network: string;
    };
    payPalAccount: {
        email: string;
        firstName: string;
        lastName: string;
        phone: string;
        billingAddress: string;
        shippingAddress: string;
        clientMetadataId: string;
        payerId: string;
    };
    applePaycard: {};
    threeDSecureCard: {
        liabilityShifted: boolean;
        liabilityShiftPossible: boolean;
    };
    venmoAccount: {
        username: string;
    };
}

export interface IBraintreePlugin {
    setToken(options: DropInToken): Promise<any>;

    showDropIn(options: DropInOptions): Promise<DropInResult>
}
