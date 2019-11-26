#include "xirr.h"
#include "net_present_value.h"

VALUE rb_mXirr;

static VALUE rb_return_xirr_net_present_value(VALUE self, VALUE rate, VALUE period, VALUE amount) {
  double c_rate = NUM2DBL(rate);
  double c_period = NUM2DBL(period);
  double c_amount = NUM2DBL(amount);
  double result = xirr_net_present_value(c_rate, c_period, c_amount);

  return DBL2NUM(result);
}

void Init_xirr(void) {
  rb_mXirr = rb_const_get(rb_cObject, rb_intern("Xirr"));
  VALUE NativeHelpers = rb_define_module_under(rb_mXirr, "NativeHelpers");
  rb_define_method(NativeHelpers, "xirr_net_present_value", rb_return_xirr_net_present_value, 3);
}
