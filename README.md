# MaterialTB
A library that makes TabBars beautifly Material and animated.

## Description
iOS 11 has introduced TabBars into many of their apps, this style of navigation is becomming more and more popular nowadays. Still, iOS native TabBar can be a little dull if compared to Material Design. This Pod is meant to make your Tabbars look really cool and support Material Design's focus animations.

### Installation

`pod 'MaterialTB'`

### Usage

After installing the pod the steps are really simple:

#### 1. In your storyboard add an empty ViewController

![alt text](https://preview.ibb.co/gQ69Jk/Screen_Shot_2017_09_26_at_10_17_34_PM.png "Storyboard")

Make sure that this View Controller's custom class is `MaterialTB` same as its module.

#### 2. Add your ViewContollers how ever you like, with one condition: Your controller must extend from MaterialViewController

```swift
import UIKit
import MaterialTB

class ViewController: MaterialViewController {

    ...

    // This method is called whenever an opened Tab is "reopende" i.e: You are on
    // 'sales' tab and you tap on 'sales' tab again. By default it triggers an animation
    // but leaves the view controller as-is. You can override it to reload your VC from
    // Storyboard or do any actions you desire.
    override func refreshViewController() -> MaterialViewController {
        // Reload from storyboard
    }
}
```

#### 3. Configure Segues in Storyboard

This is where the magic happens, when you have both your MaterialTB VC and your custom view controller that extends from MaterialViewController, you can ctrl+drag from MaterialTB to your View Controller to create a segue. In the popover you choose 'material view'

![alt text](https://image.ibb.co/b7m9Jk/Screen_Shot_2017_09_26_at_10_36_20_PM.png "Segue selection")

Then in the atributes insepctor of the segue, set the 'Identifier' to be the number of this view in your TabBar i.e: 1, 2, 3, 4, 5. 


#### 4. Configure View Controller info

You can configure the information that will display in the TabBar for each View Controller in the Atributes Inspector of the View Controller

![alt text](https://preview.ibb.co/j0var5/Screen_Shot_2017_09_26_at_10_34_10_PM.png "Controller setup")

`Selected Image`: The image that will display on the TabItem when this view controller is selected. To achieve a better look-and-feel we recomend you to use a slightly biggrer image here than in the Idle Image.

`Idle Image`: The image that will display on the TabItem when this view controller is not selected.

`Tab Title`: The title for this view controller on the TabBar. You can leave it blank to have no text on the Tab.

#### 5. You're all setup! At this point your TabBar should work. Take into account that a TabBar-like navigation is recomended for 3-5 view controllers. MaterialTB supports 1 to 5 view controllers.

### Demo

<a href="https://imgflip.com/gif/1wllsm"><img src="https://i.imgflip.com/1wllsm.gif" title="made at imgflip.com"/></a>

<a href="https://imgflip.com/gif/1wlkxn"><img src="https://i.imgflip.com/1wlkxn.gif" title="made at imgflip.com"/></a>

### Customization

You can customize the look and feel of the TabBar in the atributes inspector of the MaterialTB

![alt text](https://preview.ibb.co/iLRejQ/Screen_Shot_2017_09_26_at_10_45_03_PM.png "Controller setup")

`Initial View Controller`: This tells MaterialTB which Tab is the first loaded Tab when app launches. It's an Integer from 1 to 5.

`Tab Bar Heigth`: This allows you tu customize the TabBar heigth that suits your needs. Default is 65px

`Selected Tint`: This is the color of the text on the TabBar label when it is selected. It should match your 'Selected Image' main color.

`Idle Tint`: This is the color of the text on the TabBar label when it is not selected. It should match your 'Idle Image' main color.

`Tab Bar Background Color`: This is the color of the TabBar's background.

`Font Size`: You can specify the size of the TabItem label's font. We recomend you to use anything from 9 to 15. Default is 12.

`Font Family`: You can specify the Family Font for your TabBar. Default is System's. Font will fallback to default if Family specified is not found.

### Support

This library is completely free of charge, if you want to support us, share this with your friends, or give us some feedback! Support is to grow.

