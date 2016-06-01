require File.expand_path('../../test_helper', __FILE__)

class IssueAssignmentWatcherFlowTest < Redmine::IntegrationTest
  fixtures :projects, :trackers, :issue_statuses, :issues,
           :enumerations, :users, :issue_categories,
           :projects_trackers,
           :roles,
           :member_roles,
           :members,
           :enabled_modules

  def test_assignee_becomes_watcher
    log_user("admin", "admin")
    ass = Issue.find(2).assigned_to
    assert_not_equal(ass.id, 1)

    put(issue_path(2), :issue => {:assigned_to_id => 1})

    assert_redirected_to(issue_path(2))
    assert(assigns(:issue).watched_by?(ass))
  end
end