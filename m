Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A1C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 09:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJRJGh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJRJGh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 05:06:37 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA6B60F1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 02:06:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q9so12752651pgq.8
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9MOOms4QunOl/6Redp5Ge9aew4FeGkKwE9CSS5CTGUk=;
        b=bdWf76FJaO1kF+hjnmXSBf/v9sJfP6NN+AVj77rOmYr/zC8IJoba7lZzu08X7MAtMl
         onZbwHwT2GXyaR2b/c44rjKulTveOHZojgOfs1AkYf+FxN/CXynUlvVyFJVSV3C1plZA
         +ElyZ5TJkZm/c3w2KMvc/gs0yEqh4f8DPd2Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MOOms4QunOl/6Redp5Ge9aew4FeGkKwE9CSS5CTGUk=;
        b=lCoUDbaN4JQrIRkCYvarv9xuhIwQItlAa/sI05z9CMy4JYtWF4Dn2K26ePI72h0xG8
         TzzwCK7YFk9zrowYveb410qbresjKKMyf0RT34iFkF/eN2InCUWKD85xg7ad+8fdJE+8
         vw/NMI5jYAsOpyIHm4focGByjjsWfmz3Paeiw4xBuPigT/XwIZMK+xTKY8rAlfIoNzsf
         qJdRs4JHlr5bNt1Ze9HtnZGQtYeXROAWHZyagcuCUCUBXMtUWC7V6pG9tVSCteNY4/De
         IJMkqdsN0V3fNk8D5vgT+gZqncqY5Wcm9FJrUa01hOs5FsBfmvAXGwaZTyjGesFeZSNx
         BRsw==
X-Gm-Message-State: ACrzQf2vbgdsuxWGsnDV32DUmPIIzjKW/jHrPc90W9gyQus35Vl5LpO3
        H6Gpd140uHtDW9c/Pp+PXRleow==
X-Google-Smtp-Source: AMsMyM792Vj0JPXYUwPr2ha3uaSFw4/jApLxlft5B+Zat/R3sbDCHGmJw1Kh9nUMvocMBKWs61q+Ug==
X-Received: by 2002:a63:f924:0:b0:46b:1a7d:3b91 with SMTP id h36-20020a63f924000000b0046b1a7d3b91mr1854046pgi.133.1666083995181;
        Tue, 18 Oct 2022 02:06:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a31cd00b0020a28156e11sm10860369pjf.26.2022.10.18.02.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:06:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pravin B Shelar <pshelar@ovn.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] openvswitch: Use kmalloc_size_roundup() to match ksize() usage
Date:   Tue, 18 Oct 2022 02:06:33 -0700
Message-Id: <20221018090628.never.537-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; h=from:subject:message-id; bh=NhjdtkVuggI88oO8Nj3gLYP4PbB5EfOeHn4wwpvKYiQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmyYd07vNuW7hF46ml2A2+/iXnZPwyLH4REJ4KB4 /tmTfbyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05smAAKCRCJcvTf3G3AJqluD/ 0aRWBEoY+aCL2cVvvXRcvGOlgjAflm5NRESnXMp3Ytrxe5RKVsnitgn+q6vpSH/DQG38ZEmnsD8t2B 1Ww0ENz3AoE1LZ1RkIHoeNvaZ4/+BwWFkeeuSDqyr7pGxj5C/Q6+viPgg1gwDR2kmMbKnK2rqWmFjz ktZZalu1MKeLEXCougjT2krbZUY0N+8VOIYuCPGzZq70YE4Y56QdBTo4H8C9Oaa9MI4oJf3z4sd+TU WfENOVET6aeuD01do32M9dF4nZBNCov90BDgu/BQ30xk8bzNOpyju2gXrOhbOOqoxNb+mI47omLcB7 Iu4iqYXYufV1PicXiMVNG2KFKoAxmMm/3RK6evB3nIknqBjqvgJ9N4tflIIjdjyL+Sdl6vyKT0APvL t88jWnJPU0qIZiVRNs4NQZTJkj+tLrenYF8GWfp0kTnFxJSWHni3PozAWgcu0SLMXNvSZoWtYZCQX+ hsWc+ujLaI+sFb1B+azMbWAYFfQsKizkbs2lW0bwYMwUeEo2l6kqxi1k9tWoItDzQP8qUyfXe9L4SD epapI+7OOojqQtsyi5/T7QPKtrCLVvovLc9WqqrvchYa8BuisBoejpXE2k0oKU0KlgCH9g4orTIEd+ c9DCR4z7mwmBuFajGsC5cgQlLd51nAExgPzCNT7HXayfyuGL4ILnp1DP1M3Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Round up allocations with kmalloc_size_roundup() so that openvswitch's
use of ksize() is always accurate and no special handling of the memory
is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.

Cc: Pravin B Shelar <pshelar@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: dev@openvswitch.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/openvswitch/flow_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 4a07ab094a84..ead5418c126e 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2309,7 +2309,7 @@ static struct sw_flow_actions *nla_alloc_flow_actions(int size)
 
 	WARN_ON_ONCE(size > MAX_ACTIONS_BUFSIZE);
 
-	sfa = kmalloc(sizeof(*sfa) + size, GFP_KERNEL);
+	sfa = kmalloc(kmalloc_size_roundup(sizeof(*sfa) + size), GFP_KERNEL);
 	if (!sfa)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1

