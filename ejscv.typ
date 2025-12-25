#import "@preview/fontawesome:0.6.0": *

// utility functions
#import "utils.typ": *

// title/contact block
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
#let main_summary(cvdata) = {
  set list(marker: (none, [•]))
  [
    - #block(breakable: false)[
        #if (
          cvdata.summary != none
        ) [#cvdata.summary]
        #if cvdata.highlights != none [
          #for highlight in cvdata.highlights {
            [- #highlight]
          }
        ]
      ]
  ]
  set par(justify: true, spacing: 1.2em)
}

// technologies and languages
#let technologies_and_languages(technologies) = {
  [= technologies and languages]
  set par(justify: true, spacing: 1.2em)
  for category in technologies {
    set list(marker: none)
    [- / #category.label: #category.skill.join(" - ")]
  }
}

// professional experience
#let professional_experience(jobs) = {
  [= professional experience]
  for job in jobs {
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
        ]
    ]
  }
}

// projects and affiliations/membership
#let projects_and_affiliations(projects, affiliations) = {
  [= projects and affiliations]
  for project in projects {
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
  set list(marker: none)
  for afln in affiliations {
    [
      - #grid(
          columns: (auto, 1fr),
          [
            #align(left)[
              #if afln.name != none [#afln.role \- #afln.name] else [#afln.role]
            ]
          ],
          [
            #align(right)[#afln.start_date\-#afln.end_date]
          ],
        )
    ]
    [
      - #if afln.summary != none [#afln.summary]
        - #if afln.url != none [#afln.url]
    ]
  }
}

// links to linkedin, github, website, etc.
#let links(links) = {
  [= links]
  set list(marker: none)
  for link in links {
    [- #fa-icon(link.name, size: 0.9em) #h(0.05cm) #text(9pt)[#link.url]]
  }
}

// education
#let education_and_certifications(education, certifications) = {
  [= education and certifications]
  set list(marker: none)
  for cert in certifications {
    [
      - #grid(
          columns: (auto, 1fr),
          [
            #align(left)[
              #if cert.name != none [#cert.name]
            ]
          ],
          [
            #align(right)[#cert.start_date\-#cert.end_date]
          ],
        )
    ]
  }
  for edu in education {
    set list(marker: none)
    [- #text(weight: "bold")[#edu.degree, #edu.area]]
    [- #edu.institution]
  }
}

// footer definition
#let footer(
  email: "contactme@ejs.sh",
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


// finally, define the CV layout
#let ejscv(
  cvdata,
  doc,
) = {
  set par(justify: true)
  set text(
    font: "Noto Sans",
    size: 10pt,
    hyphenate: false,
  )
  // underline and make smallcaps all H1
  show heading.where(level: 1): it => block(width: 100%)[
    #set align(left)
    #set text(13pt, weight: "regular")
    #underline[#smallcaps(it.body)]
  ]
  // italicize all H2
  show heading.where(level: 2): it => text(
    size: 10pt,
    weight: "bold",
    style: "italic",
    it.body,
  )
  // set the page size
  set page(
    paper: "us-letter",
    margin: (x: 2cm, y: 1cm),
    footer: context [
      #footer(
        email: cvdata.contact.email,
        phone: cvdata.contact.phone,
      )
    ],
  )
  // populate the contact information
  contact(
    author: cvdata.contact.name,
    email: cvdata.contact.email,
    phone: cvdata.contact.phone,
    location: cvdata.contact.location,
  )
  // draw a horizontal line
  line(length: 100%, start: (0%, 0%), stroke: 0.5pt)
  // insert 1em of vertical spacing
  v(1em)
  // add more space to the side margins, but only for the summary block
  pad(
    left: 1.5em,
    right: 1.5em,
    main_summary(cvdata.main_summary),
  )
  // insert 1em of vertical spacing
  v(1em)
  technologies_and_languages(cvdata.skills)
  // insert 1em of vertical spacing
  v(1em)
  professional_experience(cvdata.jobs)
  // insert 1em of vertical spacing
  v(1em)
  projects_and_affiliations(cvdata.projects, cvdata.affiliations)
  // insert 1em of vertical spacing
  v(1em)
  grid(
    columns: (1fr, 2fr),
    [
      #links(cvdata.contact.links)
    ],
    [
      #education_and_certifications(cvdata.education, cvdata.certifications)
    ],
  )
}
