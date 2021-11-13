Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C0C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 13 Nov 2021 21:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3864261157
	for <linux-hardening@archiver.kernel.org>; Sat, 13 Nov 2021 21:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhKMVjT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 13 Nov 2021 16:39:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234306AbhKMVjS (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 13 Nov 2021 16:39:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7261060E9B;
        Sat, 13 Nov 2021 21:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636839386;
        bh=kA00sl16Wz+fTC6dvTZqWvwDl/ATVl0hIrqyB5JqMFk=;
        h=Date:From:To:Cc:Subject:From;
        b=A93+fKM5P6uBMPwMaRoqlvg4KRPZ2DCcaVTYYKgu+sclJO3C28Yol0uTPimu+6Or5
         6LgBxJzM4raXLq57horkWAP5RPvbzfbxzCpXVaYwa7SJHUk/NvLtKdC4cZdeNa8Trl
         aPAhanUYpzZaOlkjRQkBplvySwBmaFVRC+rkUJ+n+IB+k9wluv+YqCcJJ9JE56qxMJ
         t5+un7Kf4Oeu2R5HxyOTU/FHnGeKDubYXe2Dfry2G16xv9a36QERbGnwRSkwssLoIp
         UnNmCGBVPhzsCa9rxbdjXAytR615qjZaQNPFT6xBxjaK3WZy1SuyUYUie/N/nHPG5I
         EtqmnsG6ceYIA==
Date:   Sat, 13 Nov 2021 15:41:25 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.16-rc1
Message-ID: <20211113214125.GA23640@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The following changes since commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea:

  Linux 5.15-rc7 (2021-10-25 11:30:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/enable-clang-fallthrough-5.16-rc1

for you to fetch changes up to 428a8bf629ecc118d1eadbb629312c25fde2103f:

  Makefile: Enable -Wimplicit-fallthrough for Clang (2021-11-13 15:24:33 -0600)

----------------------------------------------------------------
Enable -Wimplicit-fallthrough for Clang for 5.16-rc1

Hi Linus,

Please, pull the following patch that enables -Wimplicit-fallthrough
for Clang 14+, globally.

We had almost 40,000[1] of these issues for Clang in the beginning,
and now I think we are in good shape and it is now possible to enable
-Wimplicit-fallthrough for Clang, with this finally getting rid of
the unintentional fallthrough bug-class in the kernel, entirely. :)

I have to say that I'm sending this pull-request this late in the
merge window, intentionally. I first wated to make sure that no other
warning shows up before sending it.

This patch has been baking in linux-next for a couple of developement
cycles, now. So, I think we are pretty much ready to merge it into
mainline.

[1] https://github.com/KSPP/linux/issues/115

Thanks!

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      Makefile: Enable -Wimplicit-fallthrough for Clang

 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)
