# AI PDF Reviewer - App Preview

## 📱 Screen Mockups & Features

### 🎨 Color Scheme
```
Primary Purple:    #6C63FF
Secondary Green:   #4CAF50
Light Gray BG:     #F5F7FA
White Cards:       #FFFFFF
Dark Text:         #2D3436
```

---

## Screen 1: SPLASH SCREEN (2-3 seconds)

```
┌─────────────────────────────────┐
│                                 │
│     🟣 🟣 🟣 🟣 🟣 🟣 🟣       │
│    🟣 Gradient Purple BG 🟣     │
│     🟣 🟣 🟣 🟣 🟣 🟣 🟣       │
│                                 │
│           ╔════════╗            │
│           ║   📄   ║ (animated) │
│           ║ rotating║           │
│           ╚════════╝            │
│                                 │
│      AI PDF Reviewer            │
│   (Bold, Large, White)          │
│                                 │
│   Smart Document Analysis       │
│  (Subtitle, Gray, Smaller)      │
│                                 │
│    🎬 Fade-in animation        │
│    ↑  Scale animation (elastic) │
│                                 │
└─────────────────────────────────┘

Animation:
  • 0.0s: Opacity 0%, Scale 0.5x
  • 0.75s: Opacity 100%, Scale 1.0x (elastic)
  • 2.25s: Hold at full opacity
  • 3.0s: Navigate to Home Screen
```

---

## Screen 2: HOME SCREEN

```
┌─────────────────────────────────┐
│  Status Bar (System)            │
├─────────────────────────────────┤
│                                 │
│   ⬆️  (Soft gradient BG)        │
│   F5F7FA to E8EAF6              │
│                                 │
│            40px space           │
│                                 │
│   AI PDF Reviewer               │
│   (36px, Bold, Purple)          │
│                                 │
│   12px space                    │
│                                 │
│   Upload your PDF and get       │
│   instant smart insights        │
│   (16px, Gray, Centered)        │
│                                 │
│            60px space           │
│                                 │
│  ╔═══════════════════════════╗  │
│  ║                           ║  │
│  ║   ╭─────────────────╮     ║  │
│  ║   │   📤 (80px)    │     ║  │
│  ║   ╰─────────────────╯     ║  │
│  ║                           ║  │
│  ║   ┌──────────────────┐    ║  │
│  ║   │  Select PDF ✓   │    ║  │
│  ║   └──────────────────┘    ║  │
│  ║  (ElevatedButton, Purple) ║  │
│  ║                           ║  │
│  ║   📄 document.pdf         ║  │
│  ║   (filename display)      ║  │
│  ║                           ║  │
│  ╚═══════════════════════════╝  │
│  (Card, Elevation 8, Rounded)   │
│                                 │
│            32px space           │
│                                 │
│  ╔═══════════════════════════╗  │
│  ║  Review PDF Watch Ad 🎬   ║  │
│  ║  (Gradient Button, Purple) ║  │
│  ║  64px height, Bold Text    ║  │
│  ║  • Disabled if no PDF      ║  │
│  ║  • Loading spinner if busy ║  │
│  ╚═══════════════════════════╝  │
│                                 │
│            Auto (spacer)        │
│                                 │
│  Watch a short ad to unlock    │
│  AI analysis                   │
│  (12px, Gray, Centered)        │
│                                 │
│            8px space           │
│                                 │
└─────────────────────────────────┘

Animations:
  • Screen fade-in on entry
  • Button hover effects
  • Smooth state transitions
  • File picker opens on tap
```

**Home Screen Actions:**

