#include <math.h>

double xirr_net_present_value(double rate, double amount, double period) {
  return amount / pow(1 + rate, period);
}
