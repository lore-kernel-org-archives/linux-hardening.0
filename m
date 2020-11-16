Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8AC4742C
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Nov 2020 14:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D5022447
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Nov 2020 14:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="ui5VeM3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgKPOue (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:50:34 -0500
Received: from devianza.investici.org ([198.167.222.108]:48623 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbgKPOue (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Nov 2020 09:50:34 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CZX7D26zVz6vMY;
        Mon, 16 Nov 2020 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605538232;
        bh=a3zHnvJB+r9RNfl3DPAO+0or0w/wLRTHPn7ivbVch2A=;
        h=From:To:Cc:Subject:Date:From;
        b=ui5VeM3Ozn/pDam7YaF5bUK+yg+xdRdP9YCuG0ktRR9TW/AHTDiQHvWzF16Ms69ru
         9NZKgkzAmpOzlWCIoc6rzLT3LiVLweJLhcURPWTVGcdkpvwMk6JKwFUm1UQJt49kdZ
         QHbDjYMXcokJmTmVOBCGc2Zf2sJxEJm0NijIhf6Y=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CZX7C73b2z6vMX;
        Mon, 16 Nov 2020 14:50:31 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     dja@axtens.net, keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC PATCH v4 0/5] Fortify strscpy()
Date:   Mon, 16 Nov 2020 15:50:07 +0100
Message-Id: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
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
1. There is no read overflow because we either size is smaller than src length
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

