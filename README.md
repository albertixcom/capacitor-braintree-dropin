# capacitor-braintree
A Capacitor plugin for the Braintree mobile payment processing SDK (forked from https://github.com/sumbria/capacitor-braintree)

## Installation

```bash
$ npm i capacitor-braintree
```

## iOS configuration

Add the following in the `ios/App/App/info.plist` file:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>capacitor-braintree</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>{Bundle Identifier}.payments</string>
        </array>
    </dict>
</array>
```

More information can be found here: https://developers.braintreepayments.com/guides/paypal/client-side/ios/v4

Important:

Code "ios/Plugin/Plugin.swift" was modified (see source code comments)

## Android configuration
android/app/src/main/java/[..]/MainActivity.java

```ts
add(com.cubytes.braintree.BraintreePlugin.class);
```

android/app/src/main/AndroidManifest.xml

```xml
<activity android:name="com.braintreepayments.api.BraintreeBrowserSwitchActivity" android:launchMode="singleTask">
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="${applicationId}.braintree" />
    </intent-filter>
</activity>
```

android/build.gradle

```ts
...
implementation 'com.braintreepayments.api:braintree:3.9.0'
implementation('com.braintreepayments.api:drop-in:4.5.0') {
    exclude group: 'com.braintreepayments.api', module: 'three-d-secure'
    because 'Use the development version of Braintree'
}
```
Useful links:
Cordova version (unmaintained): 
https://github.com/engineerapart/cordova-plugin-braintree

Here original demo:
https://github.com/braintree/braintree-android-drop-in/tree/master/Demo

Official documentation
https://developers.braintreepayments.com/guides/drop-in/setup-and-integration/android/v3
https://developers.braintreepayments.com/guides/drop-in/overview/android/v3

## Usage

```ts
import {Braintree, DropInResult} from 'capacitor-braintree';
...
const braintree = new Braintree();
braintree.setToken({
    token: token
}).then(
    () => {
        braintree.showDropIn({
            amount: '10.0',
            disabled: ['venmo'] // (optional) 'paypal', 'card', 'venmo', 'applePay'
        }).then(
            (payment: DropInResult) => {
                console.log(payment);
            }).catch((error) => {
            console.log(error);
        });

    }).catch((error) => {
    console.log(error);
});
```
