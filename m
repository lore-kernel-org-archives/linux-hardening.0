Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FAFC4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 03:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiKRDnB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiKRDnA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 22:43:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC65EF89
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 19:42:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so1550661pji.4
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 19:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOVj/vcA43GEmLzOxkf/CHOVgdiQSuspf1pwsCrY4DI=;
        b=N9jcBtuWkS8x6QuPDI6a/CaFzzlJ3Ass1QGsZ4K1wyf53R8TxQNZykeyan0RhuLHNC
         ScLsHL5MuylEzgS8BIivm2uCy6J9erKFz48w567dPx0zXVI89dtKi4uDaTRSrBS8sx85
         WEEyPtE2IM62HuRC+LlnYtfWNYSHLRjn5eE+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOVj/vcA43GEmLzOxkf/CHOVgdiQSuspf1pwsCrY4DI=;
        b=wLr8h+GVh76JA5aUy8q2OYo424FogIIms5HeovdThIAGZozMCXS7ItgSiqC+RvHTwm
         0YmzfP7bpTXYvBQBP2i6JHmqQDErlW2hckRrqug+Sih358+4buCB5r5uLeMBegafoCs9
         qh/eeoMBsW0E1J3KyUV/5OxjSLi9UUqTl+/H3jQ71kMloepTVtpWtoGDy70nfcyiQP+V
         0x1Yu2yjLsegzxBNNazJ/FmaxBE5rqGBDEK2tlv+q9sqTIIHXPMMHgutUqaOpdJ5PqCK
         GPqsNArereVkUH0blMpH1m+bzUYhNzRhfQVqXY910y8yWLYYDPgRwMSOVE0M+6a0GEkq
         PX7w==
X-Gm-Message-State: ANoB5pny24AaMRGWIlo16amzTTWTja8zhySUzX4VeNT5IoReskZ5KS28
        MfZMKlDP9l8unt1Znd5z7WpxKQ==
X-Google-Smtp-Source: AA0mqf7oPtZISN4+9QfW8E/l3HubTOkufxUVDeuTtst0mgG92D/JFZGMTleYkAibN6J9x0yzxsBhuQ==
X-Received: by 2002:a17:90a:ad4c:b0:212:d3ec:632f with SMTP id w12-20020a17090aad4c00b00212d3ec632fmr5904213pjv.43.1668742978266;
        Thu, 17 Nov 2022 19:42:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm1775011pgr.10.2022.11.17.19.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:42:57 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Clemens Ladisch <clemens@ladisch.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] hpet: Replace one-element array with flexible-array member
Date:   Thu, 17 Nov 2022 19:42:55 -0800
Message-Id: <20221118034250.never.999-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; h=from:subject:message-id; bh=3hBZWlpQeB25CbJOuKYMyAJRSVDo5TGnXwmNCkPCrPo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdv8+VYED8zZ28eD8b2rN1FwHB0FxGowuj+UwvoB6 n/LrI5iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3b/PgAKCRCJcvTf3G3AJt3hD/ 4w6jgJDMghcOe7eJGjGCHM5me8MjMOqWObyVYbnIZDNGnuVP4C3zmjH1viyf5AeQNj/6XPk8Z7WS3C uYnosPtQ+NjM3YQneG/RJbw4IHJQHcBrrHipz7nLIgTzfTROJAHfD4ZrMq0vVbQ4vTDajO5GBpt4uN ZZB0ZvcRJ8nI9YGi+/e511k2YcbT3jJIu8xXsk/LfJm43X7K25RaMAMWJBiubUf2NbwYJVUEJZGgYi WZM2txmwf3DR+3TOoFdkz06x3wohOsO4vNre7i9ub0qiP+NTqLVq2MJ70Kswi8CM/5UMZaJTsjRAJe rPQAjmCXXtKvJnVy/3tk4VeWBTELTWzQi44Pq5S9taVc18zUIYHLy9V5L9y+N1Ltb/6RAFo4XTD2D4 RFYCfMtQ81rHI7DEIlFDakI++2PK19oojPk9YAqoOJl1I4tZFtp6Fswel4p/kfVtSkIqBg4G9Bw9hs 69ECP1wY9AZWVcmAk39wxeWL25d8HVl43l6cta6rzRFRmwb0YO88vGcgwxhoScPebO3Cao61KOA62F Zs+yJ7t/0C6m9mG7S9Z8Y2G4UwZIf3/ccM+k4J4BeEu31YZLqBA5+D4aDcoZFfdCiccLyY+jHmKpps JlSmkhx6DYmnbQd8jyxMUU83I9QPUSpWibI39KqoHsb8Jk8KcVEDfoG6grOg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

One-element arrays are deprecated[1] and are being replaced with
flexible array members in support of the ongoing efforts to tighten the
FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.

Replace one-element array with flexible-array member in struct hpet.

This results in no differences in binary output. The use of struct hpet
is never used with sizeof() and accesses via hpet_timers array are
already done after explicit bounds checking.

[1] https://github.com/KSPP/linux/issues/79

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/hpet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hpet.h b/include/linux/hpet.h
index 8604564b985d..21e69eaf7a36 100644
--- a/include/linux/hpet.h
+++ b/include/linux/hpet.h
@@ -30,7 +30,7 @@ struct hpet {
 			unsigned long _hpet_compare;
 		} _u1;
 		u64 hpet_fsb[2];	/* FSB route */
-	} hpet_timers[1];
+	} hpet_timers[];
 };
 
 #define	hpet_mc		_u0._hpet_mc
-- 
2.34.1

