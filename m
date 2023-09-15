Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E636CD37A7
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbjIOUEZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjIOUDw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:03:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F599211E
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:03:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf57366ccdso26330305ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808227; x=1695413027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=585ELGKH6mcU0nuyAJeZCpFUeKhNPgDgSqqVI53K3fs=;
        b=H/toPEu6GpGPDI/SfYB5S5T6q6DbHy789mftoN2S2PbUP3xd6W8InOwXbirIVwkF6G
         yCfw8xBQ7fnSb7cof0cLEL+N0EbIjlzlUsN9qAugrhwufHTp8kcdiWKqrM37Jx+ZoXPE
         Vhd4W6fOZd8Hkv3Wr477UVv7501cKTX9XwkjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808227; x=1695413027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=585ELGKH6mcU0nuyAJeZCpFUeKhNPgDgSqqVI53K3fs=;
        b=FnYZviXaDEb/yCQnABMZxUqRUEP0WxQNwmHtVui4v1arOp9xI4Rid0F2dGYg+BTYzQ
         9XLy1kn9Lrzw1K3fAdxU7jT7jUQPObLb6v+AoI1VZ/weP3pTex3VdzhYno7pJLaZX+G5
         vaVlsyDrgQLLSDHAuLyq2nvoN5blr8DTK2zd+RI9oYGS3tp+DBbdkFm1gDKXYJVViAkC
         5GAq34woFN2Gq423DD3DJjKgNNxFgUUWS/9XOOcxGmsw7taAz2zDZBnlSwTD6QlWJkK9
         PBNGRsQaGG7QeNrrWZrcsATgDn12xZMXDQreAIhhTiUKzzFwEYzKOz0vrQa2sk3FBuE8
         5meA==
X-Gm-Message-State: AOJu0YyGnKol/Ja2qEVQAqi+EKEekCL49iSzUsYS3FXaiC5tbOgPdtDZ
        tjHNZ34D+y15rZzaY2F6TcK81A==
X-Google-Smtp-Source: AGHT+IGxirG4c1+wNpjD+C0ivacitJE7me+i97dg7mLg1+2Am2AXQTOZsLaZMKFyejKoHm2lSiLWUg==
X-Received: by 2002:a17:903:2311:b0:1c3:81b7:2385 with SMTP id d17-20020a170903231100b001c381b72385mr4018353plh.11.1694808227690;
        Fri, 15 Sep 2023 13:03:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001bf044dc1a6sm3488624plb.39.2023.09.15.13.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:03:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] dm crypt: Annotate struct crypt_config with __counted_by
Date:   Fri, 15 Sep 2023 13:03:45 -0700
Message-Id: <20230915200344.never.272-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=keescook@chromium.org;
 h=from:subject:message-id; bh=2J6fBiPdZIR8mGnEk0bNvAHhXLvKbIZhyM289hn91M0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLihfwsK6T3HOV1j4wnd25zaVLF5WQpYGwyS+
 5kE88zkP0eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS4oQAKCRCJcvTf3G3A
 JtSpD/9zzSwBgu0DciTVR5Kuff9eIrmBXAQb1lB9CqCovFopZkSEQY5tNgaZ78xwjchx+SUL0+w
 U596UPQfpyHBDuBCDdrWmn59UUrEv7daZ8bnNYszDjqEEloDL9evqkm1heUI+1NZHp3hBGJMY1I
 EPN/1/SnJZemS9I2Ehsn50giqtGvagxkRx4RTYc43lLCi8lyzkQpyy4aWuunQZ9b/jooQ29YCRu
 0qTTTLUZM2YFI0C6XmnedeWXMaxGCHs/UC/+f2Pa/lnMg3D8cahgzy1Meee+78H4cJCjFKRM8e8
 WfB0QQeYwFx3HGHCcMgtArJ8KYAFzMHtm7MqCvqz8smhDz+Tt6gYqVOgFvC1LUHK9dwlsPEVjg1
 mGDPElivAoJ2+o2BHgDTbzDcWqqQLoENNm2VzQWQfKmprPY/mlLkzPP8x1RWz72qpmm0qWLp/ep
 1Gf+h0kU5Mxb/1lfNNO7kryPvP1ucJ42ibtEOAszDV/9sy4qkmCInNjCBni+HPeRYChSAwjwQV5
 Giq8/cHs+mSSMRPvoBCFcwfHVqQY+zPw8VuhEnjXYnAGtAHiW6nz91S5ysEHuXjmdIZbWNmHbLT
 h55IMoKtjCzJ3T/HKqcJCJ61XbHGSK92I6vRuEyJip7zWe6rUlExh+M8SUVR6nsQ5lM9wIdus/R
 Dbhko43 8ezYT+5g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct crypt_config.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f2662c21a6df..f276e9460feb 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -224,7 +224,7 @@ struct crypt_config {
 	struct mutex bio_alloc_lock;
 
 	u8 *authenc_key; /* space for keys in authenc() format (if used) */
-	u8 key[];
+	u8 key[] __counted_by(key_size);
 };
 
 #define MIN_IOS		64
-- 
2.34.1

