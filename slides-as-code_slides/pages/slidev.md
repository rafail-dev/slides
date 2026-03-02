# Slidev by Anthony Fu

Framework for Presentation Slides

<div grid="~ cols-2 gap-x-8" class="mt-10 text-center">

  <div>
    <img src="/antfu.png" class="rounded-full w-48 mx-auto" />

  </div>

  <div>
    <img src="/slidev.svg" class=" w-48 mx-auto" />

  </div>

[antfu.me](https://antfu.me)

[Github](https://sli.dev)

</div>

_Core team of Vue, Nuxt, Vite_

---

# Getting Started

<div grid="~ cols-2 gap-x-8">

[Stackblitz](https://stackblitz.com/fork/github/stackblitz/starters/tree/main/slidev?title=Slidev%20Starter&description=Presentation%20slides%20for%20developers)

[This Presentation](https://github.com/rafail-dev/slides)

</div>

or [create](https://sli.dev/guide/) your own...

````md magic-move
```bash
bun create slidev
# npm init slidev@latest
# pnpm create slidev
# yarn create slidev
# deno init --npm slidev
```

```json
{
  "scripts": {
    "dev": "slidev --open",
    "build": "slidev build",
    "export": "slidev export"
  }
}
```
````

---

# Presenter UI

- ✏️ **Drawing** — annotate slides on the fly
- ⏱️ **Timer** — track your presentation time
- 📝 **Notes** — presenter notes, markdown supported
- 🔗 **Sync** — audience follows your current slide
- 🗂️ **Overview** — navigate all slides at a glance
- 📷 **Camera** — webcam overlay on slides
- 🎥 **Recording** — built-in recording mode

---
layout: iframe-right

# the web page source
url: https://sli.dev/builtin/layouts#layouts

# a custom class name to the content
class: my-cool-content-on-the-right
---

# Base

- [layouts](https://sli.dev/builtin/layouts#layouts)
- [themes](https://sli.dev/guide/theme-addon)
- [transitions](https://sli.dev/guide/animations#slide-transitions)
- [ui](https://sli.dev/guide/ui)
- [Vue](https://sli.dev/guide/component)
- ...

<Counter :count="10" m="t-8 b-4" />

```html
<Counter :count="10" />
```

---

# Slide Clicks

_Each slide has a click state — reflected in the URL_

<div v-click="[3, 6]">🎩</div>

<div grid="~ cols-3 gap-4" class="mt-8 text-center text-2xl">
  <div v-click>👆 one</div>
  <div v-click>✌️ two</div>
  <div v-click>🤟 three</div>
</div>

<div v-click="5" class="mt-6 text-center text-2xl">🖐️ five</div>

---

# Rough Markers

Annotate any text with <span v-mark.underline.orange="1">hand-drawn style markers</span>, triggered by clicks

Powered by <span v-mark.circle.purple="2">Rough Notation</span> — supports underline, circle, highlight, box, strike-through

Use `v-mark` <span v-mark.highlight.yellow="3">directive</span> directly on any HTML element in your slide

---
src: ./motion.md
---

---
src: ./draggable.md
---

---
layout: iframe-left
url: https://sli.dev/features
---

<div class="h-full flex flex-col">

  <div class="flex-1 flex items-center justify-center">

_Anything possible on a webpage is possible in Slidev_

  </div>

[sli.dev/features](https://sli.dev/features)

</div>

---

# Uno

_Tailwind-inspired, atomic, utility-first CSS framework_

<div grid="~ cols-3 gap-4" class="text-3xl text-center my-12">
  <div>🥕</div>
  <div>🌽</div>
  <div>🥦</div>
</div>

```html
<div grid="~ cols-3 gap-4" class="text-3xl text-center my-12">
  <div>🥕</div>
  <div>🌽</div>
  <div>🥦</div>
</div>
```

---
src: ./code-snippets.md
---

---
src: ./math.md
---

---
src: ./diagrams.md
---

---
src: ./ai.md
---