```
┌─ Select PDF Button ─────────────────┐
│ Taps "Select PDF"                   │
│ ↓                                   │
│ File Picker opens (PDF filter)      │
│ User chooses document               │
│ ↓                                   │
│ Filename appears below button ✓     │
│ "Review PDF" button enables         │
└─────────────────────────────────────┘

┌─ Review PDF Button ─────────────────┐
│ Taps "Review PDF (Watch Ad First)"  │
│ ↓                                   │
│ Ad readiness checked                │
│ ├─ Not ready? Show error dialog     │
│ └─ Ready? Show rewarded ad          │
│ ↓                                   │
│ User watches ad (30-60 seconds)     │
│ ↓                                   │
│ Reward granted by AdMob             │
│ ↓                                   │
│ Loading dialog appears:             │
│  "Analyzing your document..."       │
│ ↓                                   │
│ PDF text extracted                  │
│ Text sent to Gemini API             │
│ AI analysis performed               │
│ ↓                                   │
│ Navigate to Review Screen           │
│ with analysis results               │
└─────────────────────────────────────┘
```

---

## Screen 3: REVIEW SCREEN (Results)

```
┌─────────────────────────────────┐
│ ◀ | PDF Analysis | ⋮           │  (AppBar)
├─────────────────────────────────┤
│                                 │
│  📜 SUMMARY              ← (card animation 1)
│  ╔═══════════════════════════╗  │
│  ║ 🟣 (purple icon)         ║  │
│  ║                           ║  │
│  ║ SUMMARY                   ║  │
│  ║                           ║  │
│  ║ This comprehensive        ║  │
│  ║ analysis shows that...    ║  │
│  ║ (7-10 sentences)          ║  │
│  ║ ...is critical for        ║  │
│  ║ success in this domain.   ║  │
│  ╚═══════════════════════════╝  │
│                                 │
│            16px gap             │
│                                 │
│  📋 KEY POINTS          ← (card animation 2)
│  ╔═══════════════════════════╗  │
│  ║ 🟠 (orange icon)         ║  │
│  ║                           ║  │
│  ║ KEY POINTS                ║  │
│  ║                           ║  │
│  ║ • First key point about   ║  │
│  ║   the document content    ║  │
│  ║                           ║  │
│  ║ • Second important point  ║  │
│  ║   extracted from text     ║  │
│  ║                           ║  │
│  ║ • Third critical takeaway ║  │
│  ║   for user understanding  ║  │
│  ╚═══════════════════════════╝  │
│                                 │
│            16px gap             │
│                                 │
│  💡 ACTIONABLE INSIGHTS ← (card animation 3)
│  ╔═══════════════════════════╗  │
│  ║ 🟢 (green icon)           ║  │
│  ║                           ║  │
│  ║ ACTIONABLE INSIGHTS       ║  │
│  ║                           ║  │
│  ║ Consider implementing...  ║  │
│  ║ The document suggests     ║  │
│  ║ that prioritizing...      ║  │
│  ║ would lead to improved    ║  │
│  ║ outcomes...               ║  │
│  ╚═══════════════════════════╝  │
│                                 │
│            16px gap             │
│                                 │
│  ❓ ASK AI ANYTHING     ← (card animation 4)
│  ╔═══════════════════════════╗  │
│  ║ 🔵 (blue icon)            ║  │
│  ║                           ║  │
│  ║ ASK AI ANYTHING           ║  │
│  ║                           ║  │
│  ║ ┌─────────────────────┐   ║  │
│  ║ │ Type your question  │   ║  │
│  ║ │ about this doc...   │   ║  │
│  ║ │ (3 lines max)       │   ║  │
│  ║ └─────────────────────┘   ║  │
│  ║                           ║  │
│  ║ ┌──────────────────────┐  ║  │
│  ║ │  ➤ Ask Question     │  ║  │
│  ║ │ (Blue Button)       │  ║  │
│  ║ └──────────────────────┘  ║  │
│  ╚═══════════════════════════╝  │
│                                 │
│  [If Question Asked]             │
│                                 │
│  🤖 AI ANSWER           ← (appears on demand)
│  ╔═══════════════════════════╗  │
│  ║ 🤖 | AI ANSWER           ║  │
│  ║                           ║  │
│  ║ Based on the document,    ║  │
│  ║ the answer to your        ║  │
│  ║ question is... [AI         ║  │
│  ║ generated response with    ║  │
│  ║ context from PDF]          ║  │
│  ║                           ║  │
│  ║ User can ask more...      ║  │
│  ╚═══════════════════════════╝  │
│                                 │
│            32px space           │
│                                 │
└─────────────────────────────────┘

Card Animations (Staggered):
  • Card 1 (Summary): Fade-in + slide up, delay 0ms
  • Card 2 (Key Points): Fade-in + slide up, delay 150ms
  • Card 3 (Insights): Fade-in + slide up, delay 300ms
  • Card 4 (Ask): Fade-in + slide up, delay 450ms
  • All cards: 400ms animation duration
  • Total: 1200ms from screen load

Colors per Card:
  ✓ Summary: Purple accent (#6C63FF)
  ✓ Key Points: Orange accent (#FF9800)
  ✓ Insights: Green accent (#4CAF50)
  ✓ Ask AI: Blue accent (#2196F3)
  ✓ Answer: Light blue background
```

