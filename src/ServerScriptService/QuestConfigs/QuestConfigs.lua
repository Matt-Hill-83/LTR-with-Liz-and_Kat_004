local module = {}

module.questConfigs = {
    {
        questTitle = "8054-math-NineTimesSix",
        words = "BAD,DAD,HAD,MAD,PAD,SAD",
        startSceneCoords = {row = 0, col = 0},
        endSceneCoords = {col = 7, row = 0},
        sceneConfigs = {
            {
                name = "home",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "Nine time six"},
                            {char = "liz2", text = "is 54 bricks!"},
                            {char = "kat", text = "Nine time six"},
                            {char = "liz2", text = "is 54 bricks!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cup"}, {name = "pig"}}
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
                name = "babyTroll01",
                frames = {
                    {
                        dialogs = {
                            {char = "both", text = "Nine times six"},
                            {char = "both", text = "is 54"},
                            {char = "both", text = "Nine times six"},
                            {char = "both", text = "is 54"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cup"}, {name = "pig"}}
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
                name = "cleopatra01",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "What? 54?"},
                            {char = "kat", text = "Nine times six?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cup"}, {name = "pig"}}
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
                name = "wilda01",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "And hey!"},
                            {char = "kat", text = "You have fine fine bricks!"},
                            {char = "liz2", text = "These old things...?"},
                            {char = "liz2", text = "Here, want a couple!"},
                            {
                                char = "kat",
                                text = "nope. I'm trying to find sticks!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cup"}, {name = "pig"}}
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
                name = "stump",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "I insist!"},
                            {char = "kat", text = "Then, I'll take 54!"},
                            {
                                char = "kat",
                                text = "I'll take 54 of those bricks!"
                            },
                            {
                                char = "liz2",
                                text = "54?  That's nine times six!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cup"}, {name = "pig"}}
                    }
                },
                coordinates = {row = 0, col = 4},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 4
            }, {
                name = "paradox01",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "And didn't you say you were trying to find sticks?"
                            }, {char = "kat", text = "I just switched."},
                            {
                                char = "liz2",
                                text = "You switched sticks for bricks?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cup"}, {name = "pig"}}
                    }
                },
                coordinates = {col = 5, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 5
            }, {
                name = "splendaCat01",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "both",
                                text = "Nine time six is 54 bricks!"
                            }, {char = "liz2", text = "I am so lost..."},
                            {
                                char = "both",
                                text = "Nine time six is 54 bricks!"
                            }, {char = "liz2", text = "You can do that?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cup"}, {name = "pig"}}
                    }
                },
                coordinates = {col = 6, row = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 6
            }, {
                name = "strawberry01",
                frames = {
                    {
                        dialogs = {
                            {char = "both", text = "Nine times six"},
                            {char = "both", text = "is 54"},
                            {char = "both", text = "Nine times six"},
                            {char = "both", text = "is 54"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cup"}, {name = "pig"}}
                    }
                },
                coordinates = {col = 7, row = 0},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 0,
                maxCol = 7
            }
        },
        gridSize = {rows = 1, cols = 8}
    }, {
        questTitle = "9912-R2D2andTheDOMStringList",
        words = "BOG,DOG,FOG,HOG,JOG,LOG",
        startSceneCoords = {col = 0, row = 0},
        endSceneCoords = {col = 1, row = 0},
        sceneConfigs = {
            {
                name = "bubbleGirl01",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Hi Kat!  Do you think it's gonna rain, dear?"
                            }, {char = "kat", text = "Get it, rain deer?"}, {
                                char = "liz2",
                                text = "Nope.  I think it's just going to rain cats and DOMStringList"
                            }, {char = "kat", text = "Ummmm... what?"},
                            {
                                char = "liz2",
                                text = "I said I think it's just going to rain cats and dogs."
                            }, {char = "kat", text = "You didn't say dogs..."},
                            {
                                char = "kat",
                                text = "You said= cats and DOMStringList."
                            }, {char = "liz2", text = "DOMStringList?"},
                            {char = "liz2", text = "I did?  Oh my gosh!"},
                            {char = "liz2", text = "That's so embarrasing...."},
                            {
                                char = "liz2",
                                text = "That just happends to me some times."
                            }, {char = "kat", text = "Like a hiccup?."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "queenZupula01"}, {name = "crow01"}
                        }
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
                name = "pup01",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Yes. My doctor said it's some kind of autocomplete thing."
                            },
                            {
                                char = "kat",
                                text = "Oh brother... doctors say that about everything."
                            },
                            {
                                char = "kat",
                                text = "Did she say what a DOMStringList is?"
                            },
                            {
                                char = "liz2",
                                text = "No.  But it sounds like some kind of robot talk."
                            }, {
                                char = "kat",
                                text = "C3PO, take this DOMStringList to Princess Leah.  You are my only hope."
                            },
                            {
                                char = "liz2",
                                text = "R2D2!  What in the world has gotten into you?"
                            },
                            {
                                char = "kat",
                                text = "Beep Boop! Beep Boop! DOMStringList."
                            }, {char = "liz2", text = "Princess who?"},
                            {
                                char = "liz2",
                                text = "No I will not go with you to planet Hoth!"
                            },
                            {
                                char = "kat",
                                text = "Beep Boop! Beep Boop! Wheeeeeeee!"
                            },
                            {
                                char = "liz2",
                                text = "R2D2!  You need to get your disk drive cleaned!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "queenZupula01"}, {name = "crow01"}
                        }
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
        questTitle = "9913-TheCowInTheTree",
        words = "CAP,GAP,LAP,MAP,NAP,SAP,TAP,RAP,ZAP",
        startSceneCoords = {col = 0, row = 0},
        endSceneCoords = {row = 0, col = 1},
        sceneConfigs = {
            {
                name = "bubbleGirl01",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Do you see a bee in a tree?"
                            }, {char = "kat", text = "Me?"},
                            {char = "kat", text = "Do I see a bee in a tree?"},
                            {char = "liz2", text = "Yes. A bee in a tree."},
                            {char = "kat", text = "Gee. Let me check."},
                            {char = "kat", text = "Nope. Not yet."},
                            {char = "liz2", text = "Wait a sec..."},
                            {char = "liz2", text = "Check now."},
                            {
                                char = "kat",
                                text = "I don't see a bee in a tree."
                            },
                            {char = "kat", text = "But I do see a big red cow."},
                            {char = "liz2", text = "In the tree?"},
                            {char = "kat", text = "Nope. On the ground."},
                            {char = "kat", text = "She probably fell down."},
                            {char = "liz2", text = "Well that doesn't count."},
                            {char = "kat", text = "Oh wow."},
                            {
                                char = "kat",
                                text = "And we gotta get the gold to buy that dress somehow."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "boomALoo01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "queenZupula01"},
                            {name = "rose01"}, {name = "crow01"}
                        }
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
                name = "pup01",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Liz, let's put the cow in the tree!"
                            },
                            {char = "liz2", text = "Kat, that's not allowed!"},
                            {
                                char = "kat",
                                text = "You can't put a cow in a tree!"
                            }, {char = "kat", text = "Why not?"},
                            {char = "liz2", text = "It would be too loud."},
                            {char = "kat", text = "Moo Moo Moo."},
                            {
                                char = "grownUp01",
                                text = "You kids turn that cow sound down! Now!"
                            }, {char = "kat", text = "Sorry mom!"},
                            {
                                char = "liz2",
                                text = "Plus, how will you get the cow down?"
                            }, {
                                char = "liz2",
                                text = "I don' want to see a cow all splattered on the ground."
                            },
                            {
                                char = "kat",
                                text = "Maybe we can use this ladder I found?"
                            }, {char = "kat", text = "How does that sound?"},
                            {char = "liz2", text = "How does that sound?"},
                            {char = "liz2", text = "How does that sound?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "boomALoo01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "queenZupula01"},
                            {name = "rose01"}, {name = "crow01"}
                        }
                    }
                },
                coordinates = {row = 0, col = 1},
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
        questTitle = "9915-KatGetsADressForReal",
        words = "VAN,RAN,CAN,AN,PAN,DAN,FAN,BAN,TAN",
        startSceneCoords = {col = 0, row = 0},
        sceneConfigs = {
            {
                name = "bog",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Big day today Liz!  Big day."
                            },
                            {
                                char = "kat",
                                text = "Liz, today we will stay on task."
                            },
                            {
                                char = "kat",
                                text = "We can get the dress if we follow the steps."
                            },
                            {
                                char = "kat",
                                text = "Follow the steps.  Get the dress."
                            },
                            {
                                char = "liz2",
                                text = "But Kat, what about the singing contest?"
                            },
                            {
                                char = "kat",
                                text = "Step #1= Give the bun to the pig."
                            },
                            {
                                char = "liz2",
                                text = "Kat, what about dog01's outer space thing?"
                            }, {char = "kat", text = "Bun to the pig."},
                            {
                                char = "liz2",
                                text = "Kat, what about Happy Time Baby Land?"
                            }, {char = "kat", text = "La! La! La! La! La!"},
                            {char = "kat", text = "I can't hear you Liz!"},
                            {
                                char = "kat",
                                text = "Follow the steps.  Get to the pig."
                            },
                            {
                                char = "kat",
                                text = "Get the gold.  Get the dress."
                            },
                            {
                                char = "liz2",
                                text = "What about Cold Girl's lost penguin."
                            },
                            {
                                char = "liz2",
                                text = "Do we just stop looking for her?"
                            },
                            {
                                char = "liz2",
                                text = "Is that who we are now Kat?"
                            },
                            {char = "liz2", text = "Is your heart that cold?"},
                            {
                                char = "kat",
                                text = "Ummm.... ok calm down Anna of Arendelle."
                            },
                            {
                                char = "kat",
                                text = "She's probably just at the zoo."
                            }, {char = "liz2", text = "Who is at the zoo?"},
                            {
                                char = "kat",
                                text = "The Penguin.  Cold girl's lost penguin."
                            }, {char = "kat", text = "Focus Liz, focus."},
                            {char = "liz2", text = "oh yeah, right"},
                            {
                                char = "liz2",
                                text = "...gosh you sound like my mom..."
                            },
                            {
                                char = "kat",
                                text = "Liz you get more distracted than a cat gets"
                            }, {
                                char = "kat",
                                text = "...when it does a triple back flip and lands smack dab in a patch of cat nip."
                            }, {
                                char = "liz2",
                                text = "Sorry, the Anna of Arendale thing kind of threw me for a loop."
                            },
                            {
                                char = "liz2",
                                text = "Do you think kids will understand the reference?"
                            }, {
                                char = "kat",
                                text = "The graders... for sure.  but these younger kids... I just don't know."
                            },
                            {
                                char = "liz2",
                                text = "Why do you think the penguin is at the zoo?"
                            }, {
                                char = "kat",
                                text = "Think about it Liz, what would you rather eat, some real live dead fish, or cat food from a can?"
                            },
                            {
                                char = "kat",
                                text = "ooohhhhh... geez, I hate these questions..."
                            }, {char = "troll01", text = "we don't say hate"},
                            {
                                char = "liz2",
                                text = "Ooops. sorry.  These questions are not my favortie."
                            },
                            {
                                char = "liz2",
                                text = "Can I be excused, please and thank you?"
                            },
                            {char = "troll01", text = "Three more bites Liz."},
                            {char = "liz2", text = "But Daaaaaad!"},
                            {
                                char = "liz2",
                                text = "Wait, cold girl feeds Penny catfood out of a can?"
                            },
                            {char = "kat", text = "That's what I just said."},
                            {
                                char = "liz2",
                                text = "No you didn't, you inferred it."
                            }, {char = "kat", text = "I implied it."},
                            {
                                char = "liz2",
                                text = "oh thanks,  Ruth Bader Ginsberg"
                            }, {char = "kat", text = "Let's go see Rose."}, {
                                char = "kat",
                                text = "You mean that new girl who lives on top of the mountain?"
                            }, {char = "kat", text = "Out in Carcassan?"},
                            {char = "kat", text = "That place is so chill."},
                            {
                                char = "kat",
                                text = "Yeah. We better put our parkas on."
                            },
                            {
                                char = "liz2",
                                text = "We can start fresh on dress quest tomorrow."
                            },
                            {char = "liz2", text = "We said that yesterday."},
                            {
                                char = "liz2",
                                text = "It might be part of our process..."
                            },
                            {
                                char = "liz2",
                                text = "What? Getting distracted all the time?"
                            },
                            {
                                char = "liz2",
                                text = "It might be ALL of our process..."
                            },
                            {
                                char = "kat",
                                text = "Tomorrow we will hit it really hard."
                            },
                            {
                                char = "liz2",
                                text = "Yeah.  Big day tomorrow.  Big day."
                            }, {char = "liz2", text = "Let's go to the zoo."},
                            {
                                char = "liz2",
                                text = "Yeah, we'll find some answers at the zoo."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "oopsieCat01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "cat01"},
                            {name = "boomALoo01"}
                        }
                    }
                },
                coordinates = {col = 0, row = 0},
                showBottomPath = true,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }, {
                name = "hill",
                frames = {
                    {
                        dialogs = {{char = "kat", text = "We can play."}},
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "oopsieCat01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "cat01"},
                            {name = "boomALoo01"}
                        }
                    }
                },
                coordinates = {col = 3, row = 0},
                showBottomPath = true,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 3
            }, {
                name = "castle",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "Boo Hoo!"},
                            {char = "liz2", text = "I got a boo boo."},
                            {char = "kat", text = "You got a Boo boo?"},
                            {char = "liz2", text = "Yup."},
                            {char = "kat", text = "Me too!"},
                            {char = "kat", text = "I got a boo boo too!"},
                            {char = "liz2", text = "Toodle Loo!"},
                            {char = "kat", text = "Toodle Loo to you too!"},
                            {char = "OTheOwl", text = "Hoo! Hoo!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "oopsieCat01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "cat01"},
                            {name = "boomALoo01"}
                        }
                    }
                },
                coordinates = {row = 1, col = 0},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = true,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = false,
                maxRow = 1,
                maxCol = 3
            }, {
                name = "tree",
                frames = {
                    {
                        dialogs = {{char = "kat", text = "We can play."}},
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "oopsieCat01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "cat01"},
                            {name = "boomALoo01"}
                        }
                    }
                },
                coordinates = {row = 1, col = 1},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 1,
                maxCol = 3
            }, {
                name = "castle",
                frames = {
                    {
                        dialogs = {{char = "kat", text = "We can play."}},
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "oopsieCat01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "cat01"},
                            {name = "boomALoo01"}
                        }
                    }
                },
                coordinates = {row = 1, col = 2},
                showBottomPath = true,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 1,
                maxCol = 3
            }, {
                name = "pond",
                frames = {
                    {
                        dialogs = {{char = "kat", text = "We can play."}},
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "oopsieCat01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "cat01"},
                            {name = "boomALoo01"}
                        }
                    }
                },
                coordinates = {col = 3, row = 1},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = true,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 1,
                maxCol = 3
            }, {
                name = "end",
                frames = {
                    {
                        dialogs = {{char = "kat", text = "We can play."}},
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "oopsieCat01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "cat01"},
                            {name = "boomALoo01"}
                        }
                    }
                },
                coordinates = {row = 1, col = 4},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 1,
                maxCol = 4
            }, {
                name = "barn",
                frames = {
                    {
                        dialogs = {{char = "kat", text = "We can play."}},
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "oopsieCat01"}, {name = "dog01"},
                            {name = "pup01"}, {name = "cat01"},
                            {name = "boomALoo01"}
                        }
                    }
                },
                coordinates = {row = 2, col = 2},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = true,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = false,
                maxRow = 2,
                maxCol = 4
            }
        },
        gridSize = {rows = 3, cols = 5}
    }, {
        questTitle = "9000 - A glitch in the Forest",
        words = "PET,WET,GET,VET,NET,LET,SET,YET",
        startSceneCoords = {col = 0, row = 0},
        endSceneCoords = {row = 1, col = 5},
        sceneConfigs = {
            {
                name = "pin",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "That was not fun."},
                            {char = "kat", text = "Let's go to the bun."},
                            {char = "liz2", text = "Let's run to the bun!"},
                            {char = "kat", text = "Fun, fun, fun!"},
                            {char = "liz2", text = "Tee Hee Hee!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "pup01"}, {name = "cup"}}
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
                name = "bun",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "I see a bun!"},
                            {char = "kat", text = "I see a bun... and a bun!"},
                            {
                                char = "liz2",
                                text = "I see a bun... and a bun..."
                            }, {char = "liz2", text = "...and a... bun?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "bun"}, {name = "bun"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Matt!!!"},
                            {
                                char = "liz2",
                                text = "Kat? Who are you talking to?"
                            },
                            {
                                char = "kat",
                                text = "Very sloppy matt, very slopppy!!!"
                            }, {char = "liz2", text = "Who is Matt?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "bun"}, {name = "bun"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Bun Bun was supposed to be here."
                            },
                            {
                                char = "liz2",
                                text = "I don't know what you are talking about..."
                            }, {
                                char = "kat",
                                text = "Remember Matt...? Bun Bun was going to be here? With the carrot?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "bun"}, {name = "bun"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "We were going to do the 'muncha buncha crunchy carrots joke?"
                            },
                            {
                                char = "liz2",
                                text = "The 'muncha buncha crunchy... what?!?"
                            },
                            {
                                char = "kat",
                                text = "We went through this last night Matt!"
                            }, {char = "liz2", text = "Kat, what is going on?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "bun"}, {name = "bun"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Uggghhh!  I spent like 2 hours on the 'muncna buncha cruncy carrots' joke!"
                            },
                            {
                                char = "kat",
                                text = "Oh forget it! Let's just keep going."
                            }, {char = "liz2", text = "To where?"},
                            {char = "kat", text = "How about the bees?"},
                            {char = "liz2", text = "I love the bees!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "bun"}, {name = "bun"}}
                    }
                },
                coordinates = {row = 0, col = 1},
                showBottomPath = true,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 1
            }, {
                name = "elf",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Elf= DO NOT GO IN THE CAVE!!!!"
                            }, {char = "liz2", text = "I see a dog."},
                            {
                                char = "kat",
                                text = "Liiiiiizzzzz!!!! That is not a dog!"
                            },
                            {char = "liz2", text = "I see a dog... and a bog!"},
                            {
                                char = "kat",
                                text = "Liiiiiizzzzz!!!! That is not a dog!"
                            }, {char = "liz2", text = "Hi doggy doggy!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cave"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Elf= DO NOT GO IN THE CAVE!!!!"
                            }, {char = "liz2", text = "Hi doggy woggy!"},
                            {
                                char = "kat",
                                text = "Liz! We need to get out of here!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cave"}}
                    }
                },
                coordinates = {row = 0, col = 2},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 0,
                maxCol = 2
            }, {
                name = "cat01",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "I see a cat."}, {
                                char = "liz2",
                                text = "I see a cat... oh my gosh Kat, that cat is too cute! Don't look!"
                            }, {char = "kat", text = "It's too late. I looked."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "cap"}, {name = "bunny"}}
                    }
                },
                coordinates = {col = 1, row = 1},
                showBottomPath = true,
                showRightPath = false,
                showTopPath = true,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = false,
                maxRow = 1,
                maxCol = 2
            }, {
                name = "cave",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Hi Drake, what are you doing in the cave?"
                            }, {
                                char = "drake",
                                text = "Oh hi Kat and Liz! This bright pink boy was just telling me about..."
                            }, {
                                char = "drake",
                                text = "...ummm... I have no idea what he was talking about..."
                            },
                            {
                                char = "drake",
                                text = "But he can make some really cool airplane sounds..."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "Oh, we know Gerald."}, {
                                char = "liz2",
                                text = "Gerald, 11=00 at the amusement park, remember? Are we still on?"
                            }, {char = "Gerald", text = "You bet Liz and Kat!"},
                            {
                                char = "Gerald",
                                text = "Buh-buh-buh... Buh-buh-buh... Rooooooommmmmm...."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "I'm just worried about connecting with Vulcan.... What if I never connect with him?"
                            },
                            {
                                char = "kat",
                                text = "Um, I don't know Drake.  I just don't know."
                            }, {
                                char = "kat",
                                text = "To tell you the truth, I never really understand a think you Dragon Masters say..."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "I understand= Vulcan No!"},
                            {
                                char = "liz2",
                                text = "It means= Vulcan, stop burning everything."
                            },
                            {char = "drake", text = "Yeah, most of the time."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "But look drake, we have a real problem..."
                            }, {char = "drake", text = "A math problem?"}, {
                                char = "kat",
                                text = "Ummm sure. We need to find the secret glitch in the back of the cave."
                            },
                            {
                                char = "drake",
                                text = "I need to write a letter to my mom..."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {char = "Gerald", text = "I love my Mom!"},
                            {char = "liz2", text = "What?"},
                            {char = "Gerald", text = "My mom is cool!"},
                            {char = "liz2", text = "huh?"},
                            {
                                char = "Gerald",
                                text = "I like it when she drops me off at school!"
                            }, {char = "liz2", text = "Wow!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Wow Gerald, nice poem!"},
                            {
                                char = "Gerald",
                                text = "Thanks, I wrote it for the Rap Battle!"
                            }, {char = "liz2", text = "Rap Battle?"}, {
                                char = "kat",
                                text = "But, we did the Rap Battle like 4 shows ago... with KatieKooper..."
                            },
                            {
                                char = "Gerald",
                                text = "Nope, it's today!  And I'm going to win!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Today? Wait! It must be another glitch!"
                            },
                            {
                                char = "Gerald",
                                text = "Come with me through this yellow door!"
                            },
                            {
                                char = "liz2",
                                text = "Wow, I didn't see that there!"
                            }, {char = "kat", text = "Um..... ok..."},
                            {
                                char = "liz2",
                                text = "What could possibly go wrong?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {
                                char = "drake",
                                text = "I just wish I knew how to write..."
                            },
                            {
                                char = "liz2",
                                text = "Drake, just use your best guess spelling!"
                            },
                            {
                                char = "drake",
                                text = "Thanks Liz! You mean like this="
                            },
                            {
                                char = "drake",
                                text = "D3@R M@M, horse lollipop tuna fish.?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Um... yeah, that looks uh... pretty good..."
                            }, {
                                char = "liz2",
                                text = "Maybe just have Bo proof read it before you hit send..."
                            }, {char = "drake", text = "Thanks Liz!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "drake02"}, {name = "gerald01"}}
                    }
                },
                coordinates = {row = 1, col = 4},
                showBottomPath = true,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = false,
                maxRow = 1,
                maxCol = 4
            }, {
                name = "doorYellow",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "Hi Tired Girl!"},
                            {char = "tiredGirl", text = "Hi Liz and Kat!"},
                            {char = "kat", text = "Hey, cool piece of bark!"},
                            {
                                char = "tiredGirl",
                                text = "It is not mine. You can have it."
                            }, {char = "kat", text = "Sweet!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "tiredGirl"}, {name = "barkPhone01"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Beep Boop. Beep Boop. Beep-Beep Boop."
                            },
                            {char = "liz2", text = "Kat, what are you doing?"},
                            {
                                char = "kat",
                                text = "Hold on Liz, I'm making a call..."
                            },
                            {
                                char = "liz2",
                                text = "Kat, that is not a phone, it's a piece of bark."
                            }, {char = "kat", text = "Hush..."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "tiredGirl"}, {name = "barkPhone01"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Yes, hi. I'd like to order 16 pepperoni pizzas."
                            },
                            {char = "kat", text = "With the vegan pepperoni."},
                            {
                                char = "kat",
                                text = "You don't have vegan pepperoni?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "tiredGirl"}, {name = "barkPhone01"}
                        }
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Ummm, Kat, earth to Kat..."},
                            {
                                char = "kat",
                                text = "Sorry Liz, I think this guy is new."
                            }, {
                                char = "kat",
                                text = "Hmmmm, could you do me a favor and put your manager on the phone?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "tiredGirl"}, {name = "barkPhone01"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Hi Otis. Look I need those pizzas with the vegan pepperoni."
                            },
                            {
                                char = "kat",
                                text = "New guy? Yup, that's what I figured."
                            },
                            {
                                char = "kat",
                                text = "Wait, that was Troll? You mean 'Troll' Troll?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "tiredGirl"}, {name = "barkPhone01"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "I thought I recognized that voice!"
                            }, {char = "kat", text = "Are we good now? Great."},
                            {
                                char = "kat",
                                text = "Oh and tell Troll we will see him at the Rap Battle tonite."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "tiredGirl"}, {name = "barkPhone01"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Kat, that is not a phone, it's a piece of bark!"
                            }, {char = "kat", text = "I'm keeping this thing!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "tiredGirl"}, {name = "barkPhone01"}
                        }
                    }
                },
                coordinates = {row = 1, col = 5},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = true,
                isStartScene = false,
                maxRow = 1,
                maxCol = 5
            }, {
                name = "pigInAWig",
                frames = {
                    {
                        dialogs = {
                            {char = "liz2", text = "I see a pig..."},
                            {char = "kat", text = "Me too!"},
                            {char = "liz2", text = "I see a pig... in a wig!"},
                            {
                                char = "kat",
                                text = "I see a pig in a wig, and a..."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dress01"}, {name = "pig"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Liz. Freeze! Do you see that?"
                            },
                            {
                                char = "liz2",
                                text = "The pig in the wig. Yeah, I just did that line...?"
                            }, {char = "kat", text = "No, not that?"},
                            {char = "liz2", text = "The other pig?"},
                            {char = "kat", text = "No! No, no, no, no, NO!"},
                            {char = "liz2", text = "What do you see?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dress01"}, {name = "pig"}}
                    }, {
                        dialogs = {
                            {char = "kat", text = "A dress? I see a dress!"},
                            {char = "liz2", text = "Oh yes! I see a dress!"},
                            {char = "kat", text = "Oh yes! Oh yes!"},
                            {char = "liz2", text = "A dress! A dress!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dress01"}, {name = "pig"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "...but... how...?"},
                            {char = "kat", text = "It must be a glitch!"},
                            {char = "liz2", text = "A glitch?"},
                            {char = "kat", text = "Yeah, a glitch in the game!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dress01"}, {name = "pig"}}
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "Wait, you mean like that girl Vanelope is always talking about?"
                            },
                            {
                                char = "kat",
                                text = "Yes, exactly that! That dress is a glitch!"
                            }, {char = "liz2", text = "Cool!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dress01"}, {name = "pig"}}
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Wait, what is a glitch?"},
                            {
                                char = "kat",
                                text = "It's where the game is broken. And things are in the wrong place."
                            }, {
                                char = "liz2",
                                text = "...like a bunch of hamburger buns just sitting around?"
                            }, {char = "kat", text = "Exactly!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dress01"}, {name = "pig"}}
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Come on, we need to find Vanelope!"
                            }, {char = "liz2", text = "Yay!"},
                            {char = "liz2", text = "Wait, who is Vanelope?"},
                            {char = "kat", text = "No time to explain!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dress01"}, {name = "pig"}}
                    }
                },
                coordinates = {col = 1, row = 2},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = true,
                showLeftPath = false,
                isEndScene = false,
                isStartScene = false,
                maxRow = 2,
                maxCol = 5
            }, {
                name = "rori",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "Hi Vanelope! Hi Robot Girl!"},
                            {char = "lucy", text = "It's Space Girl..."},
                            {
                                char = "kat",
                                text = "Vanelope, what's with the new look?"
                            },
                            {
                                char = "vanelope",
                                text = "Sometimes, you must go slow to go fast..."
                            }, {char = "kat", text = "...right..."},
                            {
                                char = "liz2",
                                text = "Wow, I never thought of that!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "lucy"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "So anyways Vanelope, we have a big problem!"
                            }, {
                                char = "lucy",
                                text = "A math problem? I could tell you about some dark math problems..."
                            },
                            {char = "kat", text = "maybe some other time..."},
                            {
                                char = "rori",
                                text = "Vulcan is the best at math problems!"
                            },
                            {char = "kat", text = "No, it's a dress problem!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "lucy"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "vanelope",
                                text = "Wow. Yeah. I was actually a little afraid to bring it up."
                            },
                            {
                                char = "kat",
                                text = "No, not this dress! A 'dress' dress!"
                            }, {char = "lucy", text = "A 'dress' dress!"},
                            {char = "kat", text = "Yes, a 'dress' dress!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "lucy"}
                        }
                    }, {
                        dialogs = {
                            {char = "vanelope", text = "keep talking..."},
                            {
                                char = "liz2",
                                text = "We saw a dress, and we think it's a glitch!"
                            },
                            {
                                char = "vanelope",
                                text = "Wait, did you put it in your pocket?"
                            }, {char = "kat", text = "Do what now?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "lucy"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "vanelope",
                                text = "Did you put the dress in your pocket?"
                            }, {char = "liz2", text = "...in her pocket...?"}, {
                                char = "kat",
                                text = "What are you talking about, did I put the dress in my pocket?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "lucy"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "Do I look like I could fit a dress in my pocket?"
                            }, {char = "kat", text = "Oh wait. I forgot."}, {
                                char = "kat",
                                text = "I put it right here in my pocket right next to my pet hippopotamus."
                            }, {
                                char = "kat",
                                text = "Um hello? Did you tie your bun too tight this morning..."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "lucy"}
                        }
                    }
                },
                coordinates = {row = 2, col = 2},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 2,
                maxCol = 5
            }, {
                name = "bus",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "Vanelope",
                                text = "Did you see a big pink bubble above you that said"
                            },
                            {
                                char = "kat",
                                text = "You put the dress in your pocket."
                            }, {char = "liz2", text = "...bubble...?"},
                            {char = "kat", text = "What?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "pig"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "Vanelope",
                                text = "Never mind. We need to get you to skunk hollow, and fast!"
                            },
                            {
                                char = "liz2",
                                text = "Do we need to go slow to go fast...?"
                            }, {
                                char = "vanelope",
                                text = "Never mind. We need to get to skunk hollow, and fast!"
                            },
                            {
                                char = "liz2",
                                text = "Do we still need to go slow to go fast...?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "pig"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "vanelope",
                                text = "We need to hurry! There is no time to explain!"
                            },
                            {
                                char = "liz2",
                                text = "So ummm... go super slow then...?"
                            }, {
                                char = "kat",
                                text = "If that glitch goes unstable, it could tear a memory hole in the game..."
                            },
                            {
                                char = "kat",
                                text = "...and swallow up this entire world!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "pig"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "liz2",
                                text = "...wait, make those words make sense..."
                            },
                            {
                                char = "kat",
                                text = "Um Siri... a little help here?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "pig"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "siri",
                                text = "A memory hole. Would you like to hear 'A Memory Hole', by the Back Street Bugs?"
                            },
                            {
                                char = "liz2",
                                text = "Yes! We love the Back Street Bugs!"
                            }, {char = "kat", text = "No! No, no, no, no no!!!"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "pig"}
                        }
                    }, {
                        dialogs = {
                            {char = "liz2", text = "Baby, all my memories..."},
                            {
                                char = "kat",
                                text = "Siri, explain this memory hole that may swallow up the world!"
                            },
                            {
                                char = "liz2",
                                text = "My memories, my memories..."
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "pig"}
                        }
                    }
                },
                coordinates = {row = 2, col = 3},
                showBottomPath = false,
                showRightPath = true,
                showTopPath = false,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 2,
                maxCol = 5
            }, {
                name = "bag",
                frames = {
                    {
                        dialogs = {
                            {
                                char = "vanelope",
                                text = "...the only way to fix a glitch..."
                            },
                            {char = "kat", text = "Oh brother, here we go..."},
                            {
                                char = "vanelope",
                                text = "Is to jump into another glitch!"
                            },
                            {
                                char = "liz2",
                                text = "I see a bad! I see a bad... and a flag!"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "flag"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "kat",
                                text = "But where can we find a glitch?"
                            },
                            {
                                char = "vanelope",
                                text = "We have to go behind the cave!"
                            }, {
                                char = "kat",
                                text = "Ha! Girl, you are crazier than a pigeon in a pile of popcorn!"
                            }, {
                                char = "liz2",
                                text = "The cave? But what about the elf who always says= 'Don't go in the cave!'?"
                            }
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "flag"}
                        }
                    }, {
                        dialogs = {
                            {
                                char = "vanelope",
                                text = "There is no time to explain! Come with me if you want to live!"
                            }, {char = "kat", text = "Ummm...okay."},
                            {char = "liz2", text = "This sounds super safe..."}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {
                            {name = "vanellope_little"}, {name = "flag"}
                        }
                    }
                },
                coordinates = {col = 4, row = 2},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = true,
                showLeftPath = true,
                isEndScene = false,
                isStartScene = false,
                maxRow = 2,
                maxCol = 5
            }
        },
        gridSize = {rows = 3, cols = 6}
    }, {
        questTitle = "9914-TheBloodyPotato",
        words = "TAG,RAG,SAG,WAG,NAG,ZAG",
        startSceneCoords = {row = 0, col = 0},
        endSceneCoords = {row = 0, col = 0},
        sceneConfigs = {
            {
                name = "bubbleGirl01",
                frames = {
                    {
                        dialogs = {
                            {char = "kat", text = "I see a bloody frog."},
                            {
                                char = "kat",
                                text = "I see a bloody frog... on a bloody log."
                            }, {
                                char = "liz2",
                                text = "Kat, you did not just see that! <jaw drops in stunned amazement>"
                            },
                            {
                                char = "kat",
                                text = "Liz what in the bloody heck is going on around here?"
                            },
                            {
                                char = "liz2",
                                text = "Have you gone completely out of your mind?"
                            },
                            {
                                char = "kat",
                                text = "I see a bee in a bloody tree."
                            }, {char = "liz2", text = "Kat, look around."},
                            {char = "liz2", text = "There is no blood here."},
                            {
                                char = "liz2",
                                text = "There is not even a frog and a log here."
                            }, {char = "liz2", text = "Or a bog."},
                            {char = "kat", text = "STOP IT!."},
                            {char = "kat", text = "Oh right.  Sorry."},
                            {
                                char = "kat",
                                text = "Please Liz.  I'm talking British."
                            },
                            {
                                char = "kat",
                                text = "In British, bloody is a swear word."
                            }, {char = "liz2", text = "No. way."},
                            {char = "liz2", text = "No. Hecka frickin' way."},
                            {
                                char = "kat",
                                text = "Yup, they say it in front of everything."
                            },
                            {
                                char = "kat",
                                text = "They say= Give me that bloody potato."
                            },
                            {
                                char = "liz2",
                                text = "Give me that bloody potato."
                            }, {char = "kat", text = "Ummm.... no."},
                            {char = "kat", text = "No no no no no..."},
                            {
                                char = "kat",
                                text = "You are saying it all wrong."
                            }, {
                                char = "kat",
                                text = "The way you are saying it, you are asking someone for a real live bloody potato."
                            }, {char = "liz2", text = "oops..."},
                            {char = "liz2", text = "and yuck..."}, {
                                char = "kat",
                                text = "You need to kind of pretend like you are mad at the potato."
                            }, {char = "liz2", text = "I'm mad at a potato?"},
                            {
                                char = "kat",
                                text = "Yeah, pretend it jumped up off your plate and ran up the wall and got ketchup everywhere."
                            }, {char = "liz2", text = "RRRRRRRrrrrrrr!"},
                            {
                                char = "liz2",
                                text = "Get back here you bloody potato!"
                            }, {char = "kat", text = "There you go!"},
                            {char = "liz2", text = "Potato!"},
                            {
                                char = "liz2",
                                text = "Come back here is bloody instant!"
                            }, {char = "kat", text = "You got it!"},
                            {char = "kat", text = "Go Liz!"},
                            {
                                char = "liz2",
                                text = "Get back on my bloody plate!"
                            }, {char = "liz2", text = "What does it mean?"},
                            {
                                char = "kat",
                                text = "Get this, it doesn't even mean anything."
                            },
                            {
                                char = "liz2",
                                text = "It's a word that doesn't even mean anything?"
                            }, {
                                char = "kat",
                                text = "Yeah.  It's an intensifier.  It just makes everything more intense."
                            }, {
                                char = "liz2",
                                text = "Oh, like when lightning flashes in the background when you are talking?"
                            }, {char = "kat", text = "Exactly."},
                            {char = "liz2", text = "Wow!"},
                            {
                                char = "liz2",
                                text = "I am sooooooo trying this one at dinner tonite!"
                            },
                            {
                                char = "kat",
                                text = "I think your parent will love it."
                            },
                            {char = "kat", text = "Can I come over for dinner?"}
                        },
                        characters01 = {{name = "kat"}, {name = "liz2"}},
                        characters02 = {{name = "dog01"}, {name = "crow01"}}
                    }
                },
                coordinates = {row = 0, col = 0},
                showBottomPath = false,
                showRightPath = false,
                showTopPath = false,
                showLeftPath = false,
                isEndScene = true,
                isStartScene = true,
                maxRow = 0,
                maxCol = 0
            }
        },
        gridSize = {rows = 1, cols = 1}
    }
}

return module

