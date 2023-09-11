Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B199CA0EDC
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Sep 2023 21:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347742AbjIKV2a (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243941AbjIKS1d (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Sep 2023 14:27:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C5198
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 11:27:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b56dab74bso34658357b3.2
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694456847; x=1695061647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4gDHjdo7g0e0VEUdde9XhYVf3BvNK1Q4R1IFhdu2EU=;
        b=2ghIN16C+85JNtjLFbVOdwlr2kwwxPlmKzcutw6C3YmWUJCq5eLYMpzFZHlUEvgFMe
         lPNksjrlVZDLLnbYXPTioJY2LdAnoFUFJCcKIhABtWRyUcCtMma8NN510Sfc2Zjb6iXe
         iTN2ywHMEENOnLU1ME9Hb3XcfqVaDRxnxlw9ZnvD82PWl20TBdj9f3W5ccY8MlPsj33T
         4SOILPiPFYdXH84tyEpk7tf7QBU93TV6ySExY/DgQ8e+w8zZETyyKOQnQr7Q1QofJ+ym
         pz1I7g4qatqEDu+/lj/4W1FGjB3cVlzOwncrZbr0Ohu/W/9suWEDAEEG5s0RzurIwRMi
         qFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694456847; x=1695061647;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4gDHjdo7g0e0VEUdde9XhYVf3BvNK1Q4R1IFhdu2EU=;
        b=g+hH+q8evySqTrOlPz+FWPnimhUumNqzxaK50duM2zAApTsyYyn6p9dXsUmcxJkbnb
         aYl3nPoIWRk5AGU6uXiMBXz9bQGq+LRuSqTrqxRDBBJhJ4gTN2O2AQyngkhHkytykhph
         ELFgBUEG7avJjtasMIgCgeQLIXxS8PVEzzZT7J04kbCwhgAnZt+qn2jR+/xaCAo5WVg9
         q2jgpgxK0ptMwZKUlBO3TdCizVx5iONWEomzQ7nD9oZxpvGB5HqorwVxpxgpOb3utfVT
         Kyj+hfxcjJcEz9Ai1bMiWqCQ/DkQ6yFc9HcBbRrhmjH7/vUkxdtf86ke+jZLJfO14lR9
         /BEg==
X-Gm-Message-State: AOJu0Yzo+PfGiBwgplloTt//jN6V5aoZi89DRSwi32g0m6xS++q1W/sv
        Tc4LYCOP1cnoBaENY9NKfYT3GzabjpMikyvQdA==
X-Google-Smtp-Source: AGHT+IFXwRs2WiPU1oQO41cJq/UB6Ht6s9+w8CBY9n7RHSCOA92/od6eE9lpWuVMuGg4p6bdi9Xfs61/jcv0peYObQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:cb05:0:b0:576:8cb6:62a9 with SMTP
 id q5-20020a81cb05000000b005768cb662a9mr261505ywi.6.1694456847000; Mon, 11
 Sep 2023 11:27:27 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:27:25 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAxc/2QC/x2NQQqDMBAAvyJ7diGxEJJ+pfRgNtu6l0Q2IhHx7
 wYPc5jLzAmVVbjCezhBeZcqJXex4wC0zPnPKKk7TGZ6mWAt1k0zrQfOSgs275AKFdxSeyAMPpo YnIvRJ+iVVfkn7Tl8vtd1A6LFs0JxAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694456846; l=1696;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=dB+yasP8Bzxdh37I4XyOTceZ5yt48YWVpNpjD6rXby4=; b=FlV+BHOQFu2YvXN7PEVhHveROJCatNBEXKLmz3ikk6gHqPooRAghFock1yvnxmr/1xo2rxa0R
 /y9OxN0uAveB0WeynZZwEf9tY2My2NYnliox/S8LAYpzG4xaPOFDuJe
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
Subject: [PATCH] x86/tdx: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated and we should prefer more robust string apis.

In this case, `message.str` is not expected to be NUL-terminated as it
is simply a buffer of characters residing in a union which allows for
named fields representing 8 bytes each. There is only one caller of
`tdx_panic()` and they use a 59-length string for `msg`:
|	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";

Given all this information, let's use `strtomem_pad` as this matches the
functionality of `strncpy` in this instances whilst being a more robust
and easier to understand interface.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 arch/x86/coco/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..2e1be592c220 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -119,7 +119,7 @@ static void __noreturn tdx_panic(const char *msg)
 	} message;
 
 	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
-	strncpy(message.str, msg, 64);
+	strtomem_pad(message.str, msg, '\0');
 
 	args.r8  = message.r8;
 	args.r9  = message.r9;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-arch-x86-coco-tdx-tdx-c-98b0b966bb8d

Best regards,
--
Justin Stitt <justinstitt@google.com>

