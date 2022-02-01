Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE5C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Feb 2022 01:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiBABhV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 20:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiBABhU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 20:37:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29E5C06173D
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 17:37:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y17so14096314plg.7
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 17:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VuYqPh9FWvBPErW+7cbS/BvTqyrq3aqJFJydMkz9nQ=;
        b=LeTluDHvp4Zd+nWaQbK0cNzKoknHbotGA4qTfiMiSc+IhG1EsL+U0VQxaxB1dv4vZT
         LM2KbO1plv2tvPI6SkOTBv2gl1+vXYnh5F5CeNMOs5vIy05CIxgAmjyueqRZUJiqM8VE
         NdwzrVZYFOMTYBW9u/bpb0UrIlBW0MwSyP4Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VuYqPh9FWvBPErW+7cbS/BvTqyrq3aqJFJydMkz9nQ=;
        b=uIb7WtzIva4b//PuGICtycAIP6h+IlwSwc4TjeaCDoaNJpGrjlfhYX8Tfovfu4yjoy
         ucm1jxLxnMENpJykV4a1J70DmAGlNNpJRliA4suaTbM1gFj2OeStjPO/B1uCU56f6uX7
         vJv4WGGpqtOw8HRhQxiBhlAv1Q+nZG4TxDrjyGw5V4myawjdHLpk4+b0+TetA8ygNzza
         Xns+ee8le2MJ9RCHMfAey0GsSYFkEssuNIKVPeC9ONGtmW4k9wHNKqz8agOlotFeoH1z
         BWQC9H1FR0aPE7NLBhObSIku16Cy/SbT++iwQEl3Hya0+HrW73RO2lI7aDo4gt9eWBYu
         k8CA==
X-Gm-Message-State: AOAM531ElOxrcCjMOPC4BlqXXPGlQum8GtHGdBgrKDqZ+s0LbIie7tAI
        jZL1lWAhqKEIPICgih0p8ebdLnQYBmgOWw==
X-Google-Smtp-Source: ABdhPJw2QDP3k0s9nPmM1tjRDNbK38vYyK7vy7UnZ08dmR9C/5PzGxtEG8VCsDhgcvdvdQkN6Nf8lQ==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr23488629plp.60.1643679439364;
        Mon, 31 Jan 2022 17:37:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm19744700pfj.115.2022.01.31.17.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 17:37:19 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] selftests: kselftest framework: Provide "finished" helper
Date:   Mon, 31 Jan 2022 17:37:17 -0800
Message-Id: <20220201013717.2464392-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; h=from:subject; bh=OirkO6WjaogjR/Fh4r6b5tu/SqXlUScKuU2FQDHT/Jc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+I7NSg/0NTh1CFzL3X8rEnWOEQ1wJvRjP52epi/v V1wIXfGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfiOzQAKCRCJcvTf3G3AJlD+D/ 4wadZcIw2Sr/BUwBjt5N/MO1eBfgKS13OFBRZtzP2taoHihfFaL4544NJF8EmTEZJorPSQMxQXFnM+ OiXA519G9YogiIGToWuFv1xf2RICG4Hh9zty+G4CvMXyz25N/tiXttXLNC11N+VqOiUB1J/bD/uv97 UqEPllQxZ6Rsi4tmnSYSHNTc0X/jn5yFoq/ycGvN49mBQ1+XtrFfmomqv8QANRICQTT7HDcAeqmbeK l399wnztj6L0JyvC14NYDMAPwr8dmg7ZskU4ClNgDnvdbKxgvDp4psaSCmCzrpmxNAsCyQL61KgwXo Bm1wNW1vddAXRh9FQ7yGeb3nLDPO/sIDFx/DnT8+Xdjsl3vhGLYi3KBvNL63GiT0OL/pdiUzd8y6WL 8HN38IAj6aOnQuGbPauou7RsRZbZ7P8fqOUsymS64jr1v0tLAK1tKjeHSr8qNyRWmmdMCJ0/Z4hGNo Os/T9E6sNdwGKwUKoW+3rh04ZwsL0IUHPrzV4idtAkry8afh1ZAV26UtCup175QSBMGTsDzDizluYa JctMAbbmkgGXM1Ozic6xabqPCuXgtgChJosucuaFdn9476jIQWr4iWap74Y4qlp6wRKQ1oifARgV3s ZwkESvMS/nBnMIhcvAAH1Wo8Bh9XRU0eeyqJ5BN80qNNPSUIhTxqOQAFP2NA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Instead of having each time that wants to use ksft_exit() have to figure
out the internals of kselftest.h, add the helper ksft_finished() that
makes sure the passes, xfails, and skips are equal to the test plan
count.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest.h       | 10 ++++++++++
 tools/testing/selftests/vm/memfd_secret.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index f1180987492c..b8f248018174 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -28,6 +28,7 @@
  *
  * When all tests are finished, clean up and exit the program with one of:
  *
+ *    ksft_finished();
  *    ksft_exit(condition);
  *    ksft_exit_pass();
  *    ksft_exit_fail();
@@ -235,6 +236,15 @@ static inline int ksft_exit_fail(void)
 		ksft_exit_fail();	\
 	} while (0)
 
+/**
+ * ksft_finished() - Exit selftest with success if all tests passed
+ */
+#define ksft_finished()			\
+	ksft_exit(ksft_plan ==		\
+		  ksft_cnt.ksft_pass +	\
+		  ksft_cnt.ksft_xfail +	\
+		  ksft_cnt.ksft_xskip)
+
 static inline int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
index 93e7e7ffed33..957b9e18c729 100644
--- a/tools/testing/selftests/vm/memfd_secret.c
+++ b/tools/testing/selftests/vm/memfd_secret.c
@@ -282,7 +282,7 @@ int main(int argc, char *argv[])
 
 	close(fd);
 
-	ksft_exit(!ksft_get_fail_cnt());
+	ksft_finished();
 }
 
 #else /* __NR_memfd_secret */
-- 
2.30.2

