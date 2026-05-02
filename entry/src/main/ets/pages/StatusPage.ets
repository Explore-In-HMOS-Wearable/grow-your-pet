import { timeAgo, bondLevel, bondProgress } from '../utils/PreferencesUtils';

@Component
export struct StatusPage {
  @StorageLink('love') loveStatus: number = 5;
  @StorageLink('hungry') hungryStatus: number = 5;
  @StorageLink('wash') cleanStatus: number = 5;
  @StorageLink('bondXp') bondXp: number = 0;
  @StorageLink('careCount') careCount: number = 0;
  @StorageLink('lastFed') lastFed: number = Date.now();
  @StorageLink('lastWashed') lastWashed: number = Date.now();
  @StorageLink('lastLoved') lastLoved: number = Date.now();
  context: UIContext = this.getUIContext();

  @Builder
  statCard(icon: Resource, label: string, value: number, color: Resource, subtitle: string) {
    Column() {
      Row() {
        Image(icon)
          .width(14)
          .height(14)
          .margin({ right: 4 })
        Text(label)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_dark'))
          .layoutWeight(1)
        Text(`${value}%`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(color)
      }
      .width('100%')
      .padding({ left: 2, right: 2 })

      Progress({ value: value, total: 100, type: ProgressType.Linear })
        .color(color)
        .value(value)
        .style({ strokeWidth: 4 })
        .width('100%')
        .margin({ top: 2 })

      Text(subtitle)
        .fontSize(8)
        .fontColor($r('app.color.text_gray'))
        .margin({ top: 1 })
    }
    .width('100%')
    .padding(6)
    .backgroundColor($r('app.color.start_window_background'))
    .borderRadius(10)
  }

  @Builder
  bondCard() {
    Column() {
      Text(AppStorage.get<string>('petName') ?? 'Isabella')
        .fontSize('30px')
        .fontWeight(FontWeight.Bolder)
        .fontStyle(FontStyle.Italic)
        .fontColor($r('app.color.brand_pink'))

      Text('Your Little Fluffy Friend')
        .fontSize('14px')
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.brand_pink'))
        .margin({ top: 2, bottom:2 })

      Row() {
        Text(`Bond Lv. ${bondLevel(this.bondXp)}`)
          .fontSize(11)
          .fontWeight(FontWeight.Bolder)
          .fontColor($r('app.color.bond_pink_dark'))
          .layoutWeight(1)
        Text(`${this.careCount} cares`)
          .fontSize(9)
          .fontColor($r('app.color.text_gray'))
      }
      .width('100%')

      Progress({ value: bondProgress(this.bondXp), total: 100, type: ProgressType.Linear })
        .color($r('app.color.bond_pink_dark'))
        .style({ strokeWidth: 3 })
        .width('100%')
        .margin({ top: 2 })
    }
    .width('80%')
    .padding(6)
    .backgroundColor($r('app.color.card_pink_bg'))
    .borderRadius(10)
  }

  build() {
    Scroll() {
      Column({ space: 6 }) {
        this.bondCard()

        this.statCard(
          $r('app.media.soap'),
          'Cleaning',
          this.cleanStatus,
          $r('app.color.stat_blue'),
          `Washed ${timeAgo(this.lastWashed)}`
        )

        this.statCard(
          $r('app.media.heart'),
          'Love',
          this.loveStatus,
          $r('app.color.brand_pink'),
          `Loved ${timeAgo(this.lastLoved)}`
        )

        this.statCard(
          $r('app.media.fish'),
          'Hunger',
          this.hungryStatus,
          $r('app.color.stat_orange'),
          `Fed ${timeAgo(this.lastFed)}`
        )
      }
      .width('70%')
      .padding({ top: 10, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.Top)
  }
}