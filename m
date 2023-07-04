Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E6DEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 13:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGDNw2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDNw1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 09:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC36FBE
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 06:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A0716123C
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 13:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC717C433C8;
        Tue,  4 Jul 2023 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688478745;
        bh=ym66uhLczvnzychJy9bNcQL6WUWzycdJ5ZeI6bTwjUY=;
        h=From:To:Cc:Subject:Date:From;
        b=t4T+uYnZs/F+YvJb28b907tfS07+mkMHYFSz8HcWZg8V58WChmwzYDyghqH7uf7Gc
         19l/qy3RVjyRf0M3oX3O2YTnnPAlO8aaKlBTmTfi3ckn4iWPaRr0RhvZoPnsrKtUir
         GvuDZH6sbyb2bDCjuT0b59zAUo5Pk3ejDfbwm4M1XILhU1NJphZ6zTOb9QkXQsYYZr
         98yvjn7BJ5ZeaLS0gmzSCB0MxQtKu8om2hP03zGNKgYktu+JloGeqh7YnmR2LCJZwB
         pX8wteYZrUwjiyj14tTO/BuLmn1tDfSF3XV232rZCe4HW6XTptdWhz/D91fh8BTOOh
         LvLKu55mxMGog==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 0/2] pstore: Replace crypto API compression with zlib calls
Date:   Tue,  4 Jul 2023 15:52:09 +0200
Message-Id: <20230704135211.2471371-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=ardb@kernel.org; h=from:subject; bh=ym66uhLczvnzychJy9bNcQL6WUWzycdJ5ZeI6bTwjUY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWJCoe05ZktJ1ffuHG688mBR5urntk9SXOwNNQ7E/Qpd CaP4R/djlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR/TxGho5fc/Z73urMEtns sOR5c6OaaUQzzzNG3b1zo28t9Ps50Z7hr2wnm/wO63Uhb/e7PzwcxLQut3cNr8buZW4Ht2k0Rl4 JYgUA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The pstore layer implements support for compression of kernel log
output, using a variety of compressions algorithms provided by the
[deprecated] crypto API 'comp' interface.

This appears to have been somebody's pet project rather than a solution
to a real problem: the original deflate compression is reasonably fast,
compressed well and is comparatively small in terms of code footprint,
and so the flexibility that the crypto API integration provides does
little more than complicate the code for no reason.

So let's get rid of this complexity, and switch back to zlib deflate
using the library interface.

Cc: Kees Cook <keescook@chromium.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

Ard Biesheuvel (1):
  pstore: Replace crypto API compression with zlib_deflate library calls

Kees Cook (1):
  pstore: Remove worst-case compression size logic

 fs/pstore/Kconfig    | 100 +-------
 fs/pstore/platform.c | 249 +++++---------------
 2 files changed, 72 insertions(+), 277 deletions(-)

-- 
2.39.2

