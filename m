Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2E14266
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 06:41:42 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79011E5
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 23:41:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a1df5b7830so65925877b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695796898; x=1696401698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yP0qHUJH7sO2KgRz3yivnxn+m8P4l8V6unnDvl/tBE=;
        b=uRVFJfyPRzEDUZ0USgKfyN6ajnoXp6oPASneL/q6udY7wsGbT3kKtk+VdCtulyIPjr
         z/toV/qvw+m9JqDDxdTucQWvANd0oSL9hGwxIcvIaK7oDY5h7MDbzrn8PwKxvWWeu9A1
         AXEbaiEJ0Bahv/XICyiwpcXcacYGybAhXEFikVvQBN9ChhkzCdEjqu+ehofPgFBBLj8C
         2XQZM7DEfCdicmtOFHb/aqzmbb3g8oNOCDyNntvCF01pSaiSZk1kwUPWFjoAc3bgl9rd
         60Zf0dOChb0lQedxKVzw2GKdNG7FkLIJmCBSkDMnZlcwhRBv5T+eNy/hTt2WtmoeLldL
         I6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695796898; x=1696401698;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yP0qHUJH7sO2KgRz3yivnxn+m8P4l8V6unnDvl/tBE=;
        b=SJ8XLM9KN8JA2hUEb/NcTvGlZQNQSzL155Wy6X/zWhsqnVD8MdtUMXzT2Ot0Vxjgm7
         Qv+NYbQNMX2tHljwT+DcLUgfBi82HPs9/XA/m1bdeQOT6yK6KMOjsJ9F4NIdf9y5ghiI
         AtsAbcyrEmoA4Y4d2dJC/M6rUnp72zFuuoU8UqzKmgtxp7T5nYpNmcPGtBbgiEnpfsUQ
         doWLTpU17PPzINZrlQehi68ytd6iUX9ioclRmX7+pKbdqrbbYJiTIvGKxkpY8wzwTwO8
         8vOY0Z0tjPvSG0225V9A60Q3IxI25RqO9wUdtkx4vdDIgWZgOWooX1Cc2NZ9JQdAEM+h
         lrTg==
X-Gm-Message-State: AOJu0Yyq0iO0pvN3SGdxBDJalwIRIHZPbIbgHjXzL4c23WWAxDq1nEIV
	+JD5nRV9b3c1ELakA+0vcDJfG/3dw7F2Kw8G4Q==
X-Google-Smtp-Source: AGHT+IEVCCuMI/uy+Ltg5u5M7A4hgRyW/gCmF8sn1IuFuDTTOBFPGmO2kHmy+heH9Iq0t3g3VcTknBCD7VhmotgVLA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1682:b0:d81:78ec:c403 with
 SMTP id bx2-20020a056902168200b00d8178ecc403mr13774ybb.12.1695796898745; Tue,
 26 Sep 2023 23:41:38 -0700 (PDT)
Date: Wed, 27 Sep 2023 06:41:37 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKHOE2UC/x3NMQ6DMAxA0asgz7WUJiCgV6kYmmDAAwHZIWqFu
 Hsjxrf8f4KSMCm8qhOEMitvseD5qCAsnzgT8lgM1lhnetuiJolh/+EonEkU1zXgsmnCfHhnDAb 0rXf91FlquhpKZxea+Hs/3sN1/QGl6Ar9cwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695796897; l=5550;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=YPZfe2Wyy7QnsQhjAGzhJqwDXvMubl0PpcqCu4zLYvI=; b=DVmX3rW9B9/NdIy6Sx1tPZhSRgJUBHuGbPKG2EobRxqUmLqriHBIfHZa6/44chl99vMNeGrDV
 ufoIE9dRsqwDdET0IHyIJy7USZl/n6oXtJwqFm9YsEIrFepousjKoKk
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-mmc-host-vub300-c-v1-1-77426f62eef4@google.com>
Subject: [PATCH] mmc: vub300: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `vub300->vub_name` to be NUL-terminated based on its uses with
format strings:
| 	dev_info(&vub300->udev->dev, "using %s for SDIO offload processing\n",
| 		 vub300->vub_name);

NUL-padding is not needed. We can see cleaning out vub_name simply
consists of:
|       vub300->vub_name[0] = 0;

Considering the above, for all 11 cases a suitable replacement is
`strscpy` [2] due to the fact that it guarantees NUL-termination on the
destination buffer without unnecessarily NUL-padding.

