Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AEAC433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 22:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbhLMWd6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbhLMWdt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:49 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338BC061B38
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 14:33:42 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id m15so15759461pgu.11
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YgyvWs4tutxnDqYTDwetVnj46UWWmfeOWxYILXaAup0=;
        b=BRTae51MNdlzeOXGolcubKnnxqAyhmg5T0xoqLLnYhBfIze5+8aAhoroEF/XZj6XyB
         R9iIX5oHU6zyfZydXe4CzbEhKJVu0dD3Z19NaSVafwfREWiRWFm8T4ZzwlTwbQ5DC/Tx
         FWC3mT+F4zi+QoNHc6AEz35rthtOT/8NSK6Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YgyvWs4tutxnDqYTDwetVnj46UWWmfeOWxYILXaAup0=;
        b=nVAbOqWDBXVJqvZrBX9LK+zrsWweX5eHoGg/DsmBtpVklHs6NhX6oKMrouq6TnLmIY
         40Dt9GqRXVZiC3Z58MeUfZKcr9amu+n/ZPZ3PfGGI8HGwO2Ycuy+/wVHC5WzY0FcJQyE
         JJkVjKwO/gxVQaATMa/fkaaAjMU9xlhLMjqRPleh5chscCJIt7k2D3n1dBaygoUsktVp
         S5OxeAYoP84ceYBZdYx5Fx8itnjAFmjcMY6Ho/ZFXcAh4F4bzXegYCWsCJNy9UFsvG1d
         8LnqF5d2wcdhWMlnfZDBgNmxx0XdeKq36F9trGCPBIfgIwMklv0c4fIXtpnaWFh4frws
         dLSQ==
X-Gm-Message-State: AOAM530IYjjdCcF4/zGYaLA9SFlkfZgEvcZodLeHYyFR/hgTMZa71bE8
        J0SRbjBXvB25l6hWKEWifr8DGg==
X-Google-Smtp-Source: ABdhPJxfs3G9SgBQOpvzNbbUSr07IB+8a2RoV0KOBCY/VV1CteSYlQSlFhfsGXdWAr8ufph1XIWCaA==
X-Received: by 2002:a63:62c6:: with SMTP id w189mr999201pgb.343.1639434821587;
        Mon, 13 Dec 2021 14:33:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z14sm14106178pfh.60.2021.12.13.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] dm integrity: Use struct_group() to zero struct journal_sector
Date:   Mon, 13 Dec 2021 14:33:25 -0800
Message-Id: <20211213223331.135412-12-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; h=from:subject; bh=Rw8elaX7lzkqZjVeNdewcjpE1pz4Up9kM2UagQ4QfoI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o5l4H+ZB5qLvrKCuFHRRdblpiRo+kyACzvwRjU NJG7MUGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOQAKCRCJcvTf3G3AJqt0D/ 442RCWEfLc/vdJO62YkZXZbB86UYpqLs4jsfmJVAEkx1bNVEloZiAif7Bt2t0ZojDaapmU1VefQTo7 Nw8zpBk0JkOinnr7PMRoZFA+4ML3GD26IoHkkdmlHmazoirzWVZ3a0RWyjcvCzTcP2ui9K5q0alwjD E4lxTnUnuQD12YR4FgxJz5UR5WmfJT5cd4WTsMoxrSunwkZNA+D0OXTMq706Ppu4IEVAZ74udYWRHB dhhLIp1ijQnkGMm9KeGcSo7sOlPRFB5/43T5jOoB9GoEtHQzdbzFxY+0bSP1yXaUBrUOfih2VmW0Qb kalL/o7vrD84bAzd920phPCmSWnpHQlBvDSB7u5XYNp6Zs0EnRYIJV2z+g1o0zceEaNrVbhsjq1Loi Hv+9VoUrujn/5n5FHRvrUPgdnkf+HnvVKxc+8rnXSqdMsJoTXU7yz/doAH2x93ac2mLbiVRxA2rvQo GoFGSJ4zQeFfGlCSKOeQo17UKOZsAA5YF41J8GR54McDg3k3EetgUanJlz04P/YER31qTj7Hu1zClU btgXZRyAgJM0pkdxgfIlUnxeOtXqWGujlwnrUJbdXq+7mI8xxY66kN7E0EHcsVFzCFnUd0jduTxh5S ASm+fSppb3CWwxajeVgI9wPDZj68zHa20Mo3ugrQOBPXoL2jeZidn2EqzDBA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark region of struct journal_sector that should be
initialized to zero.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-integrity.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 6319deccbe09..163c94ca4e5c 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -121,8 +121,10 @@ struct journal_entry {
 #define JOURNAL_MAC_SIZE		(JOURNAL_MAC_PER_SECTOR * JOURNAL_BLOCK_SECTORS)
 
 struct journal_sector {
-	__u8 entries[JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR];
-	__u8 mac[JOURNAL_MAC_PER_SECTOR];
+	struct_group(sectors,
+		__u8 entries[JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR];
+		__u8 mac[JOURNAL_MAC_PER_SECTOR];
+	);
 	commit_id_t commit_id;
 };
 
@@ -2870,7 +2872,8 @@ static void init_journal(struct dm_integrity_c *ic, unsigned start_section,
 		wraparound_section(ic, &i);
 		for (j = 0; j < ic->journal_section_sectors; j++) {
 			struct journal_sector *js = access_journal(ic, i, j);
-			memset(&js->entries, 0, JOURNAL_SECTOR_DATA);
+			BUILD_BUG_ON(sizeof(js->sectors) != JOURNAL_SECTOR_DATA);
+			memset(&js->sectors, 0, sizeof(js->sectors));
 			js->commit_id = dm_integrity_commit_id(ic, i, j, commit_seq);
 		}
 		for (j = 0; j < ic->journal_section_entries; j++) {
-- 
2.30.2

