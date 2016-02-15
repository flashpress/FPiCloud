package {

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;
    import flash.system.Capabilities;
    import flash.text.TextField;
    import flash.text.TextFormat;

    import ru.flashpress.iCloud.FPiCloud;
    import ru.flashpress.iCloud.events.FPiCloudEvent;
    import ru.flashpress.ui.buttons.FPButton;
    import ru.flashpress.ui.containers.FPHBox;
    import ru.flashpress.ui.containers.FPVBox;
    import ru.flashpress.ui.text.FPInput;
    import ru.flashpress.ui.text.params.FPLabelParams;

    public class Main extends Sprite
    {
        public function Main()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            //
            createUI();
            initICloud();
        }

        private var keySaveInput:FPInput;
        private var valueSaveInput:FPInput;
        private var saveButton:FPButton;
        //
        private var keyReadInput:FPInput;
        private var readButton:FPButton;
        //
        private var logField:TextField;
        private function createUI():void
        {
            FPLabelParams.defaultSize = 24;
            //
            var rootBox:FPVBox = new FPVBox({halign:'left'});
            rootBox.x = 40;
            rootBox.y = 40;
            //
            keySaveInput = new FPInput();
            keySaveInput.text = 'MyKey';
            keySaveInput.width = 120;
            //
            valueSaveInput = new FPInput();
            valueSaveInput.text = 'value 123';
            valueSaveInput.width = 120;
            //
            saveButton = new FPButton('save');
            saveButton.addEventListener(MouseEvent.CLICK, saveClickHandler);
            saveButton.width = 100;
            //
            keyReadInput = new FPInput();
            keyReadInput.text = 'MyKey';
            keyReadInput.width = 120;
            //
            readButton = new FPButton('read');
            readButton.addEventListener(MouseEvent.CLICK, readClickHandler);
            readButton.width = 100;
            //
            logField = new TextField();
            logField.multiline = logField.wordWrap = true;
            logField.defaultTextFormat = new TextFormat('Tahoma', 18);
            logField.border = true;
            logField.background = true;
            logField.width = Capabilities.screenResolutionX-rootBox.x*2;
            //
            this.addChild(rootBox);
            rootBox.addChild(FPHBox.createWithChilds(null, keySaveInput, valueSaveInput, saveButton));
            rootBox.addChild(FPHBox.createWithChilds(null, keyReadInput, readButton));
            rootBox.addChild(logField);
            //
            logField.height = Capabilities.screenResolutionY-rootBox.y-logField.y-40;
        }

        private function saveClickHandler(event:MouseEvent):void
        {
            var key:String = keySaveInput.text;
            var value:String = valueSaveInput.text;
            if (!key || !value) return;
            var result:Boolean = FPiCloud.manager.keyValueStore.setString(key, value);
            log('save, key="'+key+'", value="'+value+'"');
            log('	result:', result);
            //
        }
        private function readClickHandler(evnet:MouseEvent):void
        {
            var key:String = keyReadInput.text;
            log('read, key="'+key+'"');
            var value:String = FPiCloud.manager.keyValueStore.getString(key);
            log('	value:', value);
        }
        private function log(...message):void
        {
            logField.appendText(message.join(' ')+'\n');
            logField.scrollV = logField.maxScrollV;
        }

        private function initICloud():void
        {
            FPiCloud.manager.init();
            FPiCloud.manager.addEventListener(FPiCloudEvent.ACCOUNT_STATUS_CHANGE, accountStatusChangeHandler);
            //
            log('version:'+FPiCloud.VERSION+'.'+FPiCloud.BUILD);
            log('isSupported:'+FPiCloud.isSupported);
            log('isAvaliable:'+FPiCloud.manager.isAvaliable);
            log('currentToken:'+FPiCloud.manager.currentToken);
            log('defaultUbiqUrl:'+FPiCloud.manager.defaultUbiqUrl);
            log('container available:'+FPiCloud.manager.containerAvailable('WZMTNWJBJ7', 'ru.flashpress.test'));
            log('isAvaliable:'+FPiCloud.manager.isAvaliable);
            log('currentToken:'+FPiCloud.manager.currentToken);
            log('defaultUbiqUrl:'+FPiCloud.manager.defaultUbiqUrl);
            //
            FPiCloud.manager.keyValueStore.addEventListener(FPiCloudEvent.KEYVALUE_STORE_CHANGE, keyValueChangeHandler);
        }

        private function accountStatusChangeHandler(event:FPiCloudEvent):void
        {
            log('accountStatusChangeHandler:');
            log('   accountAvailable:', event.accountAvailable);
            log('   currentToken:', FPiCloud.manager.currentToken);
        }

        private function keyValueChangeHandler(event:FPiCloudEvent):void
        {
            log('KeyValue change:', event.changeData);
        }
    }
}
