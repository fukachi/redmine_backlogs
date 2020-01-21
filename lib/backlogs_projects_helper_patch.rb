require_dependency 'projects_helper'

module BacklogsProjectsHelperPatch
  #module ProjectsHelperPatch

    #def self.included(base)
    #  base.send(:include, InstanceMethods)
    #  base.class_eval do
    #    unloadable
    #    alias_method :project_settings_tabs_without_backlogs, :project_settings_tabs
    #    alias_method :project_settings_tabs, :project_settings_tabs_with_backlogs
    #  end
    #end

    #module InstanceMethods

      def project_settings_tabs
        #tabs = project_settings_tabs_without_backlogs
        tabs = super
        tabs << {:name => 'backlogs',
          :action => :manage_project_backlogs,
          :partial => 'backlogs/project_settings',
          :label => :label_backlogs
        } if @project.module_enabled?('backlogs') and 
             User.current.allowed_to?(:configure_backlogs, nil, :global=>true)
        return tabs
      end

    #end

  #end
end

#ProjectsHelper.send(:include, Backlogs::ProjectsHelperPatch) unless ProjectsHelper.included_modules.include? Backlogs::ProjectsHelperPatch
ProjectsHelper.prepend(BacklogsProjectsHelperPatch)
