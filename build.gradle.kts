import org.gradle.plugins.ide.idea.model.IdeaModel

plugins {
    id("idea")
    id("base")
}

group = "com.helloscala"

version = "1.0-SNAPSHOT"
// 1. 环境检查
val cjpm = "cjpm"          // 统一入口：cjpm

// 2. 定义目录
val outputPath = "target"
val cjOutDir = layout.buildDirectory.dir(outputPath).get().asFile   // cjpm 默认输出目录
val exePath = "${cjOutDir}/bin/${project.name}"

interface ExecOpsProvider {
    @get:Inject
    val execOps: org.gradle.process.ExecOperations
}

/* 给每个子模块注册任务 */
subprojects {
    apply(plugin = "idea")
    configure<IdeaModel> {
        module {
            sourceDirs.add(file("src"))          // 源码根
            resourceDirs.add(file("resources"))  // 资源根
            excludeDirs.add(file(outputPath)) // 不索引构建产物
        }
    }

    val srcDir      = file("${project.projectDir}/src")
    val resourcesDir= file("${project.projectDir}/resources")

    // 1. 构建
    tasks.register("cjpmRun") {
        group = "build"
        description = "Using cjpm run cangjie project module ${project.name}"

        inputs.dir(srcDir)
        inputs.dir(resourcesDir)
        inputs.file(file("${project.projectDir}/cjpm.toml"))
        outputs.dir(file("${project.projectDir}/${outputPath}"))
        val injected = project.objects.newInstance<ExecOpsProvider>()
        doLast {
            injected.execOps.exec {
                workingDir = project.projectDir
                commandLine(cjpm, "run")
            }
        }
    }

    // 1. 构建
    tasks.register("cjpmBuild") {
        group = "build"
        description = "Using cjpm build cangjie project module ${project.name}"

        inputs.dir(srcDir)
        inputs.dir(resourcesDir)
        inputs.file(file("${project.projectDir}/cjpm.toml"))
        outputs.dir(file("${project.projectDir}/${outputPath}"))
        val injected = project.objects.newInstance<ExecOpsProvider>()
        doLast {
            injected.execOps.exec {
                workingDir = project.projectDir
                commandLine(cjpm, "build")
            }
        }
    }

    // 2. 清理
    tasks.register("cjpmClean") {
        group = "build"
        description = "Using cjpm clean ${project.name}"
        doLast {
            exec {
                workingDir = project.projectDir
                commandLine(cjpm, "clean")
            }
            delete(file("${project.projectDir}/${outputPath}"))
        }
    }
}

/* 聚合任务 */
tasks.register("buildAll") {
    group = "build"
    description = "Build all cangjie modules"
    dependsOn(subprojects.map { it.tasks["cjpmBuild"] })
}

tasks.register("cleanAll") {
    group = "build"
    dependsOn(subprojects.map { it.tasks["cjpmClean"] })
}

/* 让默认 build/clean 直接等于聚合任务 */
tasks.build { dependsOn("buildAll") }
tasks.clean { dependsOn("cleanAll") }