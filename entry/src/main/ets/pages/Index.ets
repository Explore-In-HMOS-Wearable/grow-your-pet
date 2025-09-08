import { StatusPage } from './StatusPage';
import { CatPage } from './CatPage';

@Entry
@Component
struct Index {

  build() {
    Swiper() {
      StatusPage()
      CatPage()
    }.backgroundColor('#EFEFE8')
    .indicator(DotIndicator.dot().color(Color.Pink).selectedColor('#E75480'))
    .autoPlay(false)
    .borderColor(Color.Pink)
    .height('100%')
    .width('100%')
  }
}