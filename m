Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD204EE3F3F
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Sep 2023 23:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbjILXnL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Sep 2023 19:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjILXnK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Sep 2023 19:43:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7B01705
        for <linux-hardening@vger.kernel.org>; Tue, 12 Sep 2023 16:43:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e4151d07aso6008471276.2
        for <linux-hardening@vger.kernel.org>; Tue, 12 Sep 2023 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694562186; x=1695166986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNUsumri2UZDwpZg4M25MzHoYyNv/o7N3O07+7K4l9w=;
        b=kLDB3Uzz2R30PZxELJnpFMlA4qdjFAlhpkR8Im8RjF2iyya5kGY9b3UQai0tiLEe4I
         nT8tIEkTdhCie842an4uofb+UZBuoPqA0S1UvX5RmwmseYR09jxdUo3SYC58xUfzSkE8
         LvZD11Eirg3r+ksEX+oCUdRwu8wjN5b9W4Is+STsTgmSSa9W9xcC1cqiplIugxC7YQNT
         KWBgtiZMsqnKL03ICMaSEWQ9qZZl4ZqOln9XT8hceRd09rRZ3mZtCGAIYazyQE7/UNVr
         00lfROWGWhlcKSjZMslbRpXZDFRmc4vf5yLhG/ijFmCpAijL18uo9LhEBltAWVP2sT05
         nlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694562186; x=1695166986;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNUsumri2UZDwpZg4M25MzHoYyNv/o7N3O07+7K4l9w=;
        b=wXKkY6gn4Yrbw1MNJGeAsn1TInLAtu3EN7q9taB8mzL3M7ZS+Kd82fV+oTHLSa5aPk
         uxZRn2gze6T64mlL2blM0Tq7AWiIJ5GrQ/Zn3qOE+SEA8Bggyucd5nEnjxgS9vpfRETX
         vgydZzIWOSkrPpd2vjdxz6GTzZGLtjWHtQkFKGdwmA8rNqbGp+8S8w0tCnKaE0HedsZB
         yUL93R376MN9C8JquRrvu79eJwaVzdDW/9i14/XF0HI3IYw9fpILP8dm42JNggh2NymD
         R9R3eaJXeU+STrYeWUowyw/Kvc8XlhW2edw1koD0Pn53Ir4+C/XWTUkCk9kb0LOFWpTU
         MUcg==
X-Gm-Message-State: AOJu0YyGAwkt5NvaYwdFOEr/nO32ee/NECna/VB6CH1OMN6Kww+0JCNG
        nhepxzSirXNjjuak9wTr6b2WPgh71Vv9DAZZyQ==
X-Google-Smtp-Source: AGHT+IH6SifBPntdJajOqDoIl0d+wzT81RxzJmUw5FruJ/HVH/OU8IAMaIS62QrQtsH5yMq0xGUrXRssB9QCNYiyng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dac4:0:b0:d11:6816:2d31 with SMTP
 id n187-20020a25dac4000000b00d1168162d31mr19901ybf.7.1694562186031; Tue, 12
 Sep 2023 16:43:06 -0700 (PDT)
Date:   Tue, 12 Sep 2023 23:43:05 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIj3AGUC/yWNywqDQAxFf0WybmAehcH+irhQEzULp0NSRBH/v
 UO7OXDgcO8Fxips8GouUN7F5J2r+EcD0zrkhVGoOgQXomt9QPtonsqJpLKzGtZKUcomfxANzzT GlOJMUEeK8izH76Dr7/sL24jtpnAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694562185; l=2602;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OIAMVV96NW5a8b/nTfJAZD/DTUfCZOJLgk+SCG3GQBk=; b=ckzKCq3t3UA3eFuuHAx+JY/jr5F0GucpbypzVAzaul87I5QvwxTn5nJ9flbz2PKRvdeLmF0Ch
 QziNcx/Hv5MCYxScI73E/uFcjMuLcWfYcNnqi2LEzSVTrSSoydInSaC
X-Mailer: b4 0.12.3
Message-ID: <20230912-strncpy-drivers-char-ipmi-ipmi-v1-1-cc43e0d1cae6@google.com>
Subject: [PATCH] ipmi: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

In this case, strncpy is being used specifically for its NUL-padding
behavior (and has been commented as such). We can use a more robust and
less ambiguous interface in `strscpy_pad` which makes the code more
readable and even eliminates the need for that comment.

Let's also use `strnlen` instead of `strlen()` with an upper-bounds
check as this is intrinsically a part of `strnlen`.

Also included in this patch is a simple 1:1 change of `strncpy` to
`strscpy` for ipmi_ssif.c. If NUL-padding is wanted here as well then we
should opt again for `strscpy_pad`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 11 +++--------
 drivers/char/ipmi/ipmi_ssif.c       |  2 +-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 186f1fee7534..04f7622cb703 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -5377,20 +5377,15 @@ static void send_panic_events(struct ipmi_smi *intf, char *str)
 
 	j = 0;
 	while (*p) {
-		int size = strlen(p);
+		int size = strnlen(p, 11);
 
-		if (size > 11)
-			size = 11;
 		data[0] = 0;
 		data[1] = 0;
 		data[2] = 0xf0; /* OEM event without timestamp. */
 		data[3] = intf->addrinfo[0].address;
 		data[4] = j++; /* sequence # */
-		/*
-		 * Always give 11 bytes, so strncpy will fill
-		 * it with zeroes for me.
-		 */
-		strncpy(data+5, p, 11);
+
+		strscpy_pad(data+5, p, 11);
 		p += size;
 
 		ipmi_panic_request_and_wait(intf, &addr, &msg);
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 3b921c78ba08..edcb83765dce 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1940,7 +1940,7 @@ static int new_ssif_client(int addr, char *adapter_name,
 		}
 	}
 
-	strncpy(addr_info->binfo.type, DEVICE_NAME,
+	strscpy(addr_info->binfo.type, DEVICE_NAME,
 		sizeof(addr_info->binfo.type));
 	addr_info->binfo.addr = addr;
 	addr_info->binfo.platform_data = addr_info;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230912-strncpy-drivers-char-ipmi-ipmi-dda47b3773fd

Best regards,
--
Justin Stitt <justinstitt@google.com>

