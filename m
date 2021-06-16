Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEDFC48BE6
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 20:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE013613BF
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 20:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhFPUV1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhFPUV0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Jun 2021 16:21:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2051C061760
        for <linux-hardening@vger.kernel.org>; Wed, 16 Jun 2021 13:19:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id n12so2928520pgs.13
        for <linux-hardening@vger.kernel.org>; Wed, 16 Jun 2021 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXkY4a/HV1Ph3YHecyaHK41JQ91qxWbjouVX/OSCcv4=;
        b=a5UJzUi9datRGqwYpJ+B3FoLxvpWE6SNPm76x8lTIJTiLV3aBggt4hsrsmqRHqMHud
         5WoT13zj5dALKy+CGeZ6fe+Cpq/mJ9zTLrT1BXZTuITpuBQQuv6QMxjc0Y3/T2Uey/0N
         37YFJnrLw/64me/2U7lu0xPRyg9/Bg2rcOl0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXkY4a/HV1Ph3YHecyaHK41JQ91qxWbjouVX/OSCcv4=;
        b=IZd7SDjW0lrzP1YbHKFM0trLdEh5ofldst1XVjxPUORTIXu6e3FbQHRoTDpd879CNY
         vbFik9j8XK1f9fWNs7B1n096KLM3naZISykn8PIj3NlnqQ12px99CHYoMuuSZ6IWfNJn
         d8Y3vBGRvkgOb8+JD5EX1y4q23DXcVuBFk7F2oGwXfWp5zrt2MBMLVH3gUipqu9g+2w3
         XS06C+ll7VeTFKe7Rv8ySOd8uEKRxSM8S09nBOd2OaczqhDW5qjiU0oohJ+OFgJsQt1O
         SSkBuv5YDbPekIKyix01QObMN9gJE8YLhXgvPv+rm+QgQ1QIeAGrmgx2UYM8wMFr4XEX
         cpsQ==
X-Gm-Message-State: AOAM531y3S07QScKPIv+soJbjVG+KD+PgLpZr4nnC3FS1nlYyAK1D5CN
        zXOcfY2yvGLhHAjssul3+LC3Ew==
X-Google-Smtp-Source: ABdhPJyKBFuUFqVJzznDGcYT9/ewX8mfp9nc5cDbjjipwb4v9+ehu86FCqXv7Cp+hEfkwjmTufaF4A==
X-Received: by 2002:a62:687:0:b029:2ef:be02:c346 with SMTP id 129-20020a6206870000b02902efbe02c346mr1663294pfg.51.1623874759428;
        Wed, 16 Jun 2021 13:19:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p11sm2932921pfo.126.2021.06.16.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:19:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] s390/dasd: Avoid field over-reading memcpy()
Date:   Wed, 16 Jun 2021 13:19:17 -0700
Message-Id: <20210616201917.1246079-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=697d003d261a1aaf310eb7be8caae5b4660abf75; i=pi4W3O7Zv5OHY+YtzmGH+XabNZro8cgInV3ToqYsbzI=; m=UBlIvRhoMeYKOaOfj8niG1h/dGh2iuo7r+hDT07Fh7U=; p=kTiZedB59XgADi9+zCtQn7wPW77AYR5F1bSjf1YFHwM=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKXMQACgkQiXL039xtwCZLkQ//cpl v5Ope74TfInOOBrZXBK6unkpg2OgHyb86iqJ/P1mGjy+8hNLqFnsJt0xobh614N2mkQD5HHrsybZU SEmjdk38lcqad7EH7CJLTe0Udjbl7vAgcNZxeeeBQCmeFlZi5bMIIFbn4e6Ta/Poty1L457PNMjJg C/XKUz0KfrfRi0KbyOyqLzzyBDsG2HGmBO4VtWpCd1hvOUPgA/zC5gu/ptv/EhxfUbfh3vXbfX8b2 ThPG1Cl3TZXMwoSLE82uQYspuybFEwMDdl5/bEYIBAIKsSsgN+Qn0V93jhy/ESRGFO5IRJuhKm/uQ B5ZSKhrMD8kFxOXdyFwHFUx+DU6OeUFF+09Z6hJqJGAzmqee0BYdj03ef2Xv8TaoITrUmMa7wtSGd n9qFvbBidYNrFRPCq1lTuh+nc8XSrZCLLcfhopVsSLq4WDrh8QsHcBHdgN1h87yhzoDBq6i2BbU3Q pRh5jisU9PuCCkRqEcZ8pAs5Xhy6/6oIrB+e2HV9SovsNNk7QlxAnuFZxUQ/9XlO3LYfUAnKIQlcK 3hPjuvbSxu8QtVNxEt+xCLiFVmU542M7Cj/hXFGikCLXcM/kBHmIzL9yFyPihoQmzQn8wVAGVEKam KuvC2g7ePtZEhg4cBp9ozecdiuOJsXZVxatN5qTwTaAaJy0HwgQ8Ci7RuKwzx30Q=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field array bounds checking for memcpy(), memmove(), and memset(),
avoid intentionally reading across neighboring array fields.

Add a wrapping structure to serve as the memcpy() source, so the compiler
can do appropriate bounds checking, avoiding this future warning:

In function '__fortify_memcpy',
    inlined from 'create_uid' at drivers/s390/block/dasd_eckd.c:749:2:
./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/s390/block/dasd_eckd.c | 2 +-
 drivers/s390/block/dasd_eckd.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index a6ac505cbdd7..0de1a463c509 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -746,7 +746,7 @@ static void create_uid(struct dasd_eckd_private *private)
 	memcpy(uid->vendor, private->ned->HDA_manufacturer,
 	       sizeof(uid->vendor) - 1);
 	EBCASC(uid->vendor, sizeof(uid->vendor) - 1);
-	memcpy(uid->serial, private->ned->HDA_location,
+	memcpy(uid->serial, &private->ned->serial,
 	       sizeof(uid->serial) - 1);
 	EBCASC(uid->serial, sizeof(uid->serial) - 1);
 	uid->ssid = private->gneq->subsystemID;
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 73651211789f..65e4630ad2ae 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -332,8 +332,10 @@ struct dasd_ned {
 	__u8 dev_type[6];
 	__u8 dev_model[3];
 	__u8 HDA_manufacturer[3];
-	__u8 HDA_location[2];
-	__u8 HDA_seqno[12];
+	struct {
+		__u8 HDA_location[2];
+		__u8 HDA_seqno[12];
+	} serial;
 	__u8 ID;
 	__u8 unit_addr;
 } __attribute__ ((packed));
-- 
2.25.1

