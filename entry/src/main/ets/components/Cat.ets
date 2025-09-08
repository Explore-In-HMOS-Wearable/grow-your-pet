import getPermission, { sendReminder } from '../PermissionUtils';
import { common } from '@kit.AbilityKit';

@Component
export struct Cat {
  @StorageLink('love') @Watch('checkCatStatus') loveStatus: number = 0;
  @StorageLink('hungry') @Watch('checkCatStatus') hungryStatus: number = 0;
  @StorageLink('wash') @Watch('checkCatStatus') cleanStatus: number = 0;
  @State cat: string = 'app.media.cat'
  @State textMessage: string = '';
  private intervalId: number = 0;
  private reminderSent: boolean = false;
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;

  reduceValues() {
    if (this.intervalId !== 0) {
      return;
    }

    this.intervalId = setInterval(() => {
      if (this.cleanStatus > 20) {
        this.cleanStatus -= 20;
      }
      if (this.hungryStatus > 20) {
        this.hungryStatus -= 20;
      }
      if (this.loveStatus > 20) {
        this.loveStatus -= 20;
      }

      this.checkCatStatus();
      if (!this.reminderSent &&
        (this.cleanStatus <= 20 || this.hungryStatus <= 20 || this.loveStatus <= 20)) {
        sendReminder();
        this.reminderSent = true;
      }

    }, 5000);
  }

  checkCatStatus() {
    if (this.cleanStatus <= 60) {
      this.cat = 'app.media.dirty'
      this.textMessage = 'Wash Me!'
    } else if (this.hungryStatus <= 60) {
      this.cat = 'app.media.hungry'
      this.textMessage = 'Feed Me!'
    } else if (this.loveStatus <= 60) {
      this.cat = 'app.media.sad'
      this.textMessage = 'Love me!'
    } else {
      this.cat = 'app.media.happy'
      this.textMessage = 'I am happy!'
      this.reduceValues()
    }
  }

  aboutToAppear(): void {
    getPermission(this.context);
    this.checkCatStatus();

  }

  build() {
    Column() {
      Text(this.textMessage).fontColor(Color.Gray).fontSize(24)
      Image($r(this.cat))
        .height('100%')
        .width('100%')
    }
  }
}