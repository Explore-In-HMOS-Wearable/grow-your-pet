import { PetPreferences, bondLevel } from '../utils/PreferencesUtils';
import { PromptAction } from '@kit.ArkUI';

@Component
export struct SettingsPage {
  @StorageLink('petName') petName: string = 'Isabella';
  @StorageLink('bondXp') bondXp: number = 0;
  @StorageLink('careCount') careCount: number = 0;
  @State editingName: string = '';
  private prefs: PetPreferences = PetPreferences.getInstance();
  private promptAction: PromptAction = this.getUIContext().getPromptAction();

  async saveName(): Promise<void> {
    const trimmed = this.editingName.trim();
    if (trimmed.length > 0 && trimmed.length <= 20) {
      this.petName = trimmed;
      await this.prefs.save('petName', trimmed);
      try {
        this.promptAction.showToast({ message: 'Name saved' });
      } catch (e) {
        console.error(`toast error: ${(e as Error).message}`);
      }
    }
  }

  async resetAll(): Promise<void> {
    await this.prefs.reset();
    this.editingName = '';
    try {
      this.promptAction.showToast({ message: 'Reset done' });
    } catch (e) {
      console.error(`toast error: ${(e as Error).message}`);
    }
  }

  build() {
    Scroll() {
      Column({ space: 6 }) {
        Text('Settings')
          .fontSize(16)
          .fontWeight(FontWeight.Bolder)
          .fontColor($r('app.color.brand_pink'))
          .margin({ top: 4 })

        Column({ space: 2 }) {
          Text('Bond Lv.')
            .fontSize(9)
            .fontColor($r('app.color.text_gray'))
          Text(`${bondLevel(this.bondXp)}`)
            .fontSize(18)
            .fontWeight(FontWeight.Bolder)
            .fontColor($r('app.color.bond_pink_dark'))
          Text(`${this.careCount} total cares`)
            .fontSize(8)
            .fontColor($r('app.color.text_gray'))
        }
        .padding(6)
        .backgroundColor($r('app.color.card_pink_bg'))
        .borderRadius(10)
        .width('60%')

        Column({ space: 4 }) {
          TextInput({ placeholder: this.petName, text: this.editingName })
            .fontSize(11)
            .fontColor(Color.Black)
            .placeholderColor(Color.Gray)
            .placeholderFont({ size: 11 })
            .height(28)
            .backgroundColor($r('app.color.start_window_background'))
            .borderRadius(8)
            .onChange((v: string) => {
              this.editingName = v;
            })

          Button('Save Name')
            .fontSize(10)
            .margin({ top: 2 })
            .height(24)
            .width('100%')
            .backgroundColor($r('app.color.brand_pink'))
            .onClick(() => {
              this.saveName();
            })
        }
        .width('60%')

        Button('Reset Everything')
          .fontSize(10)
          .height(24)
          .width('60%')
          .backgroundColor($r('app.color.text_gray'))
          .onClick(() => {
            this.resetAll();
          })
      }
      .width('100%')
      .padding({ top: 4, bottom: 16 })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}