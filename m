Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E124293F
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl82I0r5"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8ADFE
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 14:50:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d99ec34829aso10142615276.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697665801; x=1698270601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8zZipBfwYNWzVL/d5y/qUL95UR9zvumjoOjtC0bzRU=;
        b=sl82I0r5PMtHtJ6HzraR/DHXHBM77LzsndZNdvsOaZrTDj2RWUzCXC9OpAXU+iwjpE
         jnPMHAU6cvTBsnuuEM45zMaC6XYV8h6gj46DIQstwtT/6FjJ4SqnZSWf4w9I0iH5lDYR
         Gc+QbeIfiQDNG7QxmfTY5CnVfgcyfdAvuBFDIH7DI0b9QccGe04yt/mgxlfTQ8k9vWw+
         hEORv86pxWu/B3LU/VaqoxoxtrHMm65zM2jgjCWH+ddmW48pm6NUipKNoOTRfIkZlW9B
         3CCTfW0eWnQHqgHUwddT9NAxuiiGmD9uvLeciy8vzROLj/6+2L8KEiUaZ7SqajjW9sOo
         bMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697665801; x=1698270601;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8zZipBfwYNWzVL/d5y/qUL95UR9zvumjoOjtC0bzRU=;
        b=GGUuUXKzNGCUZKYtPl9N+EsPKkQiyNTOjdU6QoHPtmO7jhHEAgSwImiFYtYWCbwTRy
         DXS/A3gc/99J64yrY89o2gy/YwnkPQD1B3PEgYD0qj/b8er9WVeicwcXXo466+ThV4KM
         3fA6gEhfscidMN/WfumFnH6AvxPsX0F5YzcYPdRbXt+QWpv83GGpRbKV4OoXZ7geF3Tu
         KwHOZZaXz3cBj4z5c6xJOZlP88bCtvAxYBKlONNUS23M3+8v/42etDNEYcu+ayl1g+he
         hnOHm3idROMWnqaswxG4tcq5JUfRjZ7MoEh7wSrvA/6s06K/QMDqQ4A/vr47xsTkoXKg
         WHNQ==
X-Gm-Message-State: AOJu0Yy3+3sOgFiq2irlZow03t1ERKblq/w/TrGTMNAUcYh8gd8diG5E
	uevZ8AzNqEdcQ73eR53MNP70jxNzZkXsBn7JSg==
X-Google-Smtp-Source: AGHT+IEN/FTSASrll23QyNRMxl3kr6I8Hj0ECv2EwBFAUZlWSl9jzbvTcPJAY+6SodfofM1HCyBdr6WOwoVCZaWyww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:9a42:0:b0:d9a:da03:97e8 with SMTP
 id r2-20020a259a42000000b00d9ada0397e8mr15079ybo.2.1697665801580; Wed, 18 Oct
 2023 14:50:01 -0700 (PDT)
Date: Wed, 18 Oct 2023 21:50:01 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAhTMGUC/x3NwQqDMAyA4VeRnBdou4vsVcYOXUy3gIuSFHWI7
 27x+F3+fwdnE3Z4dDsYL+IyaUO8dUDfrB9GGZohhXSPIfbo1ZTmPw4mC5ujcsVVjEd2xyq4jjQ Z4y+LIiEFSn1OpbxDgdacjYts1+/5Oo4Td1K6yn8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697665800; l=2656;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+Kzx2MbD//7ayd+aOst6C3X1PEowOw6WZ0FJ1cJtGh0=; b=PHmejvnmSgVgn+JBcu0Adx76+ya44Z1bQUxBUSKkPHEXVZqm2ntP844KkvGQvnoeCjqDYj+QK
 VdfW2La2QM2BXds6tdk7luDoj/gtbofZTNzHKJ52cnnh7z7vH0EK0Xu
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-v1-1-1b1055f482a1@google.com>
Subject: [PATCH] wifi: wlcore: main: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect fw_version strings to be NUL-terminated based on other similar
assignments:

wireless/broadcom/brcm80211/brcmsmac/main.c
7867:           snprintf(wlc->wiphy->fw_version,
7868:                    sizeof(wlc->wiphy->fw_version), "%u.%u", rev, patch);

wireless/broadcom/b43legacy/main.c
1765:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",

wireless/broadcom/b43/main.c
2730:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",

wireless/intel/iwlwifi/dvm/main.c
1465:   snprintf(priv->hw->wiphy->fw_version,
1466:            sizeof(priv->hw->wiphy->fw_version),

wireless/intel/ipw2x00/ipw2100.c
5905:   snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",

Based on this, NUL-padding is not required.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ti/wlcore/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index bf21611872a3..52a427bd54fa 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -1126,7 +1126,7 @@ int wl1271_plt_start(struct wl1271 *wl, const enum plt_mode plt_mode)
 
 		/* update hw/fw version info in wiphy struct */
 		wiphy->hw_version = wl->chip.id;
-		strncpy(wiphy->fw_version, wl->chip.fw_ver_str,
+		strscpy(wiphy->fw_version, wl->chip.fw_ver_str,
 			sizeof(wiphy->fw_version));
 
 		goto out;
@@ -2344,7 +2344,7 @@ static int wl12xx_init_fw(struct wl1271 *wl)
 
 	/* update hw/fw version info in wiphy struct */
 	wiphy->hw_version = wl->chip.id;
-	strncpy(wiphy->fw_version, wl->chip.fw_ver_str,
+	strscpy(wiphy->fw_version, wl->chip.fw_ver_str,
 		sizeof(wiphy->fw_version));
 
 	/*

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-c0c28a2ffb0f

Best regards,
--
Justin Stitt <justinstitt@google.com>

