module OnceAssignedEverWatcher
  class Hooks < Redmine::Hook::ViewListener

    def controller_issues_edit_before_save (context={})

      issue = context[:issue]
      journal = context[:journal]

      if defined?( issue ) && !issue.id.blank?
        if issue.assigned_to_id != nil
       	  Watcher.find_or_create_by(watchable_type: "Issue",
                                  watchable_id: issue.id,
                                  user_id: issue.assigned_to_id)
	end

	if defined?( journal ) && journal != nil
      	  Watcher.find_or_create_by(watchable_type: "Issue",
        	                  watchable_id: issue.id,
                                user_id: journal.user.id)
        end	
      end
    end

    def controller_issues_bulk_edit_before_save(context={})
      controller_issues_edit_before_save(context)
    end

    def controller_issues_new_after_save(context={})
      controller_issues_edit_before_save(context)
    end
    
  end
end
