module NotesHelper
  def note_belongs_to_current_user? note
    note.case.user == current_user
  end
end
