module OnceAssignedEverWatcher
  class Hooks < Redmine::Hook::ViewListener
  
    def controller_issues_edit_before_save (context={})
      if context[:issue] && context[:issue].id != nil                      
        issue = Issue.find_by_id(context[:issue].id)      
        Watcher.find_or_create_by_watchable_type_and_watchable_id_and_user_id("Issue", 
                                                                              context[:issue].id, 
                                                                              User.current.id)
        if issue.assigned_to_id != nil
          Watcher.find_or_create_by_watchable_type_and_watchable_id_and_user_id("Issue", 
                                                                                context[:issue].id, 
                                                                                issue.assigned_to_id)
        end
      end
    end
    
  end
end
