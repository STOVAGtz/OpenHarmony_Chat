// Second.ets
// 注册
import { router } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State message: string ='Register'
  @State username: string =''
  @State password: string =''
  @State password2: string =''
  @State passwordtips1 :string = '    6-10位纯数字'
  @State ispasswordtips1 :boolean = false
  @State passordtipscolor1 :boolean = false
  @State passwordtips2 :string = '    两次密码输入不同'
  @State ispasswordtips2 :boolean = false
  @State passordtipscolor2 :boolean = false
  @State iswarningvisiable: boolean = false
  @State url: string ='127.0.0.1:65000/register'
  @State warning: string = '    用户名或密码错误!'

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
          })
        TextInput({ placeholder:'password', text: this.password })
          .type(InputType.Password)
          .fontSize(16)
          .width('60%')
          .height('5%')
          .margin({ top: 10 })
          .onChange((value: string) => {
            this.password = value
            let reg = new RegExp("^\\d{6,10}$")
            this.passordtipscolor1 = reg.test(this.password);
          })
          .onFocus(()=>{
            this.ispasswordtips1 = true;
          })
          .onBlur(()=>{
            if (this.passordtipscolor1){
              this.ispasswordtips1 = false;
            }
          })
        if (this.ispasswordtips1){
          Text(this.passwordtips1)
            .width('60%')
            .height('3%')
            .fontSize(12)
            .textAlign(TextAlign.Start)
            .backgroundColor(0xEEEEFF)
            .fontColor(this.passordtipscolor1==false? 0xFF0000 : 0x00AA00)
        }
        TextInput({ placeholder:'password', text: this.password2 })
          .type(InputType.Password)
          .fontSize(16)
          .width('60%')
          .height('5%')
          .margin({ top: 10 })
          .onChange((value: string) => {
            this.password2 = value
            if (this.password.toString() != this.password2.toString()) {
              this.passordtipscolor2 = false;
            }else{
              this.passordtipscolor2 = true;
            }
          })
          .onFocus(()=>{
            this.ispasswordtips2 = true;
          })
          .onBlur(()=>{
            if (this.passordtipscolor2){
              this.ispasswordtips2 = false;
            }
          })
        if (this.ispasswordtips2){
          Text(this.passwordtips2)
            .width('60%')
            .height('3%')
            .fontSize(12)
            .textAlign(TextAlign.Start)
            .backgroundColor(0xEEEEFF)
            .fontColor(this.passordtipscolor2==false? 0xFF0000 : 0x00AA00)
        }
        if (this.iswarningvisiable) {
          Text(this.warning)
            .width('60%')
            .height('3%')
            .fontSize(12)
            .textAlign(TextAlign.Start)
            .backgroundColor(0xFFFFFF)
            .fontColor(0xFF0000)
        }
        Button('立即注册')
          .margin({ top: 10 })
          .width('60%')
          .height('5%')
          .onClick(() => {
            console.log("click login button");
            console.log(JSON.stringify({
              username: this.username,
              password: this.password,
              password2: this.password2,
            }));
            if (this.username=="" || this.password==""){
              return;
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
                })
              },
              (err: BusinessError, data: http.HttpResponse) => {
                if (!err) {
                  console.info(JSON.stringify({
                    username: this.username,
                    password: this.password,
                  }));
                  console.info('code:' + JSON.stringify(data.responseCode));
                  let responseCode = data.responseCode;
                  httpRequest.destroy();
                  if (responseCode==400) {
                    router.back();
                  }else{
                    console.log('返回错误');
                  }
                } else {
                  console.error('error:' + JSON.stringify(err));
                  httpRequest.destroy();
                }
              }
            )
          })
        Button("返回")
          .width('60%')
          .height('5%')
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
