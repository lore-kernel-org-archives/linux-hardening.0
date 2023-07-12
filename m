Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8A9EB64DD
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jul 2023 16:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjGLQYf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjGLQYG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jul 2023 12:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712081FDE
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 09:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF0F6183B
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 16:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF741C433C8;
        Wed, 12 Jul 2023 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689179020;
        bh=xN+Ptodba6sw5zR9RG++Zd/Hx+r1BWcWHPr1uq59BoI=;
        h=From:To:Cc:Subject:Date:From;
        b=uxqAsOKcNNNwKSvZGisd8tvx67IyEM6ref7rOpp2ceg5eeZu5SDI0DJ7zeV8Pzqx6
         E+l+ZyNev5ok65ntbTetgiTgK1g+bpMOosDSlW17AfDdcrps5fBhhvHIw8rui5p3K4
         wU8TuksV1vNElG2mTg7WYfO19zMU3OWWHtfrbvwE8nSEgU3HQpnv83iffB4AJfbihG
         jimcvwsCAQKtoFPwspJdZuaJeWUZjMUrUKK4ouMIMkVTil/x+L5JzkuYj1lTe2LLLZ
         gI8gS9+n9lTIYSZi+Cbqf6WMEsvO43vSu9rXUgQxnf3a3SRkNJPkvDGXIlRI+uUdQT
         qrE7dSPawCWHw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 0/2] pstore: Replace crypto API compression with zlib calls
Date:   Wed, 12 Jul 2023 18:23:30 +0200
Message-Id: <20230712162332.2670437-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=ardb@kernel.org; h=from:subject; bh=xN+Ptodba6sw5zR9RG++Zd/Hx+r1BWcWHPr1uq59BoI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWXd5cbJW9sXr+ldt/dB7067ib9O/JL1W9TE4/riSlb7y RVp3soHOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEvsxh+MNluPjmwtaDh/z2 OUofm7a+POustYXtlilBj7+Jzm5rZNrByPBa9NbzJzOLzl+NFDu05kSpaHN6/MUfcQ/3d+9+yXW FiYcPAA==
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

Changes since v2:
- some more prose improvements and NULL checks/assignments suggested by
  Eric
- reset author on patch #1
- add Guilherme's Tested-by

Changes since v1:
- add missing vfree() of zlib compression workspace
- implement improvements and simplifications suggested by Eric
- add missing zlib_in/deflateEnd() calls
- add code comment to document that the use of a library interface is
  deliberate, and doesn't require a future 'upgrade' to the crypto API

Cc: Kees Cook <keescook@chromium.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Eric Biggers <ebiggers@kernel.org>

Ard Biesheuvel (2):
  pstore: Remove worst-case compression size logic
  pstore: Replace crypto API compression with zlib_deflate library calls

 fs/pstore/Kconfig    | 100 +-----
 fs/pstore/platform.c | 330 ++++++--------------
 2 files changed, 110 insertions(+), 320 deletions(-)

-- 
2.39.2

