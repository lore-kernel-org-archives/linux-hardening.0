Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35964EE49A5
	for <linux-hardening@archiver.kernel.org>; Tue, 22 Aug 2023 22:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjHVWFe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 22 Aug 2023 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjHVWFd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 22 Aug 2023 18:05:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C77A11F
        for <linux-hardening@vger.kernel.org>; Tue, 22 Aug 2023 15:05:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c4d30c349so69567377b3.2
        for <linux-hardening@vger.kernel.org>; Tue, 22 Aug 2023 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692741931; x=1693346731;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kvfNAmaQkydKuK6ht78gS3RG+WyOgiqVP4AeurXmSVU=;
        b=YurVokxypIFmdNON8ep9uamAlris/X4zsoEuaaroV7EPJxmx+G1qMnvW9BifErZ7Ys
         5zE3J5jTO/J3KR3rPHz72d3FPwqGTPE0sQkhx3B4egJALdUC1L3kw063q/eWrB2MupcE
         sjM7AG3epGtZpNARVuUgXwdsvckKwHy6AY7k8KVvEEPu3kW9sy7Q/nbp/LMc6H8g/w86
         MbN6EMt/k5t8f5/3545gKucIkhtIjTY96at/vrz1VTNsvVM7X0N5SSTLiDkM+bgIZ64T
         DEpk/3B4N6QIgGviUFKaWyy8VFwwZYfNwKIz+1lf2gzDkJDbkpk85UPqquCVPlcqYMgC
         /u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692741931; x=1693346731;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvfNAmaQkydKuK6ht78gS3RG+WyOgiqVP4AeurXmSVU=;
        b=H455QM0CqyPQr7QWLcw5j/EM61l0cZKse4tUSLlzwzDl4v6XQZf82LkTQ6DvAfriRX
         9rsNaI27LZN+O0/VqgYyEuEDGuetXEK3E7cjdZiAZfY48j8qgPTF0YYbOLnPtZ9D2k75
         pH6P/0m0xS+zS86U0FNaKwZ7x3gP9yQ9CRbkzn8t+dgB0Es/P7drK5V9dAPgF6gZKaN/
         5uj3aBd9Ygygk0cgYaFNUhVJ09uRqRwmZvjVZuW6figLVKXCxZPAzmYQ7RfZBI4udlzh
         UKykob2hPFOeF/tFEc3FCPp51D45U180AMl6BVgctsMNDd77+AzrABkY2R2d0r0Qihvc
         cnNw==
X-Gm-Message-State: AOJu0Yx/hHLddmtb4T9vCPov7kd+vl2ALcYTJX2sQFKjqpQt65rKO2Wz
        IdLJheKbcUkBWwGYeQ48kUA2K5Z7qEXbf9OhOw==
X-Google-Smtp-Source: AGHT+IE3B57XdbJQeeRxg6tfixLqzX6c6nh6PDYTDTOOozVZuiP29CWKkjiXnDbtOgadRu1V5u5FVV5tcubdZSVRtg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:7647:0:b0:586:4eae:b943 with SMTP
 id j7-20020a817647000000b005864eaeb943mr140317ywk.8.1692741931359; Tue, 22
 Aug 2023 15:05:31 -0700 (PDT)
Date:   Tue, 22 Aug 2023 22:05:30 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACkx5WQC/x2N0QrCMAwAf2Xk2UAXmRR/RWTULHNBqSWdozL27
 +t8Ou7lboUsppLh2qxgsmjWT6zSnhrgKcSnoA7VgRydnSfCPFvk9MNgPGHxF3yJRXljSMpY6ED /XfqC0rXifOjGBw9Qc8lk1PJf3e7btgNuSiRLegAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692741930; l=2119;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Y1vCgp5GYs4NsHT5r24HqojZFhU1daRE+/NKAA6CphQ=; b=Hi2h478Ff+VDwMs+vUBVNbhWGLJXHmI+lE2ifNg773E08iMLOxweArHLlRRxelq0JWloX12XL
 tTzo4RTqpLLDlFI7D1ya9b2QD+lAjabmNXKoLbUNeVWHnv22G1AnXl3
X-Mailer: b4 0.12.3
Message-ID: <20230822-strncpy-arch-x86-kernel-apic-x2apic_uv_x-v1-1-91d681d0b3f3@google.com>
Subject: [PATCH] x86/platform/uv: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

In this case, it means we can drop the `...-1` from:
|       strncpy(to, from, len-1);

as well as remove the comment mentioning NUL-termination as `strscpy`
implicitly grants us this behavior.

There should be no functional change as I don't believe the padding from
`strncpy` is needed here. If it turns out that the padding is necessary
we should use `strscpy_pad` as a direct replacement.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9384d5b4b8e..b524dee1cbbb 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -294,8 +294,7 @@ static void __init early_get_apic_socketid_shift(void)
 
 static void __init uv_stringify(int len, char *to, char *from)
 {
-	/* Relies on 'to' being NULL chars so result will be NULL terminated */
-	strncpy(to, from, len-1);
+	strscpy(to, from, len);
 
 	/* Trim trailing spaces */
 	(void)strim(to);
@@ -1013,7 +1012,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 
 	/* One (UV2) mapping */
 	if (index == UV2_MMIOH) {
-		strncpy(id, "MMIOH", sizeof(id));
+		strscpy(id, "MMIOH", sizeof(id));
 		max_io = max_pnode;
 		mapped = 0;
 		goto map_exit;

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230822-strncpy-arch-x86-kernel-apic-x2apic_uv_x-e51e08a5fbcd

Best regards,
--
Justin Stitt <justinstitt@google.com>

