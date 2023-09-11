Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF1ACA0EC6
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Sep 2023 23:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjIKXRf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Sep 2023 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354034AbjIKVwO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Sep 2023 17:52:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E67524A
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 14:41:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 6a1803df08f44-655e42d1dc7so20603106d6.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694468422; x=1695073222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QwxqNL1zXUB9OAJf/Ygs9mELpjYs6oPReuh29ZTVE2Q=;
        b=YPCSRb6tm02RJVb3sqLHoQFpoPE6cOKar1toSbEls0ySzNSynx5dhNjLSZQu70Jhyt
         rNcPQy1xPM7GlbOaW73y/WsG7AyA463LCUOZXhdkUhh5hL+OnpCX5nqmYSc232YFCYHc
         mG4l+x5zFMT4kJl7tBNATfSjbBHwNVM6uvLcCJXdDT5Wmn4bPxpZtz0B+0fU/eaE2erw
         5iTJJy9OfcsG7uHA+tGA52DCJ3lAA/OWb5JUghpqZtXS4GaFfMoVzW6EDUpjP5aItyyK
         0dneA36Gu2m735mOBELBAnWvKMbzIgotJb1zbM8sT8tiC/O2OrGV9HIyZSbmyfHX2ebA
         Cz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694468422; x=1695073222;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwxqNL1zXUB9OAJf/Ygs9mELpjYs6oPReuh29ZTVE2Q=;
        b=tVrKMRcYJPNqowhUizJPQsBnHWGV65ld0fEC3cHGMaOZ1ZXHL+Us2GGXvNVBOTwsws
         VnGsYSs/c/rrBsqjH9qBdbmmFeRqYcgIE1e6ze9zuT0K6BqeS1l+VbWhxW7obiwzglpD
         9NG6EIJzKgzi7qpP490flkkhQBQRvWRGopfUKRFcZgEPT/I4PaueK1H3m53Spyy2QqPn
         bffHlls+1+qsTE0fhSMmjCsNyUiZctxnq2UCoCfPy6tQeCuzSt5bUGyr/5asVwv7u6zz
         kpkch9lHGTNzRl2EiHJKIFGbR/+fI4gSGHXy2AxdcOn02KSz/O3yzEqkcwXjWbGZOUS6
         7JBg==
X-Gm-Message-State: AOJu0YziYT7rLdwf7eoJV7T9oMbNqvfMWDlNYN6mla/oIV3GCmxheZgz
        n2skyJpGQTXAufnlf40VNgn3UkqLH3mrDJd0AQ==
X-Google-Smtp-Source: AGHT+IHcMR+ryqln3fSBxGzKEDejFhIMPnxZUI8UrQblXcfot9EpwsLm83Fof7MdvFLqO8WCd16dz/9x4QOU6vN4eA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b708:0:b0:581:3939:59a2 with SMTP
 id v8-20020a81b708000000b00581393959a2mr281042ywh.3.1694466550612; Mon, 11
 Sep 2023 14:09:10 -0700 (PDT)
Date:   Mon, 11 Sep 2023 21:09:07 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPOB/2QC/x2NzQrCMBAGX6Xs2YUk/oC+inhIk6+6KEnZLaVS+
 u7GHuYwl5mVDCowunUrKWYxqaWJP3SUXrE8wZKbU3Dh6K7es01a0vjlrDJDjftPTW+OFX8KJk7 swimjj/ni3ZlaaFQMsuyT+2Pbfr6XNDh0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694466549; l=1855;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=isAQzdD4TDo3zPe9CmPoe7IjN/uC1JjTZgMq1hRyNwE=; b=PhU1KfeKpdN/BDvmqV7i6qAIViRdCxXDRe+/LXWdXeF0pas87bxDJPMKvwHjUa7w8g1DIDeue
 gKAjrn2y7siAoBO+CzhL32W04xXDWNV/yjjqwSJhVE0GfveW0V6sWnm
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
Subject: [PATCH] aoe: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

`aoe_iflist` is expected to be NUL-terminated which is evident by its
use with string apis later on like `strspn`:
| 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);

It also seems `aoe_iflist` does not need to be NUL-padded which means
`strscpy` [2] is a suitable replacement due to the fact that it
guarantees NUL-termination on the destination buffer while not
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Xu Panda <xu.panda@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: This exact same patch exists [3] but seemed to die so I'm
resending. If it was actually picked-up somewhere then we can ignore
this patch.

[3]: https://lore.kernel.org/all/202212051930256039214@zte.com.cn/
---
 drivers/block/aoe/aoenet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..c51ea95bc2ce 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -39,8 +39,7 @@ static struct ktstate kts;
 #ifndef MODULE
 static int __init aoe_iflist_setup(char *str)
 {
-	strncpy(aoe_iflist, str, IFLISTSZ);
-	aoe_iflist[IFLISTSZ - 1] = '\0';
+	strscpy(aoe_iflist, str, IFLISTSZ);
 	return 1;
 }
 

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-drivers-block-aoe-aoenet-c-024debad6105

Best regards,
--
Justin Stitt <justinstitt@google.com>

