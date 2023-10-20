Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412A1DDC8
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRyQvAni"
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37ADD63
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 12:35:44 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-581ec87fbf9so1570521eaf.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697830544; x=1698435344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9+iAGOL8fBcRKregm2UatJBSjxVyGVTi97qzrD87J/M=;
        b=aRyQvAni2EHDC0yRsExYndr00a4pAr2Rtc9NCVfSzpCdgmvO5I5cL6jHXAntyhyxL2
         FI9KRSEINv+Hs6h/g1KbBbbso/zbisELGQolS1SFa35WUNcqQ2iZ9dnMyQAqQ1/QUCF7
         klwPq5O8MSJFKEYZ0DM3XcZwQh3+MzdWqiLmcC1ojS+1CtCn1Xw7Mek462kLySxhoc4h
         FehbPwXpxTs61coqrVJ9RGMalTRWJN0Ymdl4kSyOZGeAJpjLzdsOzlUIta2TRhogRJve
         +P1QXvrg5VOCNk4mHO7U2CSk6Zhiezr8zxVyhIj8LTgfHtEwoGataffKbvaUqYufSGtR
         eGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697830544; x=1698435344;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+iAGOL8fBcRKregm2UatJBSjxVyGVTi97qzrD87J/M=;
        b=Ocm7lV4zE0yWcmJv/oEr9pqs+ekDRp55bqOlxPilo/8BXlPd0UXizzczWwwECqzz0F
         r/PjF7n0GclVPj8Q16zR/UYVvqX6sesKR8Q7Dy/Mki8JmVQdWWbNt9kRwqAQKYEJLgt9
         PsQ2l9fKQ9eNV6mGM6yS1u6nPmhfAL2T9QUTWLVGGAetMz6Hoj/diaml4bNf9K3PHEEl
         d4nR65/XpdMAeHweZWuT0STCL/ZKpGUbdZgXwidYw2BUZpOJSEe0VCnfU/zL/YH6pDUl
         aHbZCUC2ujOV0IniUkpRHpZik7e5iyjoU/vI7PfEU6m+LJSWD6Rck5os03IJ81ufqLHV
         aM8Q==
X-Gm-Message-State: AOJu0Yw/lLEq0GrBpRLZUOWm4toHvVl/XZa9D3kAVWZmzr9dvFUs/4/r
	j9oOH013wd3pcuXvZpEe7LH30NzsFYxIWD2dPA==
X-Google-Smtp-Source: AGHT+IHZQUY9baCehYvzXAaS7x9nNF6uHCQ2/74bV2qdNWPoNwNQLv1R/Hn9zc2YRsn/RnRPDVOTLR2TZ+Z8Sxp5Ag==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:448f:b0:3ad:da36:1dd6 with
 SMTP id eq15-20020a056808448f00b003adda361dd6mr1891601oib.1.1697830544173;
 Fri, 20 Oct 2023 12:35:44 -0700 (PDT)
Date: Fri, 20 Oct 2023 19:35:43 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI7WMmUC/x2N0QrCMAwAf2Xk2UBXJwx/RUTaLNOAdCWp0zL27
 ys+Hfdyt4GxChtcuw2UVzFZUpP+1AG9QnoyytQcvPPn3nmHVjRRrjiprKyGefmyon1yftcGnQP xI4ZSWCsSRkfjEN0lkB+hRbPyLL//8Hbf9wN9+HSXgAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697830543; l=2313;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zmP6Agkd7BUv41JUTgaRBkw1r6Q9BZkiPWT2tLR0LAQ=; b=qUt1cyoTbXs6qmJVgPAXz5mbtcGQzIOLTkM7z8UR/GVWZ8gVAAzFiOhg9+1gcHscXS/bles5K
 Hd71E9a1vbbDBn24xeS1hMCC89N3IDNnw1W+pJJ4CZNXEiLH5v1sOMH
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-surface_battery-c-v1-1-cabaea50e667@google.com>
Subject: [PATCH] platform/surface: aggregator: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Maximilian Luz <luzmaximilian@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect bat->name to be NUL-terminated based on its usage with
strcmp():

power_supply_core.c:
445: return strcmp(psy->desc->name, name) == 0;

... and also by the manual `... - 1` for the length argument of the
original strncpy() invocation.

Furthermore, no NUL-padding is needed as bat is zero-allocated before
calling spwr_battery_init():
826: bat = devm_kzalloc(&sdev->dev, sizeof(*bat), GFP_KERNEL);
827: if (!bat)
828:   return -ENOMEM;
829:
830: spwr_battery_init(bat, sdev, p->registry, p->name);

... this means any further NUL-byte assignments (like the ones that
strncpy() does) are redundant.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy() usage of:
(dest, src, sizeof(dest)).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/surface_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index 19d2f8834e56..196d290dc596 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -722,7 +722,7 @@ static void spwr_battery_init(struct spwr_battery_device *bat, struct ssam_devic
 			      struct ssam_event_registry registry, const char *name)
 {
 	mutex_init(&bat->lock);
-	strncpy(bat->name, name, ARRAY_SIZE(bat->name) - 1);
+	strscpy(bat->name, name, sizeof(bat->name));
 
 	bat->sdev = sdev;
 

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-surface_battery-c-b0c84b05ac28

Best regards,
--
Justin Stitt <justinstitt@google.com>

