import { Cat } from '../components/Cat';
import { CustomCatButton } from '../components/CustomCatButton';

@Entry
@Component
export struct CatPage {
  @StorageLink('wash') clean: number = 0;
  @StorageLink('hungry') hungry: number = 0;
  @StorageLink('love') loveStatus: number = 0;

  love() {
    if (this.loveStatus <= 80) {
      this.loveStatus = this.loveStatus + 20;
      AppStorage.setOrCreate('love', this.loveStatus)
      console.log(this.loveStatus.toString())
    }
  }
  wash() {
    if (this.clean <= 80) {
      this.clean = this.clean + 20;
      AppStorage.setOrCreate('wash', this.clean)
      console.log(this.clean.toString())
    }
  }
  feed() {
    if (this.hungry <= 80) {
      this.hungry = this.hungry + 20
      AppStorage.setOrCreate('hungry', this.hungry)
      console.log(this.hungry.toString())
    }
  }

  build() {
    Row() {
      Column() {
        CustomCatButton({
          icon: 'app.media.soap',
          onClickMethod: () => {
            this.wash()
          }
        })
      }.height('20%')
      .width('20%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        Cat()
          .height('70%')
        CustomCatButton({
          icon: 'app.media.fish',
          onClickMethod: () => {
            this.feed()
          }
        })
          .height('16%')
          .width('40%')
      }
      .width('60%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)

      Column() {
        CustomCatButton({
          icon: 'app.media.heart',
          onClickMethod: () => {
            this.love()
          }
        }).margin({ top: 16 })
      }.height('20%')
      .width('20%')
      .alignItems(HorizontalAlign.Center)
    }.height('100%').justifyContent(FlexAlign.Center)
  }
}