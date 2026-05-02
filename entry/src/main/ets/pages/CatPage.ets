import { Cat } from '../components/Cat';
import { CustomCatButton } from '../components/CustomCatButton';
import { PetPreferences } from '../utils/PreferencesUtils';

@Component
export struct CatPage {
  @StorageLink('wash') clean: number = 0;
  @StorageLink('hungry') hungry: number = 0;
  @StorageLink('love') loveStatus: number = 0;
  @StorageLink('bondXp') bondXp: number = 0;
  @StorageLink('careCount') careCount: number = 0;
  @StorageLink('lastFed') lastFed: number = 0;
  @StorageLink('lastWashed') lastWashed: number = 0;
  @StorageLink('lastLoved') lastLoved: number = 0;
  private prefs: PetPreferences = PetPreferences.getInstance();

  private async bumpCare(): Promise<void> {
    this.careCount += 1;
    this.bondXp += 1;
    await this.prefs.save('careCount', this.careCount);
    await this.prefs.save('bondXp', this.bondXp);
  }

  async love(): Promise<void> {
    if (this.loveStatus <= 80) {
      this.loveStatus = this.loveStatus + 20;
    } else {
      this.loveStatus = 100;
    }
    this.lastLoved = Date.now();
    await this.prefs.save('love', this.loveStatus);
    await this.prefs.save('lastLoved', this.lastLoved);
    await this.bumpCare();
  }

  async wash(): Promise<void> {
    if (this.clean <= 80) {
      this.clean = this.clean + 20;
    } else {
      this.clean = 100;
    }
    this.lastWashed = Date.now();
    await this.prefs.save('wash', this.clean);
    await this.prefs.save('lastWashed', this.lastWashed);
    await this.bumpCare();
  }

  async feed(): Promise<void> {
    if (this.hungry <= 80) {
      this.hungry = this.hungry + 20;
    } else {
      this.hungry = 100;
    }
    this.lastFed = Date.now();
    await this.prefs.save('hungry', this.hungry);
    await this.prefs.save('lastFed', this.lastFed);
    await this.bumpCare();
  }

  build() {
    Row() {
      Column() {
        CustomCatButton({
          icon: 'app.media.soap',
          onClickMethod: () => {
            this.wash();
          }
        })
      }
      .height('15%')
      .width('18%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        Cat()
          .height('60%')

        CustomCatButton({
          icon: 'app.media.fish',
          onClickMethod: () => {
            this.feed();
          }
        })
          .height('14%')
          .width('35%')
      }
      .width('50%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Column() {
        CustomCatButton({
          icon: 'app.media.heart',
          onClickMethod: () => {
            this.love();
          }
        })
      }
      .height('15%')
      .width('18%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .padding({ left: 4, right: 4 })
  }
}