---

## 🔄 Complete User Journey

```
START
  ↓
┌─────────────────────────────────┐
│ Splash Screen (3 sec)           │
│ • Logo animation                │
│ • Fade in + scale               │
│ • Auto navigate to Home         │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Home Screen                      │
│ • Clean gradient background     │
│ • Title + subtitle              │
│ • PDF selection card            │
│ • Disabled review button        │
│ • "Watch a short ad..." text    │
└─────────────────────────────────┘
  ↓
User taps "Select PDF"
  ↓
┌─────────────────────────────────┐
│ Native File Picker              │
│ • Filter: .pdf only             │
│ • User selects document         │
└─────────────────────────────────┘
  ↓
Back to Home Screen with:
  • Filename displayed ✓
  • Review button now ENABLED
  ↓
User taps "Review PDF (Watch Ad First)"
  ↓
┌─────────────────────────────────┐
│ Rewarded Ad Display             │
│ • Full screen ad (30-60 sec)    │
│ • User watches to get reward    │
│ • Test ad auto-plays in debug   │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Loading Dialog                  │
│ "Analyzing your document..."    │
│ • PDF text extracted            │
│ • Sent to Gemini API            │
│ • AI generates analysis         │
│ • ~5-15 seconds                 │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Review Screen (Animated Load)   │
│ • Summary card (fade in)        │
│ • Key Points card (150ms delay) │
│ • Insights card (300ms delay)   │
│ • Ask AI card (450ms delay)     │
│ • Scroll enabled                │
└─────────────────────────────────┘
  ↓
User reads analysis & scrolls
  ↓
User types question in "Ask AI Anything"
  ↓
User taps "Ask Question"
  ↓
┌─────────────────────────────────┐
│ Loading State                   │
│ • Input field disabled          │
│ • Button shows spinner          │
│ • "Processing..."              │
│ • ~3-5 seconds                  │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ AI Answer Card Appears          │
│ • Smooth fade-in                │
│ • Styled with blue accent       │
│ • Context-aware response        │
└─────────────────────────────────┘
  ↓
User can:
  ✓ Ask more questions
  ✓ Scroll to see all results
  ✓ Back arrow to return to Home
  ↓
If User taps back:
  → Returns to Home Screen
  → Can select another PDF
  → Process repeats
```

---

## 🎨 Design Details

### Typography

```
Splash Screen:
  • Title: 32px, Bold, White
  • Subtitle: 16px, Regular, White opacity 0.9

Home Screen:
  • Main Title: 36px, Bold, #2D3436
  • Subtitle: 16px, Regular, #636E72
  • Button Text: 18px, Bold, White
  • Helper Text: 12px, Regular, #636E72

Review Screen:
  • AppBar Title: 20px, SemiBold, #2D3436
  • Section Headers: 22px, Bold, #2D3436
  • Body Text: 15px, Regular, #2D3436
  • Line Height: 1.6x (24px for 15px text)
  • Input Hint: 14px, Regular, Gray
```

### Spacing System (8px grid)

