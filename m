Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88855C64ED6
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Feb 2023 22:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjBWWXu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Feb 2023 17:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWWXu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Feb 2023 17:23:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3F14208;
        Thu, 23 Feb 2023 14:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4F33617AB;
        Thu, 23 Feb 2023 22:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66A8C433EF;
        Thu, 23 Feb 2023 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677191028;
        bh=Fol8hNvH87YYIF1bZR/i5khr1RuizrUI3aldcifhpdo=;
        h=Date:From:To:Cc:Subject:From;
        b=KlZ4KxorGS+Tmv4YDi68lA4C7GenBJGAldBLipR+XVJ+TdU0ThBXzflYyNrY6xxIQ
         b7cQ+STaqzkGVaEsnx1j+ycXkWXj0+CrV1cHmiTEWDwVUsrQhzYliNgZgxYqpWyACj
         U0WYnPsGNwgGZAPJYSye/Qz8V8VEemCB6flLvhnna9vsY4nPjtWEwGwW3gki1avqYK
         v8pgnh3UKBba7DGwYDKadKxMvlG8zkZCLuizcb9P2kvsHYmSSldqJ4mmyXTz3FdQaX
         83mV6xnjW2+EE2XdQd3w5F7Ec4sWhhnOgoQl1QuwnPxxHoNb+O0avPxSvRizNrSuys
         gEIzCfTOptEyA==
Date:   Thu, 23 Feb 2023 16:24:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] flexible-array transformations for 6.3-rc1
Message-ID: <Y/fnjS5eHNauiUUR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.3-rc1

for you to fetch changes up to b942a520d9e43bc31f0808d2f2267a1ddba75518:

  bcache: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper (2023-01-05 17:48:45 -0600)

----------------------------------------------------------------
flexible-array transformations for 6.3-rc1

Hi Linus,

Please, pull the following patches that transform zero-length arrays,
in unions, into flexible arrays. These patches have been baking in
linux-next for the whole development cycle.

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (3):
      exportfs: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
      mm/memremap: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
      bcache: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper

 drivers/md/bcache/bcache_ondisk.h | 8 ++++----
 include/linux/exportfs.h          | 2 +-
 include/linux/memremap.h          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
