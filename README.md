<!--
SPDX-FileCopyrightText: 2025-present git@ejs.sh
-->

# EJ's CV Template

I've been using LaTeX (XeTeX) as the primary source for my CV since 2008ish. Although Tectonic was a huge improvement
in consistently building the PDF, making any update was a slow and tedious process. I was first introduced to Typst by a
previous coworker who recommended the [RenderCV](https://github.com/rendercv/rendercv) generator.

This template is the result of what I've learned.

## JSON Schema

Put the following line at the top of the YAML data file to use the JSON schema for interactive autocompletion and
inline documentation with the [yaml-language-server](https://github.com/redhat-developer/yaml-language-server) in an
IDE/editor:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/ejsdotsh/ejscv/refs/heads/main/ejscv.typ.schema.json
```

## Usage

This package is intended to be used by importing the template [entrypoint](https://github.com/ejsdotsh/ejscv/blob/main/ejscv.typ);
please see [template.typ](template/template.typ) for a complete example.

## References

- [RenderCV](https://github.com/rendercv/rendercv)
- [Modern-CV](https://github.com/DeveloperPaul123/modern-cv)
- [ImpreCV](https://github.com/jskherman/imprecv)
- [FreeCV](https://github.com/Freezy727/FreeCV)
