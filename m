Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E1C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 20:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJKUBV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJKUBT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 16:01:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFECA98C9C
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 13:01:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d24so14245031pls.4
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ1cTQd85nGrkiImwfDDDaCgLcX1vPdneNcSSjPtuw4=;
        b=BVGjn2RX1vwV26pt5fborATzz7xULiVhsekVt/LIt94o4wLJIsx77762Y7mc1OrhCN
         oDVoMZNP023tOv20o7HyeCbLZuXFZppnitlG2S+kpMrN483O66RB6I6hgvvBeabTJxKf
         jZ4x6fc/u2sImJN5n1csIbTdZFazaHqnY0olQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJ1cTQd85nGrkiImwfDDDaCgLcX1vPdneNcSSjPtuw4=;
        b=6mY2bPdWFzOnmVEkUb1HwOx4n4KVGhx/o67bsR/Y28ATYGXdoafRjaIJQUylJ36YsU
         FDRbCZKYmA+aFEyJtnqDsI5b8vCq/D2dP9KJIjsxh4CenAXBysQjWo+pfG3uUiPWqBN2
         H99INDIDJE6lfEvG2yz4XfYAorBi/m7dUJ/xo3xgUh37B3P049Mw2p/iIJ0rA5B3BvZi
         c5933FBSeisFE24Pn6avo12HQZZFCGHTyhuq/8hUqNEbji1PGt+Q6S+IFifZq1z4Cxii
         aNpjzwwvu0r3on2H2Gfl5zZUrj9mDlXNCIPylg4H7fY0ZGPH8WG9oaEm1ejQ7VGAb1O5
         Mhrg==
X-Gm-Message-State: ACrzQf346dO05uKjxun1h1SAKWOtAYtU9XSYlBASEwIIn/Y1EdgZN6hf
        RYwmAgedxGYfhF6zsMDqUuV6wQ==
X-Google-Smtp-Source: AMsMyM7bNlk/PmiqnIeaO05aAnLq+IGIZ6viTuKMoXOapYUbjgcQ8VTCjPKv64bc0KujVDixnknvGA==
X-Received: by 2002:a17:90b:4f87:b0:20b:12e3:32ae with SMTP id qe7-20020a17090b4f8700b0020b12e332aemr936883pjb.236.1665518477150;
        Tue, 11 Oct 2022 13:01:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x10-20020aa7940a000000b005636326fdbfsm4558354pfo.78.2022.10.11.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:01:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Paramjit Oberoi <pso@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pstore/ram: Move pmsg init earlier
Date:   Tue, 11 Oct 2022 13:01:09 -0700
Message-Id: <20221011200112.731334-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011200112.731334-1-keescook@chromium.org>
References: <20221011200112.731334-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; h=from:subject; bh=+g4u4+FgFgWBu1b7+yVjjcuGsr5BOPWcLxgo6xJciQY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRcuHdD1swiD0rif+92sRKU5/B6CGuM5Tcos5JPsY OyYA06CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0XLhwAKCRCJcvTf3G3AJo0GEA CENH1RQrmHnVrohHRJbkzORcy0wObSDY8g8FV/evLgRSDX+sFTEoeOxyaLttsJquZ1PK71cUn0HlqO 5+2GMB8d+HqfusuYY0hsR9nJsJBjoKzfQL/RjVC1niQA4Mg9612+FGsC/SdnwSbKjWQ2BJcUC3efbu o87VHKyV929j9cnjYWpJ+PkxqhLiuXFQ9B3lFBcZMsRPDA3AKdloD+IK1Vkvd3FdigxDzjN9JyHSRB gD+8Xh8FwGrxl0BsHCH4HrmNjGlptWaYNqMNw+yP7paqf6pSP5eugeKhrSC742yZUVbWrIbELJvl1E SubVqvlpnWY8sPM24OShDCGYcyPw5hTaXmPQa4YKBy+RKRpD/08qxFefCzr06GE1Hgbhaa92BdYabc hb+7G3PthvvasGOiAeu/PhXT7fiebdtFD7oUi8QT8aRutW2bvI50zbxYOIeSg/JA4BUXYcNdqhda0R a4d9PlkQO0Xkia3eMfShZsD14gKDiIkpTk1y0GGN9hacFYFcmz6Q3x7ZOzSG5+rzVB0ua9mZWCmzj1 uxD2GjM+dTHYObRxJtDngjUEobBr7pNnwc0yr0ailvDsaoEmH1BuG5fQwUyDcqPzzMTOuz0HZU+RBc /F2Du9XOv0WL4NKmtk2CIJjgoCh2cgNn4fh26ughQ8FmQg8ADTRFqPxFswZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Since the ftrace area can vary in size based on CPU count, move pmsg
initialization earlier so it will have a stable location.

Suggested-by: Paramjit Oberoi <pso@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 348820a3ce88..2f18563c8141 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -785,6 +785,11 @@ static int ramoops_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_init;
 
+	err = ramoops_init_prz("pmsg", dev, cxt, &cxt->mprz, &paddr,
+				cxt->pmsg_size, 0);
+	if (err)
+		goto fail_init;
+
 	cxt->max_ftrace_cnt = (cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)
 				? nr_cpu_ids
 				: 1;
@@ -796,11 +801,6 @@ static int ramoops_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_init;
 
-	err = ramoops_init_prz("pmsg", dev, cxt, &cxt->mprz, &paddr,
-				cxt->pmsg_size, 0);
-	if (err)
-		goto fail_init;
-
 	cxt->pstore.data = cxt;
 	/*
 	 * Prepare frontend flags based on which areas are initialized.
-- 
2.34.1

