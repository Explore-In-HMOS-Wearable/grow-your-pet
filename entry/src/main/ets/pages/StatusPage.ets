import { ArcList, ArcListItem, ArcListAttribute, LengthMetrics, ComponentContent } from '@kit.ArkUI';

@Builder
function buildText() {
  Column() {
    Text('Cat Isabella')
      .fontSize('44px')
      .fontWeight(FontWeight.Bolder)
      .fontStyle(FontStyle.Italic)
      .fontColor(Color.Pink)
    Text('Wash Her Love Her')
      .fontSize('28px')
      .fontWeight(FontWeight.Bold)
      .fontColor('#E75480')
    Text('Feed Her')
      .fontSize('28px')
      .fontWeight(FontWeight.Bold)
      .fontColor('#C12B78')
  }
}

@Entry
@Component
export struct StatusPage {
  @StorageLink('love') loveStatus: number = 5;
  @StorageLink('hungry') hungryStatus: number = 5;
  @StorageLink('wash') cleanStatus: number = 5;
  context: UIContext = this.getUIContext()
  tabBar1: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(buildText));

  build() {
    Stack() {
      ArcList({ header: this.tabBar1, initialIndex: 0 }) {
        ArcListItem() {
          Text('Cleaning is: %' + this.cleanStatus).fontColor(Color.Black).fontSize(12)
        }

        ArcListItem() {
          Progress({ value: this.cleanStatus, total: 100, type: ProgressType.Linear })
            .color('#00BFFF')
            .value(this.cleanStatus)
            .style({ strokeWidth: 6 })
        }

        ArcListItem() {
          Text('Love is: %' + this.loveStatus).fontColor(Color.Black).fontSize(12)
        }

        ArcListItem() {
          Progress({ value: this.loveStatus, total: 100, type: ProgressType.Linear })
            .color(Color.Pink).value(this.loveStatus).style({ strokeWidth: 6 })
        }

        ArcListItem() {
          Text('Hungry: %' + this.hungryStatus).fontColor(Color.Black).fontSize(12)
        }

        ArcListItem() {
          Progress({ value: this.hungryStatus, total: 100, type: ProgressType.Linear })
            .color('#FF7F00')
            .value(this.hungryStatus)
            .style({ strokeWidth: 6 })
        }
      }
      .space(LengthMetrics.px(12))
      .height('100%')
      .width('90%')
    }

  }
}