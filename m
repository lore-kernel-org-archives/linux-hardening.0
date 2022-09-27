Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4064C32771
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiI0CPY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 22:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiI0CPX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 22:15:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F3550B7
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:15:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so514427pjb.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7F5iDqpSb/3NowJ9vBWtXROgMKuieJmMYin6qJsoTgE=;
        b=Ez3YY7hf2oS+EvshS/Fc66PWW7ZIGfVbhM2KHC+tQfDXeGjcwUPxSzImeFj+DcnUR9
         hs4fgk8RYR1XxKTg9qjl+IDuBgoe9XF1ZTBEpPX7GFbgZ6X1VCgTxA38U9Nn2rR+JU/j
         LXfDoUNkotn2dJ/fyuxD8ZsGRf4OrfwBxqcnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7F5iDqpSb/3NowJ9vBWtXROgMKuieJmMYin6qJsoTgE=;
        b=M+lNxDniRh6oSQrGMmApYcD4nBa+DdBSpSyvjV3RwZ8YQQStGmnt62t75mnej7JyOU
         BrMcE57GSg6SpdhffAolANTWTdFFqWk0tZaqs4uKKRAHmVkddp8xiMkLKmIEdfjKmODt
         7HZOSZpIE0Y1DJLKE2TGViPpSwGaosf+XEZaVdOtGWzkcC1eaqnvvQNHJ5U2avwcj5uC
         vTpVKSgcoWGamLIvivGcp336jNtCZbJNojtfnkqiHCMXNqxYc/ntGbfbNj3QSsg6yim/
         tLyu+k6hOI3WsnveWA7xM4z3drfSa4wzUAnsvMl7Lmgoebyd3fUh5zeHCroJzPdz+33V
         Fofw==
X-Gm-Message-State: ACrzQf0tsBmpmuq9Zz0X5c1SlII0i2NML+1Kt54O7+3VUNpn1C/J+Lbf
        dZG1CqmsEyvqguVco/SZt43MMCln4eYY1g==
X-Google-Smtp-Source: AMsMyM6NSHeJ54V/XuI2azAxMqKNn7RgfZoPeBhZIHx7QGUELr+H/nkB7+e3wf8LySCfGIfnM0ogyA==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5c with SMTP id z2-20020a170902ccc200b0017829f95c5cmr24458623ple.19.1664244921560;
        Mon, 26 Sep 2022 19:15:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b00176d6ad3cd4sm68234plg.100.2022.09.26.19.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:15:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] checkpatch: Don't count URLs for "line too long"
Date:   Mon, 26 Sep 2022 19:15:17 -0700
Message-Id: <20220927021517.1952202-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; h=from:subject; bh=yAWd4XKJpk8MN/Q4+hlhqes0hfZgokxxQF/B9ZCPxYQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjMly1V6lhtN8KpibJqti2iNcZrBN+SYWizUVAwtDs wMDaqVGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzJctQAKCRCJcvTf3G3AJvJREA CHL57PNuX2NQlygSHCRoCfa3NmbQKAATGivmy7I4AFzHMHPmWLbU79rzZu6hI1gf9zyDTo2FkCAlJw flzzjJDMwKld5R80QnlWAE/ZZBRNQuPZJj9ssBZw3MxrJo3F4xYxD8b6wxRV79OMd5eQjHIpqDfQTp 2guFraPPnAaX97Aeb0K0BOW8RZeb9bzEOzgxspuWSfbZcLOu7qt7DAjz0mX2IgTlFROqGbVgMA3am9 Y1tr4235vHqD9aLyI6d6adnUENYPr0JhM0BGVj13cbVC8WcbTE7WSpIDA1WinSRisa3EoVcA5dQSDb 5+66mOsCFLFl9KFr8OHd18buaQ/Z2rrrg4ECx9GOtIm2R+6JIXd+gjUPHi7t1LfpNdrSSP0EKmwpiT sTGecnfYH2vwHE43fi3fMSwC1pi4dt8aDl71auBo0ghYLSLgY1s5l/xeAtJWIXv2kvfygDAZdtWLRA ql7pbX9m5XFDx1LnmZwUKimKNfC9y5U87RCqv1NsvVZIO3KxHuFSVqTPbpUf2XYKjY2GDpMIfS2Cy/ hEeEn5XYehN3wcCH212/lnRl6TZGuN+M/dPHbtypUKuihRvKnlqmWp1/4KxmP0U+eNr6w4IhvQr7IH GOhh5bqfhU9rPBistfMvHUjPBB+z5CzrYcabtLWos/w022259ewJqV2LQlxw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

URLs (not in a Link: field) should be ignored for "line too long"
warnings. Allow any line containing "https://" or "http://".

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..d4dec90673b7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3175,6 +3175,8 @@ sub process {
 					# file delta changes
 		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
 					# filename then :
+		      $line =~ /https?:\/\// ||
+					# URLs
 		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
 					# A Fixes: or Link: line or signature tag line
 		      $commit_log_possible_stack_dump)) {
-- 
2.34.1