```
Card Padding:       20px (2.5 x 8px)
Screen Padding:     24px (3 x 8px)
Between Cards:      16px (2 x 8px)
Icon to Text:       12px (1.5 x 8px)
Button Height:      56-64px (7-8 x 8px)
Rounded Corners:    12-20px
Icon Sizes:         24-80px
```

### Elevation & Shadows

```
Cards:       elevation 6, blur 12px, offset 6px
Buttons:     elevation 4, blur 8px, offset 4px
Icons:       No shadow (overlaid on cards)
```

---

## 📊 Visual Hierarchy

```
LEVEL 1 (Highest Priority)
  • Main action buttons (Review PDF)
  • Section headers (SUMMARY, KEY POINTS)
  • Large numeric values
  → Size: 22-36px, Bold, Primary color

LEVEL 2 (Important Content)
  • Card titles
  • Body text
  • Input fields
  → Size: 15-18px, Medium/Regular

LEVEL 3 (Supporting)
  • Helper text
  • Timestamps
  • Metadata
  → Size: 12-14px, Regular, Gray
```

---

## 🎬 Animation Timeline

### Splash Screen
```
Time    Element              Action
────────────────────────────────────
0ms     Logo + Text          Start (opacity 0%, scale 50%)
75ms    Logo + Text          Animating (fade + scale)
750ms   Logo + Text          Done (opacity 100%, scale 100%)
2000ms  Logo + Text          Hold
2900ms  Screen               Fade out
3000ms  →                    Navigate to Home
```

### Review Screen Cards
```
Time    Card             Action
────────────────────────────────────
0ms     All cards        Start hidden
0ms     Summary          Fade in (0→100%) + slide up
75ms    Key Points       Fade in (0→100%) + slide up
225ms   Insights         Fade in (0→100%) + slide up
375ms   Ask AI           Fade in (0→100%) + slide up
525ms   All cards        Hold at full opacity
```

---

## 💬 Dialog Examples

### Ad Loading Failure
```
┌─────────────────────────────┐
│  ⚠️  Ad Failed               │
├─────────────────────────────┤
│                             │
│  Failed to load rewarded    │
│  ad. Please try again in a  │
│  moment.                    │
│                             │
├─────────────────────────────┤
│                    [OK]     │
└─────────────────────────────┘
```

### API Error
```
┌─────────────────────────────┐
│  ⚠️  Error                   │
├─────────────────────────────┤
│                             │
│  AI Analysis failed:        │
│  [API error message]        │
│                             │
├─────────────────────────────┤
│                    [OK]     │
└─────────────────────────────┘
```

### Loading Analysis
```
┌─────────────────────────────┐
│                             │
│       ⟳ (spinning)          │
│                             │
│   Analyzing your           │
│   document...              │
│                             │
│  This may take a few       │
│  moments                   │
│                             │
└─────────────────────────────┘
(Modal, non-dismissible)
```

---

## 🎯 Color Usage Guide

```
PRIMARY (#6C63FF) - Purple
  Used for:
  • Main action buttons
  • Summary card accent
  • Icons in primary context
  • Links and highlights

SECONDARY (#4CAF50) - Green
  Used for:
  • Success states
  • Actionable Insights card
  • Confirmation icons
  • Positive indicators

ACCENT COLORS
  Orange (#FF9800) → Key Points
  Blue (#2196F3) → Ask AI questions
  Purple (#6C63FF) → Summary

NEUTRALS
  Dark Text (#2D3436) → Primary content
  Gray Text (#636E72) → Secondary content
  Light BG (#F5F7FA) → Page background
  White (#FFFFFF) → Card background

GRADIENTS
  Background: #F5F7FA → #E8EAF6 (light lavender)
  Button: #6C63FF → #5A52D5 (darker purple)
```

---

## 📱 Responsive Design

```
All layouts optimized for:
  • Portrait orientation (locked)
  • Mobile-first design
  • Min 320px width (old phones)
  • Max 480px optimal width
  • Padding adjusts automatically
  • Text scales with system settings
  • Safe area respected (notches, etc)
```

This is your complete visual preview! The app is production-ready and waiting for your API key.
