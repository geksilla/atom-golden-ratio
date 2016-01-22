# golden-ratio package

Golden ratio scaling for panes. Automaticaly resize pane with active item.
![golden-ratio-demo](http://i.imgur.com/FuzyCXa.gif)

## Usage

Run command via __Command Palette__ -> __Golden Ratio: Toggle__, context menu or
add custom keymap:
```cson
'atom-workspace':
  '<your_keys_here>': 'golden-ratio:toggle'
```

For better experience uncheck __Soft Wrap__ option from __Settings View -> Settings -> Editor__.

## Configuration

Name                       | Default | Description
---------------------------|---------|------------
'golden-ratio.scaleFactor' | 1       | Scale factor