To be clear, there is no existing bug in the current implementation as
the string literals are all small enough as to not cause a buffer
overread. Nonetheless, this gets us 11 steps closer to removing strncpy
uses.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/mmc/host/vub300.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 9ec593d52f0f..de3f443f5fdc 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -512,7 +512,7 @@ static void new_system_port_status(struct vub300_mmc_host *vub300)
 		vub300->card_present = 1;
 		vub300->bus_width = 0;
 		if (disable_offload_processing)
-			strncpy(vub300->vub_name, "EMPTY Processing Disabled",
+			strscpy(vub300->vub_name, "EMPTY Processing Disabled",
 				sizeof(vub300->vub_name));
 		else
 			vub300->vub_name[0] = 0;
@@ -1216,7 +1216,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		dev_err(&vub300->udev->dev,
 			"corrupt offload pseudocode in firmware %s\n",
 			vub300->vub_name);
-		strncpy(vub300->vub_name, "corrupt offload pseudocode",
+		strscpy(vub300->vub_name, "corrupt offload pseudocode",
 			sizeof(vub300->vub_name));
 		return;
 	}
@@ -1250,7 +1250,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 				"not enough memory for xfer buffer to send"
 				" INTERRUPT_PSEUDOCODE for %s %s\n", fw->data,
 				vub300->vub_name);
-			strncpy(vub300->vub_name,
+			strscpy(vub300->vub_name,
 				"SDIO interrupt pseudocode download failed",
 				sizeof(vub300->vub_name));
 			return;
@@ -1259,7 +1259,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		dev_err(&vub300->udev->dev,
 			"corrupt interrupt pseudocode in firmware %s %s\n",
 			fw->data, vub300->vub_name);
-		strncpy(vub300->vub_name, "corrupt interrupt pseudocode",
+		strscpy(vub300->vub_name, "corrupt interrupt pseudocode",
 			sizeof(vub300->vub_name));
 		return;
 	}
@@ -1293,7 +1293,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 				"not enough memory for xfer buffer to send"
 				" TRANSFER_PSEUDOCODE for %s %s\n", fw->data,
 				vub300->vub_name);
-			strncpy(vub300->vub_name,
+			strscpy(vub300->vub_name,
 				"SDIO transfer pseudocode download failed",
 				sizeof(vub300->vub_name));
 			return;
@@ -1302,7 +1302,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		dev_err(&vub300->udev->dev,
 			"corrupt transfer pseudocode in firmware %s %s\n",
 			fw->data, vub300->vub_name);
-		strncpy(vub300->vub_name, "corrupt transfer pseudocode",
+		strscpy(vub300->vub_name, "corrupt transfer pseudocode",
 			sizeof(vub300->vub_name));
 		return;
 	}
@@ -1336,13 +1336,13 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		dev_err(&vub300->udev->dev,
 			"corrupt dynamic registers in firmware %s\n",
 			vub300->vub_name);
-		strncpy(vub300->vub_name, "corrupt dynamic registers",
+		strscpy(vub300->vub_name, "corrupt dynamic registers",
 			sizeof(vub300->vub_name));
 		return;
 	}
 
 copy_error_message:
-	strncpy(vub300->vub_name, "SDIO pseudocode download failed",
+	strscpy(vub300->vub_name, "SDIO pseudocode download failed",
 		sizeof(vub300->vub_name));
 }
 
@@ -1370,11 +1370,11 @@ static void download_offload_pseudocode(struct vub300_mmc_host *vub300)
 		 vub300->vub_name);
 	retval = request_firmware(&fw, vub300->vub_name, &card->dev);
 	if (retval < 0) {
-		strncpy(vub300->vub_name, "vub_default.bin",
+		strscpy(vub300->vub_name, "vub_default.bin",
 			sizeof(vub300->vub_name));
 		retval = request_firmware(&fw, vub300->vub_name, &card->dev);
 		if (retval < 0) {
-			strncpy(vub300->vub_name,
+			strscpy(vub300->vub_name,
 				"no SDIO offload firmware found",
 				sizeof(vub300->vub_name));
 		} else {
@@ -1758,7 +1758,7 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			 * has been already downloaded to the VUB300 chip
 			 */
 		} else if (0 == vub300->mmc->card->sdio_funcs) {
-			strncpy(vub300->vub_name, "SD memory device",
+			strscpy(vub300->vub_name, "SD memory device",
 				sizeof(vub300->vub_name));
 		} else {
 			download_offload_pseudocode(vub300);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-mmc-host-vub300-c-b7b39f82e584

Best regards,
--
Justin Stitt <justinstitt@google.com>

