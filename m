Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7759FC4338F
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jul 2021 15:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5239F61B6F
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jul 2021 15:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhG0Ptm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jul 2021 11:49:42 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:57683 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG0Ptm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jul 2021 11:49:42 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2021 11:49:42 EDT
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-08.nifty.com with ESMTP id 16RFeZYK016056
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jul 2021 00:40:36 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 16RFdQxD020251;
        Wed, 28 Jul 2021 00:39:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 16RFdQxD020251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627400367;
        bh=3zPhroot46RHejpnFDk8fLbgEyTZ7afbXGsRLNI8Ohk=;
        h=From:To:Cc:Subject:Date:From;
        b=BRgdn7+9lc9pcKUYJl2vRPStgOkd5C73s28FmSUcJ4VPzrti52wI0nHAflZhN6bia
         8Y7fPgV06rKYJgAIgWgR+fHNGhCK+zJ21NIjtQZCh42Lte2w/+kYYk22FgRMS7WPQR
         M/iVl8gM/Huh3nj2mleoB80TUXACvdVjJKIjursLa2HCg/ZNeVL5QgGwQdEwdcUCZT
         Y6WJ87rHXJa5/f1eE5Egh5lj1sEieDROFgHQXY+gLWnXtFuKhka//Azf2BQAIhJsxD
         jrvQjeSjsBnAoFm2ytEyEM8fJy3hK6TRFMl7tZ8E0+DXMNYekeb+zhHPaFSOb+xy/n
         2OzKdj2FJhmJw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] scripts: make some scripts executable
Date:   Wed, 28 Jul 2021 00:39:24 +0900
Message-Id: <20210727153924.79473-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Set the x bit to some scripts to make them directly executable.

Especially, scripts/checkdeclares.pl is not hooked by anyone.
It should be executable since it is tedious to type
'perl scripts/checkdeclares.pl'.

The original patch [1] set the x bit properly, but it was lost when
it was merged as commit 21917bded72c ("scripts: a new script for
checking duplicate struct declaration").

[1] https://lore.kernel.org/lkml/20210401110943.1010796-1-wanjiabing@vivo.com/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/checkdeclares.pl               | 0
 scripts/gcc-plugins/gen-random-seed.sh | 0
 scripts/syscallnr.sh                   | 0
 scripts/xen-hypercalls.sh              | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 scripts/checkdeclares.pl
 mode change 100644 => 100755 scripts/gcc-plugins/gen-random-seed.sh
 mode change 100644 => 100755 scripts/syscallnr.sh
 mode change 100644 => 100755 scripts/xen-hypercalls.sh

diff --git a/scripts/checkdeclares.pl b/scripts/checkdeclares.pl
old mode 100644
new mode 100755
diff --git a/scripts/gcc-plugins/gen-random-seed.sh b/scripts/gcc-plugins/gen-random-seed.sh
old mode 100644
new mode 100755
diff --git a/scripts/syscallnr.sh b/scripts/syscallnr.sh
old mode 100644
new mode 100755
diff --git a/scripts/xen-hypercalls.sh b/scripts/xen-hypercalls.sh
old mode 100644
new mode 100755
-- 
2.27.0

