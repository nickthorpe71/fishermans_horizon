# Fishermans Horizon

### Focus
Test what graphics rendering methods work well with phoenix liveview and render well in the vdi. I've already tested svg with phoenix and it seems to render well on the vdi which means any kind of data visualization libraries that use svg (d3, chartjs) should be a good option. I'm planning to test css sprite sheets for animation with pixel graphics as the art style. I'll also be testing liveview hooks to learn how user input events on the front end can trigger events on the back end. I'll need to deploy this app to test the graphics in the vdi. 

### Story
Build a simple pixel art game with animation and user mouse event interaction (drag and drop). Deploy so graphics can be tested in the vdi.

### What does it test?
- graphics in vdi
- css sprite sheets
- html5 canvas (stretch goal)
- basic elixir deployment
- complex user front end behavior (drag and drop)
- using js libraries with liveview (sortablejs)
- liveview hooks

### Stack
- phoenix live view
- tailwind css