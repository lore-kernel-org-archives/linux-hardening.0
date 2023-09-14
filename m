Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DC1EEAA42
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Sep 2023 13:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbjINNqC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbjINNpt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 09:45:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588B12716
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 06:37:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so10689085e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694698653; x=1695303453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YijemSwI1+8LVE6KhMKFO+kptldrLUx/Lx16gfEKIdE=;
        b=H7GNhveBcNA4A0Hd0OLQLJFH9vNznrT2hEeuJbRCVIyhSiAZvBWzkrmahICXUU9qDM
         pUHZL5uetsAP3X1qJIzMobAslsdC9+EJhgZDpT5LN0tMR+UHRJgrgki5LIG2K8lggUpg
         wjhiqcikirhzwQbSEcL8dteIMoeVFD5f37hyXKGS0XJONYhcUm+HarmX1syjRbovfnsT
         HZQZ9WhxiTd46bbEuDtVyVMlXGeEzUcsLvkQ2ZbJNnm6evW+xynIi87z9MFug7uGamsP
         ZcvrzSJHLYaKEdU0Ge3X82iAKLSvImsliDajL+59rYjWawEDTfNoEX6fPBP1YEm3ty+J
         H+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698653; x=1695303453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YijemSwI1+8LVE6KhMKFO+kptldrLUx/Lx16gfEKIdE=;
        b=gSbcIkduHQZD/iytBSZFAMdYPsuaQwhIK+0F4sSHE4ceujDypZiK49lDXOzfZgbqVX
         UTPwjqIxd0vrwh+HPL0AZVmJ/9P/qG7hfkirKNyHUnSwIwpn5KfdH6w3exSKuDH8vrkC
         8ygbrNkYmVJiIMaOMuPv7SnZ8EPlr4eYfkMALTUC6vkTSRlzyO2lP4wOZTHmKL7Om1rZ
         Z9F9+V4r8oGTZrG1UGaqP6DDMIiIcujirTw7olWn35lZogq1rbgxVhQqmI/a+lKQYa47
         ky4K6u1GckSH1VXdGTnzbCYCxXWlqtVdWM7+rpyhxLqTGRVS7prkhQ6goH3UYdG0nl5h
         10+g==
X-Gm-Message-State: AOJu0Yx9F2CUgsJvTbW0fl4IWZOlthYEEYfKJgN9Tn3mtf5rllGXwBHV
        wPf31cRtGkD09azAVPDd/xNG0w==
X-Google-Smtp-Source: AGHT+IG0msC+1yArixL6pavKB1GvoxXi2eydfTwuplBW/9AloToxndTPZI50AevgPYG05MxwynRvMA==
X-Received: by 2002:adf:d08c:0:b0:317:54de:9719 with SMTP id y12-20020adfd08c000000b0031754de9719mr4465428wrh.70.1694698653568;
        Thu, 14 Sep 2023 06:37:33 -0700 (PDT)
Received: from ta2.c.googlers.com.com (206.39.187.35.bc.googleusercontent.com. [35.187.39.206])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b0031c5dda3aedsm1824865wrs.95.2023.09.14.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:37:32 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        corbet@lwn.net
Cc:     linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/2] docs: pstore-blk.rst: fix typo, s/console/ftrace
Date:   Thu, 14 Sep 2023 13:37:29 +0000
Message-ID: <20230914133729.1956907-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914133729.1956907-1-tudor.ambarus@linaro.org>
References: <20230914133729.1956907-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The author referred to the ftrace log, but mentioned console log
instead. Fix the typo.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/admin-guide/pstore-blk.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index 1df5d4f93219..1bb2a1c292aa 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -111,7 +111,7 @@ ftrace_size
 ~~~~~~~~~~~
 
 The chunk size in KB for ftrace front-end. It **MUST** be a multiple of 4.
-It's optional if you do not care about the console log.
+It's optional if you do not care about the ftrace log.
 
 Similar to oops front-end, there are multiple chunks for ftrace front-end
 depending on the count of cpu processors. Each chunk size is equal to
-- 
2.42.0.459.ge4e396fd5e-goog

