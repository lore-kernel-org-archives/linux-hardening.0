Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD917C56201
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396EB22227
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 16:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="D++SkNK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgKSQtb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:49:31 -0500
Received: from devianza.investici.org ([198.167.222.108]:63275 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgKSQtb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Nov 2020 11:49:31 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CcQd56kjNz6vNl;
        Thu, 19 Nov 2020 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605804569;
        bh=pRohe2wpPXolmMdvR/at0ovtLoyHsrhZfm/U2gcuOco=;
        h=From:To:Cc:Subject:Date:From;
        b=D++SkNK6pbJkyjcCEpXxxJmoOlYPtxe9TJQ+15OKO5FRadCs5Obh+N8VP7Y9EZqEf
         mmji3d3vAZywXZPrcnXxga2QUWTQ8YY4T8fIMQUSPjR+3ktGCjyn04Dm6RHawH4WaH
         t/UKJrXtP7TauplAOHpB4a6B0yXqHo44HiYEbbeg=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CcQd53QGhz6vNC;
        Thu, 19 Nov 2020 16:49:29 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     akpm@linux-foundation.org
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v6 0/5] Fortify strscpy()
Date:   Thu, 19 Nov 2020 17:49:10 +0100
Message-Id: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


I hope your families, friends and yourselves are fine.

This patch set answers to this issue:
https://github.com/KSPP/linux/issues/46

I based my modifications on top of two patches from Daniel Axtens which modify
calls to __builtin_object_size to ensure the true size of char * are returned
and not the surrounding structure size.

To sum up, in my first patch I implemented a fortified version of strscpy.
This new version ensures the following before calling vanilla strscpy:
1. There is no read overflow because either size is smaller than src length
or we shrink size to src length by calling fortified strnlen.
2. There is no write overflow because we either failed during compilation or at
runtime by checking that size is smaller than dest size.
The second patch brings a new file in LKDTM driver to test this new version.
The test ensures the fortified version still returns the same value as the
vanilla one while panic'ing when there is a write overflow.
The third just corrects some typos in LKDTM related file.

If you see any problem or way to improve the code, feel free to share it.


Best regards.

Daniel Axtens (2):
  string.h: detect intra-object overflow in fortified string functions
  lkdtm: tests for FORTIFY_SOURCE

Francis Laniel (3):
  string.h: Add FORTIFY coverage for strscpy()
  Add new file in LKDTM to test fortified strscpy.
  Correct wrong filenames in comment.

 drivers/misc/lkdtm/Makefile             |  1 +
 drivers/misc/lkdtm/bugs.c               | 50 +++++++++++++++
 drivers/misc/lkdtm/core.c               |  3 +
 drivers/misc/lkdtm/fortify.c            | 82 +++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h              | 19 +++---
 include/linux/string.h                  | 75 ++++++++++++++++++----
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 7 files changed, 213 insertions(+), 18 deletions(-)
 create mode 100644 drivers/misc/lkdtm/fortify.c

-- 
2.20.1

