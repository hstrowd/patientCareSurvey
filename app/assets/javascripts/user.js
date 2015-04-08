/**
 *   ---  Place all User related JS logic here.  ---
 **/

var setupPresenceBasedButtonLabelToggle = function($field, $button, hasValueLabel, noValueLabel) {
    $field.change(function() {
        var fieldValue = $field.val();
        if (fieldValue) {
            $button.text(hasValueLabel);
        } else {
            $button.text(noValueLabel);
        }
    });
};

var setupUserSelectionHandlers = function(userFieldsSelector, dataKey, $baseField) {
    var $userFields = $(userFieldsSelector);
    if ($userFields.legnth) { return; }

    $userFields.each(function(index, userField) {
        var $userField = $(userField);
        $userField.change(function() {
            if ($userField.prop('checked')) {
                $userFields.prop('checked', false);
                $userField.prop('checked', true);

                $baseField.val($userField.data(dataKey));
                $baseField.trigger('change');
            } else {
                $userFields.prop('checked', false);

                $baseField.val('');
                $baseField.trigger('change');
            }
        });
    });
};
