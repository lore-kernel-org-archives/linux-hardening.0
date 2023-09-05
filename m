Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26ADCA101A
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Sep 2023 21:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbjIEVzE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Sep 2023 17:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbjIEVzB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Sep 2023 17:55:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CCA1A2
        for <linux-hardening@vger.kernel.org>; Tue,  5 Sep 2023 14:54:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so2647307276.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Sep 2023 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693950886; x=1694555686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mYSSYqyZSAKIfvzMRnscK0LuxZzE2hQmiaI7r8kw+io=;
        b=JyJk91Z+QZRTbtKgeOK+Nk934z+HbCX09Ydgq9HHngyKBl70aBv7Rf2twBg9hzmzTt
         zfzpoq49lcoW2YyU3UgP1jpTMEteaB7Ig6Er6LCRSfjl6cu9uFwNBDlJDNw9MzPBS7cD
         cwG0b7IP9X1QqwomSD4xPJJo5tqAHMwBz/24zmJIMPtcHADklz6M1aF8lBROfeK3Ou/z
         PYlLA0CvCCY2q9iY3H/NhSXeQu5kt7mXdBesBuGt00om7K1dMtt4K/HL9fw+ROybWgV9
         vxTxisuE0bsczIrZmkVKEFLUiStgtA7pmsqmWXO8uGOoacbufOPjcGO/WYpKPJo7j8SJ
         dfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950886; x=1694555686;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYSSYqyZSAKIfvzMRnscK0LuxZzE2hQmiaI7r8kw+io=;
        b=SqJ8BAPjaF+3RFx7tisX53IWENgfLdPf/Uov/O8Iuf4tsSF3/SDPOuEbAR0LjlZjwP
         3aoTgGeXtl4QkHjpWgaxRCcS6+FFbu2tARxankCCfnQZRoRw6uVUm2QkkFKdDlh63ofn
         pu0/8LhMeymPu3jVtigNF/nzGa598i67iME+bt0xm/NvVQbQlTDnKbhvSnxGiSlHs10k
         2IlhocMZdChkFlX5mNe5gVW0EQvZrvkvZcKDDLCUz48Wyw+ygyBA/dojkqpDTWRPsryD
         gO6YZHr+CK97phKgKcAaFC6gw7AKflf488Cv5zWf2lPbArA6zwfimubA2pmv3peJ0EAi
         pUtw==
X-Gm-Message-State: AOJu0YxjupfHM6ebnbfD1Iys+uMBmaAnHQV/Xa39+si/gRjufhvjN+Fw
        rRZh9AvEU1U8Yc1Qx2QXAmGo3VzODmF47jvXFw==
X-Google-Smtp-Source: AGHT+IEthNzV8ZE+tRL4eK9ihsAlyb2EPkYYpRYCKGSbFbV8n6cZni6u1SkJNkJThkTG6zrJpu4FeNqiuTv3OYY/+g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b082:0:b0:d01:60ec:d0e with SMTP
 id f2-20020a25b082000000b00d0160ec0d0emr340324ybj.9.1693950886135; Tue, 05
 Sep 2023 14:54:46 -0700 (PDT)
Date:   Tue, 05 Sep 2023 21:54:40 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ+j92QC/5XNQQ6CMBCF4auQrh1DpwXElfcwxjRlgCZASYsNh
 HB3CyvdaTKbfxbfW5knZ8iza7IyR8F4Y4cY4pQw3aqhITBVbIYpivSCCH5ygx4XUE63MF9yGDs
 11db18ArxnkNvQBaSMiwzjZqzKI2OajMfK/dH7Nb4ybrlGA18//7nBw4cSsFrLKWoKK1ujbVNR 2dte7YPBPxE5W8oRpR4XpVKkM6K9Avdtu0NRuNskCwBAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693950885; l=2964;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=gDNLo7BwDTNW1pc/8WsCxyt7x3/IodsVK/vgZb9S0ms=; b=IXGF5h8HALV0QqVdSV0NY5o+3DcKJUjKJaxugsEIOU5l5nkn5MICgLmVSJpktWLpi5DXLER2m
 +QzOs8fM8cADr7PK33mrLHiIBTTAif+aH/Gsy4Qv8sV8thWQW0bekKZ
X-Mailer: b4 0.12.3
Message-ID: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
Subject: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
destination strings [1].

We can see that `arg` and `uv_nmi_action` are expected to be
NUL-terminated strings due to their use within `strcmp()` and format
strings respectively.

With this in mind, a suitable replacement is `strscpy` [2] due to the
fact that it guarantees NUL-termination on its destination buffer
argument which is _not_ the case for `strncpy` or `strcpy`!

In this case, we can drop both the forced NUL-termination and the `... -1` from:
|       strncpy(arg, val, ACTION_LEN - 1);
as `strscpy` implicitly has this behavior.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- Use sizeof instead of strlen (thanks Andy and Dimitri)
- Drop unrelated changes regarding strnchrnul (thanks Hans)
- Link to v2: https://lore.kernel.org/r/20230824-strncpy-arch-x86-platform-uv-uv_nmi-v2-1-e16d9a3ec570@google.com

Changes in v2:
- use `sizeof` on destination string instead of `strlen` (thanks Andy, Kees and Dimitri)
- refactor code to remove potential new-line chars (thanks Yang Yang and Andy)
- Link to v1: https://lore.kernel.org/r/20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com
---
Note: build-tested only
---
 arch/x86/platform/uv/uv_nmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index a60af0230e27..dd30fb2baf6c 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -205,8 +205,7 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 	char arg[ACTION_LEN], *p;
 
 	/* (remove possible '\n') */
-	strncpy(arg, val, ACTION_LEN - 1);
-	arg[ACTION_LEN - 1] = '\0';
+	strscpy(arg, val, sizeof(arg));
 	p = strchr(arg, '\n');
 	if (p)
 		*p = '\0';
@@ -216,7 +215,7 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 			break;
 
 	if (i < n) {
-		strcpy(uv_nmi_action, arg);
+		strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
 		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
 		return 0;
 	}
@@ -959,7 +958,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
 
 		/* Unexpected return, revert action to "dump" */
 		if (master)
-			strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
+			strscpy(uv_nmi_action, "dump", sizeof(uv_nmi_action));
 	}
 
 	/* Pause as all CPU's enter the NMI handler */

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230822-strncpy-arch-x86-platform-uv-uv_nmi-474e5295c2c1

Best regards,
--
Justin Stitt <justinstitt@google.com>

