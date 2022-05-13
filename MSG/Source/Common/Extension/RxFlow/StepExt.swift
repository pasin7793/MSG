//
//  StepExt.swift
//  MSG_Test
//
//  Created by 임준화 on 2022/05/13.
//

import RxFlow

extension Step{
    var asTestStep: TestStep?{
        return self as? TestStep
    }
}
