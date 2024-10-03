return {
 -- Required fields
  name = "Tantor build",
  builder = function(params)
    -- This must return an overseer.TaskDefinition
    return {
      -- cmd is the only required field
      cmd = {'sudo'},
	  args = {
		  '/home/at1ass/tdb/build.sh',
	  },
      -- additional arguments for the cmd
      -- the name of the task (defaults to the cmd of the task)
      name = "Build",
      -- set the working directory for the task
      cwd = "/home/at1ass/tdb",
      -- additional environment variables
      -- the list of components or component aliases to add to the task
    }
  end,
  -- Optional fields
  desc = "Optional description of task",
  -- Tags can be used in overseer.run_template()
  condition = {
    -- A string or list of strings
    -- Only matches when current buffer is one of the listed filetypes
    filetype = {"c", "cpp"},
    -- A string or list of strings
    -- Only matches when cwd is inside one of the listed dirs
    dir = "/home/at1ass/tdb",
    -- Arbitrary logic for determining if task is available
    callback = function(search)
      print(vim.inspect(search))
      return true
    end,
  },
}
