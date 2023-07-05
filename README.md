# BetterRest
This app is designed to help coffee drinkers get a good night's sleep by asking them three questions:
- When do they want to wake up?
- Roughly how many hours to sleep do they want?
- How many cups of coffee do they drink per day?

Once we have those three values, we’ll feed them into Core ML to get a result telling us when they ought to go to bed. If you think about it, there are billions of possible answers – all the various wake times multiplied by all the number of sleep hours, multiplied again by the full range of coffee amounts.

That’s where machine learning comes in: using a technique called regression analysis we can ask the computer to come up with an algorithm able to represent all our data. This in turn allows it to apply the algorithm to fresh data it hasn’t seen before, and get accurate results.

Here is a quick look at the app:

![2023-07-05 13-46-49 2023-07-05 13_47_58](https://github.com/akashsheelavant/BetterSleep/assets/52631413/db3fe7f5-e6c6-413d-99f5-b38eb1856da0)



