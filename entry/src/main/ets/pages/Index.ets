import { StatusPage } from './StatusPage';
import { CatPage } from './CatPage';
import { SettingsPage } from './SettingsPage';
import { PetPreferences } from '../utils/PreferencesUtils';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State loaded: boolean = false;
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;

  async aboutToAppear(): Promise<void> {
    const prefs = PetPreferences.getInstance();
    await prefs.init(this.context);
    await prefs.loadAll();
    this.loaded = true;
  }

  build() {
    if (this.loaded) {
      Swiper() {
        StatusPage()
        CatPage()
        SettingsPage()
      }
      .backgroundColor($r('app.color.page_background'))
      .indicator(DotIndicator.dot()
        .color($r('app.color.indicator_pink'))
        .selectedColor($r('app.color.brand_pink')))
      .autoPlay(false)
      .borderColor(Color.Pink)
      .height('100%')
      .width('100%')
    } else {
      Column() {
        LoadingProgress()
          .color($r('app.color.brand_pink'))
          .width(60)
          .height(60)
      }
      .height('100%')
      .width('100%')
      .backgroundColor($r('app.color.page_background'))
      .justifyContent(FlexAlign.Center)
    }
  }
}