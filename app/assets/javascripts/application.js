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
        if ($form.legnth == 0) { return; }

        var $actionField = $form.find('input.action');
        if ($actionField.legnth != 0) {
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
    },
    enabledControlField: function(formID, controlSelector, fieldSelector) {
        var $form = $('#' + formID);
        if ($form.legnth == 0) { return; }

        var $control = $form.find(controlSelector);
        var $field = $form.find(fieldSelector);
        if ($control.legnth || $field.legnth) {
            return;
        }

        $control.change(function() {
            if ($control.is(':checked')) {
                $field.attr('disabled', 'disabled');
                $field.val(null);
            } else {
                $field.removeAttr('disabled');
            }
        });
    },
    // Note: The source is expected to be updated by the user and the base
    //   will be updated to reflect this.
    reflectField: function(formID, baseSelector, sourceSelector) {
        var $form = $('#' + formID);
        if ($form.legnth == 0) { return; }

        var $base = $form.find(baseSelector);
        var $source = $form.find(sourceSelector);
        if ($base.legnth || $source.legnth) {
            return;
        }

        $base.change(function() {
            $source.val($base.val());
        });
        $source.change(function() {
            $base.val($source.val());
            $base.trigger('change');
        });

        $base.trigger('change');
    },
    // Note: The radio is expected to be updated by the user and the base field
    //   will be updated to reflect this.
    reflectRadio: function(formID, baseFieldSelector, radioName) {
        var $form = $('#' + formID);
        if ($form.legnth == 0) { return; }

        var $base = $form.find(baseFieldSelector);
        var $radio = $form.find('input:radio[name=' + radioName + ']');
        if ($base.legnth == 0 || $radio.legnth == 0) {
            return;
        }

        $base.change(function() {
            var $checkedOption = $radio.filter('#' + radioName + '_' + $base.val());
            if ($checkedOption.length == 0) { return; }

            $checkedOption.attr('checked', true);
        });
        $radio.change(function() {
            $base.val($radio.filter(':checked').val());
            $base.trigger('change');
        });

        $base.trigger('change');
    }
}
