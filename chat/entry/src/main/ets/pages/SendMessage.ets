import { router } from '@kit.ArkUI';

class ChatInfo{
  user_id: string = ''
}
const params: ChatInfo = router.getParams() as ChatInfo;

@Entry
@Component
struct SendMessage {

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

          Text(params.user_id)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('85%')
            .height('8%')
            .backgroundColor(0xCCCCCC)
        }
      }
    }
  }
}