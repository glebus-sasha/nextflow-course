#!/usr/bin/env nextflow

def x = Math.random()

if( x < 0.5 ) {
    println 'You lost'
}
else {
    println 'You won!'
}