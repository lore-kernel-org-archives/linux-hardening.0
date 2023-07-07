Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41514EB64D9
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Jul 2023 08:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGGIfK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjGGIfD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jul 2023 04:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D85113
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 01:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D78618D6
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 08:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64BCC433D9;
        Fri,  7 Jul 2023 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688718901;
        bh=IEyxOI0bcXBOdslO5Uw70qZyWx9lThMQo9lrBduhcDc=;
        h=From:To:Cc:Subject:Date:From;
        b=pRsxyrClHOW+ML1+SrM0BdCN7F58oOUidOKSftvGcnOcL3Md5oGDVE0OGi7a6JLX+
         Tz2W1jeR4fv7pFdTG62/+rvnu3H7FiZNpSTsrIqiqsJRV+XiaQWS4OGbyo6cgkCZye
         QvMm4emhTBVAn5RnJm8oEvZP5azlvIHRSLJW61YAU82WbYglTxWEXhkDgKzJAo4sed
         6Up9ir2h026Y86wEzPJ1XGo9oiY9KDbVbxS7SqD1lX7lxmpJqiwgNwJ0Ux1+Lug2iJ
         BWAqJj/DbnDBKb0o5NHn3fe2G8PhHe+7DRjYd/q6tontwjT61c6kbaW+/mv3sZxWLG
         M50uc8KKRwt4g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/2] pstore: Replace crypto API compression with zlib calls
Date:   Fri,  7 Jul 2023 10:34:54 +0200
Message-Id: <20230707083456.2501913-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=ardb@kernel.org; h=from:subject; bh=IEyxOI0bcXBOdslO5Uw70qZyWx9lThMQo9lrBduhcDc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWX5OZ2iTd0Fn+KzntpxmQT4przsnfGirDvLODxy5XW7U zp+7h0dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCLO+xn+x8TP//P/9eGSa/qX u8Rz9KPyWMr2sS9uO6u1+sGnoCimg4wM358+dPdbYPni913Lbttnq+JuMy7StVl2Zi7n9MXbr/I X8gIA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The pstore layer implements support for compression of kernel log
output, using a variety of compression algorithms provided by the
[deprecated] crypto API 'comp' interface.

This appears to have been somebody's pet project rather than a solution
to a real problem: the original deflate compression is reasonably fast,
compresses well and is comparatively small in terms of code footprint,
and so the flexibility that the crypto API integration provides does
little more than complicate the code for no reason.

So let's get rid of this complexity, and switch back to zlib deflate
using the library interface.

Changes since v1:
- add missing vfree() of zlib compression workspace
- implement improvements and simplifications suggested by Eric
- add missing zlib_in/deflateEnd() calls
- add code comment to document that the use of a library interface is
  deliberate, and doesn't require a future 'upgrade' to the crypto API

Cc: Kees Cook <keescook@chromium.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Eric Biggers <ebiggers@kernel.org>

Ard Biesheuvel (1):
  pstore: Replace crypto API compression with zlib_deflate library calls

Kees Cook (1):
  pstore: Remove worst-case compression size logic

 fs/pstore/Kconfig    | 100 +-----
 fs/pstore/platform.c | 321 ++++++--------------
 2 files changed, 101 insertions(+), 320 deletions(-)

-- 
2.39.2

