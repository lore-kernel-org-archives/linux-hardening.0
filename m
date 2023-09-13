Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E88EE01F4
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Sep 2023 17:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjIMRVB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Sep 2023 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIMRVA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Sep 2023 13:21:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F3A9B
        for <linux-hardening@vger.kernel.org>; Wed, 13 Sep 2023 10:20:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bc02af5dcso888437b3.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 Sep 2023 10:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694625656; x=1695230456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCfSG6mCnW0qyfFGMhWtptM2uKei1bLEhKpvdaKI0EM=;
        b=mbVlcO2zidVtaVhja0n27bJA5JUPBLrMqWLDu03p6zWIreTemgObvDj2JT3YXbp/PP
         0mERMOgi5CZPe/zPpHIIsl4oIdAA/iQA5Gopi8qOGHAGhdwuCn7h3JzzQ7lAeFU0Q6ET
         ac3b5t98vS0KIuDXViyhVC3p/SsvxTBEIqf4PsnysO8Sl1u9elhWDKui4ghQ2Hd8WWwQ
         NoiBRhvUrlvtXhtYRr7AHNiQdvYCDwkx6acthwaz3n/B7yzzGyPhz4FG4jKWrDYTI0xB
         7fMt7l7YkfJkbjO8oqZ1XSZfozRa9mojuFm/M6hQSkzdkA7eoglfhg+ZaLmBkmwPNSrn
         tAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625656; x=1695230456;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCfSG6mCnW0qyfFGMhWtptM2uKei1bLEhKpvdaKI0EM=;
        b=JG8tQLreMeD8KW73W/kq+cccANugJIp7wOuRZdMiUG5VSrWC06QCG1BLJYz/7/NZQq
         0G/RAuC8dFxPRKaUIGX2i53aP5gETMtiMIshFTaISVDRBUXn+l27Uv+fzt4SZ8p9RwVT
         33uQRWQTeJ1nVNwVg9Q5C15RNPnx1el5sa5MefVtuGNQ9Wa4b8Lw/gXa3kZIazxP2T9+
         RopzN52zu6nPPET49iEWz11M3DIAyL3aV+rKo0FM6lt/Q6WxFptcdKrfkopuZR8n2YLx
         YhBh99RpuDKxk20HWeu5CC7Hspv6DXo+SV/bSXfh9fSzeVBQnOpErGJGMKDh51hgxYI7
         6XXg==
X-Gm-Message-State: AOJu0YxkIo+m/QqmsOvnPODtT1YKQTW0UiFZvXVNQtIsUGNU0hQ6Lety
        mqhUtHiwhUOeKt5HO9n/A6EGjVKvknmyMppXBA==
X-Google-Smtp-Source: AGHT+IHmZqG7+RKPg5oWQee0z9k9bPQgJZLAzA5rk6LcXiW5RHunFlSaUBTGy88s7nRwnv+MUI+mv7kvTmKVj2ZfyQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:4522:0:b0:59b:ca80:919e with SMTP
 id s34-20020a814522000000b0059bca80919emr50177ywa.0.1694625655805; Wed, 13
 Sep 2023 10:20:55 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:20:50 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHHvAWUC/52NwQqDMBAFf0VybkqysVJ76n+UIiZZNVCNZCU0i
 P/e6K3H9vJg3mFmZYTBIbFbsbKA0ZHzUwZ1KpgZ2qlH7mxmBgKUqKXitITJzInb4CIG4mhbc0w
 zmoYSdcQzV7LWQkgoW8Wyag7YufeReTwzD44WH9JRjXJ/fwxEySW3oOBaSy0uWtx77/sXno0f2 V6I8I8VshUsYKVtqaoSvqzbtn0AqJbMzS8BAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694625654; l=2145;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rHRbEEg76Fmzd3MgqtwO/Ydw/98CvZy1Bgwo8SLGEU8=; b=t9+RA3S3Zt+d24hZNYz4lNO+qJ9Nkfkp9t7nbfQbXU15aWNksTlAFug+khYhTUHKD5Ak2gdAU
 vZ9gixMYyYUB2tnTzpUBemu2Ekkb7/ti0NUblWa/3B8a28wJup3ZbE6
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v3-1-38c1db7d207f@google.com>
Subject: [PATCH v3] EDAC/mc_sysfs: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without needlessly
NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- prefer strscpy to strscpy_pad (thanks Tony)
- Link to v2: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v2-1-2d2e6bd43642@google.com

Changes in v2:
- included refactor of another strncpy in same file
- Link to v1: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com
---
Note: build-tested only.
---
 drivers/edac/edac_mc_sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 15f63452a9be..9a5b4bbd8191 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -229,8 +229,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(rank->dimm->label))
 		return -EINVAL;
 
-	strncpy(rank->dimm->label, data, copy_count);
-	rank->dimm->label[copy_count] = '\0';
+	strscpy(rank->dimm->label, data, copy_count);
 
 	return count;
 }
@@ -535,7 +534,7 @@ static ssize_t dimmdev_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(dimm->label))
 		return -EINVAL;
 
-	strncpy(dimm->label, data, copy_count);
+	strscpy(dimm->label, data, copy_count);
 	dimm->label[copy_count] = '\0';
 
 	return count;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230913-strncpy-drivers-edac-edac_mc_sysfs-c-e619b00124a3

Best regards,
--
Justin Stitt <justinstitt@google.com>

