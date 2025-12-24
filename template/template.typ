#let configuration = yaml("template.yaml")

// for local development, uncomment/use an absolute path
#import "../ejscv.typ": *
// #import "@preview/ejscv:0.1.0": *

// render the template
#show: ejscv.with(
  author: configuration.contact.name,
  email: configuration.contact.email,
  phone: configuration.contact.phone,
  location: configuration.contact.location,
)
