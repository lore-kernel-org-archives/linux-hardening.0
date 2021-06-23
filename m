Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD2CC49EA5
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B22C611C9
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFWUmF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFWUmE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C00DC061574
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v7so2795892pgl.2
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2E/emdsJT4/hSnBDyJfRLo21OxhdAolWugWFwmcmlQ=;
        b=W3ln4OJoSgh2tDYaZAkeBL1277kPHbjLgQzh5jp2lHmXWXDid6pL7ifbY/8JMhqBnS
         E7ljjEw7rDNL3pcvx7ES8rXIbycmwc5DlSBciCnxaHzzXxCJZJrIjzcmCdgTP3ZMG3h1
         SvFAVic/oKTuJMlBmdCueWnPCoQBZ/kqG3otE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2E/emdsJT4/hSnBDyJfRLo21OxhdAolWugWFwmcmlQ=;
        b=PF7RGQvsJKhj7bLz/nxT2GG9ANfyKB+A0wSHz9w9scs5ZORwo3hRqWvK3lsuPr0Vzt
         3EQp8cIO4YeP4b5SRfqiQSJLOxQVaDNl5ad2jhfxSQP+F/kc31y+elH7YgJnm2+ZBAfg
         iGNlLxk7ACZboCp/dFZUxxfYNb9LTRZ48FHU0J3DM5DX1WBQMerxu4sRiPdWlb85DdOC
         4/QhTHjNiCY/0rsh0smj2vwuVGryJ1+aYW98sGxCGQ9dY6F+i3TyutnSqAtjyOVtue9y
         saO1rGv9yVnxrvok9JUWQOVS48tlNw6JbR3HAH6fxjBFQX0HulpVB6BXgml2moHPgyV5
         b8yQ==
X-Gm-Message-State: AOAM531G4vHVO5bLyzYw4k+H0Ym13qQ+GegTpKZ/i/iqAralqEzvhM9G
        9dHijxV2UuttI2UhK5GaBYmeLA==
X-Google-Smtp-Source: ABdhPJzu//ZPWLX4RFym3EWsld5xfBoKsgNiAcSmpIzhn3Zc80aAcR0fpGEdYQmR0b32cLTxprQFRw==
X-Received: by 2002:a63:d003:: with SMTP id z3mr1232630pgf.210.1624480786581;
        Wed, 23 Jun 2021 13:39:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c5sm5961432pjq.38.2021.06.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/9] selftests/lkdtm: Fix expected text for free poison
Date:   Wed, 23 Jun 2021 13:39:30 -0700
Message-Id: <20210623203936.3151093-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; h=from:subject; bh=7Z6rDIdXc6OEiqueR+KR4HSl76Pq0nn3txazVEELU2Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wG3Bu0QsJe7x2Dvq5gEv1AswiiPcQny5ntqUEu USMIUZuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBgAKCRCJcvTf3G3AJsYqEA C06Fjzuf/YFUDtqs9XGLBFg8ytEwa9LuoVTEzEvqPRHMjLXpPtx0U+WDGizzYfKlE9cFl1/pMdd05j Wqbj0N7UjHFWwa0qWFNGrMl0TnxkVFLZfK0ATu8aHMg6WAaZeSIBkijJHxpo5Oucnw5eDyiMn+eaGC Ht8s39AluGZ9uMqV0Ra2HIUaMimP7PnwM71FZXQ0OT+HxNtj4uL3gQuImuMfFRr5eaUsFDRVMHbsDL SOQXpMm34N/lycRcZvd8dRinj3+tA+TMBrv9pydRg6n3Qgm/FBD0Te8TnASKtt2RedQpsuj72Ho+Fe 4Lxv2yQ7inHYJbkrl9GAYOEDY1W7zQOj6yYUgutI6/919Zt3bs0Ml6CYaGCAtuu3evX9uhSdvR1ZPt NvglZf1dMNUGJZ3qeib24mKTek1QAcTJzvswlV+JxLBaCxAFtvMelCA7re6G/OO/84EEg4yKGtJxEp VmAjYgmqw3ZJbfB9PBCNgi89vQuhA85JuyGLqta9lTeu1U76SWF2IdUCctfcGnAAlcVtMBGLwiYPN5 Ajj52D8lA1Mcl9Wa0N98/YLkIynMA9A5evXOM/0x1WQ8C2gnVipNq6pk4+u1OvkX2Kf7XOzp4+lVqO Ap6O16W38xSAf6o1xen1nRrRpc1Um5d/6PNVEObh//+D2Moh51HKm+vbrBCg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Freed memory poisoning can be tested a few ways, so update the expected
text to reflect the non-Oopsing alternative.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/tests.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index a5fce7fd4520..a94d4d8eeb5c 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -17,9 +17,9 @@ CORRUPT_PAC
 UNALIGNED_LOAD_STORE_WRITE
 #OVERWRITE_ALLOCATION Corrupts memory on failure
 #WRITE_AFTER_FREE Corrupts memory on failure
-READ_AFTER_FREE
+READ_AFTER_FREE call trace:|Memory correctly poisoned
 #WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
-READ_BUDDY_AFTER_FREE
+READ_BUDDY_AFTER_FREE call trace:|Memory correctly poisoned
 SLAB_FREE_DOUBLE
 SLAB_FREE_CROSS
 SLAB_FREE_PAGE
-- 
2.30.2

