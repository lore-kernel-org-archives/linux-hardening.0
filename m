Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB434C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 04:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF8061075
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 04:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhHREnb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 00:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbhHREna (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 00:43:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3347C0613CF
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 21:42:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y190so891919pfg.7
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n6kYv5qs2U5TDaRwVdsnZZRqO6Jb+ByXJ8zD1IUqO58=;
        b=gLNXqYFJBgXda8AczoZgx2Ab7vX25Hiq7x5mv5VD7ys5VUnd/eDPkl2myWiX7IbJa8
         XQ7spT+M7+Cty6i9haMBqVPbDoLsr518VyVZtB8u29NZwBYTa4+Q44I83og78TJL4SgL
         c6ZcBo8Q52xDbF6xBv2Lr1pio1M7Qu0bi/y+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n6kYv5qs2U5TDaRwVdsnZZRqO6Jb+ByXJ8zD1IUqO58=;
        b=E/2349qC2SatsyBSuEig/sRlJORTqVMFTV+cGOkKefWDK/PA2onkUUOpQ8XHyLczRt
         jyYywSNh0w/xg6s3/RP2r2uIOPFBhElBn1aIOP/whaMNxSpLY3NhY0YekodoLLwJWhqr
         swPqFYybIrTPvixnA6xxWpLr9oS7D3hCSSkpjFOdikKqufq/FOmBHGIzixPzF4R1b7YP
         BpM21/53b7oGYv+9V2pUsljf728radIPmGS5JsXp7j1n4Yz2uc6cUzfR7As8rDQrrtg+
         kPRSVdz6ZPGXQpqT0ciI1A+j4RA2HwS/gp6V+nZ7P+LY2LfImM6iCrXaAqcEUA2skhaA
         SWQg==
X-Gm-Message-State: AOAM533kHs3bEQtNNqPGuOoU9O+oX+La2dki3CVpsp9gvFo5uyYYHGBh
        4heXKdJDmQ/SV+nkJw0wcgtWMOi7lKDUCg==
X-Google-Smtp-Source: ABdhPJw2jYB9l0R7WFUhPJs3ENXjO+knhTs7u8+lFuGMKnsHlUZLfTf8F0CDoClzOrtMlJV9L//UDw==
X-Received: by 2002:a05:6a00:704:b029:39e:3043:ec64 with SMTP id 4-20020a056a000704b029039e3043ec64mr7198884pfl.68.1629261776383;
        Tue, 17 Aug 2021 21:42:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j68sm5109996pgc.44.2021.08.17.21.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:42:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] staging: rts5208: Fix get_ms_information() heap buffer size
Date:   Tue, 17 Aug 2021 21:42:52 -0700
Message-Id: <20210818044252.1533634-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2921; h=from:subject; bh=OPgWxfVbe6Ch3Gi360oeNmrGi1QocR4XlQyE7Vi1MFM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHI/LOnJmhqY91I+JO2LnJu8KltlU2ODOIHVqS4wU Oda8pwiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyPywAKCRCJcvTf3G3AJsxZD/ 4hbkFgS0HxFPsqLAP88lHEhEfKxOBwgDOo4YDSl2nrPzQpBOdvxPcA20FWPRoWUgZ5OanUZq7D/yGz AOXpB9YL508ueXW7GVYH//kd/2uM/gqNNOFeIRzHix5E0gtm+SkP92DpND8pSQfyQJgXjODLhsR9dC FaTNiALDs8vqsgwMS8eX2j8XtmKrGgZONuaHcmYlp4M6xwWbl9rOF/245Rddbc+4aHZGJv014xEv4E QaaaMI57tTuZwkn2bMW8Zdi8GmEyAPkheQpyW9G82xGaeIBi1ycmMLEQWTjxNilESoUKhSEiiqrunj ARVe3YFiMGd62ij25juUqW08Jpl3Nx0665isfyaXki7zkVzkE+8jg5H1spe0H2zConY/86feh5La1X gARw8gjDz6CmNxn9Cbtk4W6cFSwZT4D+6Ay4bTnbp4SkI1C90Ugk861AfBUi8uP/xziWL1RwV/y15v 9tyPee3+33v5pbHPmPbqT2TM0pdKGTQg8scwRxhaHpDQb9HOFM1w4V62zry7RPpubc5eKVZeQhK92K uMlk/VIp1i2/B05+u0uwomOBfgm+TbunYbtoVwwuQSn9gln8drnrSzkbrVv9QEL9m7TzocziFa6sC+ 2DY9ohayN2DVCHMeygsKncwtknrYJKI+BZDN4mdLTnxZiD1Uoqa3WcyWSyNw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fix buf allocation size (it needs to be 2 bytes larger). Found when
__alloc_size() annotations were added to kmalloc() interfaces.

In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:10,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:17,
                 from ./arch/x86/include/asm/irqflags.h:63,
                 from ./include/linux/irqflags.h:16,
                 from ./include/linux/rcupdate.h:26,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from ./include/linux/blkdev.h:5,
                 from drivers/staging/rts5208/rtsx_scsi.c:12:
In function 'get_ms_information',
    inlined from 'ms_sp_cmnd' at drivers/staging/rts5208/rtsx_scsi.c:2877:12,
    inlined from 'rtsx_scsi_handler' at drivers/staging/rts5208/rtsx_scsi.c:3247:12:
./include/linux/fortify-string.h:54:29: warning: '__builtin_memcpy' forming offset [106, 107] is out
 of the bounds [0, 106] [-Warray-bounds]
   54 | #define __underlying_memcpy __builtin_memcpy
      |                             ^
./include/linux/fortify-string.h:417:2: note: in expansion of macro '__underlying_memcpy'
  417 |  __underlying_##op(p, q, __fortify_size);   \
      |  ^~~~~~~~~~~~~
./include/linux/fortify-string.h:463:26: note: in expansion of macro '__fortify_memcpy_chk'
  463 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/staging/rts5208/rtsx_scsi.c:2851:3: note: in expansion of macro 'memcpy'
 2851 |   memcpy(buf + i, ms_card->raw_sys_info, 96);
      |   ^~~~~~

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/rts5208/rtsx_scsi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
index 1deb74112ad4..11d9d9155eef 100644
--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -2802,10 +2802,10 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	if (dev_info_id == 0x15) {
-		buf_len = 0x3A;
+		buf_len = 0x3C;
 		data_len = 0x3A;
 	} else {
-		buf_len = 0x6A;
+		buf_len = 0x6C;
 		data_len = 0x6A;
 	}
 
@@ -2855,11 +2855,7 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	rtsx_stor_set_xfer_buf(buf, buf_len, srb);
-
-	if (dev_info_id == 0x15)
-		scsi_set_resid(srb, scsi_bufflen(srb) - 0x3C);
-	else
-		scsi_set_resid(srb, scsi_bufflen(srb) - 0x6C);
+	scsi_set_resid(srb, scsi_bufflen(srb) - buf_len);
 
 	kfree(buf);
 	return STATUS_SUCCESS;
-- 
2.30.2

