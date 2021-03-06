/* Copyright (c) 2018 PaddlePaddle Authors. All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License. */

import Foundation
import Metal

class TransposeParam<P: PrecisionProtocol>: OpParam {
    //typealias ParamPrecisionType = P
    required init(opDesc: PMOpDesc, inScope: Scope) throws {
        input = try TransposeParam.inputX(inputs: opDesc.inputs, from: inScope)
        output = try TransposeParam.outputOut(outputs: opDesc.outputs, from: inScope)
        axis = try TransposeParam.getAttr(key: "axis", attrs: opDesc.attrs)
    }
    let input: Texture
    var output: Texture
    let axis: [Int32]
}

class TransposeOp<P: PrecisionProtocol>: Operator<TransposeKernel<P>, TransposeParam<P>>, Runable, Creator, InferShaperable{
    
    typealias OpType = TransposeOp<P>
    
    func inferShape() {
        //para.output.dim = para.input.dim
    }
    
    func runImpl(device: MTLDevice, buffer: MTLCommandBuffer) throws {
        try kernel.compute(commandBuffer: buffer, param: para)
    }
    
    func delogOutput() {
        print(" \(type) output: ")
        para.output.delog()
    }
}



