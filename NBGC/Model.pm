#
# NBGC Project
# 
# Class NBGC::Model - dynamic system model
# 
# Author: Michael McClennen
# Copyright (c) 2010 University of Wisconsin-Madison
# 
# Each instance of this class represents a dynamic system model.  The model
# expresses a system of differential equations by means of a set of variables
# and flows.  An approximate solution to this system of equations can then be
# generated by iteration over a series of time steps.  This is referred to as
# "running" the model, and is controlled by an object of classs NBGC::Simulator.

