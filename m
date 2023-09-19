Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A713DCD343C
	for <linux-hardening@archiver.kernel.org>; Tue, 19 Sep 2023 05:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjISFao (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Sep 2023 01:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjISFan (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Sep 2023 01:30:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D07FC
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 22:30:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e8bb74b59so5895589276.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695101436; x=1695706236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lQR/HsEkBNxMstFQzjiG0kZ36IY24+GODbvDcs1xA8Y=;
        b=KriOVzCOvcGdBw0yrpyw/QTwjVfniRRMypPNnZTdEo6ZZ5LToI4nth4/P9rDdaZ7nt
         YMCUk6+9j5Fqx52uiKAFtNgyavNuQqa914CHj5NRQkJVnGEVoQ8fLFxmqKmu3fZkwG/w
         5/2pBQkAgRzep3p6FQe4kzj3PV6rrDS3UFBAbi5YYsI7zyCDj/56L3ul88B7HNTwZhog
         n+7bI3fOYbFs5QmhYUT7Hnc1Ql0R9iDoqA3Nsv8rYbO8Tpmnn9KexyrnHvG6O8uGIhFo
         mh9TZ2cmLI1g1xw3ufiQDiWAXBOy6V159HqIDWipyrHEaKQGWUQmMWcWt7FPaL1ebmxR
         NZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695101436; x=1695706236;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQR/HsEkBNxMstFQzjiG0kZ36IY24+GODbvDcs1xA8Y=;
        b=KQztzT/9i+7oZ9QaCUAFBWAZYOx9rAesUhYG6wyLgMNN2AhuNTCSdeX4pDvsblNZLU
         1EnilT3AKx6J7zr1on+UX5BrfQM7xXOIxPFnul0b7fz1drL6HyrR5AlnBZZWMJK5GlXn
         P1w/SsQNfpRHnDSCBYkkS+alYX17F0GN1RobJQRb1wh6rafqynUVttXHR/uYjGJ5MRlF
         9tgapFBmT5GIaqgl7pnS4S0ED0pPGdtZy8t5Iv0LVpAhlZmb//HTdXvEG6m5J+cM5i3T
         FCcUv25SBylhdpje0QKHOfPiSDN9htnif64tBTz3opNwkQE9xhtDVWJBIFKNGVTwfuKE
         7bLw==
X-Gm-Message-State: AOJu0YyROI9Kw80IpsveYXxKc/MMbiBJoSGepaoNgWJMqgbR8aiWAQsU
        o6J45jp28MWkfM2e2qBRY8T6KE5a9sPHAMCVlA==
X-Google-Smtp-Source: AGHT+IFW1aPaR9HHx6n9GsBH2tBx9fbAKPkEthMum464JJMRObYbrsNbypZUwY8pZ7jVSq5ktKJBKzFH/QKj6h+cyg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:9392:0:b0:d7e:752f:baee with SMTP
 id a18-20020a259392000000b00d7e752fbaeemr219229ybm.10.1695101436311; Mon, 18
 Sep 2023 22:30:36 -0700 (PDT)
Date:   Tue, 19 Sep 2023 05:30:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPoxCWUC/5XNsQ6CMBSF4Vchnb2Gtijg5HsYY6C9QENpSYuNh
 PDuFibddDxn+P6FeHQKPbkkC3EYlFfWxMEPCRFdZVoEJeMmLGU8LSkFPzkjxhmkUwGdh1pb0YN
 5av2odQ9DpQwIyHlW0hNHKs4VidbosFGvvXO7x90pP1k379lAt/ffQqBAgde8KHLMG4nZtbW21 XgUdiBbIrBPtviVZZEVsqxpWqJsZPPFruv6BiS8jjkyAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695101435; l=2972;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=RXCzkkhOQ+E9UQbcpoxWnHInR3mEf5rOQmZil2qhk+M=; b=FImjMy9YVwdq2HB1Atjs+s0JDQE+Fxn7+UN+L9PGSCOdB7Zi1ONJXuCKBxeO2KFrlKI9jCLp+
 fdreS7InpzLCkCrpsn9S2Gxrmta6YbpzhETuSxVCpokVKbDdQow7atn
X-Mailer: b4 0.12.3
Message-ID: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
Subject: [PATCH v3] null_blk: replace strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should favor a more robust and less ambiguous interface.

We expect that both `nullb->disk_name` and `disk->disk_name` be
NUL-terminated:
|     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
|              "%s", config_item_name(&dev->group.cg_item));
...
|       pr_info("disk %s created\n", nullb->disk_name);

It seems like NUL-padding may be required due to __assign_disk_name()
utilizing a memcpy as opposed to a `str*cpy` api.
| static inline void __assign_disk_name(char *name, struct gendisk *disk)
| {
| 	if (disk)
| 		memcpy(name, disk->disk_name, DISK_NAME_LEN);
| 	else
| 		memset(name, 0, DISK_NAME_LEN);
| }

Then we go and print it with `__print_disk_name` which wraps `nullb_trace_disk_name()`.
| #define __print_disk_name(name) nullb_trace_disk_name(p, name)

This function obviously expects a NUL-terminated string.
| const char *nullb_trace_disk_name(struct trace_seq *p, char *name)
| {
| 	const char *ret = trace_seq_buffer_ptr(p);
|
| 	if (name && *name)
| 		trace_seq_printf(p, "disk=%s, ", name);
| 	trace_seq_putc(p, 0);
|
| 	return ret;
| }

From the above, we need both 1) a NUL-terminated string and 2) a
NUL-padded string. So, let's use strscpy_pad() as per Kees' suggestion
from v1.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- reword subject line (thanks Jens)
- rebase onto 3669558bdf354cd352be955ef2764cde6a9bf5ec
- Link to v2: https://lore.kernel.org/r/20230918-strncpy-drivers-block-null_blk-main-c-v2-1-cd9b109edfdf@google.com

Changes in v2:
- use strscpy_pad (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230911-strncpy-drivers-block-null_blk-main-c-v1-1-3b3887e7fde4@google.com
---
Note: build-tested
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 968090935eb2..6cd0614d8786 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1946,7 +1946,7 @@ static int null_gendisk_register(struct nullb *nullb)
 	else
 		disk->fops		= &null_bio_ops;
 	disk->private_data	= nullb;
-	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
+	strscpy_pad(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
 	if (nullb->dev->zoned) {
 		int ret = null_register_zoned_dev(nullb);

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230911-strncpy-drivers-block-null_blk-main-c-7349153e1c6a

Best regards,
--
Justin Stitt <justinstitt@google.com>

