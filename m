Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC4EC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 16:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EF16112E
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 16:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhINQii (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 12:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhINQib (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 12:38:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD12F60FD7;
        Tue, 14 Sep 2021 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631637434;
        bh=UAcYLB+NEUWJXtqSiE8P3i+7GLJn9hsz9hqFty/Uc0g=;
        h=Date:From:To:Cc:Subject:From;
        b=f18CaMqaWCA6mI5EuEpru5Amvr6VzYDlVPu58O+SJMc4jAhz8U/tjoDfBLlvVz0cH
         YGyOiFOm3G9SE9oKZiKKvwf+6rmo3QV985HzIiisd2P+qN3804gwSxL00qWwmbVCMI
         l1gstKRl8tiiPwVAoTbZc6Hut2viVfdtrJo3M68DxCHL7fxCdEibzOO/fPbCJf75U7
         YTd7luKmFOgJIf/NBFGnbw9fZVnuo0py2fvlqkf18NqEfPps6H371ObuJzh6UQR7qy
         yLUjF1OodXJqIAyZE0wcw9VBlb1S+Xyi/JFU+SJ8QI/lb5tQicXxlAoRI7DN9h4BA4
         67+DHHVS5LPdg==
Date:   Tue, 14 Sep 2021 11:41:00 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.15-rc2
Message-ID: <20210914164100.GA236780@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/implicit-fallthrough-clang-5.15-rc2

for you to fetch changes up to 236378bb6ca791cbde68eacedd7688084d06177e:

  Makefile: Enable -Wimplicit-fallthrough for Clang (2021-09-13 23:47:12 -0500)

----------------------------------------------------------------
Enable -Wimplicit-fallthrough for Clang for 5.15-rc2

Hi Linus,

Please, pull the following patches that fix the last warnings in
x86_64, ARM and MIPS reported by kernel test robot, and enables
-Wimplicit-fallthrough for Clang 14+, globally.

We had almost 40,000[1] of these issues for Clang in the beginning,
and there might be a couple more out there when building some
architectures with certain configurations. However, with the
recent fixes, I think we are in good shape and it is now possible
to enable -Wimplicit-fallthrough for Clang, with this finally getting rid of
the unintentional fallthrough bug-class in the kernel, entirely. :)

[1] https://github.com/KSPP/linux/issues/115

Thanks!

----------------------------------------------------------------
Gustavo A. R. Silva (4):
      scsi: st: Fix fall-through warning for Clang
      MIPS: Fix fall-through warnings for Clang
      pcmcia: db1xxx_ss: Fix fall-through warning for Clang
      Makefile: Enable -Wimplicit-fallthrough for Clang

 Makefile                             | 8 ++++++++
 arch/mips/alchemy/devboards/db1550.c | 1 +
 arch/mips/kernel/uprobes.c           | 1 +
 drivers/pcmcia/db1xxx_ss.c           | 1 +
 drivers/scsi/st.c                    | 1 +
 5 files changed, 12 insertions(+)
