Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A4EC001B0
	for <linux-hardening@archiver.kernel.org>; Sat,  1 Jul 2023 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGAQMF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 1 Jul 2023 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGAQME (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 1 Jul 2023 12:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45A270E;
        Sat,  1 Jul 2023 09:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88F79600BE;
        Sat,  1 Jul 2023 16:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2F27C433C8;
        Sat,  1 Jul 2023 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688227923;
        bh=gJzHuTVfdzUvwJvKHCqV5CrmrPHXO9GNjtF8nhc4haE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SQ2hp5grrEhKBHouoGFBefQn2kEutAeFok7dKqyTKy5WYqZQRXdfwRV/lJFZabcxh
         0uhCyNF2470s9xedQwOhQB+Y1VN01DZcYLlXDYyVvhDaJbN77bl0fnpccjs14pYeJN
         RSBc/j0h8dlXY9q9PV640Hgjn6bf62u94962Lu5lK35HlqUpxxlkCe1BjvvfblSNw7
         Uhm358cdy/2MgVEveRo25AmCSFoVWp22CExSLVxMQkymrotI0sRjzA3v5W59hhGZRF
         3g2N6CHcgpt1mXbKliZt3GMVy+/64O0Hq/K0zN+upeTX1kVJB+4+kHrf5jw5XUAoot
         Mx7oG9Kuz0Bww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE920C0C40E;
        Sat,  1 Jul 2023 16:12:02 +0000 (UTC)
Subject: Re: [GIT PULL v2] flexible-array transformations for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJ8C4PtPrxr6LTA7@work>
References: <ZJ8C4PtPrxr6LTA7@work>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJ8C4PtPrxr6LTA7@work>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.5-rc1
X-PR-Tracked-Commit-Id: 40ca06d71d60677a8424798610c97a46e4140a21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 170ab6c51a42a8a1c1a7ce09367b578db6f2f383
Message-Id: <168822792283.621.4577729889953275464.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 16:12:02 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The pull request you sent on Fri, 30 Jun 2023 10:29:20 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/170ab6c51a42a8a1c1a7ce09367b578db6f2f383

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
