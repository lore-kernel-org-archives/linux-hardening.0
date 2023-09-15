Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD7DCD37AC
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbjIOUE1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbjIOUEI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:04:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A072120
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:04:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fb79ef55eso2328261b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808243; x=1695413043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBuZz+BdckpJHOm1ZISAhTef4sCi4HSxGN+vf0MxAr8=;
        b=lMqXZr9zTLxsy5KQL5G498j4MM23oTudzH5Bwlq5wwkOAbVDRL/RGT4JJxIYIko/gG
         7drOLMhs7FKyly+iCDy92tYvrgHYidKzvNeskOffC/7GJDLaL5ok2aGnYzJmd6qViPXz
         6S3oIX4Tf1Ht2ZjC00eRsxvIofGY5lv3KlJ1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808243; x=1695413043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBuZz+BdckpJHOm1ZISAhTef4sCi4HSxGN+vf0MxAr8=;
        b=MvreeRCkyzDE0DBShB6vWRoiuTJKet2e3Ty3DNV3xD8X4ejKdLvG/hHrd8gAbFbS7O
         xt8ovyMi/xfB7XidlvIV2SqU8GlgRP1GIYOR3yFJUue2pr24YMlqTmLesxQZ67l2h3lO
         Pz/iF3RJZEfR+1AccwZgGYp5O42toERcucFU8Dc/9x7c/bv27XBEiif8c0l5+EmgVQb+
         22stlB+3xUtz5drtZWb6e7k6ujAEnJ7ruOx2i34Pp5YHN/sny7vuj0e1qU1wx94bMJmK
         9dPAbT9H0dtBP7Zxnf3AcoAWnutovoeTCfccDWhc73B0EAnLalayPk8gE1QjrDwN6+LV
         wB6A==
X-Gm-Message-State: AOJu0YxGcImTIE78Zme4QYltDVVYot07Fkg3eb+eNCxgqegAmMJT4cTs
        h+CPSVpq6V6/FE8EJOhJeGFMmw==
X-Google-Smtp-Source: AGHT+IHRUYTJjIKllYHBewMbpKQsYsoD6C28ob0Nn4eDxpBQYKIGmGp4tJnxthVcYLQpU9tsohhP2w==
X-Received: by 2002:aa7:88c8:0:b0:690:15c7:60d8 with SMTP id k8-20020aa788c8000000b0069015c760d8mr3508557pff.22.1694808242750;
        Fri, 15 Sep 2023 13:04:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k15-20020aa792cf000000b0068a3f861b24sm3312716pfa.195.2023.09.15.13.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:04:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] dm: Annotate struct dm_stat with __counted_by
Date:   Fri, 15 Sep 2023 13:04:01 -0700
Message-Id: <20230915200400.never.585-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hh6/l0ERrceykgj05rTGEqoGv9O3N3l11v+m7r5kK6w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLiwjAee1aCYWRgESmBPvaP+ZPywLMQavQYy6
 K1opOJdk7yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS4sAAKCRCJcvTf3G3A
 JmEyD/9Nw4qdkEPs0CMpZYH9PJm4rFd+PH9nRC+v78Gfq/aOca9MZMGgAsVTNZVVLy3P6KBjD2m
 mtmN77g1YZHJHCVzbdUI0UvlIfsuR086YpqaUWYp7+Q7hZfHkyCcKKrUFceRRDruDxkNaUOsNN2
 IzNy4s/CR4vogKkDt+GZ1M4KjWCNednV7pIbc7OTZ7oDfmLZSemK//MribH6UwbwstZZ/IbuMuy
 aeNZcS/1An4v4h1P+RuIKViYXbrMbIVTWpvGjOIbLasIYjcKoW9pSlewMy33Z139w9b2WMNcLGN
 01cMC9t6y0j1p4xe4bkCrA0JEvmLH5zv+rMOGyLuvyeaG6u2Y41oqm+FNy5fEZOI3Neo6HIqjrW
 8dQ4XaWrwKCWR6rc2vzr2N6EFCxh7FMrjtAvMQo4HoYMuzYpp+4owygZiP1XptuqamDfXDnhjTf
 d79h5FKJzmmzKtPa7y41OC7rFq2Hk7JciHa8JTHI3cw1D4J5VvcDE1ZlMq+Cxpi9QK4ImW7tWhS
 DrKAuYb0nA6Npm4thazac1wWwsCnAmJf6MLJqBrJfE1yYX4s3Tr2XuB22ABIm6T4hfpag6YFrbQ
 NiOsSHMZ6+N3PeHEo1lrusu22nve1JOWkpcUnxD7lJ3kW3pdEnfUXewlmUjhQFSa9tdp54xnhT6
 5iS4QDJ ir8mttuw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct dm_stat.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index db2d997a6c18..bdc14ec99814 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -56,7 +56,7 @@ struct dm_stat {
 	size_t percpu_alloc_size;
 	size_t histogram_alloc_size;
 	struct dm_stat_percpu *stat_percpu[NR_CPUS];
-	struct dm_stat_shared stat_shared[];
+	struct dm_stat_shared stat_shared[] __counted_by(n_entries);
 };
 
 #define STAT_PRECISE_TIMESTAMPS		1
-- 
2.34.1

