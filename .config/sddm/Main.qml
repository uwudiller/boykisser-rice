import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Effects
import org.kde.kirigami 2.20 as Kirigami

Rectangle {
    id: root
    width: screenGeometry.width
    height: screenGeometry.height
    color: "#1e1e2e"

    property string username: ""
    property string password: ""
    property var screenGeometry: Qt.rect(0, 0, 1920, 1080)

    // Background image
    Image {
        id: background
        anchors.fill: parent
        source: "/usr/share/sddm/themes/boykisser/background.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 1.0
    }

    // Overlay
    Rectangle {
        anchors.fill: parent
        color: "rgba(30, 30, 46, 0.4)"
    }

    // Login form container
    Rectangle {
        id: loginForm
        anchors.centerIn: parent
        width: 450
        height: 520
        radius: 24
        color: "rgba(30, 30, 46, 0.95)"
        border.color: "rgba(255, 105, 180, 0.5)"
        border.width: 2

        // Glow effect
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: "#ff69b4"
            shadowBlur: 0.4
            shadowVerticalOffset: 8
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 32
            spacing: 24

            // Title
            Text {
                text: "🌸"
                font.pixelSize: 48
                color: "#ff69b4"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Welcome Back"
                font.pixelSize: 28
                font.family: "JetBrains Mono Nerd Font"
                font.weight: Font.Bold
                color: "#f8f8f2"
                Layout.alignment: Qt.AlignHCenter
            }

            Item { Layout.preferredHeight: 16 }

            // Username field
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                radius: 12
                color: "rgba(68, 71, 90, 0.6)"
                border.color: "rgba(255, 105, 180, 0.3)"
                border.width: 2

                TextInput {
                    id: usernameInput
                    anchors.fill: parent
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 16
                    font.family: "JetBrains Mono Nerd Font"
                    color: "#f8f8f2"
                    selectByMouse: true
                    clip: true

                    Text {
                        anchors.fill: parent
                        anchors.leftMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Username"
                        font.pixelSize: 16
                        font.family: "JetBrains Mono Nerd Font"
                        color: "#cdd6f4"
                        visible: !usernameInput.text && !usernameInput.activeFocus
                    }

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            parent.border.color = "#ff69b4"
                        } else {
                            parent.border.color = "rgba(255, 105, 180, 0.3)"
                        }
                    }
                }
            }

            // Password field
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                radius: 12
                color: "rgba(68, 71, 90, 0.6)"
                border.color: "rgba(255, 105, 180, 0.3)"
                border.width: 2

                TextInput {
                    id: passwordInput
                    anchors.fill: parent
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 16
                    font.family: "JetBrains Mono Nerd Font"
                    color: "#f8f8f2"
                    echoMode: TextInput.Password
                    selectByMouse: true
                    clip: true

                    Text {
                        anchors.fill: parent
                        anchors.leftMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Password"
                        font.pixelSize: 16
                        font.family: "JetBrains Mono Nerd Font"
                        color: "#cdd6f4"
                        visible: !passwordInput.text && !passwordInput.activeFocus
                    }

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            parent.border.color = "#ff69b4"
                        } else {
                            parent.border.color = "rgba(255, 105, 180, 0.3)"
                        }
                    }

                    Keys.onReturnPressed: {
                        sddm.login(usernameInput.text, passwordInput.text, sessionIndex)
                    }
                }
            }

            Item { Layout.preferredHeight: 16 }

            // Login button
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                radius: 12
                color: "#ff69b4"
                border.width: 0

                Text {
                    anchors.centerIn: parent
                    text: "Login"
                    font.pixelSize: 18
                    font.family: "JetBrains Mono Nerd Font"
                    font.weight: Font.Bold
                    color: "#1e1e2e"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        sddm.login(usernameInput.text, passwordInput.text, sessionIndex)
                    }
                    hoverEnabled: true
                    onEntered: {
                        parent.color = "#ffb6c1"
                    }
                    onExited: {
                        parent.color = "#ff69b4"
                    }
                }
            }

            Item { Layout.fillHeight: true }

            // Session selector
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: "Session:"
                    font.pixelSize: 12
                    font.family: "JetBrains Mono Nerd Font"
                    color: "#cdd6f4"
                }

                Repeater {
                    model: sddm.sessions
                    Rectangle {
                        Layout.preferredWidth: 80
                        Layout.preferredHeight: 30
                        radius: 8
                        color: index === sessionIndex ? "#ff69b4" : "rgba(68, 71, 90, 0.6)"
                        border.color: index === sessionIndex ? "#ff69b4" : "rgba(255, 105, 180, 0.3)"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: modelData.name.split(' ')[0]
                            font.pixelSize: 11
                            font.family: "JetBrains Mono Nerd Font"
                            color: index === sessionIndex ? "#1e1e2e" : "#cdd6f4"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: sessionIndex = index
                        }
                    }
                }
            }
        }
    }

    // Clock
    Text {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 32
        text: Qt.formatDateTime(new Date(), "HH:mm")
        font.pixelSize: 48
        font.family: "JetBrains Mono Nerd Font"
        font.weight: Font.Bold
        color: "#ff69b4"
    }

    // Date
    Text {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 32
        anchors.topMargin: 88
        text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
        font.pixelSize: 16
        font.family: "JetBrains Mono Nerd Font"
        color: "#ffb6c1"
    }

    // Power button
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 32
        width: 50
        height: 50
        radius: 25
        color: "rgba(255, 85, 85, 0.6)"
        border.color: "rgba(255, 85, 85, 0.8)"
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: "⏻"
            font.pixelSize: 24
            color: "#f8f8f2"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: sddm.powerOff()
            hoverEnabled: true
            onEntered: {
                parent.color = "rgba(255, 85, 85, 0.8)"
            }
            onExited: {
                parent.color = "rgba(255, 85, 85, 0.6)"
            }
        }
    }

    // Restart button
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 32
        anchors.rightMargin: 96
        width: 50
        height: 50
        radius: 25
        color: "rgba(255, 170, 0, 0.6)"
        border.color: "rgba(255, 170, 0, 0.8)"
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: "↻"
            font.pixelSize: 24
            color: "#f8f8f2"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: sddm.reboot()
            hoverEnabled: true
            onEntered: {
                parent.color = "rgba(255, 170, 0, 0.8)"
            }
            onExited: {
                parent.color = "rgba(255, 170, 0, 0.6)"
            }
        }
    }

    Component.onCompleted: {
        usernameInput.text = sddm.lastUser
        usernameInput.forceActiveFocus()
    }
}
