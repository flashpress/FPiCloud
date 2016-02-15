# FPiCloud v1.3

# Example
```ActionScript
import ru.flashpress.iCloud.FPiCloud;
import ru.flashpress.iCloud.events.FPiCloudEvent;

FPiCloud.manager.init();
FPiCloud.manager.addEventListener(FPiCloudEvent.ACCOUNT_STATUS_CHANGE, accountStatusChangeHandler);
function accountStatusChangeHandler(event:FPiCloudEvent):void
{
    trace('accountStatusChangeHandler:', event.accountAvailable);
    trace('currentToken:', FPiCloud.manager.currentToken);
}

FPiCloud.manager.keyValueStore.addEventListener(FPiCloudEvent.KEYVALUE_STORE_CHANGE, keyValueChangeHandler);
var result:Boolean = FPiCloud.manager.keyValueStore.setString('my_key', 'some data');
trace('save result:', result);

var text:String = FPiCloud.manager.keyValueStore.getString('my_key');
trace('text:', text);
function keyValueChangeHandler(event:FPiCloudEvent):void
{
    trace('change:', event.changeData);
}
```

# Descriptor
```XML
<extensions>
    <extensionID>ru.flashpress.FPiCloud</extensionID>
</extensions>

<iPhone>
    <Entitlements>
    <![CDATA[
        <key>com.apple.developer.ubiquity-container-identifiers</key>
        <array>
            <string><TEAM_ID>.<CONTAINER_ID></string>
        </array>
        <key>com.apple.developer.ubiquity-kvstore-identifier</key>
        <string><TEAM_ID>.<CONTAINER_ID></string>
    ]]>
	</Entitlements>
</iPhone>
```

## Get TEAM_ID
![TeamID](/screenshots/TeamID.png)

## Get CONTAINER_ID
![ContainerID](/screenshots/ContainerID.png)

## Add CONTAINER_ID to Profile
![AppIDs](/screenshots/AppIDs.png)

![AppIDs](/screenshots/AddContainerID.png)

