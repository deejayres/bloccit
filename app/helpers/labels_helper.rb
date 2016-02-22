module LabelsHelper
  def labels_to_buttons(labels)
    raw labels.map { |l| link_to l.name, label_path(id: l.id), class: 'btn-xs btn-primary' }.join(' ')
  end
end
