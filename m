Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F3C6FA8F
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Aug 2023 21:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243736AbjHXVoh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Aug 2023 17:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbjHXVoc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Aug 2023 17:44:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A97E1BD9
        for <linux-hardening@vger.kernel.org>; Thu, 24 Aug 2023 14:44:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fb8933e18so3989127b3.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Aug 2023 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692913469; x=1693518269;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I2XHhFoIX29d7SjqRkOJs1D4R2XM7B/vfVqVUXWhEhg=;
        b=rY+DThLCebZPaSUnju22NEfLJ27R1oPVY6zCeRi31RmWbU68qTl1pdHi2BEfbVrayR
         k0cDrn7I4jrVtdpKs7Kr/3zfTrULZZCLECE4B9TUFsULDhfDM2hH8fRoIseQOcQ2KBMh
         2dpo+GBtUFLG298z0huIQ9O1YmAd0n4o4XF2ROgkncYzTdIFCG93DagLrGzuLGxO4r0N
         SvG5dhKPCi+BOWGViTXxgkhpedphNMKX3gFcBfPAj2pmrLsjUcSnWmHyYgpMWIlhr2zC
         RnQR+J3a3vA0iXCClziMyVIncsPBW6P6ynS7+im8mO9GfcbOe5G8fAx+a8YgTewgU5bR
         98fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692913469; x=1693518269;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2XHhFoIX29d7SjqRkOJs1D4R2XM7B/vfVqVUXWhEhg=;
        b=bmwu6oaldDUYOz0M7R9q0l/6TmyIEcwrG2EY5cqn4IH4IeXdH/tvI1RsLdB0JWu5te
         nxdObSbFFw3h9QAKGD03WULxrH+2jbVNaHCOteMxFWuYiCV3Q34JbxHVsrSfgL1qkzCI
         E8ubovNCli5NyZyaeR1qv9lyoKTrCU8wVBWa3hs+HODYzB4xAK7gnI+9K+EfLT0W1p5G
         cPVLiPdmWJzvv8YXr41rL6z0rwgiQxdx1lCuRpKWWvSvcu/n4w8tU6uGBiGpSt1D9R20
         QufNpOnh/NK7yafBKAUMO1aieH6CJmsvg5DaLEBvrbHPgSU8Yr87/uwCFwd6jVAYGrTL
         y8BQ==
X-Gm-Message-State: AOJu0YzOlqp/+xmUaDrmFM+K+UiGWbIr3i0yOFfqmuZJQh5gxGnYONKn
        SFM6NM8h9dZdIKl1uDnkZgf1cgIgmpJDIXZTag==
X-Google-Smtp-Source: AGHT+IH/Saoly6PdNTUksg1rPj0d+TK46Gv1Tr70tqR0y2uvJtz9y8ZhCe3UiS4eFgllnV5EYUoay6dQGm8NmlypmQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:af0e:0:b0:58c:6ddd:d27c with SMTP
 id n14-20020a81af0e000000b0058c6dddd27cmr287942ywh.6.1692913469696; Thu, 24
 Aug 2023 14:44:29 -0700 (PDT)
Date:   Thu, 24 Aug 2023 21:44:29 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADzP52QC/x3NwQ6CMAyA4VchPdtkDqLiqxgPoytaMWNpJ5EQ3
 t3F43f5/w2MVdjg2mygvIjJnCqOhwboGdKDUWI1eOdbd/EdWtFEecWosrAaBiI2k0HeUla0zGH 6ZJzm4cVUDAk753o+x9H17QlqNiuP8v0vb/d9/wHgcs+xggAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692913468; l=1729;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=q1hBG/wVyKaqLwdyOtnadSyl5YGFuaU8rnWaY2hrenw=; b=mKN37v4hCvmX1Gwo9UAku1OIHbfcUZw3kVDDrNwrJVWO+/TxQr0FpQjLDuCjpPtXEkNqC2AIR
 dhMnobjW0piDJqZJ08dL1y8Bke+/fatzOiIggDHGvCn6v1f/HWPTQzK
X-Mailer: b4 0.12.3
Message-ID: <20230824-strncpy-drivers-accessibility-speakup-kobjects-c-v1-1-3a1ef1221e90@google.com>
Subject: [PATCH] accessibility: speakup: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Use `strscpy` as it guarantees NUL-termination of its destination buffer [2]
which allows for simpler and less ambiguous code.

Also, change `strlen(buf)` to `strlen(ptr)` to be consistent with
further usage within the scope of the function. Note that these are
equivalent:
|419 	const char *ptr = buf;

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/accessibility/speakup/kobjects.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
index a7522d409802..8aa416c5f3fc 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -422,12 +422,11 @@ static ssize_t synth_direct_store(struct kobject *kobj,
 	if (!synth)
 		return -EPERM;
 
-	len = strlen(buf);
+	len = strlen(ptr);
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	while (len > 0) {
 		bytes = min_t(size_t, len, 250);
-		strncpy(tmp, ptr, bytes);
-		tmp[bytes] = '\0';
+		strscpy(tmp, ptr, bytes);
 		string_unescape_any_inplace(tmp);
 		synth_printf("%s", tmp);
 		ptr += bytes;

---
base-commit: f9604036a3fb6149badf346994b46b03f9292db7
change-id: 20230824-strncpy-drivers-accessibility-speakup-kobjects-c-4009e7df0936

Best regards,
--
Justin Stitt <justinstitt@google.com>

