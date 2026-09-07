Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F34457D5;
	Mon,  7 Sep 2026 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770678; cv=none; b=CFg+jecpXYOGS0593H1zIo/MoeLEMHkUd38VlrlhEhoRXdw97/jX89YNUyI3+96harMUK9Y+eaiB0Ub/8GARQ1A8bf07zBrt/rr/0omBlxPruu8MumilWPXTSGZJv3yOBATRN46KR1M7dLI8Yrxq08ZjdAdLWB7ONrzbQMjtjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770678; c=relaxed/simple;
	bh=vLIhxE4HPPG0ZpwIf7etXdPJdHQAsbV/v0AuWclIo4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7H+0JcXS/WMCgZlvAC6mRvstfAvr5Qa9ju3oB4dhEoUwsDiMA4WDMQPgf6WgJ97xkFw0UERPI6v5QpR8YOZooTskK2IsLyAngoqdDeHJZxxifaapOLrJoT8Wt3eP5uQzgZit+CGaibWUQ5utvRtllRMgTpbJdXrzWv2w+mDiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvOYmLRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvOYmLRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB6E1F00A3E;
	Mon,  7 Sep 2026 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788770676;
	bh=0OLA/B+yqr44OLCPzEQB5/tvzjZC/y9Kh/Rd5nyMsdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YvOYmLRpiDnrtyVM6B7HbLjKTiZxIP10/aCIcCWLkkjbf9uBcN4M93WfE+cXvh0YM
	 YL9HN/2Y1q5TBPzUNEsWZ63nNNQQ/uzNFl9jQt9Onjy4O9rwNUJEihuUYSUJwCK33N
	 RIWrABZT67VRwJNhEUk9Ima1xgkSZjJw8+qCSiZwUCbFcacI1fPM4ceETJiYhiVMlT
	 F46JRHnZNrhmPioo6VNdx+XNQXqCPRi+y6drwyRPndGoRV1wT6cTRfJgMIyEeSxsEt
	 DnNxlADcNGle79yWEiGGpnsue2ZOF4t2/m8YCpZTwRodl7H+CtdqD9EQj1NH0Jw2xu
	 OClDzQl8QFqhQ==
From: Thorsten Blum <blum@kernel.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH v2 2/2] platform/x86: thinkpad_acpi: Use str_supported_unsupported() helper
Date: Mon,  7 Sep 2026 10:43:21 +0200
Message-ID: <20260907084319.351688-6-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907084319.351688-4-blum@kernel.org>
References: <20260907084319.351688-4-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6281; i=blum@kernel.org; h=from:subject; bh=vLIhxE4HPPG0ZpwIf7etXdPJdHQAsbV/v0AuWclIo4Y=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnzKp2UVyVaWAhPjVyQGHCJ+cPNJIPgFBvlP3aZqy/xF sVzHQrrKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIlkvWdk+Pn7wc/DR+fOe1qz bUJd5eGbHFfaAydtKu7LjG5glM49x83IMGnGtUnmq7uvrvvr4fxl751Ph98/sRVsKnyzoHB1w7E OJxYA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Remove the local str_supported() function and use the common
str_supported_unsupported() helper.

Debug messages now use "unsupported" instead of "not supported".

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/platform/x86/lenovo/thinkpad_acpi.c | 42 ++++++++-------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 1082c36ae723..bda192d9261d 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -456,9 +456,7 @@ do {									\
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUG
 #define vdbg_printk dbg_printk
-static const char *str_supported(int is_supported);
 #else
-static inline const char *str_supported(int is_supported) { return ""; }
 #define vdbg_printk(a_dbg_level, format, arg...)	\
 	do { if (0) no_printk(format, ##arg); } while (0)
 #endif
@@ -3338,7 +3336,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 		"hotkeys are %s\n",
-		str_supported(tp_features.hotkey));
+		str_supported_unsupported(tp_features.hotkey));
 
 	if (!tp_features.hotkey)
 		return -ENODEV;
@@ -3415,7 +3413,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 		"hotkey masks are %s\n",
-		str_supported(tp_features.hotkey_mask));
+		str_supported_unsupported(tp_features.hotkey_mask));
 
 	/* Init hotkey_all_mask if not initialized yet */
 	if (!tp_features.hotkey_mask && !hotkey_all_mask &&
@@ -4327,7 +4325,7 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
 		"bluetooth is %s, status 0x%02x\n",
-		str_supported(tp_features.bluetooth),
+		str_supported_unsupported(tp_features.bluetooth),
 		status);
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
@@ -4506,7 +4504,7 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
 		"wan is %s, status 0x%02x\n",
