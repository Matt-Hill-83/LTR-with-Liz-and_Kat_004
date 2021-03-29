local module = {}

module.questConfigs = {
    {
        questTitle = "330 Merlinda The Fairy Princess Part3",
        startSceneCoords = {col = 0, row = 0},
        endSceneCoords = {col = 1, row = 0},
        sceneConfigs = {
            {
                name = "swing",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Rori, I'm gonna get real with you."
                            },
                            {
                                char = "rori",
                                text = "We must free the dragons from Maldred's evil spell!"
                            }, {
                                char = "kat",
                                text = "Rori, do you like sparkles and glitter beyond your wildest dreams?"
                            },
                            {
                                char = "rori",
                                text = "Does it shimmer with the power of the dragon stone?"
                            },
                            {char = "kat", text = "Oh yes... Oh yes it does..."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "rori"}, {name = "vulcan01"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Now, will you help us steal the dress from the dragon Watta-Lee-Achee?"
                            }, {char = "rori", text = "What class?"},
                            {
                                char = "liz2",
                                text = "K2. No, wait... K1.  Um...  both?"
                            },
                            {
                                char = "rori",
                                text = "I wasn't asking your kindergarten class!"
                            },
                            {char = "rori", text = "What class dragon is it?"},
                            {char = "liz2", text = "Oh... yeah right."},
                            {char = "rori", text = "Never mind."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "rori"}, {name = "vulcan01"}}
                    }
                },
                coordinates = {col = 0, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "lake",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "rori",
                                text = "I think Watta-Lee-Achee is a class 2 lava dragon with a minor healing enchantment."
                            }, {char = "liz2", text = "Doo-Da-Lee-Doo"},
                            {char = "rori", text = "What?"},
                            {char = "kat", text = "Ignore her..."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "rori"}, {name = "vulcan01"}}
                    }, {
                        dialogs = {
                            {
                                char = "rori",
                                text = "Vulcan and I will battle Watta-Lee-Achee..."
                            },
                            {
                                char = "rori",
                                text = "...and free the Dress of Atacama once and for all!!!"
                            }, {char = "kat", text = "Thanks Rori!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "rori"}, {name = "vulcan01"}}
                    }, {
                        dialogs = {
                            {
                                char = "rori",
                                text = "I will join you on your Quest for the Dress!"
                            }, {char = "liz2", text = "thanks Rori!"},
                            {char = "rori", text = "I will join you..."},
                            {char = "rori", text = "...on your..."},
                            {char = "rori", text = "...Dress Quest!"},
                            {char = "liz2", text = "Doo-Da-Lee-Doo"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "rori"}, {name = "vulcan01"}}
                    }
                },
                coordinates = {col = 1, row = 0},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }
        },
        gridSize = {rows = 1, cols = 2}
    }, {
        questTitle = "015 - Kat and Liz Split Up.",
        startSceneCoords = {row = 0, col = 0},
        endSceneCoords = {col = 2, row = 0},
        sceneConfigs = {
            {
                name = "home",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "I see a bee..."},
                            {
                                char = "kat",
                                text = "If we split up, we can find vulcan faster."
                            },
                            {char = "liz2", text = "I see a bee...in a tree!"},
                            {char = "liz2", text = "Tee Hee Hee!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "bee"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Liz, that's not a bee!!!"},
                            {char = "liz2", text = "Come here little Bee! Bee!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "bee"}}
                    }
                },
                coordinates = {row = 0, col = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "stump",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "I'll go investigate that smoke down by the river..."
                            },
                            {
                                char = "kat",
                                text = "and you look in the village, by those burning rocks..."
                            }, {char = "liz2", text = "I see a pug..."},
                            {
                                char = "kat",
                                text = "Then meet back at the log later."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Liz, have you heard anything I just said?"
                            },
                            {char = "liz2", text = "I see a pug...and a mug!"},
                            {char = "kat", text = "Liiiiizzzzz!!!"},
                            {char = "liz2", text = "Ugggh!, yes Kat!"},
                            {
                                char = "liz2",
                                text = "Smoke, river, burning stores, yadda yadda... log."
                            }, {char = "liz2", text = "I'm in the zone Kat"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {col = 1, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "bog",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Give a girl some space when she's in the zone!"
                            }, {char = "kat", text = "What zone?"},
                            {char = "liz2", text = "The rhyming zone."},
                            {
                                char = "liz2",
                                text = "It's like everything is just clicking into place."
                            },
                            {char = "kat", text = "Oh yeah, bust some rhymes!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Put A Cat A"},
                            {char = "kat", text = "Put A Cat A"},
                            {char = "liz2", text = "My name is Liz!"},
                            {char = "liz2", text = "It starts with an L."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Let's go and play with goblin"
                            }, {char = "liz2", text = "At the wishing well."},
                            {char = "kat", text = "Fresh!!!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {col = 2, row = 0},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }
        },
        gridSize = {rows = 1, cols = 3}
    }, {
        questTitle = "200 - Dennis the Menace",
        startSceneCoords = {row = 0, col = 0},
        endSceneCoords = {row = 0, col = 2},
        sceneConfigs = {
            {
                name = "home",
                frames = {
                    {
                        dialogs = {
                            {char = "dog01", text = "Yo, what’s up Kat?"},
                            {
                                char = "kat",
                                text = "Nothin’ dog. Just chillin with my girl Liz."
                            }, {
                                char = "dog01",
                                text = "Sweet! Keep it Fresh Kat! I gotta bounce. I’ll catch you on the flip!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dog01"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Laters!"},
                            {char = "liz2", text = "Bye Bye Pete! Hee Hee!"}, {
                                char = "liz2",
                                text = "Wow Kat, where did you learn all those cool things to say?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Cool right? It’s called slang."
                            }, {char = "liz2", text = "Wow! I want to learn!"},
                            {
                                char = "kat",
                                text = "I used to ride the bus with this second grader who knew like a million slangs. Like literally."
                            }, {char = "liz2", text = "Cooooool!!!!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "He’d say Kat, I like you, but sometimes, think you are a couple sandwiches short of a picnic."
                            },
                            {
                                char = "liz2",
                                text = "Cooooool! What does that mean?"
                            },
                            {
                                char = "kat",
                                text = "I dunno, but I say it all the time now."
                            },
                            {
                                char = "liz2",
                                text = "Wait, you know a second grader?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }
                },
                coordinates = {row = 0, col = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "log",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Yeah, this kid Dennis. He’s hilarious."
                            }, {
                                char = "kat",
                                text = "This one time he made me laugh so hard chocolate milk sprayed out of my nose."
                            },
                            {
                                char = "liz2",
                                text = "Wait.. Hold your horses. Back up!"
                            }, {char = "liz2", text = "What?"}, {
                                char = "liz2",
                                text = "Are you talking about Dennis, as in, Dennis the Menace?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Yeah, that’s him."},
                            {
                                char = "liz2",
                                text = "You know Dennis the Menace?"
                            }, {
                                char = "liz2",
                                text = "The kid who runs up slides the wrong way and has a slingshot hanging out of his back pocket?"
                            }, {
                                char = "kat",
                                text = "Yeah, totally. He’s super chill. We should go hang out with him."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "He is like the coolest kid in the Magic Forest!"
                            }, {char = "kat", text = "For sure."}, {
                                char = "liz2",
                                text = "Zombie said his parents grounded him until he turns 13!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Wait, What does grounded mean?"
                            }, {
                                char = "liz2",
                                text = "Oh sorry. Grounded is when you get in super big trouble and your parents don’t let you out of your room for a week!"
                            },
                            {
                                char = "kat",
                                text = "Oh that. Yeah, he’s definitely grounded."
                            }, {
                                char = "kat",
                                text = "But he sneaks out his bedroom window during nap and plays at the playground."
                            }, {char = "liz2", text = "Wow!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Come on, let’s go see if he is at the slide."
                            }, {char = "liz2", text = "Fine with me."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }
                },
                coordinates = {col = 1, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "slide",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "Hi Dennis!"},
                            {
                                char = "dennisTheMenace",
                                text = "Oh hi Kat! What are you up to?"
                            }, {char = "liz2", text = "Just some trouble."}, {
                                char = "dennisTheMenace",
                                text = "Count me in. But keep an eye out for Mr. Wilson."
                            }, {
                                char = "dennisTheMenace",
                                text = "He's not going to be too happy when he finds out what happened to his new shoes!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dennisTheMenace"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "What happened to his new shoes?"
                            }, {
                                char = "dennisTheMenace",
                                text = "You don't even want to know. Where's the fun at?"
                            }, {
                                char = "kat",
                                text = "Well, there's this new girl named Rori. She needs a place to hide her dragon."
                            },
                            {
                                char = "dennisTheMenace",
                                text = "Well now you are talking my language."
                            }, {
                                char = "dennisTheMenace",
                                text = "Have I ever told you about Mr. Wilson's shed?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dennisTheMenace"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Keep talking..."}, {
                                char = "dennisTheMenace",
                                text = "It's dustier than a book of manners in a schoolyard, but it might to the trick."
                            },
                            {
                                char = "kat",
                                text = "We will pass that along to Rori."
                            }, {
                                char = "liz2",
                                text = "Dennis, do you have a piece of paper and a pin? Rori said to pin a note to a tree."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dennisTheMenace"}}
                    }, {
                        dialogs = {
                            {
                                char = "dennisTheMenace",
                                text = "I have a ball of lint and this thumb tack, but I'm saving it to make a surprise for Mr. Wilson."
                            }, {char = "liz2", text = "Lucky him!"}, {
                                char = "dennisTheMenace",
                                text = "Yeah, he must have been born under a 4 leaf clover."
                            },
                            {
                                char = "liz2",
                                text = "See you later Dennis the Menace! Hee Hee Hee!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dennisTheMenace"}}
                    }
                },
                coordinates = {row = 0, col = 2},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }
        },
        gridSize = {rows = 1, cols = 3}
    }, {
        questTitle = "020 - Rap Battle at Troll Cave",
        startSceneCoords = {row = 0, col = 0},
        endSceneCoords = {row = 0, col = 3},
        sceneConfigs = {
            {
                name = "cave",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "katieKooper01",
                                text = "Yay, we are just in time for the rap battle"
                            },
                            {char = "kat", text = "Cool! What's a rap battle?"},
                            {char = "katieKooper01", text = "I don't know."},
                            {char = "katieKooper01", text = "Let's find out!."}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "The trolls don't know we stole the diamond. So just act cool."
                            },
                            {
                                char = "katieKooper01",
                                text = "What! We STOLE the DIAMOND?"
                            }, {char = "kat", text = "Shhhhhhhhhhh!"},
                            {char = "troll01", text = "LOOK GIRLS!"},
                            {char = "troll02", text = "GIRLS TAKE DIAMOND?"},
                            {char = "troll01", text = "TROLLS EAT GIRLS!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}, {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "What? Who? Me? Don't be silly. We hate diamonds!"
                            },
                            {
                                char = "katieKooper01",
                                text = "What? Kat, we love diamonds!!!"
                            }, {char = "kat", text = "Katie!!!!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}, {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Oh hello trolls. We are not here to take your diamond."
                            },
                            {
                                char = "kat",
                                text = "We are here for....ummmm.... uuuuuhhhh..."
                            },
                            {
                                char = "kat",
                                text = "Katie! Think of something quick!"
                            },
                            {
                                char = "katieKooper01",
                                text = "We're here for the rap battle!"
                            }, {char = "kat", text = "Good save Katie Kooper!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}, {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "My friend Kat here is going to show you trolls how to rap!"
                            }, {char = "kat", text = "Katie!!!!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}, {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {char = "troll01", text = "RAP BATTLE!"},
                            {char = "troll02", text = "RAP BATTLE!"},
                            {
                                char = "kat",
                                text = "Katie? What in the world are you getting us into."
                            },
                            {
                                char = "katieKooper01",
                                text = "Chill out Kat, it's fine."
                            },
                            {
                                char = "katieKooper01",
                                text = "Just do the rap about the frog on the log."
                            }, {char = "kat", text = "The frog on the log?!?"},
                            {
                                char = "kat",
                                text = "Yeah. The one you did this morning! That was hilarious!"
                            }
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}, {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Ugggghhh! Katie! That was not a rap!"
                            },
                            {
                                char = "kat",
                                text = "This morning, I literally, saw a frog on a log."
                            },
                            {
                                char = "katieKooper01",
                                text = "That was so funny! You had me dying!"
                            }, {char = "kat", text = "Katie!!!!"},
                            {
                                char = "kat",
                                text = "Stop Talking! For the first time in your life!"
                            },
                            {
                                char = "kat",
                                text = "Listen to me very closely. There is no rap."
                            }
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}, {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {char = "kat", text = "This morning..."},
                            {char = "kat", text = "I SAW A FROG..."},
                            {char = "troll01", text = "GIRL SAW FROG???"},
                            {char = "kat", text = "...ON A LOG!"},
                            {char = "troll02", text = "FROG ON LOG!"},
                            {char = "troll01", text = "HA! HA! HOO! HOO!"},
                            {char = "troll01", text = "TROLL LIKE FROG!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}, {name = "empty"}
                        }
                    }
                },
                coordinates = {row = 0, col = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "bog",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "And I'm NOT gonna RAP."},
                            {char = "kat", text = "It's just a silly fad."},
                            {char = "kat", text = "You think your day was bad?"},
                            {
                                char = "kat",
                                text = "Well let me tell you trolls about the day I've had."
                            }, {char = "troll01", text = "FROG ON LOG!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {char = "kat", text = "First we saw a frog"},
                            {char = "kat", text = "The frog was on a log."},
                            {char = "kat", text = "Then there was this dog..."},
                            {
                                char = "kat",
                                text = "...stuck in a bog wearing clogs!"
                            }, {char = "troll01", text = "TROLL LIKE BOG!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {char = "kat", text = "Me and Liz took a walk."},
                            {char = "kat", text = "First we see a mop."},
                            {char = "kat", text = "Then there was this top?"},
                            {char = "kat", text = "Right next to a cop"},
                            {
                                char = "kat",
                                text = "with a frog on a log, drinking pop!"
                            }, {char = "troll01", text = "HA! HA! HOO! HOO!"},
                            {char = "troll02", text = "FROGGY LIKE POP!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "So quit squishin all the fish and sit and listen!"
                            },
                            {
                                char = "kat",
                                text = "Cause I'm the kinda kid that makes the grown ups stop."
                            },
                            {
                                char = "kat",
                                text = "And yell= Honey! Hide the keys to the donut shop!"
                            }, {char = "troll01", text = "DONUT SHOP!"},
                            {
                                char = "kat",
                                text = "You trolls like the Donut Shop?"
                            }, {char = "troll21", text = "DONUT SHOP!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }
                },
                coordinates = {col = 1, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "swamp",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "My parents groan a lot."}, {
                                char = "kat",
                                text = "You hear that rumble? That's my tummy from the soda pop."
                            }, {char = "kat", text = "Call the doc!"},
                            {
                                char = "kat",
                                text = "So we can ask if I'll explode or not!"
                            },
                            {
                                char = "kat",
                                text = "I check my phone a lot, but it won't unlock!"
                            },
                            {
                                char = "kat",
                                text = "Yeah, it's bark, just wait. I'll get it Photoshopped."
                            }
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "I'll see you at my birthday when corona stops."
                            },
                            {
                                char = "kat",
                                text = "And when the party starts rockin..."
                            },
                            {
                                char = "kat",
                                text = "That's just me and Liz squawkin..."
                            },
                            {
                                char = "kat",
                                text = "Like 2 sea gulls that got locked in-"
                            }, {char = "kat", text = "side a donut shop."},
                            {char = "troll01", text = "DONUT SHOP!"}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "They said this was a battle, but you Trolls don't bloop."
                            }, {
                                char = "kat",
                                text = "Fellas, I'm about to tell a troll the stone cold truth."
                            },
                            {
                                char = "kat",
                                text = "Here's some cold stone soup."
                            }, {char = "kat", text = "In an old sewn shoe."}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "And wait, here's a bone for your pooch too!"
                            },
                            {
                                char = "kat",
                                text = "Little kid, you want a cold cone for your loose tooth?"
                            }, {
                                char = "kat",
                                text = "And here's some goop for the hole in your boot where your big hairy toes poke through."
                            }, {
                                char = "kat",
                                text = "And you two. You don't bloop? You ever heard of youTube?"
                            }, {char = "troll01", text = "We don't do it..."},
                            {char = "troll02", text = "...it's too new."}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }
                },
                coordinates = {col = 2, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }, {
                name = "hill",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "Blip Bleep Bloop."},
                            {char = "kat", text = "Flap Flop Floop, Flizz."}
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {char = "kat", text = "I like you trolls a lot"},
                            {char = "kat", text = "But I gotta find Liz."},
                            {char = "troll01", text = "Bye Bye!"},
                            {char = "troll02", text = "See you soon!"},
                            {
                                char = "troll01",
                                text = "Hope you have a nice trip!"
                            }
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "katieKooper01",
                                text = "Kat, you won the Rap battle!"
                            }, {char = "kat", text = "What's a rap battle?"},
                            {
                                char = "kat",
                                text = "Um.... Never mind. Let's go find Liz!"
                            },
                            {
                                char = "troll01",
                                text = "Baby troll wants to come with you."
                            },
                            {
                                char = "kat",
                                text = "Oh dear. Oh no no no no no... come on Matt!"
                            },
                            {
                                char = "katieKooper01",
                                text = "Cuuu----uuuute! OK!"
                            },
                            {
                                char = "kat",
                                text = "Think about pretty dresses Katie. Pretty Dresses!"
                            }
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "troll01",
                                text = "Here is baby troll's diaper pin."
                            }, {
                                char = "kat",
                                text = "Oh no, it's sundown and we don't have the magical stone of Azkabat."
                            },
                            {
                                char = "katieKooper01",
                                text = "It's actually part of the diaper pin"
                            }
                        },
                        characters01 = {{name = "kat"}},
                        characters02 = {
                            {name = "katieKooper01"}, {name = "troll01"},
                            {name = "troll02"}
                        }
                    }
                },
                coordinates = {row = 0, col = 3},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 3
            }
        },
        gridSize = {rows = 1, cols = 4}
    }, {
        questTitle = "010 - Troll So Sad",
        startSceneCoords = {col = 0, row = 0},
        endSceneCoords = {col = 4, row = 0},
        sceneConfigs = {
            {
                name = "pond",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "I see a frog."},
                            {char = "liz2", text = "I see a frog... on a log."},
                            {char = "liz2", text = "Tee Hee Hee!"},
                            {
                                char = "kat",
                                text = "Wow Liz, you have good eyes!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "I see a pig."},
                            {char = "liz2", text = "I see a pig... in a wig!"},
                            {char = "liz2", text = "Tee Hee Hee!"},
                            {
                                char = "kat",
                                text = "Liz, could we maybe talk about something else today?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "I see a goat."},
                            {char = "liz2", text = "I see a goat... in a boat!"},
                            {char = "kat", text = "Oh my gosh Kat! Turn six!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "What'evs girl... I turned six when you were still riding a trycicle."
                            }, {
                                char = "kat",
                                text = "Ha! Good one! Well, I turned six when you were still wearing Sponge Bob training pants!"
                            }, {
                                char = "liz2",
                                text = "Oh yeah, well your mom still drives you around in a backwards car seat!"
                            },
                            {
                                char = "kat",
                                text = "Oh snap! That’s a good one!"
                            },
                            {
                                char = "kat",
                                text = "I’m going to drop that one on the Troll later!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {col = 0, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "bog",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "The Troll?"},
                            {
                                char = "liz2",
                                text = "Do you mean the 'TROLL NEEDS GOLD' Troll?"
                            },
                            {char = "liz2", text = "What’s up with that guy?"},
                            {
                                char = "kat",
                                text = "I know, right? He’s the coolest!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Yeah, totally..."},
                            {char = "liz2", text = "...but, I don’t get it."},
                            {char = "liz2", text = "What’s his deal?"},
                            {
                                char = "liz2",
                                text = "Why does he always yell= 'TROLL NEED GOLD'?"
                            },
                            {char = "liz2", text = "It’s a valid question."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Really Liz?"}, {
                                char = "kat",
                                text = "Are you seriously asking me why the Troll runs around yelling= 'TROLL NEED GOLD'?"
                            }, {char = "liz2", text = "Yes!"},
                            {char = "kat", text = "You’re not kidding?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {col = 1, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "bees",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Well, I think he’s saying it because he needs gold."
                            },
                            {
                                char = "liz2",
                                text = "Um, yeah. Thanks Albert Einstein."
                            }, {char = "liz2", text = "I get that part."},
                            {char = "kat", text = "Oh."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "I understand that he is literally asking for gold."
                            }, {char = "liz2", text = "I'm six. Remember?"},
                            {char = "kat", text = "Ok."},
                            {char = "liz2", text = "But why does he need gold?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Elliot says he doesn't ~need~ gold."
                            },
                            {
                                char = "liz2",
                                text = "The troll probably just ~wants~ gold."
                            },
                            {
                                char = "kat",
                                text = "Wait, is that the kid that says="
                            },
                            {
                                char = "kat",
                                text = "You get what you get and you don't get upset?"
                            }, {char = "kat", text = "Well, I get upset!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Getting upset is my thing!"},
                            {char = "liz2", text = "Calm down Kat."},
                            {
                                char = "kat",
                                text = "Getting upset is my happy place!"
                            },
                            {
                                char = "liz2",
                                text = "Kat, no one is trying to take away your crazy."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {col = 2, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }, {
                name = "swamp",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "But the Troll... What’s his back story?"
                            },
                            {char = "kat", text = "Liz!!!! Noooooooooooo!!!!"},
                            {char = "liz2", text = "Huh?"},
                            {char = "kat", text = "No! No! No! No! No!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "What?"},
                            {char = "kat", text = "Undo! Undo!"},
                            {
                                char = "liz2",
                                text = "Kat, today is not your day to be crazy."
                            }, {char = "liz2", text = "We need to take turns."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Liz, never... ever... ever..."
                            },
                            {
                                char = "kat",
                                text = "...ask for a creature's backstory"
                            },
                            {
                                char = "kat",
                                text = "That's like Rule Number One!"
                            }, {
                                char = "liz2",
                                text = "I thought 'Never stand behind a donkey' was Rule Number One..."
                            }, {char = "kat", text = "Liiiiiiizzzz!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "You asked about the troll's back story."
                            }, {char = "liz2", text = "So?"}, {
                                char = "kat",
                                text = "Now Matt is going to do some loooooong story about the troll."
                            },
                            {
                                char = "kat",
                                text = "Remember how distracted he gets?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Wait, what's a back story?"},
                            {
                                char = "kat",
                                text = "It's a story that tells where the creature came from."
                            }, {char = "kat", text = "What's it's name?"},
                            {char = "kat", text = "Where does it live?"},
                            {
                                char = "kat",
                                text = "Did it have a happy child hood?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Cool!"},
                            {char = "kat", text = "No! Not cool!"},
                            {char = "kat", text = "The opposite of cool!"},
                            {char = "liz2", text = "Warm?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Liz, we are trying to find the that sparkly dress!"
                            },
                            {char = "kat", text = "Remember... 'Dress Quest'?"},
                            {
                                char = "kat",
                                text = "I don't even think that's the name of this game anymore."
                            }, {char = "liz2", text = "It's not."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {col = 3, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 3
            }, {
                name = "log",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "My point exactly!!!"},
                            {
                                char = "liz2",
                                text = "I think it's Rapping Troll Cave."
                            },
                            {char = "kat", text = "Oh no... here it comes..."},
                            {
                                char = "liz2",
                                text = "Hey look! There's the troll."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "troll01"}, {name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "I didn't see him there before."
                            }, {char = "kat", text = "Oh dear..."},
                            {
                                char = "liz2",
                                text = "I swear he wasn't there 3 seconds ago."
                            }, {char = "liz2", text = "Hello Troll."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "troll01"}, {name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "troll2",
                                text = "TROLL.... SOOOOOO..... SAD..."
                            },
                            {char = "liz2", text = "Oh my goodness! Why...?"},
                            {char = "troll2", text = "BOO HOO!"},
                            {char = "kat", text = "Oh brother..."},
                            {
                                char = "troll2",
                                text = "TODAY.... TROLL BIRTHDAY..."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "troll01"}, {name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "You poor thing!"},
                            {
                                char = "troll2",
                                text = "TROLL WANT FROOT LOOPS!!!"
                            }, {char = "liz2", text = "Oh my gosh... so sad."},
                            {
                                char = "troll2",
                                text = "TROLL MOM NOT LIKE SUGAR!!!"
                            }, {char = "liz2", text = "I'm so sorry..."},
                            {char = "kat", text = "We gotta go. Bye! Bye!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "troll01"}, {name = "empty"}}
                    }
                },
                coordinates = {col = 4, row = 0},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 4
            }
        },
        gridSize = {rows = 1, cols = 5}
    }, {
        questTitle = "005 - Kat Calls the Whaaa-mbulance",
        startSceneCoords = {col = 0, row = 0},
        endSceneCoords = {row = 0, col = 2},
        sceneConfigs = {
            {
                name = "bog",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "It's not fair!"},
                            {char = "kat", text = "What's not fair?"},
                            {char = "liz2", text = "Nothing is fair!"},
                            {
                                char = "kat",
                                text = "Oh dear! You poor thing...  Wait hold on..."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "What are you doing?"},
                            {
                                char = "kat",
                                text = "Just a sec liz.  I'm making a call."
                            }, {
                                char = "liz2",
                                text = "Kat, that's not a phone, it's a piece of bark that you just picked up off the ground."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Beep boop beep boop beep beep boop..."
                            },
                            {
                                char = "kat",
                                text = "Hello, operator, please send over the wha-mulance!"
                            }, {char = "kat", text = "Yes it's Liz again."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }
                },
                coordinates = {col = 0, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "swing",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "Yes I'll hold."}, {
                                char = "kat",
                                text = "No I don't want to participate in a short survey after the call."
                            }, {
                                char = "kat",
                                text = "What? Oh great!  Liz, they are sending the Wham-bulance over immediately."
                            },
                            {
                                char = "kat",
                                text = "Oh what's that?  You have a message for liz?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "Kat",
                                text = "Liz, the wha-mbulance people have a message for you!"
                            }, {char = "liz2", text = "Kat you are not funny!"},
                            {
                                char = "kat",
                                text = "Whats that?  Tell her to turn six?"
                            },
                            {
                                char = "kat",
                                text = "Oh what? And also stop being a bad frog?"
                            }, {
                                char = "kat",
                                text = "Yeah I'll pass that along to her and see what she says."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }
                },
                coordinates = {row = 0, col = 1},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "stump",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "You have a good day too."},
                            {char = "kat", text = "Mmmm-bye"},
                            {char = "kat", text = "Waaa-wer! Waaa-wer!"},
                            {
                                char = "kat",
                                text = "Liz, I just got off the phone with --"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "STOP IT!"},
                            {char = "liz2", text = "Kat, you are a BAD FROG!!!"},
                            {char = "liz2", text = "BAD FROGGY!!!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }
                },
                coordinates = {row = 0, col = 2},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }
        },
        gridSize = {rows = 1, cols = 3}
    }, {
        questTitle = "100 - Liz Goes Crazy",
        startSceneCoords = {col = 0, row = 0},
        endSceneCoords = {row = 0, col = 2},
        sceneConfigs = {
            {
                name = "cave",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Kat, I’m so glad you are here. Look!  Quick!  Look in the sky!"
                            }, {char = "kat", text = "ok."},
                            {
                                char = "liz2",
                                text = "And just sort of stare right at that cloud."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "But don’t stare with your eyes."
                            }, {char = "kat", text = "Huh?"}, {
                                char = "liz2",
                                text = "Just sort of stare with your brain, but in that direction."
                            }, {char = "kat", text = "Ummmm... ok."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Do you see the kid?  Do you see the kid up there?"
                            }, {char = "kat", text = "No."},
                            {
                                char = "liz2",
                                text = "In that cloud.  Right there."
                            }, {
                                char = "liz2",
                                text = "Look straight ahead. There is a kid staring right at us."
                            }, {char = "kat", text = "...uhhh...Still no...."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {col = 0, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "bees",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "And any time I say anything… anything at all, she says it at the same time."
                            },
                            {
                                char = "kat",
                                text = "Liz, I don’t see anything."
                            },
                            {
                                char = "liz2",
                                text = "She’s doing it.  She’s doing it right now!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Liz, as your best friend, I need be totally honest with you."
                            }, {char = "liz2", text = "I can see her!"},
                            {
                                char = "kat",
                                text = "Look, I’ve been doing crazy since I was this tall."
                            }, {char = "kat", text = "So I kind of know crazy."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "But the kind of crazy I do is more screaming-in-Target kind of crazy."
                            }, {
                                char = "kat",
                                text = "The kind of crazy you are doing now is more like be-buh-dee-dee-dee-dee kind of crazy."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Kat!  I am not crazy!"},
                            {char = "kat", text = "Ok."},
                            {char = "liz2", text = "I am not regular crazy!"},
                            {
                                char = "liz2",
                                text = "I am not be-buh-dee-dee-dee-dee crazy."
                            }, {char = "kat", text = "Ok"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "I am perfectly normal!"},
                            {char = "kat", text = "Um….check please!"},
                            {char = "liz2", text = "I’m not crazy!"},
                            {
                                char = "kat",
                                text = "Liz, you are going just a little bit hay wire!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {row = 0, col = 1},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "bog",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Just watch Kat!  I’ll make her talk."
                            },
                            {
                                char = "liz2",
                                text = "I can make her say anything I want."
                            }, {char = "kat", text = "ok."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Loo Loo. Laa Laa. Fee Fi Fo Fum!"
                            },
                            {
                                char = "liz2",
                                text = "You heard her right Kat?  You can see her too, right?"
                            },
                            {
                                char = "kat",
                                text = "Ummm... Are we playing pretend?"
                            },
                            {
                                char = "liz2",
                                text = "Look at meeeeeeeeeeeee! I am a giant banana!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "I am the banana queen!"},
                            {char = "kat", text = "How about we go to the log?"},
                            {char = "liz2", text = "Me eat all the bananas!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {}
                    }
                },
                coordinates = {row = 0, col = 2},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }
        },
        gridSize = {rows = 1, cols = 3}
    }, {
        questTitle = "110 - Liz Bloops",
        startSceneCoords = {row = 0, col = 0},
        endSceneCoords = {col = 2, row = 0},
        sceneConfigs = {
            {
                name = "cave",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "bleepity, bling blang blip blop!"
                            }, {char = "kat", text = "Hi liz. What's up?"},
                            {
                                char = "liz2",
                                text = "Oh hey Kat, what's blanging?"
                            },
                            {
                                char = "kat",
                                text = "Wow Liz! Did you make that up?"
                            }, {
                                char = "liz2",
                                text = "Yeah, I've been saying it all day. And check this out="
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Blip Blorp Bloop."},
                            {
                                char = "liz2",
                                text = "Piddle-dee. Widdle-dee. Diddle-dee."
                            },
                            {char = "liz2", text = "Plippity Ploppity plump."},
                            {char = "kat", text = "Whoa, that's sooooo cool!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "I know, right? Its called blooping."
                            }, {char = "liz2", text = "I made that up too."},
                            {char = "kat", text = "I gotta try this!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {row = 0, col = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "bog",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "chugga... chugga... chugga.. chugga.. choo-choo!"
                            }, {char = "liz2", text = "rickety! rockety!"},
                            {char = "kat", text = "pickety! pockety!"},
                            {char = "liz2", text = "Dimple Dee Doop!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "rori"}, {name = "vulcan01"},
                            {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "rori",
                                text = "Run for the hills! Maldred has the Dragon Stone --"
                            }, {char = "kat", text = "plip plop!"},
                            {char = "liz2", text = "Dimple Dee Dip!"},
                            {
                                char = "rori",
                                text = "Wait! What are those noises?"
                            }, {char = "rori", text = "It must be Maldred..."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "rori"}, {name = "vulcan01"},
                            {name = "empty"}
                        }
                    }
                },
                coordinates = {col = 1, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "log",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "We are blooping!"},
                            {char = "liz2", text = "Hee Hee!"},
                            {char = "rori", text = "Oh. Cool!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "rori"}, {name = "vulcan"}, {name = "empty"}
                        }
                    }, {
                        dialogs = {
                            {char = "kat", text = "plip plop!"},
                            {char = "liz2", text = "Dimple Dee Dip!"},
                            {
                                char = "rori",
                                text = "Vulcan can bloop better than any one!"
                            }, {char = "kat", text = "cool"},
                            {char = "vulcan", text = "BLEEEEEEP!!!!!!!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "rori"}, {name = "vulcan"}, {name = "empty"}
                        }
                    }
                },
                coordinates = {col = 2, row = 0},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }
        },
        gridSize = {rows = 1, cols = 3}
    }, {
        questTitle = "310 - Kat Gets Real With Rori About the Dress",
        startSceneCoords = {row = 0, col = 0},
        endSceneCoords = {row = 0, col = 2},
        sceneConfigs = {
            {
                name = "cave",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Well, if princesss have so much gold, can't they just buy any dress they want?"
                            }, {
                                char = "liz2",
                                text = "Oh they do.  They sure do.  They buy EVERY dress they want."
                            },
                            {
                                char = "kat",
                                text = "Sooooo.....what's the problem?"
                            }
                        },
                        characters01 = {},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "The problem...my dear, is that some dresses are not for sale."
                            },
                            {
                                char = "liz2",
                                text = "And those are the only dresses that a princess wants."
                            }
                        },
                        characters01 = {},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Keep talking."},
                            {
                                char = "liz2",
                                text = "Have you heard of Watta-Lee-Achee?"
                            }, {char = "kat", text = "Nope."}, {
                                char = "liz2",
                                text = "She's a Dragon that lives in that empty castle by the Silver Bog."
                            }
                        },
                        characters01 = {},
                        characters02 = {}
                    }
                },
                coordinates = {row = 0, col = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "bog",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "Cool..."},
                            {
                                char = "liz2",
                                text = "And this dragon, Watta-Lee-Achee..."
                            }, {char = "kat", text = "Doo-Da-Lee-Doo"},
                            {char = "liz2", text = "What?"}
                        },
                        characters01 = {},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Nothing"},
                            {
                                char = "liz2",
                                text = "Watta-Lee-Achee guards the dress of Atacama."
                            },
                            {
                                char = "liz2",
                                text = "It's the most dazzling dress in 7 kingdoms."
                            }, {char = "kat", text = "Holy Moly!"}
                        },
                        characters01 = {},
                        characters02 = {}
                    }
                },
                coordinates = {col = 1, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "swamp",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "It glimmers and it shimmers."
                            },
                            {
                                char = "liz2",
                                text = "It shines like a thousand suns."
                            }, {
                                char = "kat",
                                text = "We need to go get it.  And trade it with the princesses for gold!"
                            }
                        },
                        characters01 = {},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Ummm...hello? Kat, are you even listening to me?"
                            },
                            {
                                char = "liz2",
                                text = "There is a girl-eating dragon guarding that dress!"
                            }
                        },
                        characters01 = {},
                        characters02 = {}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Well we have something even scarier than that Dragon."
                            },
                            {char = "kat", text = "We have the Queen of Crazy."},
                            {
                                char = "kat",
                                text = "Come on.  Let's go find Rori."
                            }, {char = "liz2", text = "But where?"},
                            {char = "kat", text = "Look for fire."}
                        },
                        characters01 = {},
                        characters02 = {}
                    }
                },
                coordinates = {row = 0, col = 2},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }
        },
        gridSize = {rows = 1, cols = 3}
    }, {
        questTitle = "013 - Chocolate Milk",
        startSceneCoords = {row = 0, col = 0},
        endSceneCoords = {row = 0, col = 5},
        sceneConfigs = {
            {
                name = "swing",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Wait, your parents let you drink chocolate milk?"
                            }, {char = "kat", text = "Yeah, do yours?"},
                            {
                                char = "liz2",
                                text = "Um heck no! Most certainly not!"
                            },
                            {
                                char = "liz2",
                                text = "Wait! How have you never told me this?"
                            }, {
                                char = "kat",
                                text = "I thought everyone’s parents let them drink chocolate milk."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Oh please! My parents are like the sugar police."
                            }, {char = "kat", text = "Wow!"},
                            {
                                char = "liz2",
                                text = "Can we go over to your house and drink some?"
                            }, {
                                char = "kat",
                                text = "I wish. My big brother drank it all. He’s a total milk-hog."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {row = 0, col = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "bees",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Oh rats! You are so lucky though! My mom says sugar rots your teeth."
                            },
                            {
                                char = "kat",
                                text = "Really? I thought that was cotton candy."
                            },
                            {
                                char = "liz2",
                                text = "Yup, she read it on the internet."
                            },
                            {
                                char = "kat",
                                text = "Oh brother! Good luck with that."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "I know. Right?"}, {
                                char = "kat",
                                text = "Hey have you ever heard of Marshmallow Fluff? My cousin Emily eats it. She showed me on Facetime."
                            },
                            {char = "liz2", text = "Sounds cool! What is it?"},
                            {
                                char = "kat",
                                text = "It’s like that Gloop that we made in summer camp."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "But you can eat it and it tastes like fairy magic."
                            },
                            {
                                char = "kat",
                                text = "You'll never want to eat real food again."
                            },
                            {char = "liz2", text = "We have to go to Boston!"},
                            {char = "kat", text = "I know! For real!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {row = 0, col = 1},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "log",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Hey, do you still have that Gloop we made?"
                            }, {
                                char = "liz2",
                                text = "Sadly no. Mine grew green fuzz on it and we threw it in the compost."
                            }, {
                                char = "kat",
                                text = "Cool! That’s like something out of Zoe and Sassafras!"
                            },
                            {
                                char = "liz2",
                                text = "I know, I should have done some experiments with it."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "If you are Zoe, does that make me Sassafras?"
                            }, {
                                char = "liz2",
                                text = "Yeah, you sit on my shoulder and talk in a made up language that only kids can understand."
                            }, {
                                char = "kat",
                                text = "That’s not how Sassafrass talks. You’re thinking of Stick from TumbleLeaf."
                            }, {char = "liz2", text = "No I’m not."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {row = 0, col = 2},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 2
            }, {
                name = "pool",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Well then, Pascal from Tangled."
                            }, {
                                char = "liz2",
                                text = "Uh uh. Hello? I’m six years old, I think I know my TV shows."
                            }, {
                                char = "kat",
                                text = "Oh please! I’ve watched 10 times more TV than you have."
                            },
                            {
                                char = "liz2",
                                text = "Sister, Don’t even go there! Name five Octonauts."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Oh is this what we are doing now? Fine. Bring it. Kwazii, Barnacles, Dashi, Tunip and Professor Inkling."
                            }, {
                                char = "liz2",
                                text = "Who is Kwazaii’s grandfather and where does he live?"
                            },
                            {
                                char = "kat",
                                text = "Trick question. He’s the pirate Calico Jack."
                            },
                            {
                                char = "kat",
                                text = "But no one knows if he is still alive."
                            }, {
                                char = "kat",
                                text = "Because Kwazaii’s adventure up the Amazon River was just a dream."
                            },
                            {
                                char = "liz2",
                                text = "Dang Kat! You’ve got skills!"
                            },
                            {
                                char = "liz2",
                                text = "You can really throw down TV."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {col = 3, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 3
            }, {
                name = "stump",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Yeah, my cousins figured the password to their mom’s ipad."
                            }, {char = "liz2", text = "What?"},
                            {
                                char = "kat",
                                text = "We watched like every show on Netflix."
                            }, {char = "liz2", text = "But....how?"},
                            {
                                char = "kat",
                                text = "Get this... her password was Emily’s birthday."
                            },
                            {
                                char = "liz2",
                                text = "Oh man! I wish I had parents like that!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "I know! That’s like on page 1 of the Kid Book."
                            },
                            {
                                char = "kat",
                                text = "She must be a first time parent..."
                            }, {
                                char = "kat",
                                text = "Anyways, I’m sorry to be the one to tell you this, but Sassafrass talks like a regular normal cat."
                            }, {char = "liz2", text = "No way."},
                            {
                                char = "kat",
                                text = "He’s basically the same as Cat from Peg + Cat."
                            }, {char = "kat", text = "Or Bartleby in True."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {row = 0, col = 4},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 4
            }, {
                name = "waterfall",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "1,2,3..."},
                            {char = "kat", text = "Hey come on let’s go!"},
                            {char = "liz2", text = "...4,5,6..."},
                            {char = "kat", text = "Yeah! What do ya know"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "...7,8,9..."},
                            {char = "kat", text = "What comes next?"},
                            {
                                char = "liz2",
                                text = "10! Yeah, you’re the best!"
                            }, {char = "kat", text = "I love you Peg."},
                            {char = "liz2", text = "I love you Kat."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "So, is it just in a regular container?"
                            }, {char = "kat", text = "What?"},
                            {char = "liz2", text = "The chocolate milk."}, {
                                char = "kat",
                                text = "Yeah, we just keep it in the fridge. Like regular milk."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "empty"}}
                    }
                },
                coordinates = {row = 0, col = 5},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = true,
                maxRow = 0,
                maxCol = 5
            }
        },
        gridSize = {rows = 1, cols = 6}
    }
}

return module

