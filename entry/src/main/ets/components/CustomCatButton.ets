@Component
export struct CustomCatButton {
  @Prop icon: string = '';
  @Require onClickMethod: () => void = () => {
  };
  @State pressed: boolean = false;

  build() {
    Image($r(this.icon))
      .scale({ x: this.pressed ? 0.85 : 1, y: this.pressed ? 0.85 : 1 })
      .animation({ duration: 120, curve: Curve.EaseOut })
      .onTouch((e: TouchEvent) => {
        if (e.type === TouchType.Down) {
          this.pressed = true;
        } else if (e.type === TouchType.Up || e.type === TouchType.Cancel) {
          this.pressed = false;
        }
      })
      .onClick(() => {
        this.onClickMethod();
      })
  }
}