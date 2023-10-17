Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20452E3ED
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="are6HD4V"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5593
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 16:39:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so47404757b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697585977; x=1698190777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JGBhvzlnCVJRzTxqBWtVcPaG4tImGCahlQc9fVIO1X0=;
        b=are6HD4V/zUa3gJIUXELcCe7F/OAytJN3XOIAGluTa3H7zcRUGzd/I2IhPc8vV3KtV
         UOMpxoQy0c2kKJlVRah1eNLKHv9vnHSZafnuFvgRr5ehwhCsMKYUGgJn09mZLnO3k8Jn
         eMH0TXz0JJiXPMTQxJ7rrHA8lY6GV1290CSfq8YrBmpq1tCFJKSuORJmPuCFVpILtcUC
         g0EeZp62W8MTHF0QNUY1z06wyUOmpzISd+O9ufnEtqr9sfHWctfmpJ6v8pyMRQvZKNoN
         HTiYsPeepZd1jR6Y9/ZXugEKVYXHDN3+xn7lye5eEEX051MFlsf+ObLcEd1QpFNFkEJT
         vcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697585977; x=1698190777;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGBhvzlnCVJRzTxqBWtVcPaG4tImGCahlQc9fVIO1X0=;
        b=xR9uehX1GWqobFv4zHVm5HpVmsEdnpIXECVj8RABsSTQ3Fr7p0j4wKdRGqJ5GNMD+Y
         wh1j6KaMGlEPs5Qr8E3T5oH4SXOyS1Sjdtk+JfLvoIE6Zlseuxm8AQj7CeZMHIVuUX32
         6EBf60IL5kqNFlolgTBeja2qNWX05Egg2eCqRfByDFpZAwNghwOSY24RjpnwbhNdLQPP
         CtxBVy/qiR9rr4Kx/PYDiYj4NZwFlVomT7BmpqNhdi3Qz4P9RJ/vuzsnBHISiRK16dgy
         rs42CCntO30+EvclaqPbcRadOZ61QdCwkFMq87DKcSXT2FeFq/pVxVHSwiv/JDCD5MPl
         5HhQ==
X-Gm-Message-State: AOJu0YxOL1kQrsiA6YaBHC3KDb2qxgpSC/vtw7RVOajzidLVqFNK1egm
	Cs7HCcUvnAxGGO4YbJnCZo5YIcrE9YcJtzz61A==
X-Google-Smtp-Source: AGHT+IFQrTCrIVBagaulvADQkl+80qwLWEtkmca+L3sDOhYkQ2RGFVqhKwB9mPBOXxn4OL5HuHjG30smDswkqHVT1Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:2f05:b0:5a8:207a:143a with
 SMTP id ev5-20020a05690c2f0500b005a8207a143amr78752ywb.0.1697585976848; Tue,
 17 Oct 2023 16:39:36 -0700 (PDT)
Date: Tue, 17 Oct 2023 23:39:36 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADcbL2UC/x3NwQ6CMAyA4VchPdtkGyjGVzEexqjaBCtpF5ghv
 DuLx+/y/xsYKZPBrdlAaWHjr1T4UwPpHeVFyGM1BBda73yPllXS/MNReSE1FMq4stJEZpgZ18l fS8FPZMGE7fkSXejDEIcOanNWenL5/+6PfT8ANMnHuX8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697585975; l=2713;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=VYgIk2B2CGyo/GT7snlzLxpCgV+gVcLc8zijKRkMZRY=; b=c/DJKqnn+Pj/WL+A2qaSz61IFvasOKaZH7VVCSo6ScJAomyFfk3q8LGePxSlJ61eLLst4Qv1o
 I4jG+OF2AZ/BIlAY2DNEOJyv84A/kTkgDBHpjNWF0zxhJeuy+rNP7p/
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v1-1-ed5322ec8068@google.com>
Subject: [PATCH] wl18xx: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

wl->chip.phy_fw_ver_str is obviously intended to be NUL-terminated by
the deliberate comment telling us as much. Furthermore, its only use is
drivers/net/wireless/ti/wlcore/debugfs.c shows us it should be
NUL-terminated since its used in scnprintf:
492 | DRIVER_STATE_PRINT_STR(chip.phy_fw_ver_str);
which is defined as:
| #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
...
| #define DRIVER_STATE_PRINT(x, fmt)   \
| 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
| 			  #x " = " fmt "\n", wl->x))

We can also see that NUL-padding is not required.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

The very fact that a plain-english comment had to be made alongside a
manual NUL-byte assignment for such a simple purpose shows why strncpy
is faulty. It has non-obvious behavior that has to be clarified every
time it is used (and if it isn't then the reader suffers).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ti/wl18xx/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index 0b3cf8477c6c..1e4a430d1543 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -1516,12 +1516,9 @@ static int wl18xx_handle_static_data(struct wl1271 *wl,
 	struct wl18xx_static_data_priv *static_data_priv =
 		(struct wl18xx_static_data_priv *) static_data->priv;
 
-	strncpy(wl->chip.phy_fw_ver_str, static_data_priv->phy_version,
+	strscpy(wl->chip.phy_fw_ver_str, static_data_priv->phy_version,
 		sizeof(wl->chip.phy_fw_ver_str));
 
-	/* make sure the string is NULL-terminated */
-	wl->chip.phy_fw_ver_str[sizeof(wl->chip.phy_fw_ver_str) - 1] = '\0';
-
 	wl1271_info("PHY firmware version: %s", static_data_priv->phy_version);
 
 	return 0;

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-ti-wl18xx-main-c-356a0272bab4

Best regards,
--
Justin Stitt <justinstitt@google.com>

