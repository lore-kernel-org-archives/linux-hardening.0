Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825CBC46CA1
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 07:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjIRHZu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Sep 2023 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbjIRHZo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Sep 2023 03:25:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E6AAA
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 00:25:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8109d3a3bbso4708668276.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695021936; x=1695626736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3WAQv+e8xIAvvalEvufZpQYuwaoIOUMyrU9FgMi+IEc=;
        b=EtyU2DbHd+QkWP+a3Q3tat9zKgLFOiG/nb2tEIg/mdwcz3HmlhiGK7W5+O8j4P+YRE
         ZhdYqE01irlOcZjQI/ES1XpbgT+IvAqTpVAUaNBvA4zezOywrWykpdrOVd0RP+VznTrq
         uoEylyNjjddfu+tnguLsaA9b+5ZpiJj3HQYceBR+/cvYHRFpLPpsgRvv5o+Ll4Yxx2fI
         eUN1bYIwAYjLEYIM6Sp6bcqZe9N93VNAWd+KLKXPz9ZYzgvYQGkgcBEMJljddTxgeraF
         1dRa8mAxvnc07c63JcjWE3WSD3RFzPAslgj9gWCnmVBsPTOkM/HUR9JukV9Ohxu6985q
         DLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695021936; x=1695626736;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WAQv+e8xIAvvalEvufZpQYuwaoIOUMyrU9FgMi+IEc=;
        b=OwpRqgOYqMS3jfB5LQ8FdzmgKN5b4DdjJ57YfOURU4NN9CCjwC4iKgxS5pRsgn/bYo
         5A/RFa+XqItWHkht29mWsYVLayd56UyZ7ZLrdOHAUOUTbYm/4ZWSA6ewOW+dAeOhhl9h
         f6tQYXNnvBLMzpoUsEshFX5XcE1qT+s/1ZddrVJZgm45N9o0lCZ1pQE55vHf10jz1URP
         Zp/NO9NAM4wAj+OhQ52liEqvAGAH1A1fTkT8qKVSRy503aQjNeChBTHvk7iLbb+WZrEw
         eQoGYHHqG/F+7tJ/8ZTXr6Vvd5E004sBJnXOIw2MnZEvk8bOLoMNaduxab1aIgUuYScy
         8WnQ==
X-Gm-Message-State: AOJu0YyQgiRWN9WpIyh51PcbYeDn4OZZn6cA7NQYehYW5EA1LzrDmN/w
        EmKLss/zMLqHhAqeF9+X98hdXt3HueIYiRPdYQ==
X-Google-Smtp-Source: AGHT+IF+jX5dUSIkSB8RfzXLXxoPZwR9qlzLXtJHnwCjwBp0eZD0RK+hmfw8QP+439CpeHYVFT/vO68h56dKzlzm3w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ad5c:0:b0:d7b:9830:c172 with SMTP
 id l28-20020a25ad5c000000b00d7b9830c172mr172732ybe.0.1695021936336; Mon, 18
 Sep 2023 00:25:36 -0700 (PDT)
Date:   Mon, 18 Sep 2023 07:25:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG77B2UC/5XNQQ6CMBCF4auQrh3DUBR05T0MMVAGmFBa0mIjI
 dzdyg1c/m/xvk14ckxe3JNNOArs2ZoY2SkRaqhNT8BtbJGlmUxviOAXZ9S8Qus4kPPQaKtGMG+
 tX40eYarZgIJC5je8SEJ1rUX8mh11/DmcZxV7YL9Ytx5swN/6rxAQEGQjy7Kgomspf/TW9prOy k6i2vf9C+KPcjnbAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695021935; l=2744;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=swPV5XpUlRXB66oR7Qh/nSFtVd/YWWRwyK5xLI6b/UY=; b=lQh9KvxNeNw90KFaN+C0AaSOn2MGPv/wnngx73fGHOn+3LvNHoRUpaTOi1Y57TwXuu3uuw7Uf
 QFw1u2PR0KpBJ0fpN3sNNORHsXBuqSeRuRmZLY1W53HrYOVatw/bPjw
X-Mailer: b4 0.12.3
Message-ID: <20230918-strncpy-drivers-block-null_blk-main-c-v2-1-cd9b109edfdf@google.com>
Subject: [PATCH v2] null_blk: refactor deprecated strncpy
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
Changes in v2:
- use strscpy_pad (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230911-strncpy-drivers-block-null_blk-main-c-v1-1-3b3887e7fde4@google.com
---
Note: build-tested
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 864013019d6b..d83e65525e18 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1938,7 +1938,7 @@ static int null_gendisk_register(struct nullb *nullb)
 	else
 		disk->fops		= &null_bio_ops;
 	disk->private_data	= nullb;
-	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
+	strscpy_pad(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
 	if (nullb->dev->zoned) {
 		int ret = null_register_zoned_dev(nullb);

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-drivers-block-null_blk-main-c-7349153e1c6a

Best regards,
--
Justin Stitt <justinstitt@google.com>

