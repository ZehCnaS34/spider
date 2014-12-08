require 'term/ansicolor'

module Spider
  module Log
    include Term::ANSIColor
    ### not tests required for this module.
    # just some simple logging functions


    def log(content, color=white)
      content = yield Term::ANSIColor if block_given?
      print bold, Term::ANSIColor.send(color) , "Log :: #{content}", reset, "\n"
    end

    def log_error(content)
      log "Error [#{content}]", :red
    end

    def log_info(content)
      log "Info [#{content}]", :cyan
    end

    def log_success(content)
      log "Success [#{content}]", :green
    end

  end
end
