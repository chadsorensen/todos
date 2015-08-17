Tasks = new (Mongo.Collection)('tasks')

if Meteor.isClient
  # This code only runs on the client
  Template.body.helpers tasks: ->
      Tasks.find {}, {sort: {createdAt: -1}}

  Template.body.events
    'submit .new-task': (e) ->
      e.preventDefault()
      text = e.target.text.value

      Tasks.insert
        text: text
        createdAt: new Date
      e.target.text.value = '',
    'click .toggle-checked': ->
      Task.update(this.id, 
        $set: {checked: !this.checked}
      ),
    'click .delete': ->
      Task.remove(this._id)