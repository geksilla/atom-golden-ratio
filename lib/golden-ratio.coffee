{CompositeDisposable} = require 'atom'

module.exports = GoldenRatio =
  subscriptions: null
  paneSubscription: null
  active: false
  scaleFactor: 1

  # config:
  #   scaleFactor:
  #     type: "number"
  #     default: 1

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    @paneSubscription = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'golden-ratio:toggle': => @toggle()
    @subscriptions.add atom.config.onDidChange 'golden-ratio.scaleFactor', {}, =>
       @scaleFactor = atom.config.get 'golden-ratio.scaleFactor'
       @resizePanes atom.workspace.getActivePane() if @active

  deactivate: ->
    @subscriptions.dispose()
    @paneSubscription?.dispose()

  subscribePane: ->
    @paneSubscription.add atom.workspace.onDidChangeActivePane => @activePaneChanged()

  unSubscribePane: ->
    @paneSubscription.dispose()

  toggle: ->
    @active = !@active
    if @active
      @subscribePane()
      @resizePanes atom.workspace.getActivePane()
    else
      @unSubscribePane()
      @resetPanes atom.workspace.paneContainer.root

  activePaneChanged: ->
    if @active
      @resizePanes atom.workspace.getActivePane()

  resizePanes: (pane)->
    return unless pane
    parent = pane.getParent()
    if parent.children
      parent.children.map (item) -> item.setFlexScale(1)
      pane.setFlexScale parent.children.length*@scaleFactor
      @resizePanes parent

  resetPanes: (pane)->
    pane.setFlexScale 1
    if pane.children
      pane.children.map @resetPanes, @

  workspaceView: ->
    atom.views.getView atom.workspace
