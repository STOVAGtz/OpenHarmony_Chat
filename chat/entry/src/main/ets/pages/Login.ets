// Index.ets
// 登录
import { router } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State message: string ='Login'
  @State username: string =''
  @State password: string =''
  @State iswarningvisiable: boolean = false
  @State url: string ='127.0.0.1:65000/login'
  @State warning: string = '    用户名或密码错误!'
  @State handlePopup: boolean = false

  build() {
    Row() {
      Column({space:10}) {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        TextInput({ placeholder:'account', text: this.username })
          .type(InputType.Normal)
          .fontSize(16)
          .width('60%')
          .height('5%')
          .margin({ top: 10 })
          .onChange((value: string) => {
            this.username = value
            this.iswarningvisiable = false
          })
        TextInput({ placeholder:'password', text: this.password })
          .type(InputType.Password)
          .fontSize(16)
          .width('60%')
          .height('5%')
          .margin({ top: 10 })
          .onChange((value: string) => {
            this.password = value
            this.iswarningvisiable = false
          })
        if (this.iswarningvisiable) {
          Text(this.warning)
            .width('60%')
            .height('3%')
            .fontSize(12)
            .textAlign(TextAlign.Start)
            .backgroundColor(0xFFFFFF)
            .fontColor(0xFF0000)
        }
        Row({space:0}){
          Button('注册')
            .backgroundColor(0xFFFFFF)
            .fontColor(0x317aFF)
            .fontSize(12)
            .width('25%')
            .height('5%')
            .onClick(() => {
              //this.message ='register';
              router.pushUrl({
                url:'pages/register'
              }).then(() => {
                console.info('page jump succeed')
              }).catch(() => {
                console.info('page jump failed')
              })
            })
          Button('忘记密码')
            .backgroundColor(0xFFFFFF)
            .fontColor(0x317aFF)
            .fontSize(12)
            .width('40%')
            .height('5%')
            .onClick(() => {

            })
        }
        Button('登录')
          .width('60%')
          .height('5%')
          .bindPopup(this.handlePopup, {
            message: '无法连接服务器',
            onStateChange: (e)=> {
              if (!e.isVisible) {
                this.handlePopup = false
              }
            }
          })
          .onClick(() => {
            console.log("click login button");
            /*debug
            router.pushUrl({
              url:'pages/Main'
            }).then(() => {
              console.info('page jump succeed')
            }).catch(() => {
              console.info('page jump failed')
            })
            */

            if (this.username=="" || this.password==""){
              //return;
            }
            let httpRequest = http.createHttp();
            httpRequest.request(
              this.url,
              {
                method: http.RequestMethod.POST,
                header: {
                  'Content-Type': 'application/json'
                },
                extraData: JSON.stringify({
                  username: this.username,
                  password: this.password,
                }),
                expectDataType: http.HttpDataType.OBJECT
              },
              (err: BusinessError, data: http.HttpResponse) => {
                if (!err) {
                  console.info(JSON.stringify({
                    username: this.username,
                    password: this.password,
                  }));
                  console.info('code:' + JSON.stringify(data.responseCode));
                  let responseCode = data.responseCode;
                  if (responseCode==200) {
                    router.replaceUrl({
                      url: 'pages/Main',
                      params: JSON.parse(JSON.stringify(data.result))
                    }).then(() => {
                      console.info('page jump succeed')
                    }).catch(() => {
                      console.info('page jump failed')
                    })
                    //console.log(JSON.parse(JSON.stringify(data.result)))
                    //console.log(data.result.message)
                    httpRequest.destroy();
                  } else{
                    this.iswarningvisiable = true;
                    //console.log(JSON.stringify(data.resultType))
                    //console.log(JSON.parse(JSON.stringify(data.result)).message)
                  }
                } else {
                  console.error('error:' + JSON.stringify(err));
                  this.handlePopup = true;
                  httpRequest.destroy();
                }
              }
            )
          })

      }
      .width('100%')
    }
    .height('100%')
  }
}
