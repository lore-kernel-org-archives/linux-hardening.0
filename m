Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BB0C3DA7D
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbjAEVlk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 16:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjAEVlj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 16:41:39 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED51D671A2
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 13:41:38 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 141so7074750pgc.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 13:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr7VY1xr8D50GfMBWbQ+mcfUi8VYRH93LwFJZAO1KrE=;
        b=biqkWJn0JUgt6jN4Ix6J/6fD4m/GhQDQiMCPCM8Ezph5YY1SQnjqZKMB5f7QVA3ruy
         tT5z9opi5Ifq9fwpW+P8BDtYJCxGWahQkTZfnQDJlEYruUx6Hfcjxz/aeliuYZuEcsjG
         spbnNKGDNcv9emj8ItKmvjqCnXJoAs8jfKwcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gr7VY1xr8D50GfMBWbQ+mcfUi8VYRH93LwFJZAO1KrE=;
        b=JzBmmUThnyJ7JJqrBvj3gJhV/V1QQDYpDKkgHfxKYg3SjSk09Hor+A+BQfJnvoxMIw
         ZvUgHJiY+X8SOIvPz9hW6yEtGDoxc7+aUu2AzyR8NmDPl0CcN2decq/tVfyubEPcCC93
         utE8XmHA0M+IDD+VIj351Ojr1UIzaK9xZi0XBJjajNXO2JB7JQizsDC3KcOJmLvyCTto
         cAB8w7c6SZ6cj2JBWUG4SGKg95tBiqw7B+Sf+33rtrmeqz/NsBJx6aPskIos/BIBI0vX
         YmSuwjtdp4yS6Ru06Au/CCTwsQ5MtsSoWcnfdDwjSmFR7ta8X3GmjjVGL3/MRNuq0uve
         3Kcw==
X-Gm-Message-State: AFqh2krppVbcmnrMnq2zSbhzNpJUcrxhfY/mpurQU+XyvENSBS4VRMA4
        OR7XFIHMSK8CF4VBl2dzq5QZeQ==
X-Google-Smtp-Source: AMrXdXs+i062aZ3YucZ6kdj0ad3n/WRCnVgFIGfp+XaI0FnkCKs4/4m8+uqDObh8Z1kSjKmdbRKLOQ==
X-Received: by 2002:a05:6a00:24c9:b0:57f:7bb4:8fce with SMTP id d9-20020a056a0024c900b0057f7bb48fcemr62907948pfv.32.1672954898477;
        Thu, 05 Jan 2023 13:41:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b005825b8e0540sm9219022pfk.204.2023.01.05.13.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:41:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] ethtool: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 13:41:34 -0800
Message-Id: <20230105214126.never.757-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; h=from:subject:message-id; bh=l87vgCNM54oMq3NmxL6kds7jYVmQqBDhqu2JC3Cjh/U=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt0QOa22l3Q274W3yAGBVWu+cD27M21OizpluzMHW zmLGeXyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7dEDgAKCRCJcvTf3G3AJgxED/ sHusJjKAWOo0tmDLlG/D9LAVElK2oD/fFV4n2wXZduPK5X6mtQ2VIMJGbXqW4shFHUTX0MMw2pgYiS 6xbDlY3/TLuU6oRKlPL9OjviI5R4kxwREx/m+CnFV0YjMjIsmLMNzuNSB9sUwIYp6Wr/iARWeMkgpv XVUK7ujwfwxKbw+gMDU19IkL6xlh1Z1pPI4H13w1rZmO03v3WfofSLOxc4ST9uowmhnowtrPH35jki afPHMiSXb8wfGn6evxLz7WG/ga2grxvoHcfFHTbBWWqBKpG6a0ga9L0DTLyKIWduFGW3sYvLTQlSec x8tSnxgqOncZuTMfFdHKiOUX72KjD/EEIzZsuYVLIND6WAbvsq2J6TY71Aevbu4JR17QEbiJAJm9vG PXBodZdFkAElbgH0cFilyKsUsbVNpmcweFi6b0nvJ1294E4w2kfR2R7hsw4XFPJ7K36/nIUmZIiJQh HJQ8Uvyc3k/F9/wZuWJfNlHBeWndxlJbgiKvbdQj7tmYcb4IFQkGWtoLgA+coL7i/v1keiLUJmwjPu iZiLJkm+58YDJueYesJzwEx1Hs7G5H6/8O1gm68dlFMF553iKTaykRzk3Ovg4lwId8lJsUFv3VV1VS QrI6Jb1RYihGQT0LxXCxFGxrddRjQY6VLYFfFuFlWdGxvevcKSop1xYQfkrQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
"rule_locs" 0-length array with a flexible array. Detected with GCC 13,
using -fstrict-flex-arrays=3:

net/ethtool/common.c: In function 'ethtool_get_max_rxnfc_channel':
net/ethtool/common.c:558:55: warning: array subscript i is outside array bounds of '__u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
  558 |                         .fs.location = info->rule_locs[i],
      |                                        ~~~~~~~~~~~~~~~^~~
In file included from include/linux/ethtool.h:19,
                 from include/uapi/linux/ethtool_netlink.h:12,
                 from include/linux/ethtool_netlink.h:6,
                 from net/ethtool/common.c:3:
include/uapi/linux/ethtool.h:1186:41: note: while referencing
'rule_locs'
 1186 |         __u32                           rule_locs[0];
      |                                         ^~~~~~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: kernel test robot <lkp@intel.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>
Cc: Sean Anderson <sean.anderson@seco.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Amit Cohen <amcohen@nvidia.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 58e587ba0450..9b97b3e0ec1f 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1183,7 +1183,7 @@ struct ethtool_rxnfc {
 		__u32			rule_cnt;
 		__u32			rss_context;
 	};
-	__u32				rule_locs[0];
+	__DECLARE_FLEX_ARRAY(__u32,	rule_locs);
 };
 
 
-- 
2.34.1

