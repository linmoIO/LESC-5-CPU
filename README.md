# LESC-5 CPU

## 声明

**原创，请勿转载，严禁未经本人允许或者未标注作者的情况下使用代码。**

## 简介

LESC-5 CPU（Linmo's easy-to-learn, highly scalable and customizable, five-stage pipeline CPU），一个用Chisel语言实现的RISC-V架构的流水线CPU，具备易学性、高可扩展性和可定制性等优点。

LESC-5 CPU具有五级流水线，支持分支预测和旁路转发等功能，能高效且正确地执行RISC-V 64I的指令集，并通过RISC-V的官方测试套件的测试。

为增强可扩展性和可定制性，本设计通过设计配置部分和映射表，提供了CPU的参数配置、代码实现的统一接口和管理。同时模块化和Chisel实现中实用工具的使用，结合丰富的调试信息，降低了学习门槛。此外，提供的4个个性化版本，循序渐进，进一步增加了易学性和可定制性。

## 信息

**名称**：LESC-5 CPU

**作者**：linmo

**时间**：2023/5/20

**邮箱**：linmo@hnu.edu.cn

**微信**：linmo1222

**语言**：Chisel3

**CPU架构**：RISC-V（支持64I指令集）

## 主要文件结构

项目用metals和sbt进行管理运行。

**doc文件夹**：存储设计相关的文档

**generated文件夹**：存储生成的Verilog可综合代码

**src/main/scala/CPU文件夹**：存储源码

- **Componts**：CPU各组件
- **PiplineComponts**：流水线相关组件
- **PiplineCPU**：流水线版本的CPU顶层
- **SingleCycleCPU**：单周期版本的CPU顶层
- CPUConfig.scala：配置文件
- CPUUtils.scala：杂项工具

**src/test**：存储测试文件和测试代码

- **hex**：测试所用的官方测试集
- **scala**：测试代码（部分代码来源于DINO）

**README.md**：说明文件

## 运行

环境要求：Chisel3+Metals+sbt

具体可参考：[(72条消息) 吃透Chisel语言.02.Chisel+VS Code+Ubuntu/WSL2开发环境搭建与使用_chisel环境搭建_计算机体系结构-3rr0r的博客-CSDN博客](https://blog.csdn.net/weixin_43681766/article/details/124910441?spm=1001.2014.3001.5502)（感谢大神在我开发中提供的帮助）

## 设计

详细设计请查看doc文件夹，里面写的非常详细。

