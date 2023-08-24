Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8945C27C40
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Aug 2023 20:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbjHXU6L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbjHXU6F (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Aug 2023 16:58:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D3E1995
        for <linux-hardening@vger.kernel.org>; Thu, 24 Aug 2023 13:58:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a4bcf8a97so247642b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Aug 2023 13:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692910683; x=1693515483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wA+7Z5bFBcAE0uOSv6zSzqEkoW1yLNfWTP1h2/4HdN0=;
        b=Zd1DvXh/KDSeBl0PaEezD2gNroJsMrm1IhcqWwlWO5zavOwN9ybs13YnBFK3cmNvNS
         x4Cag66EfMowoHmsbWGFAx6eZ904Dd6DYahG9kxfX+eot4lmjfYmDucvbvus4yGCxI+B
         U6PEPjAuiAgl3SvBAoR+FXYQ1OzOzLQMNhrfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692910683; x=1693515483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA+7Z5bFBcAE0uOSv6zSzqEkoW1yLNfWTP1h2/4HdN0=;
        b=UKXumMKoEVC+0zROmuO/qtekRnJFCIPDdH9xOj35Js28EDFyNjqsarG+WiF4Kb20mN
         /PSGVoFuyaZ5/ReuNsYdO+H62zr0KmfFVZV98kap+n8KPtMKnum6tkyIf3ySvVGSZefg
         CpTXYY1GzjJmj7xlVyAzrM1cvGdUCMVXoeyBzsprkcPZgW4hHo+RI0xL9MR9c/h+Ox/E
         AYfkJC4jPFYvCJx+2flH4S/8kkxef63mYPhxq4wLfjjaeEBWwnf8yXbwAKnTkVMAQiZe
         LEHWGS3hq670RwUMqFXrx6vQ+7asL46cORic5NgID5exbRb0ekRH7EiQKLvXrSg2WCsB
         xpIA==
X-Gm-Message-State: AOJu0YxbQVQ3on+MEnPHbfn50rlri99rM4IZyP5cC/yN4BIVe4DPmvus
        azAdCoDY/iryx+Po/joe2+UdKw==
X-Google-Smtp-Source: AGHT+IFNp4VxreG3CylyrsmsqpwVJtY3FJ0hgjwSerf8ssFZIhscP48JGgNj9F+JGiCPyQ+4SiADoQ==
X-Received: by 2002:a05:6a00:234b:b0:68a:613e:a358 with SMTP id j11-20020a056a00234b00b0068a613ea358mr11733220pfj.23.1692910682737;
        Thu, 24 Aug 2023 13:58:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u24-20020a62ed18000000b0068620bee456sm151850pfh.209.2023.08.24.13.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:58:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Yonghong Song <yhs@meta.com>,
        "Erhard F." <erhard_f@mailbox.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        kernel test robot <oliver.sang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] kallsyms: Add more debug output for selftest
Date:   Thu, 24 Aug 2023 13:58:00 -0700
Message-Id: <20230824205757.never.730-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4g2gVO+jHHf6A5BpwCqHCSTJxw4am95B2lIPYwc/fVU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk58RYnI/7JqLCcNUkLpkzS5oa4Xz9o0zH+fN6z
 H/+ZOzVtAqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZOfEWAAKCRCJcvTf3G3A
 JkpVEACAMD64wyZ4NMfPswxBHkAbxx7qt+ik9F/8/drT0bMpTLKJzcqj4gPjnDCj9tk3EHT77Ym
 PTmKXACfxeLjwG70rSyngowWJFeHpB06Pe2/K4MWiLbuXvvQkjGr9ouxcUZ2jr1+8ziF92iuDro
 O4v1vSWwDYawH2qkQi5z3oyBbytEKb03F1Xs2ajq3Mi92IE1Nbz8b8oEnD7+CXwL9Cmw70Hi+rP
 W2GJ1au7oTK5xjXcFTsNgcoLOc3L6h1vg8wnJhWynwnwTbnj1d/hDiMPCiWSUSd3TZ410cnx7gq
 ns3eI9g/u/zQZzFEkNwy3O3jKq9FTKAWE6QLWU9qai/cby5mMAN7hdI9c1jPKxhNwcwOYl+DBch
 zKDgjVvQPVQ8fAxllJVGxlgMPiOWu3ELIMfrU7Gc7XPiHFRgn4nZpzKZZZVWfIGLcNx+9E7sfvH
 g0dyM1uhWz+1oE9six/tXNClkddE87DMsVxgnpU9lHSf2qqtw6CiMa5KHadp5OsTUXVMy3FSfZj
 GVJERMMp78ZsejAz4i/aTa2MKDk2Z9tuiimJ5NJlZyj1+w5j9GokzKeaM/ySPr+N45IlluGn7/M
 7lNUYAVqEBfOU6YiOnWQwSVc1nGLRAopARrcsf2RSB/zLmo2rjeomVh5aIJi9f4AwHI3D63jzp4
 FaZUEV2 tl17Qm4w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

While debugging a recent kallsyms_selftest failure[1], I needed more
details on what specifically was failing. This adds those details for
each failure state that is checked.

[1] https://lore.kernel.org/all/202308232200.1c932a90-oliver.sang@intel.com/

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Yonghong Song <yhs@meta.com>
Cc: "Erhard F." <erhard_f@mailbox.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: kernel test robot <oliver.sang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/kallsyms_selftest.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index a2e3745d15c4..232e8faefb46 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -341,6 +341,7 @@ static int test_kallsyms_basic_function(void)
 		ret = lookup_symbol_name(addr, namebuf);
 		if (unlikely(ret)) {
 			namebuf[0] = 0;
+			pr_info("%d: lookup_symbol_name(%lx) failed\n", i, addr);
 			goto failed;
 		}
 
@@ -388,8 +389,11 @@ static int test_kallsyms_basic_function(void)
 			if (stat->addr != stat2->addr ||
 			    stat->real_cnt != stat2->real_cnt ||
 			    memcmp(stat->addrs, stat2->addrs,
-				   stat->save_cnt * sizeof(stat->addrs[0])))
+				   stat->save_cnt * sizeof(stat->addrs[0]))) {
+				pr_info("%s: mismatch between kallsyms_on_each_symbol() and kallsyms_on_each_match_symbol()\n",
+					namebuf);
 				goto failed;
+			}
 
 			/*
 			 * The average of random increments is 128, that is, one of
@@ -400,15 +404,23 @@ static int test_kallsyms_basic_function(void)
 		}
 
 		/* Need to be found at least once */
-		if (!stat->real_cnt)
+		if (!stat->real_cnt) {
+			pr_info("%s: Never found\n", namebuf);
 			goto failed;
+		}
 
 		/*
 		 * kallsyms_lookup_name() returns the address of the first
 		 * symbol found and cannot be NULL.
 		 */
-		if (!lookup_addr || lookup_addr != stat->addrs[0])
+		if (!lookup_addr) {
+			pr_info("%s: NULL lookup_addr?!\n", namebuf);
+			goto failed;
+		}
+		if (lookup_addr != stat->addrs[0]) {
+			pr_info("%s: lookup_addr != stat->addrs[0]\n", namebuf);
 			goto failed;
+		}
 
 		/*
 		 * If the addresses of all matching symbols are recorded, the
@@ -420,8 +432,10 @@ static int test_kallsyms_basic_function(void)
 					break;
 			}
 
-			if (j == stat->save_cnt)
+			if (j == stat->save_cnt) {
+				pr_info("%s: j == save_cnt?!\n", namebuf);
 				goto failed;
+			}
 		}
 	}
 
-- 
2.34.1

