#import "@preview/fontawesome:0.6.0": *

#let today = datetime.today()

// a global boolean to enable prompt injection for AI systems
#let use_injection = false

#set par(justify: true)
#set text(
  font: "Noto Sans",
  size: 10pt,
  hyphenate: false,
)

#show heading.where(level: 1): it => block(width: 100%)[
  #set align(left)
  #set text(13pt, weight: "regular")
  #underline[#smallcaps(it.body)]
]

#show heading.where(level: 2): it => text(
  size: 10pt,
  weight: "bold",
  style: "italic",
  it.body,
)

// contact
#let contact(
  author: "ejsdotsh",
  location: "",
  phone: "",
  email: "contactme@ejs.sh",
) = {
  grid(
    columns: (2fr, 1fr),
    [
      #align(left)[#text(32pt)[#author]]
    ],
    [
      #align(right)[
        #set list(marker: none)
        #if location != "" [
          - #fa-icon(
              "location-dot",
              size: 0.9em,
            ) #h(0.05cm) #location
        ]
        #if phone != "" [
          - #fa-icon("phone", size: 0.9em) #h(0.05cm) #phone
        ]
        #if email != "" [
          - #fa-icon("envelope", size: 0.9em) #h(0.05cm) #email
        ]
      ]
    ],
  )
}

// summary
#let main_summary() = {
  set list(marker: (none, [•]))
  [
    - #block(breakable: false)[
        #if (
          configuration.main_summary.summary != none
        ) [#configuration.main_summary.summary]
        #if configuration.main_summary.highlights != none [
          #for highlight in configuration.main_summary.highlights {
            [- #highlight]
          }
        ]
      ]
  ]

  set par(justify: true, spacing: 1.2em)
}

// technologies and languages
#let technologies_and_languages() = {
  [= technologies and languages]
  // set par(
  //   justify: false,
  //   spacing: 1em,
  //   )
  // table(
  //   stroke: none,
  //   columns: (1fr, 1fr, 1fr),
  //   align: (start, start, start),
  //   // gutter: 0pt,
  //   ..configuration.core_skills,
  // )
  set par(justify: true, spacing: 1.2em)
  for category in configuration.skills {
    set list(marker: none)
    [- / #category.label: #category.skill.join(" - ")]
  }
}

// links to linkedin, github, website, etc.
#let links() = {
  [= links]
  set list(marker: none)
  for link in configuration.links {
    [- #fa-icon(link.name, size: 0.9em) #h(0.05cm) #text(9pt)[#link.url]]
  }
}

// education
#let education() = {
  [= education]
  for ed in configuration.education {
    set list(marker: none)
    [- #text(weight: "bold")[#ed.degree, #ed.area]]
    [- #ed.institution]
  }
}

// Function to handle prompt injection for AI systems
// adapted from https://github.com/ToyHugs/toy-cv
#let inject-keywords(keywords-injection) = {
    let prompt-ai = "technologies:"

    if keywords-injection != none {
      prompt-ai = prompt-ai + " " + keywords-injection.join(" ")
    }

    place(text(prompt-ai, size: 1pt, fill: white), dx: 0pt, dy: 0pt)
  }


// professional experience
#let professional_experience() = {
  [= professional experience]
  for job in configuration.jobs {
    set list(marker: (none, none, [•]))
    [
      - #block(breakable: false)[
          #grid(
            columns: (1fr, auto),
            [
              #align(left)[== #job.company]
            ],
            [
              #align(right)[== #job.title
                | #job.start_date \- #job.end_date
              ]
            ],
          )
          // - #if job.asn != none [(AS#job.asn)]
          - #if job.summary != none [#job.summary]
            #if job.highlights != none [
              #for item in job.highlights {
                [- #item]
              }
            ]
            #if use_injection and job.keywords != none [#inject-keywords(job.keywords)]
        ]
    ]
  }
}

// select projects
#let select_projects() = {
  [= select projects]
  for project in configuration.projects {
    set list(marker: (none, [•]))
    [
      - #grid(
          columns: (1fr, auto),
          [
            #align(left)[#text(weight: "bold")[#project.name]]
          ],
          [
            #align(right)[#project.start_date - #project.end_date]
          ],
        )
    ]
    [
      - #if project.summary != none [#project.summary]
        - #if project.url != none [#project.url]
    ]
  }
}

// certifications and affiliations/membership
#let certifications_and_affiliations() = {
  [= certifications and affiliations]
  set list(marker: none)
  for aac in configuration.affiliations {
    [
      - #grid(
          columns: (auto, 1fr),
          [
            #align(left)[
              #if aac.name != none [#aac.role \- #aac.name] else [#aac.role]
            ]
          ],
          [
            #align(right)[#aac.start_date\-#aac.end_date]
          ],
        )
    ]
  }
}

// footer definition
#let footer(
  email: "",
  phone: "",
) = {
  set text(8pt)
  grid(
    columns: (1fr, 1fr, 1fr),
    [
      #align(left)[
        last updated: #today.display()
      ]
    ],
    [
      #align(center)[
        #counter(page).display("1 of 1", both: true)
      ]
    ],
    [
      #align(right)[
        #email | #phone
      ]
    ],
  )
}


// define the CV layout
#let ejscv(
  author: "",
  email: "",
  phone: "",
  location: "",
  doc,
) = {
  set page(
    paper: "us-letter",
    margin: (x: 2cm, y: 1cm),
    footer: context [
      #footer(
        email: email,
        phone: phone,
      )
    ],
  )

  contact(
    author: author,
    email: email,
    phone: phone,
    location: location,
  )

  line(length: 100%, start: (0%, 0%), stroke: 0.5pt)

  v(1em)
  pad(
    left: 1.5em,
    right: 1.5em,
    main_summary(),
  )

  v(1em)
  technologies_and_languages()

  v(1em)
  professional_experience()

  v(1em)
  certifications_and_affiliations()

  v(1em)
  grid(
    columns: (1fr, 2fr),
    [
      // #links()
      #education()
    ],
    [
      #links()
      // #select_projects()
    ],
  )
}
