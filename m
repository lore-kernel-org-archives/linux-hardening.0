Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A1EE498B
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 17:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378003AbjHRRy1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 13:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379022AbjHRRyZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 13:54:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC53B3A99
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 10:54:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso8860375ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692381263; x=1692986063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgokGqPHO0YlcYJL+eizFkrm2SOg3pGMXQShFqwWIIk=;
        b=C+i6cLoAuCpUeWkiHluPrxJm503+BYR+kAF82fAHXfZXlci3rmX2SszO8dRCQz2+SD
         xcwVmYspIP1HJlh4sHlSmUSJlO8mIm0wdyVz9whSt90N1F1IC4DvE93eDs34XyITLObI
         gnuNutmoMoJSj/uARsbZIUFx0ROCUmLTuDUhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381263; x=1692986063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgokGqPHO0YlcYJL+eizFkrm2SOg3pGMXQShFqwWIIk=;
        b=b0GTp0Lk56vWoOgtLHufK2VBI8IioxFhvOxid5YhEYvvCmgbmlq6Si6xyAr9rY8A1E
         5V7tG1oAlDxngLRkKouLuyaNNIrYb4AoPwFpITyA7Jf2jAp0W1DyBoIFKSWCoSE+Wi0E
         u1Rc1lPKdpjIk2+sSOKdVrGupN0OyWHq82GnqV6AN9qTX76rQJMyZ6IxP6rBLLweY9sw
         2XlsiYf0Lyctxg96jcjduTrkVAWdUkDf8Hd9py/Zl7kyv506kfMN35Ya9EugJNH83IiU
         9MS7v89gFMJOeT7k7zXxhaJxtVyZGYhzJngFKdxwzjCiZtOnL7trRfk7IYzoFcTRr4bp
         3mtw==
X-Gm-Message-State: AOJu0YyYAzq6FY/JifkkLT83Xty5hC8y09EQlap3zFYUmRushGakAaLX
        4nUn8tpubtuVz3iPm9pXOioO9w==
X-Google-Smtp-Source: AGHT+IH/q+F1S/gkUp0u6TRVT8XSsZwsT26qFi4MEe+aOoh3Ei4MmwwZ8u99Ywrj8yPx5hpUt4+U5w==
X-Received: by 2002:a17:902:ea11:b0:1bc:3f9b:d96 with SMTP id s17-20020a170902ea1100b001bc3f9b0d96mr3307200plg.49.1692381263105;
        Fri, 18 Aug 2023 10:54:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001b89466a5f4sm2050080plw.105.2023.08.18.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:54:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Fiona Ebner <f.ebner@proxmox.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] tg3: Use slab_build_skb() when needed
Date:   Fri, 18 Aug 2023 10:54:21 -0700
Message-Id: <20230818175417.never.273-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=keescook@chromium.org;
 h=from:subject:message-id; bh=l0mmsLVGH+CrHvrZXQxRZRb/0ioszhM7CEHTjrpeYl0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk37BMmkdtnhTIWsR5ToZvLsbl/zm4J2IMNJinA
 ZffeIUNlr2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN+wTAAKCRCJcvTf3G3A
 JpE1EACicu9H1KwFfA69XLlwc9HkSfTfkXwHjghaPoVAvKEJWF2h2rRJvEa572+ONPIHFFT/YSB
 x+em9+AYhpXL5et5pIyHkXcoL5+3ohTaBIZT5bi1TV4sLge0Nh56nyidHgNffBDpvujhjHbjpV7
 1zXFEh8t0yi1cGvIUl9EH/ztXvXialrRvVWXoqpkJyH7bCrQdt+fZRBHaPQpeO0E1BkeFSfiTlZ
 xiXYeyQcbEllwrztLqto8snBZAP5nKWq6hUYfU2LIy3PZZcgWqyRVEOXfgHvLIlwhJVJGBv1G/X
 g8w4OH0MixMoT2Id7O+MrOAusM2pL4SPEn8IO+OnAMTtVaqqYEW2AEYWveoFSUnHOCtQBWyl+YT
 eXW9mkI0+Ao/remYhq2Ajq6w9xa0V+ofpcGIf6xH/GLLPaFt+mZgcdAKQ5T8QFlCRif1gush+Gi
 GRXmTtM9M38X7QypRLrCR7T+1V02S2GVUrj/3RFBz0k6G5j3H1SwyfivhW8+sxGYLZFc8mLhGSC
 CxKVvyqnaNoyHBoNWRrZPt7SIBaSrir41+Edsx/PI4c0QLlDMiimYZQwwWDYITBEtQ+2hM8znJd
 9QY9ZHyQwbfqNDLeeZmzZa4tAU+x55VKhSoiMgAVc2glhZoSzLBhV8P3EXRgTiYc7xeH/N+fK4m
 QcnOhyg 7Kk7cGZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The tg3 driver will use kmalloc() under some conditions. Check the
frag_size and use slab_build_skb() when frag_size is 0. Silences
the warning introduced by commit ce098da1497c ("skbuff: Introduce
slab_build_skb()"):

	Use slab_build_skb() instead
	...
	tg3_poll_work+0x638/0xf90 [tg3]

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Closes: https://lore.kernel.org/all/1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Prashant Sreedharan <prashant@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5ef073a79ce9..cb2810f175cc 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6881,7 +6881,10 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 
 			ri->data = NULL;
 
-			skb = build_skb(data, frag_size);
+			if (frag_size)
+				skb = build_skb(data, frag_size);
+			else
+				skb = slab_build_skb(data);
 			if (!skb) {
 				tg3_frag_free(frag_size != 0, data);
 				goto drop_it_no_recycle;
-- 
2.34.1

