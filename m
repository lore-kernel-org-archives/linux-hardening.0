Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23596430F4
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlAZQVX9"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CE0ED
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 14:40:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81a80097fso76312787b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697578825; x=1698183625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8h1aCmYwBL0e7W6QWqk+xWgvSrCWZqDeOTvw03oLfSg=;
        b=qlAZQVX9to8AsnGtSK9dGDNbukyPI9T4vbd0dj6nd9YHFLQnNLVaotL36E1CD3uwna
         snyna3DclkcApbbo4tkLOBNI1G5Lt26Bl9j8/ziNT7dxqIrtxMSfeqIaKD9VxsJou2mk
         pEfrpcEbXyVCSfmc6cA78W+Fwq4DyCxzr+r05f0gLrmnUtOZqlRpQ7cB8P+i3DGc+Hze
         VLIq4TZlUCrPDgpp/X9SEKTxAKKU49fzxEJDEbQYDB29EOazGR+u518qD2cACX12vAnt
         1/r8gJ+F9O23/c+B7lLCbYmDQ7UlqaEcWDjbg9loRkoG3wsyM7vHlgvIussJIoMpokmN
         xkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578825; x=1698183625;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h1aCmYwBL0e7W6QWqk+xWgvSrCWZqDeOTvw03oLfSg=;
        b=MmEaRS5om1gfbHNJpQoP3PWD5JWaPs9DBHT/iReLXyJCizTuI8OqDWVnJJ1Zdw9bkK
         OWbZ1CI6g2ZdSJrEphmxwIcVtJVMsbevUqku817zHNUXzkLNkMHBIXu6dhrosWKxnghx
         jL4aeo2OFGe7dADrYf1SVwMsSGnNnosHG+2EXKxAbEIPoT7N3HrADtH9IES7o8tgkrFI
         CMnoUzL9f+0QepnEcfzRz+zeKGvAC87S69Y0SlCfv6TxKYXgPIbTDwVYsVQm2+e5t5Oh
         1wD/1jLAUJLZ1UMmYdv3vzw1yoOG047673cx6Pc+l3VHOiy6JtHTDf2mBHQUVyMpR9k3
         qNLA==
X-Gm-Message-State: AOJu0Yxjr9EzyLjG83VSg3s6h1ZCNvRbhdiZRIQzyRALx9la3pLqjHCD
	4tVS/f3ewClydZW5AT0d4UI4Gp0jh5F94QwOyQ==
X-Google-Smtp-Source: AGHT+IFD9/z9qICdr6kZphkx91CVVnKWaOa56BAR7Tmf8Lf9ihklTplMdVnhLZQLfrXyng5/4mRo2/jNV92nK6R8IA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c711:0:b0:d9a:519f:d0e6 with SMTP
 id w17-20020a25c711000000b00d9a519fd0e6mr68734ybe.6.1697578825351; Tue, 17
 Oct 2023 14:40:25 -0700 (PDT)
Date: Tue, 17 Oct 2023 21:40:24 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEj/LmUC/x2NwQqDMBAFf0X23IUkBRv6K6WHEp92QdKwG9Qi/
 rvB0zCXmZ0MKjB6djspFjH55Sb+1lH6fvIElqE5BRfu3vkHW9Wcyp8HlQVqnFF5FcUMM5ZcMbO UNWzOXQyNifsxxtgKAa6nli6KUbZr+3ofxwlgwuPYhgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697578824; l=3644;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=no/u8aepbF9xy/WjzFODZYqsJCgSR5M+hrKqDii17yY=; b=VjQaKS/y3uXgNEupzuOEFzu8WiM+Y7gt+1HvljUvV/p0HQ5TM4zVxf5vE5G7bp9kMvXLTjTQL
 mGnDQVQcQkcDeItbzifkeXs+wU3QaL+vkhF/Sb0gikb0eDMT2gXGCgi
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-v1-1-ee7d3e258d78@google.com>
Subject: [PATCH] ipw2x00: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`extra` is intended to be NUL-terminated which is evident by the manual
assignment of a NUL-byte as well as its immediate usage with strlen().

Moreover, many of these getters and setters are NUL-padding buffers with
memset():
2439  |	memset(&tx_power, 0, sizeof(tx_power));
9998  | memset(sys_config, 0, sizeof(struct ipw_sys_config));
10084 | memset(tfd, 0, sizeof(*tfd));
10261 | memset(&dummystats, 0, sizeof(dummystats));
... let's maintain this behavior and NUL-pad our destination buffer.

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

To be clear, there is no bug in the current implementation as
MAX_WX_STRING is much larger than the size of the string literals being
copied from. Also, strncpy() does NUL-pad the destination buffer and
using strscpy_pad() simply matches that behavior. All in all, there
should be no functional change but we are one step closer to eliminating
usage of strncpy().

Do note that we cannot use the more idiomatic strscpy invocation of
(dest, src, sizeof(dest)) as the destination buffer cannot have its size
determined at compile time. So, let's stick with (dest, src, LEN).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 820100cac491..44f2d91ad30f 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -9656,31 +9656,30 @@ static int ipw_wx_get_wireless_mode(struct net_device *dev,
 	mutex_lock(&priv->mutex);
 	switch (priv->ieee->mode) {
 	case IEEE_A:
-		strncpy(extra, "802.11a (1)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11a (1)", MAX_WX_STRING);
 		break;
 	case IEEE_B:
-		strncpy(extra, "802.11b (2)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11b (2)", MAX_WX_STRING);
 		break;
 	case IEEE_A | IEEE_B:
-		strncpy(extra, "802.11ab (3)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11ab (3)", MAX_WX_STRING);
 		break;
 	case IEEE_G:
-		strncpy(extra, "802.11g (4)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11g (4)", MAX_WX_STRING);
 		break;
 	case IEEE_A | IEEE_G:
-		strncpy(extra, "802.11ag (5)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11ag (5)", MAX_WX_STRING);
 		break;
 	case IEEE_B | IEEE_G:
-		strncpy(extra, "802.11bg (6)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11bg (6)", MAX_WX_STRING);
 		break;
 	case IEEE_A | IEEE_B | IEEE_G:
-		strncpy(extra, "802.11abg (7)", MAX_WX_STRING);
+		strscpy_pad(extra, "802.11abg (7)", MAX_WX_STRING);
 		break;
 	default:
-		strncpy(extra, "unknown", MAX_WX_STRING);
+		strscpy_pad(extra, "unknown", MAX_WX_STRING);
 		break;
 	}
-	extra[MAX_WX_STRING - 1] = '\0';
 
 	IPW_DEBUG_WX("PRIV GET MODE: %s\n", extra);
 

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-6f8880232e06

Best regards,
--
Justin Stitt <justinstitt@google.com>

