Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919AC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Nov 2021 01:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E28E61077
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Nov 2021 01:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhKOBLM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 14 Nov 2021 20:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhKOBLF (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 14 Nov 2021 20:11:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1893261077;
        Mon, 15 Nov 2021 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636938490;
        bh=SGPyHKvcUXM3KqJN65/6F5Fnr0nYxnSm265J17My0h4=;
        h=Date:From:To:Cc:Subject:From;
        b=WaM2gn8fLJIAC5QoFSn2e/3WjK44EB1qpG9ezoXY7S1KMQFWByj6L0Wq1WAWsB3fQ
         ADxVQsO/Rt3s06lM3si0XFYOStbvcP7nJfByP8PB868WxlYdz4jfTsOSiI8+UwASbH
         jkDu6aBa1bLDfc9npYHMYDRD6bEamyMPxf+un+WbEKip4bToiC63BMcx+UYRZp8TI2
         QjkMKH1G8yCGpMHpvohcgyCEEqqlLnEjGZ+CKctNGvB0fr53HyCfYnIfmv4WNOnz+M
         sN3XVNGthY9/ePgxeNXFDdpK91QpduTzQnR0jE4AfsWGXuuUO9qbwpcKRb9fjYTgIu
         VDc0N8G0j2pzA==
Date:   Sun, 14 Nov 2021 19:13:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] kbuild: Fix -Wimplicit-fallthrough=5 error for GCC 5.x and
 6.x
Message-ID: <20211115011313.GA43897@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

-Wimplicit-fallthrough=5 was under cc-option because it was only
available in GCC 7.x and newer so the build is now broken for GCC 5.x
and 6.x:

gcc: error: unrecognized command line option '-Wimplicit-fallthrough=5';
did you mean '-Wno-fallthrough'?

Fix this by moving -Wimplicit-fallthrough=5 under cc-option.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Co-developed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 036b750e8d8a..85882c317235 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -887,7 +887,7 @@ config CC_HAS_INT128
 
 config CC_IMPLICIT_FALLTHROUGH
 	string
-	default "-Wimplicit-fallthrough=5" if CC_IS_GCC
+	default "-Wimplicit-fallthrough=5" if $(cc-option,-Wimplicit-fallthrough=5)
 	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
 
 #
-- 
2.27.0

