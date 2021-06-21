Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF84C48BE5
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Jun 2021 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F2A61042
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Jun 2021 21:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFUV4j (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhFUV4i (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 21 Jun 2021 17:56:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9FC061756
        for <linux-hardening@vger.kernel.org>; Mon, 21 Jun 2021 14:54:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so386994pjn.1
        for <linux-hardening@vger.kernel.org>; Mon, 21 Jun 2021 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APrF3kvRTyjTvlbhavoz/NkerS2/l6ATaVJxi4ziIkE=;
        b=c/iQ6N1/0xiTEXFHfm3yDb5q2rZQvjSZGTECVNdCQoc1vKa7GpPnDDA656In2fgnJ7
         wxVTQTIZq1F4m8rBegWJvFNY+u9DKwKmI6Z4ALPnsSdhpwtt2yTsYR3qsr5WGtBlh6Tl
         FFN7C52IIJbWFmbWgQXpfQ1BcYGX0GTB6Nero=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APrF3kvRTyjTvlbhavoz/NkerS2/l6ATaVJxi4ziIkE=;
        b=a05FGxYZ2CBE43vjium/xYc76SYGbQNfe9AWHb/OPf9mmsza4FqrpuR3VLWERz85lk
         S76mDN37cmg4gNs6HKrqhm56oh7/n7ikgmnokbo64j+zrcF8ei/DsX2EMJDjoDNbo9P4
         x4pCEn2Uur+33nRpu7XtVhlY4IEE3GFAZvfr5ecBtfsQj9yoB/VG0WoQZ6Ezi51odQOw
         M8anjsKsKzHA4HcjtDMkNAN11E8RFFfJKoX7/Xq/Ch/NJgpjYJdJ10PkKCT6H0xmjxWM
         IGAYVfdSA30RiqkbgeXIYxWR1yxUKsoJD5f7r1CkNFQrZBDpb7jka9DvHpzU4sBfoJnQ
         EB4Q==
X-Gm-Message-State: AOAM531dPthmMoWoG6I63zwGqaCUa816AcKL0oQElchwcOAEK3t2jBDN
        vC55i1FhHcdFkqQQKXL2PNwj8w==
X-Google-Smtp-Source: ABdhPJwL6RAoEZ6YFjBRXK/2kBquU1M6qjK79nhcn7Pkp8heQObszg3SzvqzImjSE8Zvmh9cGvOwkw==
X-Received: by 2002:a17:902:b409:b029:114:afa6:7f4a with SMTP id x9-20020a170902b409b0290114afa67f4amr19787048plr.56.1624312462342;
        Mon, 21 Jun 2021 14:54:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v129sm7166195pfc.71.2021.06.21.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:54:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] octeontx2-af: Avoid field-overflowing memcpy()
Date:   Mon, 21 Jun 2021 14:54:19 -0700
Message-Id: <20210621215419.1407886-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=b17b800f29ea6e6ad1b30b0c2ecbb7df53d261dd; i=11l6vH6fAxI3yJ0jzd3eaE2f+yyEs0bXJk1UH8s59xw=; m=9pzQoBWf6cgaZyB52H8V+Tt7PyeU+Nsu+QkJXmVQ/Sk=; p=6bBIi/RIyCcdYNjz3LFf9VU0AE7+w5vEKRR5cY+Qht0=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDRCosACgkQiXL039xtwCbRrg/+OrW nyJ8YIB/UpRzbZHxWA1oSiqwjP9z2JIe4sFxhNYEzQrqrhKzi1Wduovg6z6UoQ98al9pa8mfMwkjS 2gQ9lxesJzFgYTdsOB7UVXQyu+r0s17xVgeYeDvWX0/0yjvfpNTUf1PA4kSp1lqTF7CSqWwK5yIwu +zJSgDk0l3HdCKPHtTo7t0lwVho45jKnsdJEBs8CBQO9zaD2hBEOawGopmQas7Xn80Bz+fb99wkwx UqwqrtYkDzUO11LGmRMcDa8ivU0hxVOBWC4wfrfU6Bev4vJPBTPPzdygjjTuFWGkf9Xjs7GQt8BRC YTu6aeWcfIvy2ESE1PRimwwnf/G+8o5EsbxNtmqdXeklc/oEecB9MjOChPz9dGoSxRbTzr2BlNsBI mXH6BKETE3e+qY5tSJ9pouJcuCMafSgsCjUXkzHgDeNJ/y+SJYBuoBRgvrihhPBkC7SFmo6/+24M8 rnBLcakwmw5wOZ5XU+z1B5gOxvtX1nTCEnDLjmaof1Mu6k1CDAtG5cAIKKQlx10VImJ4MZpEXFPho MOFmBdH6eADBk1Jla7W281yJqT/oc/ZpPU54sMbEja+sH9zhfciaDszw7cnxOKEUNfSXPTgL+8bk+ wX63AgUI+31sLhulhNQ/GrfbI0qhxRKTqCseaEDKuOhiXPxnf8Odo/5UMnzbeGes=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

To avoid having memcpy() think a u64 "prof" is being written beyond,
adjust the prof member type by adding struct nix_bandprof_s to the union
to match the other structs. This silences the following future warning:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:10,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:65,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:11:
In function '__fortify_memcpy_chk',
    inlined from '__fortify_memcpy' at ./include/linux/fortify-string.h:310:2,
    inlined from 'rvu_nix_blk_aq_enq_inst' at drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:910:5:
./include/linux/fortify-string.h:268:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); please use struct_group() [-Wattribute-warning]
  268 |    __write_overflow_field();
      |    ^~~~~~~~~~~~~~~~~~~~~~~~

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:
...
                        else if (req->ctype == NIX_AQ_CTYPE_BANDPROF)
                                memcpy(&rsp->prof, ctx,
                                       sizeof(struct nix_bandprof_s));
...

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 7d7dfa8d8a3f..770d86262838 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -746,7 +746,7 @@ struct nix_aq_enq_rsp {
 		struct nix_cq_ctx_s cq;
 		struct nix_rsse_s   rss;
 		struct nix_rx_mce_s mce;
-		u64 prof;
+		struct nix_bandprof_s prof;
 	};
 };
 
-- 
2.30.2

