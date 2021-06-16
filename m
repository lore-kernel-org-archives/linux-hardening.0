Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3555C48BE5
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882676135C
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 19:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhFPTza (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Jun 2021 15:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhFPTz2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Jun 2021 15:55:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7CC061574
        for <linux-hardening@vger.kernel.org>; Wed, 16 Jun 2021 12:53:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so335036pjo.3
        for <linux-hardening@vger.kernel.org>; Wed, 16 Jun 2021 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgFaDgHxLA9EExjjiit960bbSMsHOuuAVtNPxuyfwdc=;
        b=VJ17cvu7qPDG1WK4ovVTB49QXegtO6/LKg7uPK5B9ll+1f+xrPu44t3v47LPVMfcv2
         0KmItzik4m+x2VTmTlVSnOpinxV24ZTm8aCjXa3H9S4bT/klp3hDewcjcatfRpsLCgZe
         sc+9OyzRK5D4I7H5C3pjWnE13Allb25xq+4Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgFaDgHxLA9EExjjiit960bbSMsHOuuAVtNPxuyfwdc=;
        b=UTchZI6MYAWjTvYTJQDLps0JEvykJYeHooCUg9uNpwIlT/dyS5biof0URSFnnyfQr0
         egiTcMbU7aldwI3F2+lJt+diknj+AP+XZdqhewD6y5wzXbK6Rve+OFE8k9sxyO9j9LhB
         aDbdhxSKHORMM7BEwATMV9B12P9b/AuFkITWwgcwbPZ0+PkYO5K4IH+Oh9ZKaa5tJVvL
         z6quI6DjmEBap5HI/OUaUqu2KA3o+K4dr8nzh7P/DdsWbNq2uU0/vJX38AGE1BWD7CsL
         IfdAnf21S6o4rh8SBObAF4iIXf0ojjzSmBKyXrC2oIGHNuiz9abVizrOXtQAIaoTOblf
         YkzQ==
X-Gm-Message-State: AOAM533pYjdGnE+12uQVhpu0GVc5EEYjJH5KR6MbGJoFGklYsEhVg0B+
        /+mRsfWgVhpf2dNWhB5ahwDG3w==
X-Google-Smtp-Source: ABdhPJw6aKAned0HD+bPhbj4vTM78zjpxifXigeJgyJTC/meWWhO/mIZDtYOVcOs6j3nTwZw/ql6Tw==
X-Received: by 2002:a17:90a:7025:: with SMTP id f34mr11406884pjk.95.1623873201649;
        Wed, 16 Jun 2021 12:53:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q21sm3044465pfn.81.2021.06.16.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:53:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     netdev@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org
Subject: [PATCH] igb: Avoid memcpy() over-reading of ETH_SS_STATS
Date:   Wed, 16 Jun 2021 12:53:19 -0700
Message-Id: <20210616195319.1231564-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=18e7700f86d329d66c5e9ddd31188ce7bbdbf71f; i=GQ68Ss1LnWXsMUWpKq38qzZWmC3gw7+5/MXnZQpVpd8=; m=CF57NG64wUjRAJMr07rJpYR31VG7hNQuEGsWk+kxwfo=; p=t+sk7BBpXQAg1WlzpO1YLmSqLjWrBlygJr4SlvC/hrM=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKVq4ACgkQiXL039xtwCYEQA/9Gnt HvtC1Xc6/V8ZXiMORBlOP/vHXePkr+giLtNGghose0IbOmt1tRgziOFj/BM5p0WyMREw3boDhgE2+ dQTmESd8sW84S6xrM71LLoa3+4hVxrkiOMLJGkcR72doje8x7sjajebb/l8NEn8qarfAmiey9j/TH npvW6TrQ7jcrNe5AvG+BM+vbsshvn57W54HeJJRh7JNrQRzChdgUMUBd/4eHVA9j7XpW3iwIN3v4r 9ze5JVtk2jlE7A11KLDVqmuXFVykB+EB4sqA80BBMZHUY8oixvlUw8JM6b10RZk+hiKTt6j3jsaXD aQCemzWurwF2nSPcut6l4yslqqp8yFBwFXLClRsRw1BS3Iq8Ks3m+yujsiCHP/JC2FJilbNSJgLAH oqVSaMQ3wH35GUenp1ZF4FhWnRtA/9q48LacfjL3hixikR/UE0DE1NNFm6cs1oNJ/KvbzcOEdmaWL U5Su1psqlgrxdlRa/Piz7izFEWwqRLZFYkP9huCKPZvzlWsqnmUSGrjJgV0lJjULBwBEwGXtjml8j ZBsaQ04jSjL3y1DnM6+IFE5HEPjY013NzEHgkF0xXRmcuFrQTyBSCTIeOvaacJVtoTrkOPXqrhpd9 BAiWrTMmCJy7uxy0zoauO7oF0TINargIQibSU8SkFoq5b0V7Y3F/kFk91DVOs6Ts=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally reading across neighboring array fields.

The memcpy() is copying the entire structure, not just the first array.
Adjust the source argument so the compiler can do appropriate bounds
checking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 636a1b1fb7e1..17f5c003c3df 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2343,8 +2343,7 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *igb_gstrings_test,
-			IGB_TEST_LEN*ETH_GSTRING_LEN);
+		memcpy(data, igb_gstrings_test, sizeof(igb_gstrings_test));
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
-- 
2.25.1

