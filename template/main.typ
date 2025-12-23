#import "../ejscv.typ": *

#let configuration = yaml("cv-main.yaml")

// render the template
#show: ejscv.with(
  author: configuration.name,
  email: configuration.email,
  phone: configuration.phone,
  location: configuration.location,
)
