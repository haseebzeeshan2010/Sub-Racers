extends Control
var facts = [
	"The ocean produces over 50% of the oxygen we breathe.",
	"More than 90% of global warming heat is absorbed by the ocean.",
	"Around 8 million tonnes of plastic enter the ocean every year.",
	"Over one million marine animals die annually due to plastic pollution.",
	"Coral reefs support 25% of all marine life but cover less than 1% of the ocean floor.",
	"Half of the world’s coral reefs have been lost in the last 30 years.",
	"The ocean is home to an estimated 700,000 to 1 million undiscovered species.",
	"Overfishing has pushed more than one-third of fish stocks beyond sustainable levels.",
	"The Great Pacific Garbage Patch is three times the size of France.",
	"Sea levels have risen about 20 cm in the last century due to climate change.",
	"The ocean absorbs about 30% of the carbon dioxide humans produce.",
	"Noise pollution from ships disrupts communication for whales and dolphins.",
	"Mangroves and seagrasses store more carbon per square metre than rainforests.",
	"Microplastics have been found in 100% of sea turtles studied.",
	"Deep‑sea mining threatens ecosystems we still barely understand.",
	"Ocean acidification has increased by 30% since the Industrial Revolution.",
	"By 2050, there could be more plastic than fish in the ocean by weight.",
	"Only about 20% of the ocean has been explored by humans.",
	"Ghost nets-lost fishing gear-kill thousands of marine animals every year.",
	"Healthy oceans are essential for the livelihoods of over 3 billion people."
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FactLabel.text = facts[randi() % facts.size()]
	pass # Replace with function body.
