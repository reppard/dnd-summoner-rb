module DnD
  def self.get_size(height_range, weight_range)
    height = rand(height_range).round(2)
    weight = rand(weight_range) * height

    {
      "Height" => height,
      "Weight" => weight.round
    }
  end

  RACES = {
    "Dwarf" => {
      "Speed"            => 25,
      "AbilityIncreases" => { "Constitution" => 2 },
      "Size"             => get_size(4.0..5.0, 30..32),
      "Subraces"         => {
        "Hill Dwarf" => {
          "AbilityIncreases" => { "Wisdom" => 1 }
        },
        "Mountain Dwarf" => {
          "AbilityIncreases" => { "Strength" => 2 }
        }
      },
      "Names" => {
        "Male" => [
          "Adrik", "Alberich", "Baern", "Barendd", "Brottor", "Bruenor", "Dain",
          "Darrak", "Delg", "Eberk", "Einkil", "Fargrim", "Flint", "Gardain",
          "Harbek", "Kildrak", "Morgran", "Orsik", "Oskar", "Rangrim", "Rurik",
          "Taklinn", "Thoradin", "Thorin", "Tordek", "Traubon", "Travok",
          "Ulfgar", "Veit", "Vondal"
        ],
        "Female" => [
          "Amber", "Artin", "Audhild", "Bardryn", "Dagnal", "Diesa", "Eldeth",
          "Falkrunn", "Finellen", "Gunnloda", "Gurdis", "Helja", "Hlin",
          "Kathra", "Kristryd", "Ilde", "Liftrasa", "Mardred", "Riswynn",
          "Sannl", "Torbera", "Torgga", "Vistra"
        ],
        "Sir" => [
          "Balderk", "Battlehammer", "Brawnanvil", "Dankil", "Fireforge",
          "Frostbeard", "Gorunn", "Holderhek", "Ironfist", "Loderr", "Lutgehr",
          "Rumnaheim", "Strakeln", "Torunn", "Ungart"
        ]
      },
      "Proficiencies" => {
        "Tools" => [
          "artisan's tools",
          "choice of: smith's tools, brewer's supplies, or mason's tools"
        ]
      }
    },
    "Elf" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Dexterity" => 2 },
      "Size"             => get_size(4.0..6.2, 20..23),
      "Subraces" => {
        "Dark Elf" => {
          "AbilityIncreases" => { "Charisma" => 1 }
        },
        "Wood Elf" => {
          "Speed"            => 35,
          "AbilityIncreases" => { "Wisdom" => 1 }
        },
        "High Elf" => {
          "AbilityIncreases" => { "Intelligence" => 1 }
        }
      },
      "Names" => {
        "Child" => [
          "Ara", "Bryn", "Del", "Eryn", "Faen", "Innil", "Lael", "Mella",
          "Naill", "Naeris", "Phann", "Rael", "Rinn", "Sai", "Syllin", "Thia",
          "Vall"
        ],
        "Male" => [
          "Adran", "Aelar", "Aramil", "Arannis", "Aust", "Beiro", "Berrian",
          "Carric", "Enialis", "Erdan", "Erevan", "Galinndan", "Hadarai",
          "Heian", "Himo", "Immeral", "Ivellios", "Laucian", "Mindartis",
          "Paelias", "Peren", "Quarion", "Riardon", "Rolen", "Soveliss",
          "Thamior", "Tharivol", "Theren", "Varis"
        ],
        "Female" => [
          "Adrie", "Althaea", "Anastrianna", "Andraste", "Antinua", "Bethrynna",
          "Birel", "Caelynn", "Drusilia", "Enna", "Felosial", "Ielenia",
          "Jelenneth", "Keyleth", "Leshanna", "Lia", "Meriele", "Mialee",
          "Naivara", "Quelenna", "Quillathe", "Sariel", "Shanairra", "Shava",
          "Silaqui", "Theirastra", "Thia", "Vadania", "Valanthe", "Xanaphia"
        ],
        "Sir" => [
          "Amakiir (Gemflower)", "Amastacia (Starflower)",
          "Galanodel (Moonwhisper)", "Holimion (Diamonddew)",
          "Ilphelkiir (Gemblossom)", "Liadon (Silverfrond)",
          "Meliamne (Oakenheel)", "Naïlo (Nightbreeze)",
          "Siannodel (Moonbrook)", "Xiloscient (Goldpetal)"
        ]
      }
    },
    "Halfling" => {
      "Speed"            => 25,
      "AbilityIncreases" => { "Dexterity" => 2 },
      "Size"             => get_size(2.8..3.3, 11..14),
      "Subraces" => {
        "Lightfoot Halfling" => {
          "AbilityIncreases" => { "Charisma" => 1 }
        },
        "Stout Halfling" => {
          "AbilityIncreases" => { "Constitution" => 1 }
        }
      },
      "Names" => {
        "Male" => [
          "Alton", "Ander", "Cade", "Corrin", "Eldon", "Errich", "Finnan",
          "Garret", "Lindal", "Lyle", "Merric", "Milo", "Osborn", "Perrin",
          "Reed", "Roscoe", "Wellby"
        ],
        "Female" => [
          "Andry", "Bree", "Callie", "Cora", "Euphemia", "Jillian", "Kithri",
          "Lavinia", "Lidda", "Merla", "Nedda", "Paela", "Portia", "Seraphina",
          "Shaena", "Trym", "Vani", "Verna"
        ],
        "Sir" => [
          "Brushgather", "Goodbarrel", "Greenbottle", "High-hill", "Hilltopple",
          "Leagallow", "Tealeaf", "Thorngage", "Tosscobble", "Underbough"
        ]
      }
    },
    "Human" => {
      "Speed"            => 30,
      "Size"             => get_size(5.2..6.8, 24..30),
      "AbilityIncreases" => {
        "Strength"     => 1,
        "Dexterity"    => 1,
        "Constitution" => 1,
        "Intelligence" => 1,
        "Wisdom"       => 1,
        "Charisma"     => 1
      },
      "Names" => {
        "Male" => [
          "Aseir", "Bardeid", "Haseid", "Khemed", "Mehmen", "Sudeiman",
          "Zasheir", "Darvin", "Dorn", "Evendur", "Gorstag", "Grim", "Helm",
          "Malark", "Morn", "Randal", "Stedd", "Bor", "Fodel", "Glar", "Grigor",
          "Igan", "Ivor", "Kosef", "Mival", "Orel", "Pavel", "Sergor", "Ander",
          "Blath", "Bran", "Frath", "Geth", "Lander", "Luth", "Malcer", "Stor",
          "Taman", "Urth", "Aoth", "Bareris", "Ehput-Ki", "Kethoth", "Mumed",
          "Ramas", "So-Kehur", "Thazar-De", "Urhur", "Borivik", "Faurgar",
          "Jandar", "Kanithar", "Madislak", "Ralmevik", "Shaumar", "Vladislak",
          "An", "Chen", "Chi", "Fai", "Jiang", "Jun", "Lian", "Long", "Meng",
          "On", "Shan", "Shui", "Wen", "Anton", "Diero", "Marcon", "Pieron",
          "Rimardo", "Romero", "Salazar", "Umbero"
        ],
        "Female" => [
          "Atala", "Ceidil", "Hama", "Jasmal", "Meilil", "Seipora", "Yasheira",
          "Zasheida", "Arveene", "Esvele", "Jhessail", "Kerri", "Lureene",
          "Miri", "Rowan", "Shandri", "Tessele", "Alethra", "Kara", "Katernin",
          "Mara", "Natali", "Olma", "Tana", "Zora", "Amafrey", "Betha",
          "Cefrey", "Kethra", "Mara", "Olga", "Silifrey", "Westra", "Arizima",
          "Chathi", "Nephis", "Nulara", "Murithi", "Sefris", "Thola", "Umara",
          "Zolis", "Fyevarra", "Hulmarra", "Immith", "Imzel", "Navarra",
          "Shevarra", "Tammith", "Yuldra", "Bai", "Chao", "Jia", "Lei", "Mei",
          "Qiao", "Shui", "Tai", "Balama", "Dona", "Faila", "Jalana", "Luisa",
          "Marta", "Quara", "Selise", "Vonda"
        ],
        "Sir" => [
          "Basha", "Dumein", "Jassan", "Khalid", "Mostana", "Pashar", "Rein",
          "Amblecrown", "Buckman", "Dundragon", "Evenwood", "Greycastle",
          "Tallstag", "Bersk", "Chernin", "Dotsk", "Kulenov", "Marsk",
          "Nemetsk", "Shemov", "Starag", "Brightwood", "Helder", "Hornraven",
          "Lackman", "Stormwind", "Windrivver", "Ankhalab", "Anskuld", "Fezim",
          "Hahpet", "Nathandem", "Sepret", "Uuthrakt", "Chergoba", "Dyernina",
          "Iltazyara", "Murnyethara", "Stayanoga", "Ulmokina", "Chien", "Huang",
          "Kao", "Kung", "Lao", "Ling", "Mei", "Pin", "Shin", "Sum", "Tan",
          "Wan", "Agosto", "Astorio", "Calabra", "Domine", "Falone",
          "Marivaldi", "Pisacar", "Ramondo"
        ]
      }
    },
    "Dragonborn" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Strength" => 2, "Charisma" => 1 },
      "Size"             => get_size(6.2..7.5, 34..38),
      "Names" => {
        "Child" => [
          "Climber", "Earbender", "Leaper", "Pious", "Shieldbiter", "Zealous"
        ],
        "Male" => [
          "Arjhan", "Balasar", "Bharash", "Donaar", "Ghesh", "Heskan", "Kriv",
          "Medrash", "Mehen", "Nadarr", "Pandjed", "Patrin", "Rhogar",
          "Shamash", "Shedinn", "Tarhun", "Torinn"
        ],
        "Female" => [
          "Akra", "Biri", "Daar", "Farideh", "Harann", "Havilar", "Jheri",
          "Kava", "Korinn", "Mishann", "Nala", "Perra", "Raiann", "Sora",
          "Surina", "Thava", "Uadjit"
        ],
        "Sir" => [
          "Clethtinthiallor", "Daardendrian", "Delmirev", "Drachedandion",
          "Fenkenkabradon", "Kepeshkmolik", "Kerrhylon", "Kimbatuul",
          "Linxakasendalor", "Myastan", "Nemmonis", "Norixius",
          "Ophinshtalajiir", "Prexijandilin", "Shestendeliath", "Turnuroth",
          "Verthisathurgiesh", "Yarjerit"
        ]
      }
    },
    "Gnome" => {
      "Speed"            => 25,
      "AbilityIncreases" => { "Intelligence" => 2 },
      "Size"             => get_size(3.0..4.0, 9..12),
      "Subraces" => {
        "Forest Gnome" => {
          "AbilityIncreases" => { "Dexterity" => 1 }
        },
        "Rock Gnome" => {
          "AbilityIncreases" => { "Constitution" => 1 }
        }
      },
      "Names" => {
        "Male" => [
          "Alston", "Alvyn", "Boddynock", "Brocc", "Burgell", "Dimble", "Eldon",
          "Erky", "Fonkin", "Frug", "Gerbo", "Gimble", "Glim", "Jebeddo",
          "Kellen", "Namfoodle", "Orryn", "Roondar", "Seebo", "Sindri",
          "Warryn", "Wrenn", "Zook"
        ],
        "Female" => [
          "Bimpnottin", "Breena", "Caramip", "Carlin", "Donella", "Duvamil",
          "Ella", "Ellyjobell", "Ellywick", "Lilli", "Loopmottin", "Lorilla",
          "Mardnab", "Nissa", "Nyx", "Oda", "Orla", "Roywyn", "Shamil", "Tana",
          "Waywocket", "Zanna"
        ],
        "Sir" => [
          "Beren", "Daergel", "Folkor", "Garrick", "Nackle", "Murnig", "Ningel",
          "Raulnor", "Scheppen", "Timbers", "Turen"
        ],
        "Nicknames" => [
          "Aleslosh", "Ashhearth", "Badger", "Cloak", "Doublelock",
          "Filchbatter", "Fnipper", "Ku", "Nim", "Oneshoe", "Pock",
          "Sparklegem", "Stumbleduck"
        ]
      }
    },
    "Half-Elf" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Charisma" => 2 },
      "Size"             => get_size(5.2..6.8, 24..30),
      "CustomAbilities" => {
        "Limit"     => 2,
        "Abilities" => [
          "Strength", "Dexterity", "Constitution", "Intelligence", "Wisdom"
        ]
      },
      "Names" => {
        "Male" => [
        ],
        "Female" => [
        ],
        "Sir" => [
        ]
      }
    },
    "Half-Orc" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Strength" => 2, "Constitution" => 1 },
      "Size"             => get_size(5.2..6.8, 28..34),
      "Names" => {
        "Male" => [
          "Dench", "Feng", "Gell", "Henk", "Holg", "Imsh", "Keth", "Krusk",
          "Mhurren", "Ront", "Shump", "Thokk"
        ],
        "Female" => [
          "Baggi", "Emen", "Engong", "Kansif", "Myev", "Neega", "Ovak", "Ownka",
          "Shautha", "Sutha", "Vola", "Volen", "Yevelda"
        ],
        "Sir" => [
        ]
      }
    },
    "Tiefling" => {
      "Speed"            => 30,
      "AbilityIncreases" => { "Intelligence" => 1, "Charisma" => 2 },
      "Size"             => get_size(5.2..6.8, 24..30),
      "Names" => {
        "Male" =>  [
          "Akmenos", "Amnon", "Barakas", "Damakos", "Ekemon", "Iados", "Kairon",
          "Leucis", "Melech", "Mordai", "Morthos", "Pelaios", "Skamos", "Therai"
        ],
        "Female" => [
          "Akta", "Anakis", "Bryseis", "Criella", "Damaia", "Ea", "Kallista",
          "Lerissa", "Makaria", "Nemeia", "Orianna", "Phelaia", "Rieta"
        ],
        "Virtue" => [
          "Art", "Carrion", "Chant", "Creed", "Despair", "Excellence", "Fear",
          "Glory", "Hope", "Ideal", "Music", "Nowhere", "Open", "Poetry",
          "Quest", "Random", "Reverence", "Sorrow", "Temerity", "Torment",
          "Weary"
        ],
        "Sir" => [
        ]
      }
    }
  }
end
