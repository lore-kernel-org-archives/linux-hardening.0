Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF5C4338F
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 04:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB41B61100
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 04:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhHSECs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Aug 2021 00:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHSECs (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Aug 2021 00:02:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 299D3610FA;
        Thu, 19 Aug 2021 04:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629345732;
        bh=cKPPsaEGpLp6LZgL6DO1Tbd1NxBMQ6XwrR2IwGuwMPs=;
        h=Date:From:To:Cc:Subject:From;
        b=LEU8viFGQvLs9Mrjnr4T5maIaz8uRZnEdPs7ViZPl2lEsDMD8sPpT+DJg+lkJttuD
         6gegwzKxXQPFmlEznhBBqnCdRXIuJ78ZlS5go+HudsdPlSr80VHdnJsoT6z2vPj9gx
         l8p+rP44M2+6+uTIr9zyVtoUvg66G+f3LXEV6FsdPdR16Y/4Rz/U3YL5jf6MifPIUP
         wkjCTj0spJDlhYD083f8mRMALhLODc/wJjVSzM9cTXlI2bDX6Mgu537eSjLrSowzMy
         kID1Y6k4rSiLScd0LgeyhvGZgBej0Sny1PtBD7Z4L/iFh/tM1pdFusplqhTIcK0FU+
         oTuDSX9Jw2pDQ==
Date:   Wed, 18 Aug 2021 23:05:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.14-rc7
Message-ID: <20210819040517.GA329693@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/implicit-fallthrough-clang-5.14-rc7

for you to fetch changes up to 7bc04ce6b914a06d5823509d1de237787c58e649:

  Makefile: Enable -Wimplicit-fallthrough for Clang (2021-08-18 16:46:44 -0500)

----------------------------------------------------------------
Enable -Wimplicit-fallthrough for Clang for 5.14-rc7

Hi Linus,

Please, pull the following patch that enables -Wimplicit-fallthrough
for Clang 14+, globally.

We had almost 40,000[1] of these issues for Clang in the beginning,
and there might be a couple more out there when building some
architectures with certain configurations. However, with the
recent fixes I think we are in good shape and it is now possible
to enable -Wimplicit-fallthrough for Clang. :)

[1] https://github.com/KSPP/linux/issues/115

Thanks!

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      Makefile: Enable -Wimplicit-fallthrough for Clang

 Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
