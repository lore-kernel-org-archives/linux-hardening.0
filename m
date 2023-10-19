Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0BA374D9
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHWdbIg0"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7E12D
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 10:29:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a581346c4so11182782276.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697736546; x=1698341346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2dM38oFA9Pe/oU12qt1pqIA50gOKDfSgpU7CFprv1yc=;
        b=cHWdbIg0jyNGVyVEhDpxNzd/63un5tiuklbwUfrz2KzIOUWXh2jO82q85+9CcBe5U0
         sgydZEpiY/wZRkzrXt4xvcXdWMpEKw8u0elwoFUMYZWL0hi8wVFUUMj8gKm7liIsO7mF
         D1S4j+F6r3+5yOyyUovTPr9LIfRgrRt7Wt4m2xz5rHIBC7u8BLS0cJuzkED03NtbrKnH
         O+1rJhBdt0YFmnmJxFGBfwCjTuiIO5rz0cXvsmiJFfD3M1STA0DTgurSQ4VE7RmCGppe
         HANmIARbxkaNF6UpdavJkoWMS/4HnnQxpk5u24CC57NgyXhd2QylQOn6t3C1Y9mEclAD
         1gqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736546; x=1698341346;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dM38oFA9Pe/oU12qt1pqIA50gOKDfSgpU7CFprv1yc=;
        b=QCVdxjrFBqruTjUj7av8Y4ko/5ryhH0PVkUJZmsa0t27c9VvgKNwCwPmdzcpvQLLF7
         SgNFPfeN1RcpLUQrpAmEVkwetJQSNAGsE3rX7v8BPyApXxMpyMopzVGb0wN6ZfMrFZaW
         xtGFvoLwLc9i8uxkr38FV890LnBrf8l5rLn8sCPrFP2mvqt/ocS1ydNnrEpBz+SEP/o8
         oBZFaIXTso8FTwP6OkWbTctrRhiIxz5sYhkom1eRmEhaM45fv1okaPfBc6wTfn5ouy2/
         iOSdJNOYD9WXr881GCaYZwWfyXu3zyo9mqhrWqTaLIUNIbDi9x10mQ1/QQoniJ3vBng+
         gW3w==
X-Gm-Message-State: AOJu0Ywit6/jcw2n5bo+VC0nz6v92oFAjneHU54/wMW/hUr/uY8fxnss
	otBRsdXN/EV1jfuJLsI+4rmBgCO5J3HfqzMiqg==
X-Google-Smtp-Source: AGHT+IHny44lFcXUUZdQ9whIolzk/nLUcQB/99Ej3mtZ8rGAwmCLBlfTDxB6r6w+HnKOSx9S/ZCVp8RA1WGHhw/9Kw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:584:0:b0:c78:c530:6345 with SMTP
 id l4-20020a5b0584000000b00c78c5306345mr62074ybp.7.1697736546059; Thu, 19 Oct
 2023 10:29:06 -0700 (PDT)
Date: Thu, 19 Oct 2023 17:29:01 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFxnMWUC/52NQQ6CMBBFr0K6dkxbVNSV9zAsmmGAJtCSGVIlh
 LtbiSdw85P3F++tSog9iboXq2JKXnwMGeyhUNi70BH4JrOy2pZGmwvIzAGnBRr2iVgg0AwvzzS
 QCLh5pOG3CBW629lgW2HrVBZOTK1/77Fnnbn3Mkde9nYy3/evTDJgQJfXRlNV4knbRxdjN9AR4 6jqbds+HuzT1uUAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697736545; l=2387;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=XowZOHRhqMCWq2fZ6yqvbWeRdNj7KFUM/jYuUGt1iRs=; b=I3H8ns0MlDbP5d8HN0mCYlz9v6sQJLyJQnj1UZVv0uRXoG+50xHyRKxV+C0qMYGOmECPx9Ey5
 8hoyNmvhpxYC4k6QRDMvh7xD/gPJGHhPeCc3sOaKgXZJlWxe7qv5Yt4
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-net-wireless-atmel-atmel-c-v2-1-52e46fbea083@google.com>
Subject: [PATCH v2] atmel: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect priv->firmware_id to be NUL-terminated based on its usage
with seq_printf() and strlen() in atmel.c:
1420 |       seq_printf(m, "%s loaded by host\n", priv->firmware_id);
...
3884 |       if (strlen(priv->firmware_id) == 0) {

NUL-padding is not required, which is evident by the usage of a plain
strcpy():
3891 |   strcpy(priv->firmware_id, "atmel_at76c502.bin");

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also replace hard-coded lengths to be `sizeof(...)` for buffers
that the compiler can detect the size for as this is less error prone.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [2]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- leave strcpy() usage as is (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wireless-atmel-atmel-c-v1-1-038d0e73c402@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/atmel/atmel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index 7c2d1c588156..99920430e8b4 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -2651,8 +2651,7 @@ static int atmel_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 
 		priv->firmware = new_firmware;
 		priv->firmware_length = com.len;
-		strncpy(priv->firmware_id, com.id, 31);
-		priv->firmware_id[31] = '\0';
+		strscpy(priv->firmware_id, com.id, sizeof(priv->firmware_id));
 		break;
 
 	case ATMELRD:

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231016-strncpy-drivers-net-wireless-atmel-atmel-c-7ca951cf7cfa

Best regards,
--
Justin Stitt <justinstitt@google.com>

