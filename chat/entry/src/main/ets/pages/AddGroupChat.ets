import { router } from '@kit.ArkUI';

@Entry
@Component
struct AddGroupChat {

  build() {
    Flex() {
      Column() {
        Row() {
          Button({ type: ButtonType.Normal }) {
            Image($r('app.media.back'))
              .width('40%')
              .height('40%')
          }
          .width('15%')
          .height('8%')
          //.contentModifier(new MyButtonStyle('app.media.background'))
          .backgroundColor(0xCCCCCC)
          .onClick(() => {
            router.back();
          })

          Text('发起群聊')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('85%')
            .height('8%')
            .backgroundColor(0xCCCCCC)
        }
        Row(){
          Search({ placeholder:'搜索'})
            //.searchButton('搜索')
            .width('90%')
            .height('5%')
            .backgroundColor('#F5F5F5')
        }
      }
    }
  }
}