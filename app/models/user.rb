class User < ApplicationRecord
  class << self
    def generate_name
      [colour, animal, rand(100_000)].join("-")
    end

    def animal
      %i[
        Dog Cow Cat Horse Donkey Tiger Lion Panther Leopard Cheetah Bear Elephant
        Polar-bear Turtle Tortoise Crocodile Rabbit Porcupine Hare Hen Otter
        Pigeon Albatross Crow Fish Dolphin Frog Whale Alligator Jellyfish Mammoth
        Eagle squirrel Ostrich Fox Goat Jackal Emu Armadillo Hippopotamus
        Eel Goose Arctic-fox Wolf Beagle Chimpanzee Monkey Beaver Orangutan Antelope Bat
        Badger Giraffe Crab Panda Hamster Cobra Shark Camel Hawk Deer Chameleon
        Jaguar Chihuahua Ibex Lizard Koala Kangaroo Iguana Llama Chinchillas Dodo
        Rhinoceros Hedgehog Zebra Possum Wombat Bison Bull Buffalo Sheep Meerkat Mouse
        Sloth Owl Vulture Flamingo Racoon Mole Duck Swan Lynx Elk Boar Lemur Mule Baboon
        Blue-whale Rat Snake Peacock
      ].sample
    end

    def colour
      %i[
        White Yellow Blue Red Green Black Brown Azure Ivory Teal Silver Purple Gray
        Orange Maroon Charcoal Aquamarine Coral Fuchsia Wheat Lime Crimson Khaki
        Pink Magenta Olden Plum Olive Cyan
      ].sample
    end
  end
end