-		str_supported(tp_features.wan),
+		str_supported_unsupported(tp_features.wan),
 		status);
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
@@ -4634,7 +4632,7 @@ static int __init uwb_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
 		"uwb is %s, status 0x%02x\n",
-		str_supported(tp_features.uwb),
+		str_supported_unsupported(tp_features.uwb),
 		status);
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
@@ -4742,7 +4740,7 @@ static int __init video_init(struct ibm_init_struct *iibm)
 		video_supported = TPACPI_VIDEO_NEW;
 
 	vdbg_printk(TPACPI_DBG_INIT, "video is %s, mode %d\n",
-		str_supported(video_supported != TPACPI_VIDEO_NONE),
+		str_supported_unsupported(video_supported != TPACPI_VIDEO_NONE),
 		video_supported);
 
 	return (video_supported != TPACPI_VIDEO_NONE) ? 0 : -ENODEV;
@@ -5340,8 +5338,8 @@ static int __init light_init(struct ibm_init_struct *iibm)
 			acpi_evalf(ec_handle, NULL, "KBLT", "qv");
 
 	vdbg_printk(TPACPI_DBG_INIT, "light is %s, light status is %s\n",
-		str_supported(tp_features.light),
-		str_supported(tp_features.light_status));
+		str_supported_unsupported(tp_features.light),
+		str_supported_unsupported(tp_features.light_status));
 
 	if (!tp_features.light)
 		return -ENODEV;
@@ -5458,7 +5456,7 @@ static int __init cmos_init(struct ibm_init_struct *iibm)
 	TPACPI_ACPIHANDLE_INIT(cmos);
 
 	vdbg_printk(TPACPI_DBG_INIT, "cmos commands are %s\n",
-		    str_supported(cmos_handle != NULL));
+		    str_supported_unsupported(cmos_handle));
 
 	return cmos_handle ? 0 : -ENODEV;
 }
@@ -5803,7 +5801,8 @@ static int __init led_init(struct ibm_init_struct *iibm)
 	}
 
 	vdbg_printk(TPACPI_DBG_INIT, "LED commands are %s, mode %d\n",
-		str_supported(led_supported), led_supported);
+		str_supported_unsupported(led_supported != TPACPI_LED_NONE),
+		led_supported);
 
 	if (led_supported == TPACPI_LED_NONE)
 		return -ENODEV;
@@ -5924,7 +5923,7 @@ static int __init beep_init(struct ibm_init_struct *iibm)
 	TPACPI_ACPIHANDLE_INIT(beep);
 
 	vdbg_printk(TPACPI_DBG_INIT, "beep is %s\n",
-		str_supported(beep_handle != NULL));
+		str_supported_unsupported(beep_handle));
 
 	quirks = tpacpi_check_quirks(beep_quirk_table,
 				     ARRAY_SIZE(beep_quirk_table));
@@ -6374,7 +6373,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 	thermal_read_mode = thermal_read_mode_check();
 
 	vdbg_printk(TPACPI_DBG_INIT, "thermal is %s, mode %d\n",
-		str_supported(thermal_read_mode != TPACPI_THERMAL_NONE),
+		str_supported_unsupported(thermal_read_mode != TPACPI_THERMAL_NONE),
 		thermal_read_mode);
 
 	return thermal_read_mode != TPACPI_THERMAL_NONE ? 0 : -ENODEV;
@@ -7596,7 +7595,7 @@ static int __init volume_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
 			"mute is supported, volume control is %s\n",
-			str_supported(!tp_features.mixer_no_level_control));
+			str_supported_unsupported(!tp_features.mixer_no_level_control));
 
 	if (software_mute_requested && volume_set_software_mute(true) == 0) {
 		software_mute_active = true;
@@ -8993,8 +8992,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_FAN,
 		"fan is %s, modes %d, %d\n",
-		str_supported(fan_status_access_mode != TPACPI_FAN_NONE ||
-		  fan_control_access_mode != TPACPI_FAN_WR_NONE),
+		str_supported_unsupported(fan_status_access_mode != TPACPI_FAN_NONE ||
+					  fan_control_access_mode != TPACPI_FAN_WR_NONE),
 		fan_status_access_mode, fan_control_access_mode);
 
 	/* fan control master switch */
@@ -11632,15 +11631,6 @@ static struct proc_dir_entry *proc_dir;
 
 static bool force_load;
 
-#ifdef CONFIG_THINKPAD_ACPI_DEBUG
-static const char * __init str_supported(int is_supported)
-{
-	static char text_unsupported[] __initdata = "not supported";
-
-	return (is_supported) ? &text_unsupported[4] : &text_unsupported[0];
-}
-#endif /* CONFIG_THINKPAD_ACPI_DEBUG */
-
 static struct dentry *tpacpi_dbg;
 static void tpacpi_debugfs_init(void)
 {
