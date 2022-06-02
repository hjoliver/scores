\version "2.22.2"

% From the "Real Book" lead sheet, then tweaked to be more like 
% a Jens Larsen chord melody arrangement in Gm.
\header {
  title = "Autumn Leaves"
  subtitle = "Chord Melody Arrangement in Em"
  composer = "Joseph Kosma"
  arranger = "Butchered by HilsTheSlayer"
  instrument = "for Guitar"
}


%{
  NOTES:
  - chordmode: can't control which string notes are on?
  - automatic chord naming, from same score:
    - works if the inversion is correct?
      (otherwise weird results require
      hardwiring exceptions?)
    - no good for chord-melody: single notes get named too
%}

\language "english"

voltaVarA = \markup \text "Var. A"
voltaVarB = \markup \text "Var. B"

music = {
  \key e \minor
  \partial 2.

  \relative {
    \set TabStaff.restrainOpenStrings = ##t

    \set TabStaff.minimumFret = 4
    r8 e8 fs4 g |

    \repeat volta 2 {
      c2 <a,\6 g' c>4.  <d\5 fs\4 c'\3>8 |
      r4 r8 d8 e4 fs |
      \set TabStaff.minimumFret = 2
      b2\3 <g,\6 fs'\4 b\3>4. <c\5 e\4 b'\3>8 |
      r4 r8 c8 d4 e\5 |
      a2\4 <fs\5 a\4 e'\3>4. <b,\6 a'\4 ds\3>8  |
    }
    \alternative{
      {
        \set TabStaff.minimumFret = 5
        r4 r8 b8 cs4 ds |
        g2\4 <e g cs>4.  <e g cs>8 |
        r4 r8 e8\5 fs4\4 g |
      }
      {
        r4 fs4 a g |
        e2\5 <e g cs>4. <e g cs>8 |
        r4 r8 e8 ds4 e |
      }
    }
    fs b,8 fs'8( fs4) <fs\5 a\4 e'\3>4 |
    <b,\6 a'\4 ds\3>4
    \set TabStaff.minimumFret = 5
    r8 fs'8 e4 fs |
    g2\4 <e g cs>4.  <e g cs>8 |
    r4 r8 g8 fs4\4 g |
    a2 <a,\6 g' c>4. <d\5 fs\4 c'\3>8 |
    r4 d4 d' c |
    b2\3 <g,\6 fs'\4 b\3>4. <c\5 e\4 b'\3>8 |
    r4 r8 b'\4 as4\4 b\4 |
    <fs\5 c'\4 e\3 a\2>4 c'\4 <fs,\5 a\4 e'\3>4 a |
    \set Score.alternativeNumberingStyle = #'numbers-with-letters

    <b,\6 a'\4 ds\3>2. a'4 |
    \repeat volta 2 {}
    \alternative {
      {
        \set Score.repeatCommands = #(list(list 'volta voltaVarA))
        <e g d'>2  <a,\6 g' cs>2 |
        \set TabStaff.minimumFret = 3
        <d\5 f\4 c'>2  <g,\6 f' b\3>4 e'\4  \bar "||" |
      }

      {
        \set Score.repeatCommands = #(list(list 'volta voltaVarB))
        <e g d'>2  <ef g cs>2 |
        \set TabStaff.minimumFret = 3
        <d\5 f\4 c'>2  <df\5 f b\3>4 e\4 \bar "|." |
      }
    }
    <c\5 e\4 a\3>2. g'4 |
    fs2 g4 b, |
    e2\5 <e g cs>4.  <e g cs>8_\markup{\italic "fine"} |
    \bar "|."  % this end bar required to get 2nd volta full extent?
    r4 r8 e8_\markup{"repeat..."} fs4 g |
  }
}

chnames = {
  \chordmode{
    s2. |
    \repeat volta 2 {
      s2 a4.:m7 d8:7 |
      s1 |
      s2 g4.:maj7 c8:maj7 |
      s1 |
      s2 fs4.:m7.5- b8:7 |
    }
    \alternative{
      {
        s1 |
        s2 e4:m6 s4 |
        s1 |
      }
      {
        s1 |
        s2 e4:m6 s4 |
        s1 |
      }
    }
    s2. fs4:m7.5- |
    b4:7 s2. |
    s2 e4:m6 s4 |
    s1 |
    s2 a4.:m7  d8:7 |
    s1 |
    s2 g4.:maj7  c8:maj7 |
    s1 |
    fs4:m7.5- s4 fs4:m7.5- s4 |

    b2.:7 s4 |
    \repeat volta 2 {}
    \alternative {
      {
        \set Score.repeatCommands = #(list(list 'volta voltaVarA))
        e2:m7  a2:7 |
        d2:m7  g2:7  \bar "||" |
      } 
      {
        \set Score.repeatCommands = #(list(list 'volta voltaVarB))
        e2:m7  ef2:7 |
        d2:m7  df2:7 \bar "|." |
      }
    }
    c2.:6 s4 |
    s1 |
    s2 e4.:m6 s8
  }
}

\score {
  <<
    \new ChordNames {
      \set majorSevenSymbol = \markup { \whiteTriangleMarkup 7 }
      \chnames 
    }
    \new Staff \with { \omit StringNumber } {
      \clef "treble_8"
      \numericTimeSignature
      \time 4/4
      \music
    }
    \new TabStaff {
      \clef "moderntab"
      \music
    }
  >>
  \layout {
    \context {
      \Score
      % wider horizontal spacing
      \override SpacingSpanner.base-shortest-duration = #(ly:make-moment 1/16)
    }
  }
}

\paper {
  #(define fonts
  (make-pango-font-tree "Times New Roman"
                        "Nimbus Sans,Nimbus Sans L"
                        "Luxi Mono"
                        (/ staff-height pt 20)))
}
