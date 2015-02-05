// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


window.patientCare = {
    autoRedirect: function(path, delayMilliseconds) {
        var callback = function() {
            window.location.assign(path)
        };

        if(window.setTimeout && window.setTimeout instanceof Function) {
            window.setTimeout(callback, delayMilliseconds);
        } else {
            callback();
        }
    },
    submitForm: function(formID, action, opts) {
        var $form = $('#' + formID);
        if (!$form) { return; }

        var $actionField = $form.find('input.action');
        if ($actionField) {
            $actionField.val(action);
        }

        var isValid = true;
        var validations = opts.validate;
        if (validations && validations instanceof Array) {
            $.each(validations, function(index, validationSpec) {
                var $field = $form.find(validationSpec.selector);

                if ($field.length == 0) {
                    return;
                }

                if (validationSpec.required && !$field.val()) {
                    $field.addClass('invalid');
                    isValid = false;
                    return;
                }
                if (validationSpec.dataType) {
                    if (validationSpec.dataType == 'date' && isNaN( new Date($field.val()).getTime() )) {
                        $field.addClass('invalid');
                        isValid = false;
                        return;
                    }
                }
                $field.removeClass('invalid');
            });
        }

        if (isValid) {
            $form.submit();
        }
    }
}
