module OnceAssignedEverWatcher
  class Hooks < Redmine::Hook::ViewListener

    def controller_issues_edit_before_save (context={})

      issue = context[:issue]
  		journal = context[:journal]

      if issue.assigned_to_id != nil
        Watcher.find_or_create_by(watchable_type: "Issue",
                                  watchable_id: issue.id,
                                  user_id: issue.assigned_to_id)
      end

      Watcher.find_or_create_by(watchable_type: "Issue",
                                watchable_id: issue.id,
                                user_id: journal.user.id)

    end

  end
end
