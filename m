Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC52AB21
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtNmozBk"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344859E
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 14:38:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b3ae01c0so25401887b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696973892; x=1697578692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AiBpkK7PnwbW3pJPRm6EBFhkiBzsIwhV9EtUrWIfgS4=;
        b=DtNmozBkOsm7OX5xzmjh1tafekkXDFCbGIK2u5/EeHduPRgeCArZZ2LkQbLsQ9uZGX
         Vj528ChxpEsn9a5xN/koZ3siE/4eP1h/YGsmVKL/KW/thyF/4Cws5VHojZjYWN8zaivv
         5LW8zVhNNGosyIcVlofW5dZobLgAk0b5LbVjUNY7kxiTala8N8fTo0mqUa8sz4ObjsPm
         9hxquRuOCqLlooqGw2kkWv1uynXOY8B405X1a/DHz6+mgOvkqzSwYdQJ7ifDSsr5A/mg
         U1eGD11fRwV17BsTKcJ1ZygqUF7SqGiTvJMsNvpKtcdFA/CKZ0nOgoauRAPy0jlvfObD
         QAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973892; x=1697578692;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiBpkK7PnwbW3pJPRm6EBFhkiBzsIwhV9EtUrWIfgS4=;
        b=rCN0Y151K/mHzTlOgIUTX0azWkzzoO4MA6XfbRPRjPVTSYQAggc2kgQHFGSt2MpdWt
         6HVyBsSScNM6cxrJ4e0l/pCVgDdBVbDr2qmfgU6/stE1kvAnwTlGdvzbxGNXKKCJiZJK
         PYMdGztJeIVItO6I4v8Ok2d4mfl7o0YuI60Uexj8pA7GS7J93DhH15oabOxV/oFB0T0D
         UTbKPyKNh7Afa/mUGkRjdBAVsVK7yLgLJA2ukHFy6d40qitKOx36FVxVcYpvb73P7dbY
         XFJP1F6ztCHMjyqUugYIngsFEfNxPFQ45vp7a5NWy7hTxX+hlZlFOrWfEkPHjI66QRCy
         FhZA==
X-Gm-Message-State: AOJu0YxzzMDSu5DW4lBL6a3bGPfubEtrEAUoK9nMbLWeldGXfnN/JhLf
	a8OxMZDAoN8bC9VKw/WkcOKak0SIgCRv9U9XAQ==
X-Google-Smtp-Source: AGHT+IFiWN7nhRH2j4mzDFkyri+VCQWqooHQZ0+SGEtnQyDUntX/F+ap6WsSMH4gK8BxZzDa12Tv2Q1nPRrVLMRcMg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:cf48:0:b0:d9a:3ebc:3220 with SMTP
 id f69-20020a25cf48000000b00d9a3ebc3220mr95879ybg.11.1696973892424; Tue, 10
 Oct 2023 14:38:12 -0700 (PDT)
Date: Tue, 10 Oct 2023 21:38:11 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAELEJWUC/x2NQQqDMBAAvyJ77kKStpH2K8VDWFddsFE2IaSIf
 2/a28xl5oDEKpzg2R2gXCTJFpvYSwe0hDgzytgcnHFXa6zBlDXS/sFRpbAmjJyR88L6g3fQwuu KG2XeYq4Ow4Q0VyS8u4fpe3/z5AO0+q48Sf2fX8N5fgG/plnyiQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696973891; l=2675;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=mae57B0djhFJNrzFky8Becq7+FXywk04Jns/uil8UeA=; b=jNc8NNosyTW++aGMiQLw1TlhgiCQQ4PVYKSSV9Zxj+sLTRhcEAcjWaPQCJN6h9oMeBKALcem8
 P8iIDtf81JxAegYOlM/un6EwNfpI0TDx6jUbBsKJnTKZyNbj4838oiO
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
Subject: [PATCH] octeontx2-af: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We can see that linfo->lmac_type is expected to be NUL-terminated based
on the `... - 1`'s present in the current code. Presumably making room
for a NUL-byte at the end of the buffer.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also prefer the more idiomatic strscpy usage of (dest, src,
sizeof(dest)) rather than (dest, src, SOME_LEN).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index e06f77ad6106..6c70c8498690 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1218,8 +1218,6 @@ static inline void link_status_user_format(u64 lstat,
 					   struct cgx_link_user_info *linfo,
 					   struct cgx *cgx, u8 lmac_id)
 {
-	const char *lmac_string;
-
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
 	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
@@ -1230,12 +1228,12 @@ static inline void link_status_user_format(u64 lstat,
 	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
 		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
 			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
-		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
+		strscpy(linfo->lmac_type, "Unknown", sizeof(linfo->lmac_type));
 		return;
 	}
 
-	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
-	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
+	strscpy(linfo->lmac_type, cgx_lmactype_string[linfo->lmac_type_id],
+		sizeof(linfo->lmac_type));
 }
 
 /* Hardware event handlers */

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-529077646c6a

Best regards,
--
Justin Stitt <justinstitt@google.com>

