# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

s1 = Style.create name:"Euro Pale Lager", description:"Similar to the Munich Helles story, many European countries reacted to the popularity of early pale lagers by brewing their own. Hop flavor is significant and of noble varieties, bitterness is moderate, and both are backed by a solid malt body and sweetish notes from an all-malt base."
s2 = Style.create name:"American Pale Ale", description:"Of British origin, this style is now popular worldwide and the use of local ingredients, or imported, produces variances in character from region to region. Generally, expect a good balance of malt and hops. Fruity esters and diacetyl can vary from none to moderate, and bitterness can range from lightly floral to pungent. American versions tend to be cleaner and hoppier, while British tend to be more malty, buttery, aromatic and balanced."
s3 = Style.create name:"Baltic Porter", description:"Porters of the late 1700's were quite strong compared to todays standards, easily surpassing 7% alcohol by volume. Some brewers made a stronger, more robust version, to be shipped across the North Sea, dubbed a Baltic Porter. In general, the styles dark brown color covered up cloudiness and the smoky/roasted brown malts and bitter tastes masked brewing imperfections. The addition of stale ale also lent a pleasant acidic flavor to the style, which made it quite popular. These issues were quite important given that most breweries were getting away from pub brewing and opening up breweries that could ship beer across the world."
s4 = Style.create name:"Hefeweizen", description:"A south German style of wheat beer (weissbier) made with a typical ratio of 50:50, or even higher, wheat. A yeast that produces a unique phenolic flavors of banana and cloves with an often dry and tart edge, some spiciness, bubblegum or notes of apples. Little hop bitterness, and a moderate level of alcohol. The Hefe prefix means with yeast, hence the beers unfiltered and cloudy appearance. Poured into a traditional Weizen glass, the Hefeweizen can be one sexy looking beer. Often served with a lemon wedge (popularized by Americans), to either cut the wheat or yeast edge, which many either find to be a flavorful snap ... or an insult and something that damages the beer's taste and head retention."

beer1 = Beer.create name:"Iso 3"
beer1.brewery = b1
beer1.style = s1
beer1.save

beer2 = Beer.create name:"Karhu"
beer2.brewery = b1
beer2.style = s1
beer2.save

beer3 = Beer.create name:"Tuplahumala"
beer3.brewery = b1
beer3.style = s1
beer3.save

beer4 = Beer.create name:"Huvila Pale Ale"
beer4.brewery = b2
beer4.style = s2
beer4.save

beer5 = Beer.create name:"X Porter"
beer5.brewery = b2
beer5.style = s3
beer5.save

beer6 = Beer.create name:"Hefeweizen"
beer6.brewery = b3
beer6.style = s4
beer6.save

beer7 = Beer.create name:"Helles"
beer7.brewery = b3
beer7.style = s1
beer7.save