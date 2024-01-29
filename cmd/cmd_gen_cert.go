package main

import (
	"github.com/hiddify/libcore/utils"
	"github.com/spf13/cobra"
	"os"
)

var commandGenerateCertification = &cobra.Command{
	Use:   "gen-cert",
	Short: "Generate certification for web server",
	Run: func(cmd *cobra.Command, args []string) {
		err := os.MkdirAll("cert", 600)
		if err != nil {
			panic("Error: " + err.Error())
		}
		utils.GenerateCertificate("cert/server-cert.pem", "cert/server-key.pem", true)
		utils.GenerateCertificate("cert/client-cert.pem", "cert/client-key.pem", false)
	},
}
