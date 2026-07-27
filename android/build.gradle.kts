allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    if (project.name == "jni" || project.name == "file_picker") {
        project.apply(mapOf("plugin" to "org.jetbrains.kotlin.android"))
    }

    val configureNamespace = {
        if (project.plugins.hasPlugin("com.android.library")) {
            val androidExt = project.extensions.getByName("android") as com.android.build.gradle.LibraryExtension
            if (androidExt.namespace == null) {
                androidExt.namespace = project.group.toString()
            }
            androidExt.compileSdk = 35
        }
    }
    if (project.state.executed) {
        configureNamespace()
    } else {
        project.afterEvaluate { configureNamespace() }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
