<h1 align="center">Momentum.com</h1>

<p align="center">
  A modern iOS reflex game built with <b>SwiftUI</b> and <b>SpriteKit</b>.
</p>

<p align="center">
  <b>Train your reflexes. Improve your precision. React faster.</b>
</p>

---

## About

Momentum is a reaction-speed game where players must tap disappearing points as quickly and accurately as possible.

The goal is to build a unique, scalable, and polished mobile game where each session feels different through procedural gameplay, difficulty-based configurations, XP progression, and future game modes.

This project is open source and welcomes ideas, suggestions, improvements, and contributions.

---

## Tech Stack

<ul>
  <li><b>Swift</b> — Core programming language</li>
  <li><b>SwiftUI</b> — Menus, interface, overlays, pause UI, XP display</li>
  <li><b>SpriteKit</b> — Game scene, point rendering, actions, touch interaction</li>
  <li><b>Foundation</b> — Timers, configuration, core utilities</li>
</ul>

---

## Current Features

<ul>
  <li>Main menu with difficulty selection</li>
  <li>Procedural point spawning</li>
  <li>Interactive touchable points</li>
  <li>XP system</li>
  <li>Pause and resume logic</li>
  <li>Countdown before resuming</li>
  <li>Difficulty-based configuration</li>
</ul>

---

## Architecture

```text
Reflexity
├── Models
│   ├── Difficulty.swift
│   └── Difficulty+Configuration.swift
│
├── Game
│   ├── GameScene.swift
│   ├── GameConfiguration.swift
│   ├── MomentumPoint.swift
│   ├── PointSpawner.swift
│   ├── TouchableNode.swift
│   └── Experience.swift
│
├── Views
│   ├── ContentView.swift
│   ├── GameView.swift
│   └── DifficultyButton.swift
│
└── Assets
