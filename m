Return-Path: <SRS0=98sU=D4=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587DC55178
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFAC20BED
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 15:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="HimXdg1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443998AbgJUPGU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:06:20 -0400
Received: from confino.investici.org ([212.103.72.250]:61279 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443805AbgJUPGU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Oct 2020 11:06:20 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CGYjQ51Lbz12jp;
        Wed, 21 Oct 2020 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603292778;
        bh=vQrou17stUEld/BUfbvXuI1P9LzkeqbTmTUXyXLpM1E=;
        h=From:To:Cc:Subject:Date:From;
        b=HimXdg1OW5HuQvWLdR00gIjLDEzHR610o3MHwWpS1VWooIwr+99k/GBpF0W0XgbST
         wlyoGal95zStrWtsNkoQqgh8hlNlICmVxZ6BXq4sbxa8pd3SAoXL6Oamjk+0UCIGc5
         ZfpBmOC1/Mg7xvNL/8jeXuCdrjoTuo/NVzp5//KI=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CGYjQ42ztz12jm;
        Wed, 21 Oct 2020 15:06:18 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     dja@axtens.net, Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC][PATCH v3 0/5] Fortify string function strscpy
Date:   Wed, 21 Oct 2020 17:06:03 +0200
Message-Id: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
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
  Fortify string function strscpy.
  Add new file in LKDTM to test fortified strscpy.
  Correct wrong filenames in comment.

 drivers/misc/lkdtm/Makefile             |  1 +
 drivers/misc/lkdtm/bugs.c               | 50 +++++++++++++++++++
 drivers/misc/lkdtm/core.c               |  3 ++
 drivers/misc/lkdtm/fortify.c            | 47 ++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h              | 19 +++++---
 include/linux/string.h                  | 65 ++++++++++++++++++++-----
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 7 files changed, 168 insertions(+), 18 deletions(-)
 create mode 100644 drivers/misc/lkdtm/fortify.c

-- 
2.20.1

