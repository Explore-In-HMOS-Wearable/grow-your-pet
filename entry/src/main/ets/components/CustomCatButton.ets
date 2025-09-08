@Component
export struct CustomCatButton {
  @Prop icon: string = '';
  @Require onClickMethod: () => void = () => { }

  build() {
    Image($r(this.icon))
      .onClick(() => {
        this.onClickMethod()
      })
  }
}

