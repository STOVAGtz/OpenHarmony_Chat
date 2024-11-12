import { router } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

class MyButtonStyle implements ContentModifier<ButtonConfiguration> {
  iconpath: string = ''

  constructor(iconpath: string) {
    this.iconpath = iconpath;
  }
  applyContent(): WrappedBuilder<[ButtonConfiguration]> {
    return wrapBuilder(buildButton);
  }
}
@Builder
function buildButton(config: ButtonConfiguration) {
  Row() {
    Image($r((config.contentModifier as MyButtonStyle).iconpath))
      .width('50%')
      .height('50%')
  }.width('100%').backgroundColor(0xFF0000)
}

@Reusable
@Component
struct head {
  @State currentTab: string =''

  @Builder
  MyMenu() {
    Menu() {
      MenuItem({
        startIcon: $r("app.media.chatproupicon"),
        content: "发起群聊"
      })
        .onClick(()=>{
          router.pushUrl({
            url:'pages/AddGroupChat'
          }).then(() => {
            console.info('page jump succeed')
          }).catch(() => {
            console.info('page jump failed')
          })
        })
      MenuItem({ startIcon: $r("app.media.addchaticon"), content: "添加朋友" })
        .onClick(()=>{
          router.pushUrl({
            url:'pages/AddFriends'
          }).then(() => {
            console.info('page jump succeed')
          }).catch(() => {
            console.info('page jump failed')
          })
        })
    }
  }

  build() {
      Row() {
        Text(this.currentTab)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('70%')
          .height('8%')
          .backgroundColor(0xCCCCCC)
        //Blank()
        Button({type:ButtonType.Normal}){
          Image($r('app.media.search'))
            .width('40%')
            .height('40%')
        }
          .width('15%')
          .height('8%')
          //.contentModifier(new MyButtonStyle('app.media.background'))
          .backgroundColor(0xCCCCCC)
          .onClick(() => {

          })
        Button({type:ButtonType.Normal}){
          Image($r('app.media.add'))
            .width('40%')
            .height('40%')
        }
          .width('15%')
          .height('8%')
          //.contentModifier(new MyButtonStyle('app.media.startIcon'))
          .backgroundColor(0xCCCCCC)
          .onClick(() => {

          })
          .bindMenu(this.MyMenu())
      }
      .width('100%')

      .backgroundColor(0xCCCCCC)
      .alignItems(VerticalAlign.Top)
    }
}

@Entry
@Component
struct Index {
  @State message: string =''
  @State currentTab: string ='xx'

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Flex({direction:FlexDirection.Column}) {
            head({ currentTab: '消息' })
          }
        }
        .tabBar('消息')

        TabContent() {
          Flex({direction:FlexDirection.Column}) {
            head({ currentTab: '联系人' })
          }
        }
        .tabBar('联系人')

        TabContent() {
          //head({currentTab:'我的'})
        }
        .tabBar("我的")
      }
    }
  }
}
