// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'

import Autosave from 'stimulus-rails-autosave'
import ClassToggleController from 'controllers/class_toggle_controller'
import DropdownManageController from 'controllers/dropdown_manage_controller'
import HTMLRemoveController from 'controllers/html_remove_controller'
import MapController from 'controllers/map_controller'
import ModalOpenController from 'controllers/modal_open_controller'
import ModalDisplayController from 'controllers/modal_display_controller'
import SlimSelectController from 'controllers/slim_select_controller'

window.Stimulus = Application.start()
Stimulus.register('autosave', Autosave)
Stimulus.register('class-toggle', ClassToggleController)
Stimulus.register('dropdown-manage', DropdownManageController)
Stimulus.register('html-remove', HTMLRemoveController)
Stimulus.register('map', MapController)
Stimulus.register('modal-display', ModalDisplayController)
Stimulus.register('modal-open', ModalOpenController)
Stimulus.register('slim-select', SlimSelectController)
