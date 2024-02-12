
'use client'

import { store } from '@/store/stote'
import { Provider } from 'react-redux'
import {ProviderProps } from '@/types/general/reactNode'


import React from 'react'

const StateProvider = ({ children }: ProviderProps) => {
  return <Provider store={store}>{children}</Provider>;
}

export default StateProvider