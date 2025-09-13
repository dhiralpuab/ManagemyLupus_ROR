class SurveyCard
  attr_reader :id, :title, :image_url, :description, :categories, :learn_more, :learn_more_id, :hidden

  def initialize(id:, title:, image_url:, description:, categories:, learn_more: nil, learn_more_id: nil, hidden:false)
    @id = id
    @title = title
    @image_url = image_url
    @description = description
    @categories = categories
    @learn_more = learn_more
    @learn_more_id = learn_more_id
    @hidden = hidden
  end

  def hidden?
    @hidden
  end

  def self.intro
      [
        new(
          id: 1,
          title: I18n.t("intro_title"),
          image_url: "group_4.jpg" ,
          description: [
            I18n.t("intro_data_1"),
            I18n.t("intro_data_2")
          ],
          categories: [:active_kidneys]
        ),
        new(
          id: 2,
          title: I18n.t("intro_title"),
          image_url: "group_4.jpg" ,
          description: [
            I18n.t("intro_data_3"),
            I18n.t("intro_data_2")
          ],
          categories: [:active_no_kidneys, :quiet]
        ),
        new(
          id: 3,
          title: I18n.t("data_1"),
          image_url: "only_for_pic.jpg" ,
          description: [
            I18n.t("data_2"),
            I18n.t("data_3"),
            I18n.t("data_4"),
            I18n.t("data_5")
          ],
          categories: []
        ),
        new(
          id: 4,
          title: I18n.t("data_6"),
          image_url: "woman_sitting.jpeg" ,
          description: [
            I18n.t("data_7"),
            I18n.t("data_8"),
            I18n.t("data_9"),
            I18n.t("data_10"),
            I18n.t("data_11"),
            I18n.t("data_12"),
            I18n.t("data_13")
          ],
          categories: [:active_kidneys]
        ),
        new(
          id: 5,
          title: I18n.t("data_14"),
          image_url: "woman.jpeg" ,
          description: [
            I18n.t("data_15"),
            I18n.t("data_16"),
            I18n.t("data_17"),
            I18n.t("data_18")
          ],
          categories: [:active_kidneys]
        ),
        new(
          id: 6,
          title: I18n.t("data_19"),
          image_url: "woman.jpeg" ,
          description: [
            I18n.t("data_20"),
            I18n.t("data_21"),
            I18n.t("data_22")
          ],
          categories: [:active_kidneys]
        ),
        new(
          id: 7,
          title: I18n.t("data_23"),
          image_url: "woman.jpeg" ,
          description: [
            I18n.t("data_24"),
            I18n.t("data_25")
          ],
          categories: [:active_kidneys]
        ),
        new(
          id: 8,
          title: I18n.t("data_26"),
          image_url: "woman.jpeg" ,
          description: [
            I18n.t("data_27"),
            I18n.t("data_28"),
            I18n.t("data_29")
          ],
          categories: [:active_kidneys]
        ),
        new(
          id: 9,
          title: I18n.t("data_30"),
          image_url: "woman_smile.jpeg" ,
          description: [
            I18n.t("data_31"),
            I18n.t("data_32"),
            I18n.t("data_33")
          ],
          categories: [:active_kidneys, :quiet]
        ),
        new(
          id: 10,
          title: I18n.t("data_34"),
          image_url: "group_photo.jpeg",
          description: [
            I18n.t("data_35"),
            I18n.t("data_36"),
            I18n.t("data_37"),
            I18n.t("data_38"),
            I18n.t("data_39"),
            I18n.t("data_40")
          ],
          categories: [:active_kidneys, :quiet]
        ),

        new(
          id: 11,
          title: I18n.t("data_47"),
          image_url: "elderly.jpg",
          description: [
            I18n.t("data_48"),
            I18n.t("data_49"),
            I18n.t("data_50")
          ],
          categories: [:active_kidneys]
        ),

        new(
          id: 12,
          title: I18n.t("data_51"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_52"),
            I18n.t("data_53"),
            I18n.t("data_54"),
            I18n.t("data_55"),
            I18n.t("data_56")
          ],
          categories: [:a, :b]
        ),

        new(
          id: 13,
          title: I18n.t("data_57"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_58"),
            I18n.t("data_59"),
            I18n.t("data_60"),
            I18n.t("data_61"),
            I18n.t("data_62")
          ],
          categories: [:a, :b]
        ),

        new(
          id: 14,
          title: I18n.t("data_63"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_64"),
            I18n.t("data_65"),
            I18n.t("data_66"),
            I18n.t("data_67"),
            I18n.t("data_68")
          ],
          categories: [:c]
        ),

        new(
          id: 15,
          title: I18n.t("data_69"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_70"),
            I18n.t("data_71"),
            I18n.t("data_72"),
            I18n.t("data_73"),
            I18n.t("data_74")
          ],
          categories: [:d]
        ),

        new(
          id: 16,
          title: I18n.t("data_75"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_76"),
            I18n.t("data_77"),
            I18n.t("data_78"),
            I18n.t("data_79"),
            I18n.t("data_80")
          ],
          categories: [:c]
        ),

        new(
          id: 17,
          title: I18n.t("data_81"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_82"),
            I18n.t("data_83"),
            I18n.t("data_84"),
            I18n.t("data_85"),
            I18n.t("data_86")
          ],
          categories: [:d]
        ),

        new(
          id: 18,
          title: I18n.t("data_41"),
          image_url: "lupus_banner.png",
          description: [
            I18n.t("data_42"),
            I18n.t("data_43"),
            I18n.t("data_44"),
            I18n.t("data_45"),
            I18n.t("data_46")
          ],
          categories: []
        ),

        
    ]
  end

  def self.treatment
      [
        new(
          id: 1,
          title: I18n.t("data_459"),
          image_url: "woman.jpeg" ,
          description: [
            I18n.t("data_460"),
            I18n.t("data_461"),
            I18n.t("data_462"),
            I18n.t("data_684"),
          ],
          categories: []
        ),
        new(
          id: 2,
          title: I18n.t("data_468"),
          image_url: "woman.jpeg" ,
          description: [
            I18n.t("data_469"),
            I18n.t("data_470"),
            I18n.t("data_471"),
            I18n.t("data_472"),
            I18n.t("data_473"),
            I18n.t("data_474"),
            I18n.t("data_475"),
          ],
          categories: []
        ),
        new(
          id: 3,
          title: I18n.t("data_463"),
          image_url: "" ,
          description: [
            I18n.t("data_464"),
            I18n.t("data_465"),
            I18n.t("data_466"),
            I18n.t("data_467")
          ],
          categories: []
        ),
        new(
          id: 4,
          title: I18n.t("data_476"),
          image_url: "" ,
          description: [
            I18n.t("data_477"),
            I18n.t("data_478"),
            I18n.t("data_479")
          ],
          categories: []
        ),
        new(
          id: 5,
          title: I18n.t("data_480"),
          image_url: "woman.jpeg" ,
          description: [
            I18n.t("data_481"),
            I18n.t("data_482"),
            I18n.t("data_685")
          ],
          categories: []
        ),
        new(
          id: 6,
          title: I18n.t("data_483"),
          image_url: "" ,
          description: [
            I18n.t("data_484"),
            I18n.t("data_485"),
            I18n.t("data_486"),
            I18n.t("data_487"),
            I18n.t("data_488"),
            I18n.t("data_489"),
            I18n.t("data_490")
            
          ],
          categories: []
        ),
        new(
          id: 7,
          title: I18n.t("data_491"),
          image_url: "",
          description: [
            I18n.t("data_492"),
            I18n.t("data_493"),
            I18n.t("data_494"),
            I18n.t("data_495"),
            I18n.t("data_496")
          ],
          categories: []
        ),

        new(
          id: 8,
          title: I18n.t("data_653"),
          image_url: "imuran_or_az.jpg",
          description: [
            I18n.t("data_654"),
            I18n.t("data_655"),
            I18n.t("data_656")
          ],
          categories: []
        ),

        new(
          id: 9,
          title: I18n.t("data_657"),
          image_url: "imu_red.png",
          description: [
            I18n.t("data_658"),
            I18n.t("data_659"),
            I18n.t("data_660")
          ],
          categories: []
        ),

        new(
          id: 10,
          title: I18n.t("data_661"),
          image_url: "imuran_naus.PNG",
          description: [
            I18n.t("data_663"),
            I18n.t("data_664"),
            I18n.t("data_665")
          ],
          categories: []
        ),

        new(
          id: 11,
          title: I18n.t("data_662"),
          image_url: "imuran_ser.PNG",
          description: [
            I18n.t("data_666"),
            I18n.t("data_667"),
            I18n.t("data_668")
          ],
          categories: []
        ),

        new(
          id: 12,
          title: I18n.t("data_669"),
          image_url: "two_pills.PNG",
          description: [
            I18n.t("data_670"),
            I18n.t("data_671"),
            I18n.t("data_672")
          ],
          categories: []
        ),

        new(
          id: 13,
          title: I18n.t("data_673"),
          image_url: "cellcept_red.PNG",
          description: [
            I18n.t("data_674"),
            I18n.t("data_675"),
            I18n.t("data_676")
          ],
          categories: []
        ),

        new(
          id: 14,
          title: I18n.t("data_677"),
          image_url: "cell_stomach.PNG",
          description: [
            I18n.t("data_679"),
            I18n.t("data_680")
          ],
          categories: []
        ),

        new(
          id: 15,
          title: I18n.t("data_678"),
          image_url: "cell_serious.PNG",
          description: [
            I18n.t("data_681"),
            I18n.t("data_682"),
            I18n.t("data_683")
          ],
          categories: []
        ),

        new(
          id: 16,
          title: I18n.t("data_497"),
          image_url: "woman_bench.jpg",
          description: [
            I18n.t("data_498"),
            I18n.t("data_499")
          ],
          categories: []
        ),

        new(
          id: 17,
          title: I18n.t("data_500"),
          image_url: "woman_smile.jpeg",
          description: [
            I18n.t("data_501"),
            I18n.t("data_502")
          ],
          categories: []
        ),

        new(
          id: 18,
          title: I18n.t("data_503"),
          image_url: "lupus_banner.png",
          description: [
            I18n.t("data_504"),
            I18n.t("data_505"),
            I18n.t("data_506"),
            I18n.t("data_507")
          ],
          categories: []
        ),

        new(
          id: 19,
          title: I18n.t("data_431"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_432"),
            I18n.t("data_433"),
            I18n.t("data_434"),
            I18n.t("data_435"),
            I18n.t("data_436")
          ],
          categories: []
        ),

        new(
          id: 20,
          title: I18n.t("data_647"),
          image_url: "",
          description: [
            I18n.t("data_648"),
            I18n.t("data_649"),
            I18n.t("data_650"),
            I18n.t("data_651"),
            I18n.t("data_652")
          ],
          categories: []
        ),

        new(
          id: 21,
          title: I18n.t("data_437"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_438"),
            I18n.t("data_439"),
            I18n.t("data_440"),
            I18n.t("data_441"),
            I18n.t("data_442")
          ],
          categories: []
        ),

        new(
          id: 22,
          title: I18n.t("data_444"),
          image_url: "belimumab_infection.png",
          description: [
            I18n.t("data_445")
          ],
          categories: [],
          learn_more: I18n.t("data_569"),
          learn_more_id: 107
        ),

        new(
          id: 23,
          title: I18n.t("data_446"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_447"),
            I18n.t("data_448"),
            I18n.t("data_449"),
            I18n.t("data_450")
          ],
          categories: []
        ),

        new(
          id: 24,
          title: I18n.t("data_451"),
          image_url: "rituximab_infection.png",
          description: [
            I18n.t("data_452")
          ],
          categories: [],
          learn_more: I18n.t("data_569"),
          learn_more_id: 107
        ),

        new(
          id: 25,
          title: I18n.t("data_453"),
          image_url: "doctor.jpeg",
          description: [
            I18n.t("data_454"),
            I18n.t("data_455"),
            I18n.t("data_456")
          ],
          categories: []
        ),

        new(
          id: 26,
          title: I18n.t("data_457"),
          image_url: "abatacept_infection.png",
          description: [
            I18n.t("data_458")
          ],
          categories: [:active_kidneys],
          learn_more: I18n.t("data_569"),
          learn_more_id: 107
        ),

        new(
          id: 27,
          title: I18n.t("data_508"),
          image_url: "woman.jpeg",
          description: [
            I18n.t("data_509"),
            I18n.t("data_510"),
            I18n.t("data_511")
          ],
          categories: [:active_kidneys]
        ),

        new(
          id: 28,
          title: I18n.t("data_512"),
          image_url: "iv.jpg",
          description: [
            I18n.t("data_513"),
            I18n.t("data_514"),
            I18n.t("data_515")
          ],
          categories: [:active_kidneys]
        ),

        new(
          id: 29,
          title: I18n.t("data_516"),
          image_url: "calm_lupus.PNG",
          description: [
            I18n.t("data_517"),
            I18n.t("data_518"),
            I18n.t("data_519")
          ],
          categories: [:active_kidneys]
        ),

        new(
          id: 30,
          title: I18n.t("data_520"),
          image_url: "saphnelo_risk.PNG",
          description: [
            I18n.t("data_521"),
            I18n.t("data_522"),
            I18n.t("data_523"),
            I18n.t("data_524")
          ],
          categories: [:active_kidneys]
        ),

        new(
          id: 31,
          title: I18n.t("data_525"),
          image_url: "saphnelo_shingles.PNG",
          description: [
            I18n.t("data_526"),
            I18n.t("data_527"),
            I18n.t("data_528"),
            I18n.t("data_529"),
            I18n.t("data_530")
          ],
          categories: [:active_kidneys]
        ),

        new(
          id: 32,
          title: I18n.t("data_531"),
          image_url: "saphnelo_bronchitis.PNG",
          description: [
            I18n.t("data_532"),
            I18n.t("data_533"),
            I18n.t("data_534"),
            I18n.t("data_535")
          ],
          categories: [:a, :b, :c, :d]
        ),

    ]
  end

  def self.steroids
      [
        new(
          id: 1,
          title: I18n.t("data_87"),
          image_url: "woman.jpeg" ,
          description: [
            I18n.t("data_88"),
            I18n.t("data_89"),
            I18n.t("data_90"),
            I18n.t("data_91"),
          ],
          categories: []
        ),
        new(
          id: 2,
          title: I18n.t("data_92"),
          image_url: "woman_med_look.jpeg" ,
          description: [
            I18n.t("data_93"),
            I18n.t("data_94")
          ],
          categories: []
        ),
        new(
          id: 3,
          title: I18n.t("data_95"),
          image_url: "weight.jpeg" ,
          description: [
            I18n.t("data_96"),
          ],
          categories: []
        ),
        new(
          id: 4,
          title: I18n.t("data_97"),
          image_url: "seventy_100.png" ,
          description: [
            I18n.t("data_98"),
            I18n.t("data_99")
          ],
          categories: [],
          learn_more: I18n.t("data_536"),
          learn_more_id: 101
        ),
        new(
          id: 5,
          title: I18n.t("data_100"),
          image_url: "twenty_four.png" ,
          description: [
            I18n.t("data_101"),
            I18n.t("data_102"),
            I18n.t("data_103")
          ],
          categories: [],
          learn_more: I18n.t("data_541"),
          learn_more_id: 102
        ),
        new(
          id: 6,
          title: I18n.t("data_104"),
          image_url: "puffy_face.PNG",
          description: [
            I18n.t("data_105"),
            I18n.t("data_106"),
            I18n.t("data_107")
          ],
          categories: [],
          learn_more: I18n.t("data_546"),
          learn_more_id: 103
        ),

        new(
          id: 7,
          title: I18n.t("data_108"),
          image_url: "eigthteen.png",
          description: [
            I18n.t("data_109"),
            I18n.t("data_110"),
            I18n.t("data_111")
          ],
          categories: [],
          learn_more: I18n.t("data_551"),
          learn_more_id: 104
        ),

        new(
          id: 8,
          title: I18n.t("data_112"),
          image_url: "nineteen.png",
          description: [
            I18n.t("data_113"),
            I18n.t("data_114"),
            I18n.t("data_115")
          ],
          categories: [],
          learn_more: I18n.t("data_557"),
          learn_more_id: 105
        ),

        new(
          id: 9,
          title: I18n.t("data_116"),
          image_url: "weakened_bones.PNG",
          description: [
            I18n.t("data_117"),
            I18n.t("data_118"),
            I18n.t("data_119")
          ],
          categories: [],
          learn_more: I18n.t("data_564"),
          learn_more_id: 106
        ),

        new(
          id: 10,
          title: I18n.t("data_120"),
          image_url: "three.png",
          description: [
            I18n.t("data_121"),
            I18n.t("data_122"),
            I18n.t("data_123")
          ],
          categories: [],
          learn_more: I18n.t("data_569"),
          learn_more_id: 107
        ),

    ]
  end

  def self.biologic
    [
      new(
        id: 1,
        title: I18n.t("data_124"),
        image_url: "woman.jpeg" ,
        description: [
          I18n.t("data_125"),
          I18n.t("data_126"),
          I18n.t("data_127")
        ],
        categories: [:active_kidneys]
      ),
      new(
        id: 2,
        title: I18n.t("data_128"),
        image_url: "woman.jpeg" ,
        description: [
          I18n.t("data_129"),
          I18n.t("data_130")
        ],
        categories: [:active_kidneys]
      ),
      new(
        id: 3,
        title: I18n.t("data_131"),
        image_url: "doctor.jpeg" ,
        description: [
          I18n.t("data_132"),
          I18n.t("data_133")
        ],
        categories: [:b]
      ),
      new(
        id: 4,
        title: I18n.t("data_134"),
        image_url: "doctor.jpeg" ,
        description: [
          I18n.t("data_135")
        ],
        categories: [:c]
      ),
      new(
        id: 5,
        title: I18n.t("data_136"),
        image_url: "doctor.jpeg" ,
        description: [
          I18n.t("data_137"),
          I18n.t("data_138")
        ],
        categories: [:d]
      ),
      new(
        id: 6,
        title: I18n.t("data_139"),
        image_url: "woman.jpeg" ,
        description: [
          I18n.t("data_140"),
          I18n.t("data_141"),
          I18n.t("data_142"),
          I18n.t("data_143"),
        ],
        categories: [:a]
      ),
      new(
        id: 7,
        title: I18n.t("data_144"),
        image_url: "woman.jpeg",
        description: [
          I18n.t("data_145"),
          I18n.t("data_146"),
          I18n.t("data_147")
        ],
        categories: [:b]
      ),

      new(
        id: 8,
        title: I18n.t("data_148"),
        image_url: "",
        description: [
          I18n.t("data_149"),
          I18n.t("data_150"),
          I18n.t("data_151"),
          I18n.t("data_152")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 9,
        title: I18n.t("data_153"),
        image_url: "",
        description: [
          I18n.t("data_154"),
          I18n.t("data_155")
        ],
        categories: [:a]
      ),

      new(
        id: 10,
        title: I18n.t("data_156"),
        image_url: "",
        description: [
          I18n.t("data_157"),
          I18n.t("data_158")
        ],
        categories: [:a]
      ),

      new(
        id: 11,
        title: I18n.t("data_159"),
        image_url: "timeline.PNG",
        description: [],
        categories: [:a]
      ),

      new(
        id: 12,
        title: I18n.t("data_160"),
        image_url: "rx_card.jpeg",
        description: [
          I18n.t("data_161"),
          I18n.t("data_162"),
          I18n.t("data_163"),
          I18n.t("data_164"),
          I18n.t("data_165")
        ],
        categories: [:a]
      ),

      new(
        id: 13,
        title: I18n.t("data_166"),
        image_url: "comparison.png",
        description: [
          I18n.t("data_167"),
          I18n.t("data_168")
        ],
        categories: [:a]
      ),

      new(
        id: 14,
        title: I18n.t("data_169"),
        image_url: "rx_card.jpeg",
        description: [
          I18n.t("data_170"),
          I18n.t("data_171"),
          I18n.t("data_172"),
          I18n.t("data_173"),
          I18n.t("data_174")
        ],
        categories: [:b]
      ),

      new(
        id: 15,
        title: I18n.t("data_175"),
        image_url: "comparison.png",
        description: [
          I18n.t("data_176"),
          I18n.t("data_177")
        ],
        categories: [:b]
      ),

      new(
        id: 16,
        title: I18n.t("data_178"),
        image_url: "rx_card.jpeg",
        description: [
          I18n.t("data_179"),
          I18n.t("data_180"),
          I18n.t("data_181"),
          I18n.t("data_182")
        ],
        categories: [:c]
      ),

      new(
        id: 17,
        title: I18n.t("data_183"),
        image_url: "cyt_ci.png",
        description: [
          I18n.t("data_167"),
          I18n.t("data_185")
        ],
        categories: [:c]
      ),

      new(
        id: 18,
        title: I18n.t("data_186"),
        image_url: "rx_card.jpeg",
        description: [
          I18n.t("data_187"),
          I18n.t("data_188"),
          I18n.t("data_189"),
          I18n.t("data_190")
        ],
        categories: [:d]
      ),

      new(
        id: 19,
        title: I18n.t("data_191"),
        image_url: "meds_taken.png",
        description: [
          I18n.t("data_167"),
          I18n.t("data_194")
        ],
        categories: [:d]
      ),

      new(
        id: 20,
        title: I18n.t("data_195"),
        image_url: "compare_med.png",
        description: [
          I18n.t("data_196"),
          I18n.t("data_197"),
          I18n.t("data_198")
        ],
        categories: [:a, :b]
      ),

      new(
        id: 21,
        title: I18n.t("data_199"),
        image_url: "cytoxan_cis.png",
        description: [
          I18n.t("data_200"),
          I18n.t("data_201"),
          I18n.t("data_202")
        ],
        categories: [:c]
      ),

      new(
        id: 22,
        title: I18n.t("data_203"),
        image_url: "improve_kidney_d.png",
        description: [
          I18n.t("data_204"),
          I18n.t("data_205"),
          I18n.t("data_206")
        ],
        categories: [:d],
        learn_more: I18n.t("data_574"),
        learn_more_id: 108
      ),

      new(
        id: 23,
        title: I18n.t("data_207"),
        image_url: "compare_med_higher.png",
        description: [
          I18n.t("data_208"),
          I18n.t("data_209"),
          I18n.t("data_210")
        ],
        categories: [:a, :b],
        learn_more: I18n.t("data_579"),
        learn_more_id: 109
      ),

      new(
        id: 24,
        title: I18n.t("data_211"),
        image_url: "kidney_failure_d.png",
        description: [
          I18n.t("data_212"),
          I18n.t("data_213"),
          I18n.t("data_214")
        ],
        categories: [:d]
      ),

      new(
        id: 25,
        title: I18n.t("data_215"),
        image_url: "kidney_flare.png",
        description: [
          I18n.t("data_216"),
          I18n.t("data_217"),
          I18n.t("data_218")
        ],
        categories: [:a, :b],
        learn_more: I18n.t("data_585"),
        learn_more_id: 110
      ),

      new(
        id: 26,
        title: I18n.t("data_219"),
        image_url: "reduce_kidney_flare.jpg",
        description: [
          I18n.t("data_220"),
          I18n.t("data_221"),
          I18n.t("data_222")
        ],
        categories: [:c]
      ),

      new(
        id: 27,
        title: I18n.t("data_223"),
        image_url: "two_women.jpg",
        description: [
          I18n.t("data_224"),
          I18n.t("data_225")
        ],
        categories: [:a, :b]
      ),

      new(
        id: 28,
        title: I18n.t("data_229"),
        image_url: "woman_close_up.jpg",
        description: [
          I18n.t("data_230"),
          I18n.t("data_231")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 29,
        title: I18n.t("data_232"),
        image_url: "hair_changes.png",
        description: [
          I18n.t("data_233"),
          I18n.t("data_234"),
          I18n.t("data_235"),
          I18n.t("data_236"),
          I18n.t("data_237"),
          I18n.t("data_238")
        ],
        categories: [:a, :b],
        learn_more: I18n.t("data_591"),
        learn_more_id: 111
      ),

      new(
        id: 30,
        title: I18n.t("data_239"),
        image_url: "cyt_cis_hair.jpg",
        description: [
          I18n.t("data_240"),
          I18n.t("data_241"),
          I18n.t("data_242"),
          I18n.t("data_243"),
          I18n.t("data_244"),
          I18n.t("data_245")
        ],
        categories: [:c]
      ),

      new(
        id: 31,
        title: I18n.t("data_246"),
        image_url: "hair_changes_d.jpg",
        description: [
          I18n.t("data_247"),
          I18n.t("data_248"),
          I18n.t("data_249"),
          I18n.t("data_250"),
          I18n.t("data_251"),
          I18n.t("data_252")
        ],
        categories: [:d]
      ),

      new(
        id: 32,
        title: I18n.t("data_253"),
        image_url: "stomach.png",
        description: [
          I18n.t("data_254"),
          I18n.t("data_255"),
          I18n.t("data_256"),
          I18n.t("data_257")
        ],
        categories: [:a, :b],
        learn_more: I18n.t("data_610"),
        learn_more_id: 114
      ),

      new(
        id: 33,
        title: I18n.t("data_258"),
        image_url: "stomach_problems.png",
        description: [
          I18n.t("data_259"),
          I18n.t("data_260"),
          I18n.t("data_261")
        ],
        categories: [:c]
      ),

      new(
        id: 34,
        title: I18n.t("data_262"),
        image_url: "nausea_d.png",
        description: [
          I18n.t("data_263"),
          I18n.t("data_264"),
          I18n.t("data_265")
        ],
        categories: [:d],
        learn_more: I18n.t("data_610"),
        learn_more_id: 114
      ),

      new(
        id: 35,
        title: I18n.t("data_266"),
        image_url: "cytoxan_imuran_diarrhea.png",
        description: [
          I18n.t("data_267"),
          I18n.t("data_268"),
          I18n.t("data_269"),
          I18n.t("data_270")
        ],
        categories: [:d],
        learn_more: I18n.t("data_610"),
        learn_more_id: 114
      ),

      new(
        id: 36,
        title: I18n.t("data_271"),
        image_url: "high_blood_pressure.png",
        description: [
          I18n.t("data_272"),
          I18n.t("data_273"),
          I18n.t("data_274")
        ],
        categories: [:c]
      ),

      new(
        id: 37,
        title: I18n.t("data_275"),
        image_url: "facial_hair_c.png",
        description: [
          I18n.t("data_276"),
          I18n.t("data_277"),
          I18n.t("data_278")
        ],
        categories: [:c],
        learn_more: I18n.t("data_601"),
        learn_more_id: 112
      ),

      new(
        id: 38,
        title: I18n.t("data_279"),
        image_url: "gum_swell.png",
        description: [
          I18n.t("data_280"),
          I18n.t("data_281"),
          I18n.t("data_282")
        ],
        categories: [:c],
        learn_more: I18n.t("data_606"),
        learn_more_id: 113
      ),

      new(
        id: 39,
        title: I18n.t("data_283"),
        image_url: "shingles.png",
        description: [
          I18n.t("data_284"),
          I18n.t("data_285"),
          I18n.t("data_286"),
          I18n.t("data_287")
        ],
        categories: [:a, :b]
      ),

      new(
        id: 40,
        title: I18n.t("data_288"),
        image_url: "shingles_cyt_cis.jpg",
        description: [
          I18n.t("data_289"),
          I18n.t("data_290"),
          I18n.t("data_291"),
          I18n.t("data_292")
        ],
        categories: [:c]
      ),

      new(
        id: 41,
        title: I18n.t("data_293"),
        image_url: "shingles_d.png",
        description: [
          I18n.t("data_294"),
          I18n.t("data_295"),
          I18n.t("data_296"),
          I18n.t("data_297")
        ],
        categories: [:d],
        learn_more: I18n.t("data_622"),
        learn_more_id: 116
      ),

      new(
        id: 42,
        title: I18n.t("data_298"),
        image_url: "six_four.png",
        description: [
          I18n.t("data_299"),
          I18n.t("data_300"),
          I18n.t("data_301"),
          I18n.t("data_302")
        ],
        categories: [:a, :b]
      ),

      new(
        id: 43,
        title: I18n.t("data_303"),
        image_url: "six_nine.png",
        description: [
          I18n.t("data_304"),
          I18n.t("data_305"),
          I18n.t("data_645"),
          I18n.t("data_646")
        ],
        categories: [:c]
      ),

      new(
        id: 44,
        title: I18n.t("data_303"),
        image_url: "six_seven.PNG",
        description: [
          I18n.t("data_304"),
          I18n.t("data_305"),
          I18n.t("data_306"),
          I18n.t("data_307")
        ],
        categories: [:d]
      ),

      new(
        id: 45,
        title: I18n.t("data_308"),
        image_url: "",
        description: [
          I18n.t("data_309"),
          I18n.t("data_310")
        ],
        categories: []
      ),
      new(
        id: 46,
        title: I18n.t("data_314"),
        image_url: "choice_similar.PNG",
        description: [
          I18n.t("data_315")
        ],
        categories: [:a]
      ),

      new(
        id: 47,
        title: I18n.t("data_314"),
        image_url: "similar_choice_b.PNG",
        description: [
          I18n.t("data_315")
        ],
        categories: [:b]
      ),

      new(
        id: 48,
        title: I18n.t("data_316"),
        image_url: "cyt_cis_diff.jpg",
        description: [
          I18n.t("data_317")
        ],
        categories: [:c]
      ),

      new(
        id: 49,
        title: I18n.t("data_318"),
        image_url: "similar_choice_d.png",
        description: [
          I18n.t("data_319")
        ],
        categories: [:d]
      ),

      new(
        id: 50,
        title: I18n.t("data_320"),
        image_url: "woman.jpeg",
        description: [
          I18n.t("data_321"),
          I18n.t("data_322")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 51,
        title: I18n.t("data_323"),
        image_url: "",
        description: [
          I18n.t("data_324"),
          I18n.t("data_325"),
          I18n.t("data_326"),
          I18n.t("data_327")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 52,
        title: I18n.t("data_328"),
        image_url: "iv.jpg",
        description: [
          I18n.t("data_329"),
          I18n.t("data_330"),
          I18n.t("data_331")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 53,
        title: I18n.t("data_332"),
        image_url: "two_pills.PNG",
        description: [
          I18n.t("data_333"),
          I18n.t("data_334"),
          I18n.t("data_335")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 54,
        title: I18n.t("data_336"),
        image_url: "woman_close_up.jpg",
        description: [
          I18n.t("data_337")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 55,
        title: I18n.t("data_338"),
        image_url: "woman_two.jpg",
        description: [
          I18n.t("data_339")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 56,
        title: I18n.t("data_340"),
        image_url: "benlysta.PNG",
        description: [
          I18n.t("data_341"),
          I18n.t("data_342"),
          I18n.t("data_343"),
          I18n.t("data_344")
        ],
        categories: [:active_kidneys],
        learn_more: I18n.t("data_574"),
        learn_more_id: 108
      ),

      new(
        id: 57,
        title: I18n.t("data_345"),
        image_url: "benlysta_risk.PNG",
        description: [
          I18n.t("data_346"),
          I18n.t("data_347"),
          I18n.t("data_348"),
          I18n.t("data_349")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 58,
        title: I18n.t("data_350"),
        image_url: "woman_two.jpg",
        description: [
          I18n.t("data_351")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 59,
        title: I18n.t("data_352"),
        image_url: "voclosporin.png",
        description: [
          I18n.t("data_353"),
          I18n.t("data_354"),
          I18n.t("data_355"),
          I18n.t("data_356")
        ],
        categories: [:active_kidneys],
        learn_more: I18n.t("data_574"),
        learn_more_id: 108
      ),

      new(
        id: 60,
        title: I18n.t("data_357"),
        image_url: "voclosporin_risk.png",
        description: [
          I18n.t("data_358"),
          I18n.t("data_359"),
          I18n.t("data_360"),
          I18n.t("data_361")
        ],
        categories: [:active_kidneys],
        learn_more: I18n.t("data_628"),
        learn_more_id: 117
      ),

      new(
        id: 61,
        title: I18n.t("data_362"),
        image_url: "voclosporin_death.png",
        description: [
          I18n.t("data_363"),
          I18n.t("data_364")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 62,
        title: I18n.t("data_365"),
        image_url: "voclosporin_highbp.png",
        description: [
          I18n.t("data_366"),
          I18n.t("data_367"),
          I18n.t("data_368")
        ],
        categories: [:active_kidneys]
      ),

      new(
        id: 63,
        title: I18n.t("data_369"),
        image_url: "elderly.jpg",
        description: [
          I18n.t("data_370"),
          I18n.t("data_371"),
          I18n.t("data_372")
        ],
        categories: [:active_kidneys]
      )



    ]
  end

  def self.sexspissues
      [
        new(
          id: 1,
          title: "Learning about my treatment options for Lupus",
          image_url: "group_4.jpg" ,
          description: ["This guide is for people with moderate to severe lupus."," What you learn in this guide will help you understand what is most important to you while deciding with your doctor how to manage your lupus."],
          categories: [:basic]
        )
    ]
  end

  def self.by_category(cat)
    all.select { |card| card.categories.include?(cat) }
  end

  def self.learn_cards
    [
      new(
          id: 101,
          title: I18n.t("data_537"),
          image_url: "weight_happy.jpeg" ,
          description: [
            I18n.t("data_538"),
            I18n.t("data_539"),
            I18n.t("data_540")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 102,
          title: I18n.t("data_542"),
          image_url: "creams.jpeg" ,
          description: [
            I18n.t("data_543"),
            I18n.t("data_544"),
            I18n.t("data_545")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 103,
          title: I18n.t("data_547"),
          image_url: "" ,
          description: [
            I18n.t("data_548"),
            I18n.t("data_549"),
            I18n.t("data_550")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 104,
          title: I18n.t("data_552"),
          image_url: "" ,
          description: [
            I18n.t("data_553"),
            I18n.t("data_554"),
            I18n.t("data_555"),
            I18n.t("data_556")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 105,
          title: I18n.t("data_558"),
          image_url: "" ,
          description: [
            I18n.t("data_559"),
            I18n.t("data_560"),
            I18n.t("data_561"),
            I18n.t("data_562"),
            I18n.t("data_563")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 106,
          title: I18n.t("data_565"),
          image_url: "weight_lift.jpeg" ,
          description: [
            I18n.t("data_566"),
            I18n.t("data_567"),
            I18n.t("data_568")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 107,
          title: I18n.t("data_570"),
          image_url: "doctor.jpeg" ,
          description: [
            I18n.t("data_571"),
            I18n.t("data_572"),
            I18n.t("data_573")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 108,
          title: I18n.t("data_575"),
          image_url: "doctor.jpeg" ,
          description: [
            I18n.t("data_576"),
            I18n.t("data_577"),
            I18n.t("data_578")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 109,
          title: I18n.t("data_580"),
          image_url: "doctor.jpeg" ,
          description: [
            I18n.t("data_581"),
            I18n.t("data_582"),
            I18n.t("data_583"),
            I18n.t("data_584")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 110,
          title: I18n.t("data_586"),
          image_url: "doctor.jpeg" ,
          description: [
            I18n.t("data_587"),
            I18n.t("data_588"),
            I18n.t("data_589"),
            I18n.t("data_590")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 111,
          title: I18n.t("data_592"),
          image_url: "hair_brush.jpg" ,
          description: [
            I18n.t("data_593"),
            I18n.t("data_594"),
            I18n.t("data_595"),
            I18n.t("data_596"),
            I18n.t("data_597"),
            I18n.t("data_598"),
            I18n.t("data_599"),
            I18n.t("data_600")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 112,
          title: I18n.t("data_602"),
          image_url: "" ,
          description: [
            I18n.t("data_603"),
            I18n.t("data_604"),
            I18n.t("data_605")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 113,
          title: I18n.t("data_607"),
          image_url: "" ,
          description: [
            I18n.t("data_608"),
            I18n.t("data_609")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 114,
          title: I18n.t("data_611"),
          image_url: "stomach_coping.jpg" ,
          description: [
            I18n.t("data_612"),
            I18n.t("data_613"),
            I18n.t("data_614"),
            I18n.t("data_615"),
            I18n.t("data_616")
          ],
          categories: [],
          hidden: false,
          learn_more: I18n.t("data_617"),
          learn_more_id: 115
        ),
        new(
          id: 115,
          title: I18n.t("data_618"),
          image_url: "stomach_coping.jpg" ,
          description: [
            I18n.t("data_619"),
            I18n.t("data_620"),
            I18n.t("data_621")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 116,
          title: I18n.t("data_623"),
          image_url: "" ,
          description: [
            I18n.t("data_624"),
            I18n.t("data_625"),
            I18n.t("data_626"),
            I18n.t("data_627")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 117,
          title: I18n.t("data_629"),
          image_url: "" ,
          description: [
            I18n.t("data_630"),
            I18n.t("data_631"),
            I18n.t("data_632"),
            I18n.t("data_633")
          ],
          categories: [],
          hidden: false
        ),
        new(
          id: 118,
          title: I18n.t("data_629"),
          image_url: "" ,
          description: [
            I18n.t("data_630"),
            I18n.t("data_631"),
            I18n.t("data_632"),
            I18n.t("data_633")
          ],
          categories: [],
          hidden: false
        )
    ]
  end
end
