Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ECBECAAD3
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Sep 2022 12:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiINMAZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiINMAB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Sep 2022 08:00:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812922CDEE
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 04:59:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n23-20020a17090a091700b00202a51cc78bso12459641pjn.2
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Y6s7NE2L0D+TeexOIWPbL9vKDjRfpSqj54lhPgRGOAA=;
        b=oWqpCruVR1MxdYpIebHjiun0qVTgcHKvDlmNzWWS+1oc2tHlCd1aZnCG+MVqrD2+k+
         bYsWTqJWQHnRSaorc/cymPXpuJmkqkHI8rNfGzMPVy9FHUEUCSPNGpwtP3NZ1REUw7tH
         UJJBuZCrgo5GsJv/V3XTYtfUHBuL3NM6DGTpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Y6s7NE2L0D+TeexOIWPbL9vKDjRfpSqj54lhPgRGOAA=;
        b=R6hK6e7znY6csY926Jhv86PmoMpsonTg0C5sLDc8whYNEz06H0NbN+wKCiyfTAGpKu
         D9IW3OXurbRqDCYSkegyBtKx+r7Pv3cNYmeh6esIkACvqCqpex2YaqN92HAT5fEL2DDQ
         uJuydo4/N1GmVawhNJgTnvVcgRzNQieZsvzodDDw3bH8VV+yQwnPf9p6cGfucInxaL0C
         JycB0xCjvJSbx/Wb4aAnKNdGaRk9QMNJ3kasQBIiAG17/VzE3igLiFy47lqRK5TsJrkE
         APYfahEIyCq7ZARe4RanDFDwcVAmlwyV3xj0q+WGFfwpeZNcpJDZgMQd1GTBt99vuCRW
         +oSw==
X-Gm-Message-State: ACgBeo0mYfEfEfd7vU4cH66mLtaLkuTDRbNyTRZC51RKCdonZA8d5o+9
        OlDf3UsfkzF9qvR/1p/smEtTHw==
X-Google-Smtp-Source: AA6agR51qC/3Mw3pxBy7uVb+w1THEnZyfb3ejZeBbnmyMXm5XocV75MVAnkIA+VdzzjwnzQvEw/JCw==
X-Received: by 2002:a17:902:aa8c:b0:178:9b2:d0c7 with SMTP id d12-20020a170902aa8c00b0017809b2d0c7mr24115956plr.23.1663156797937;
        Wed, 14 Sep 2022 04:59:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik21-20020a170902ab1500b00172d0c7edf4sm10494607plb.106.2022.09.14.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:59:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hannes Reinecke <hare@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Malcolm <dmalcolm@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: aic79xx: Use __ro_after_init explicitly
Date:   Wed, 14 Sep 2022 04:59:53 -0700
Message-Id: <20220914115953.3854029-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; h=from:subject; bh=5w/wmdKWZU/pSg2LpMWVH1zxUWjxAexvoeiA3VOoiak=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjIcI4PgRgiVGlSskmNczjF2jITudgAGSbSl/C6KuX pvUNmICJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyHCOAAKCRCJcvTf3G3AJiGAEA CCRcitpoKLPKaOtyjMOu7c4bKHZWHD0/LZbYOez5QZ15ApFNOOWAYjRqf0N1vltKAkRzAP+rlHoa6Y LZQ/i2exEqQX/2wZ6ax5x+iki1o9++DI2GjyM1BZT64YCJOazt0w1vRTKuJsVLW0rTI6q260dZhZZR XDsQ3OL2cPMOIoE6FV/WiW004TKnyiOZuytMXfELoBg3DVJWZJMP4lA5n7JBrQKVGU4fdTECWvQc4u Q3LjFFynKd6SYL85eM9VhhmgL4CuF8ORr6uS+fUY7UG/ce8ccKxXEdVfXSBWQjv9RCFIIaQ4iKOkBk RbxuytNaGb0encH18LZvc2zcTt/Q2ZCZv4SXdk603R1/f2JJ5tybg7VirfpFhOv4P/DcaYF+CH21dF f8BVq0OgOUzYlMhU2Kj0z/eCAl8PP2dXiFum0hckLO1FIi5SUt3YSUA02XK62PGO6WEDkCpjc+L02K LKS+uv05gLNd0IcnDGwsvxN3ca1IFWRirDfFa7+hi5TkmB98o9GVkeeT5ikVot+yHeieK73/cMWflp c5IAxbOQuk2KANmsv1yEYvg9POhSfAuerj1Af8MdSGC2h4HdLaeV0DiwaiLOD+v97xYMG778yHHOUP GaSj9GQkPEOJrYXKcbAWm2gGYKDtFaykPJmPahlMKd6WOVvTsMEvfpOEyZbg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

ahd_linux_setup_iocell_info() intentionally writes to the const-marked
aic79xx_iocell_info array, but is called during __init, so the location
is actually writable at this point on most architectures. Annotate this
explicitly with __ro_after_init to avoid static analysis confusion.

Reported-by: David Malcolm <dmalcolm@redhat.com>
Link: https://lpc.events/event/16/contributions/1175/attachments/1109/2128/2022-LPC-analyzer-talk.pdf
Cc: Hannes Reinecke <hare@suse.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 928099163f0f..f2f3405cdec5 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -194,7 +194,7 @@ struct ahd_linux_iocell_opts
 #define AIC79XX_PRECOMP_INDEX	0
 #define AIC79XX_SLEWRATE_INDEX	1
 #define AIC79XX_AMPLITUDE_INDEX	2
-static const struct ahd_linux_iocell_opts aic79xx_iocell_info[] =
+static struct ahd_linux_iocell_opts aic79xx_iocell_info[] __ro_after_init =
 {
 	AIC79XX_DEFAULT_IOOPTS,
 	AIC79XX_DEFAULT_IOOPTS,
-- 
2.34.1

