Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A1C3DA7A
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 23:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjAEXWi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 18:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjAEXWd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 18:22:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DDB6951C
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 15:22:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so3564261pjj.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWqazbyRLoTC8Db/Whc37KnLoFkdsyWjRIzge1/UbpU=;
        b=VnP0aHc4axpEKI97b+IZ6oWN+okfDvFssMTLbHzN1OGnrqMPIb5h1awy2f07zRIQ4C
         icvlH9o1vRj7vrO9ELlRp1Xq0S33XjDuaBdRVjnqLg4SuSZuqU0V/qlkYFJQQstBeRRB
         R8NVulvpT2OY9NfJ3exH2qhtJveVptIOOHduA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWqazbyRLoTC8Db/Whc37KnLoFkdsyWjRIzge1/UbpU=;
        b=r3z6dQelVAwFQep7x/GVo69L/ITmUnJRz0uT4RJnDGAXJBDfbIjk3g3uvT6++JETcQ
         P0uMcvQ7jGDEbfMZX8GZRcDtYZmVZzXsljq36NpWcogg1aHQA7ojkqYHAno6bNDX7r4a
         /IMeut93OoAkdtGV84eSEwofVgPogFJ2g2dhRKs7iwdkBPJeYEWoE4DmEb+iMYlOjCq+
         D2Dl/ydzh8l39fC+1VPL5MhQmTxiAzIQq6Qt9ychiEQdYucw8d13DAjiRUdNZ8fNC/xK
         goWp7qCEEQjh760zkE2FBf2ee9xFPEP5B6DusW9B2fzsYfmlUPvHDiuKG7Dao9nIQkaS
         ykWA==
X-Gm-Message-State: AFqh2kpvRjMvMQDsoMMAZX4zGmbXa5DiJzKFbCougamgD7vtb3e4g1il
        /8jU9WimGVN5qHjtKHaASt1r0g==
X-Google-Smtp-Source: AMrXdXs+zHy3f189mopMN53werK0+UClxehE+3BPUmiez17LUdiLIkzSI4JauiyJN33wESV5RRzVDQ==
X-Received: by 2002:a17:902:e886:b0:192:fd24:8bb with SMTP id w6-20020a170902e88600b00192fd2408bbmr5499697plg.62.1672960951150;
        Thu, 05 Jan 2023 15:22:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902b20c00b001801aec1f6bsm6793044plr.141.2023.01.05.15.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 15:22:30 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] mlxsw: spectrum_router: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 15:22:29 -0800
Message-Id: <20230105232224.never.150-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; h=from:subject:message-id; bh=KtszOhTtBHOJMBXcCf68gEIjIaPlW6ySs3tOC7kDi+Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt1u072FInbSWvkK9ROyDtbUdMqOT90bc67eQi6SZ JhBI0k6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7dbtAAKCRCJcvTf3G3AJkbqD/ 9m8DMcoU3/EnqRmO+0JA6ww4B2FpQawFlaOMIre43dMKbaCRiqdqo5mTurO6wxot9WWkwOz7p0V524 wQj9tp7YVXDHj1Vdk6H+fgpw9bDzfaL0JxFuEJrMDNEYpqjI4XrlYZ90En5XBYsqNgBKcHQG+MlkED z4EUXUh6WxBjC4vsXGgD5rNylMDn9jvNkgEUOyy+ljjyuPmxEmRSkyRsyqSAq+Ie+fJTNx/B5GHF55 8VDyc8ambbbn4eGqINNZUW1EdMQDQsi5b8EAfQMVX8B9bcppv8q0javJO4paFRlxNhjx3M6+reDLc+ rEuHeB2cbQRDYE8GEINDJGGkunoSezzKZ2wYZOPx1B6fIEfPrAj9duIdV0NaZkEHqCfAmzTP+B/VYm lQK+kfHYHDsE08/FGRx15VbQrkuSKioY0X0ZPp6MlQyGjRyXOu2qXjFYexxEjftQY4I6ru4I8XILVd KrcmpcXTyPP3R9+3Eu91oH2MaSABeg2pdLpyc57/8r2RBXza4nvGdJTqB/Kb9yL8Zb289T4nz6Gzfi h4QNCEaKdl2lSkkzZ9AxZ2z+dNtAqz5UmjUW4gahE179cK0HlakAUOCjohizdYsAW/7uW9g4Zaeq5x bPrnxgQaH51LS9qtvUrVbNbVSjQlqGOtxFMnDAZWd4qJPyE0Ba3kbJYzmP0g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct
mlxsw_sp_nexthop_group_info's "nexthops" 0-length array with a flexible
array. Detected with GCC 13, using -fstrict-flex-arrays=3:

drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c: In function 'mlxsw_sp_nexthop_group_hash_obj':
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3278:38: warning: array subscript i is outside array bounds of 'struct mlxsw_sp_nexthop[0]' [-Warray-bounds=]
 3278 |                         val ^= jhash(&nh->ifindex, sizeof(nh->ifindex), seed);
      |                                      ^~~~~~~~~~~~
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:2954:33: note: while referencing 'nexthops'
 2954 |         struct mlxsw_sp_nexthop nexthops[0];
      |                                 ^~~~~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index c22c3ac4e2a1..09e32778b012 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2951,7 +2951,7 @@ struct mlxsw_sp_nexthop_group_info {
 	   gateway:1, /* routes using the group use a gateway */
 	   is_resilient:1;
 	struct list_head list; /* member in nh_res_grp_list */
-	struct mlxsw_sp_nexthop nexthops[0];
+	struct mlxsw_sp_nexthop nexthops[];
 #define nh_rif	nexthops[0].rif
 };
 
-- 
2.34.1

