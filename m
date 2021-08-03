Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D95AC4320E
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Aug 2021 19:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7380B60F02
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Aug 2021 19:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbhHCTq1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbhHCTq0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Aug 2021 15:46:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C2C06175F
        for <linux-hardening@vger.kernel.org>; Tue,  3 Aug 2021 12:46:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l19so31150768pjz.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Aug 2021 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbdmhYE/Ap9tx07ENJbk+L/5B3DTJSAT+gfjbTUDTS8=;
        b=g8gKnpSIsuUKutNCarCvGvCSLP609dkCs8vFO5hQQiITyB942s5oFB1RNwOnVcumqB
         SBD/cgm2BWgKHzNuBB4CMBkU4pPG5W7u6r522gbFpjv9xVhnVHmVW+ilf1lvuKCVDQ7t
         JwlBnSNavUKHpUjTluYiOKUJoBHEt3wB7IsCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbdmhYE/Ap9tx07ENJbk+L/5B3DTJSAT+gfjbTUDTS8=;
        b=hi4VdP6UQhnY8Go+D3WnWp6On+bjoWuVzvSEcTFzGDoiLyljnoOmeE4IiXMEivD7wM
         ScgHftih4zjHaAqUOwU9TRqgkaUDGnEJ2a9hXtlxRU96xSmdMvtC7pZOygw7Az1Z0ZtA
         t/qPlxdfmHUa7qdiva+hzr75Hgmvjs50JYfexk516afsNM6n60SiH8y+avbPvZBgpEq/
         4Z4QkLkqTNFyeNPULYO6cvj6PcRkGpMe13Agjs8jbcIx/ovoNQH6wAaitmSMCTD56eLD
         Ceu5C7Q7xa/TouJ6fQC80MF7T9ch/n6bQ0Mz+19no47Em+U7+jGIe6eUkpDl3TARa8il
         Xkbw==
X-Gm-Message-State: AOAM5330mj5txhPBpTTVaNqj45GTKdCDy6mImiKTnMYApISJkPkbLvR7
        OdQ26LChjJwF7WRzJ3TXL6DPGQ==
X-Google-Smtp-Source: ABdhPJxYmJJMwBcM/YMgHpoFPm+5rRaUdvw0DCERDV6Rpfwgm+QEriZL2hJ4yOsqUE4hk8ZHUKZaMg==
X-Received: by 2002:a65:448a:: with SMTP id l10mr2750805pgq.313.1628019973979;
        Tue, 03 Aug 2021 12:46:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x25sm4657pfq.28.2021.08.03.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:46:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] media: radio-wl1273: Avoid card name truncation
Date:   Tue,  3 Aug 2021 12:46:08 -0700
Message-Id: <20210803194610.326030-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803194610.326030-1-keescook@chromium.org>
References: <20210803194610.326030-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; h=from:subject; bh=2RYUzk/cEnmLMc4fjwO7V5oCVfYHZoJHM/rw/dKeVoY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhCZ0B+B5RpPsLqNQZA2oBrk4UAo4fhcG+/TqDA6rN h8n2OAmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQmdAQAKCRCJcvTf3G3AJt16EA CpEnl+Xpi0aQBHHRN3Qvh9WApds3wbGyDLSXW02OgtWZagicTY4xvBHWmkP1Ffe70LtuUDbnOe+Wrd IQXrRbYE3sl7+h98dPQRFdfh7IYk6p4Koh64FDm1x4SEF2nFCDmi3YooawEJlwfhKIun0kOAk9vsXO /3O0IWeMKyc3Lsowj1w0HbwxuJ3EAQU3bCi9KCr9zNfFTe8eGiKTE5la6kY+54MLMJAOvgFhpaOTtc eGDyOtaewqSAVMIw5/316jtHbEYW8zurUjH9ph33O8NFutsTjFIzlgdMpS9AYClquCZJxFz12m/jiC kU81HZNpvWQDGaYva8mmKSBU6OrRZYhBeDwIxb/TVZ8V13jka8hNJwDDgbyNVH1JUP24SPkdC9yuO5 MeofEwpWSOG7TQ0W/Y1i8ENGaBcHzQpFkZzyzHng5RwDygt1HWy7OwtYEY9jNW7onqqYSCGN9bFYAb ruo/FkuhgIeFc6kypvsTXS1x6oc8WhJFabC4VRDJxYmmt7JAKVvXfQgbxo8oaKDGUqjQf00dsFKRx1 gemMg9yE59+XFLtuY+tufXbXasqtN7Q1s9bCnG+4Ul1pf3MTig+sTQD7IjjX1r+CuRwef4lHTFebSb JEE7wqMkyXYfOZTrUjowrPwhykZgaDjFjGPNpsY+Wte088hgqjhJx9mwaNUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The "card" string only holds 31 characters (and the terminating NUL).
In order to avoid truncation, use a shorter card description instead of
the current result, "Texas Instruments Wl1273 FM Rad".

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Fixes: 87d1a50ce451 ("[media] V4L2: WL1273 FM Radio: TI WL1273 FM radio driver")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/radio/radio-wl1273.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/radio-wl1273.c b/drivers/media/radio/radio-wl1273.c
index 112376873167..484046471c03 100644
--- a/drivers/media/radio/radio-wl1273.c
+++ b/drivers/media/radio/radio-wl1273.c
@@ -1279,7 +1279,7 @@ static int wl1273_fm_vidioc_querycap(struct file *file, void *priv,
 
 	strscpy(capability->driver, WL1273_FM_DRIVER_NAME,
 		sizeof(capability->driver));
-	strscpy(capability->card, "Texas Instruments Wl1273 FM Radio",
+	strscpy(capability->card, "TI Wl1273 FM Radio",
 		sizeof(capability->card));
 	strscpy(capability->bus_info, radio->bus_type,
 		sizeof(capability->bus_info));
-- 
2.30.2

