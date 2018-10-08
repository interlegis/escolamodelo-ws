import {MDCLineRipple, MDCLineRippleFoundation} from '@material/line-ripple/index';
const lineRipple = new MDCLineRipple(document.querySelector('.mdc-line-ripple'));
import {MDCFloatingLabel, MDCFloatingLabelFoundation} from '@material/floating-label/index';
const floatingLabel = new MDCFloatingLabel(document.querySelector('.mdc-floating-label'));
import {MDCTextField, MDCTextFieldFoundation} from '@material/textfield/index';
const email = new MDCTextField(document.querySelector('.email'));
const password = new MDCTextField(document.querySelector('.password'));
import {MDCTextFieldHelperText} from '@material/textfield/helper-text/index';
const helperText = new MDCTextFieldHelperText(document.querySelector('.mdc-text-field-helper-text'));