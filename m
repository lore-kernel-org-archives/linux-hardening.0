Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0225BC7EE29
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 21:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjEVVaC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjEVVaA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 17:30:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC5102
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 14:29:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52c30fa5271so3564887a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684790995; x=1687382995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBLyvMJIXVEoPILXi5pTygeAcZW5DafmkS3+kdAf2Kc=;
        b=X82Q2HodtT8g9HraWMIl6WRHWVTb82m3RSWbgXxmB7cWHpQ/9EMmYZZIsVjf9DaLD8
         SCAMWIwbtqwUg4HoPylm8ZEiqw1RJfD9rED4QOx8TyhkjCC33fQN6VzHYNghySnyMAB7
         MGGfYIqkq2GjXt67wofcPVZ+leITFGwe2m8y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684790995; x=1687382995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBLyvMJIXVEoPILXi5pTygeAcZW5DafmkS3+kdAf2Kc=;
        b=CMf/YroC4Inmsd4sR4LqaljM/VnsWeQYY+0xriO29VdR57k4+c5AaHRDwX6+Yenm6a
         1rY+YXVH6GhspqnlLfKhvTSS7jaAp19e5XVa4t0mk7Vnwgmd/OmmYCGfXMBERYFbBjFC
         nkz21XwtPu5ikzwQzc2YwTX7Vi7VA1FH4ATYh+wsSHZRCIm+d6rKpV4vdm2tF57fKYBN
         sgLkVcJwEJTA4UJ7hR4wpvzkwKDmiNPVAf9WFRhqJTUu2Ij3zp1H32A+22hiJa70wFyV
         KsSaNc4zG7FwlWUpeOkEpNrVdOcl5SvRUiP8bxUiwfY5Tf0CS9L9tLIehHj0U+59LoRs
         tLRA==
X-Gm-Message-State: AC+VfDzgiZ24oju5GhBKGWsn/IMZFEliGI1LUro0mLggP8/3gudGWZ59
        PJCaM/5kVoY+WGgkNyJtty5a2A==
X-Google-Smtp-Source: ACHHUZ5KVf25c93mzqpzXVDAq4yl6joAPQnJgMH8lV5GMMJly5FJ0vAZt87hVF+Dyj3qhc2UMaYElA==
X-Received: by 2002:a17:902:fe18:b0:1aa:e5cd:6478 with SMTP id g24-20020a170902fe1800b001aae5cd6478mr11818786plj.58.1684790995120;
        Mon, 22 May 2023 14:29:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b001ae5044c2aasm5277702plg.145.2023.05.22.14.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 14:29:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/bugs: Switch from 1-element array to flexible array
Date:   Mon, 22 May 2023 14:29:53 -0700
Message-Id: <20230522212949.never.283-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; h=from:subject:message-id; bh=y81tjhfBvnUmPtitkb7B7N9eatfqA8YTYmeHZOhOfxU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBka97QZrwNn2mIbVBJBSpfEndS4xU/2XPiI0Wr+S0L Kun4w4mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGve0AAKCRCJcvTf3G3AJhfoD/ 42C/6DH/maDdsB2RoaWdC8ev+KyoGozc+vS5p1KDZ3iuw3IdatQX6VB19FAmC02Qfft/ityZtkUckj DyVfyVg19qbMD1BkB/qgdU8WXc8RkzbQvg3iBKVBA1WpCqo9IHzANU04bMYIFxH8gUXwM6qGdu6qTa hMGJEOG4ux3t7KkFPZeooTAsE2P+AfGD7Smctm/qEYdORFqp5bNrMNLZmwNR6szCNIYY5GjALFX4Ts FoZcxWAfoNOHT/LhIiSbsV9GftsB5mp/ifmu1jhd2Ttq3rYiQaH1seUxZkpUmRgElpA6KgcAI78Icp hqfYvhzGH03caTMr+GntC7w1V64N5w7Yr+Sv4taGCJ2YE3UJ3WFRUmQv4MvnMlxn0jqxhCZ7S4ew2J XtqhvQE8OwRE9icsBdehtRH5j+tcyVEn5Fc5Bw0rHaHvySqkhLsieKO8Lu8ja5zcekuK5Wk7E3CfRO U5Ceud1NDAdSdg57fvIDDrqsQDK0HYqgDP7QgeNFLcTYE7l6OEHvOwZApnOGpOygPTwMlYw+364roT jJZW6H1q8ZNH8ViIbM/d4y/xfeE2MFg+HlakXFQJfX6neJ2aYReVrOa65MS/IsSz5fkg7ut33y82zH JGxSuqXQZ3FB4ZaUIji8Q0OVcq00PQ6E8xX57dH1rzE5rZjFOUMISwSXQkHw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The testing for ARRAY_BOUNDS just wants an uninstrumented array,
and the proper flexible array definition is fine for that.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 48821f4c2b21..224f42cdddf2 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -305,11 +305,10 @@ static void lkdtm_OVERFLOW_UNSIGNED(void)
 	ignored = value;
 }
 
-/* Intentionally using old-style flex array definition of 1 byte. */
 struct array_bounds_flex_array {
 	int one;
 	int two;
-	char data[1];
+	char data[];
 };
 
 struct array_bounds {
-- 
2.34.1

