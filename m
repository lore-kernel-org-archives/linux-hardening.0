Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D338C83F17
	for <linux-hardening@archiver.kernel.org>; Tue, 29 Aug 2023 20:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjH2UT3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 29 Aug 2023 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240479AbjH2US7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 29 Aug 2023 16:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9495E1BC;
        Tue, 29 Aug 2023 13:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3403464559;
        Tue, 29 Aug 2023 20:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95F65C433C7;
        Tue, 29 Aug 2023 20:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693340335;
        bh=OKVobnKIplOtfdK5gACCF/VIyOd8gb4EoHRGMqm4MjU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k7Wdp3MghVHXls3p8Z+1dp3E4jxbn3jeS/9kLAGScd9RRAVyatxi3yQ/GqFfqOPi+
         nrF8IvNgDjX/KNoVVI94UYVCLcX95UUFJ8RBbRC0rd3eY0XfjNEdI4My7Y2h1lzGhW
         5TbLfVroAiEL20yF8n06UCw0+j3dIpf44DTN3lGkPLYQyobzJYiDQRvP9k3R07C4ix
         zBJyDHVwJbdEg+LXtB9tRgwOLTyMGUtaPcOzvbhH9iR7T8467TqnAUWocWZlS7y0PZ
         N2Y7aFGRXQTVDQMCUcgp4UYJ2aePQjQWnxb18czBO6w2N/ufrs2sgCCapHq2z/TmPF
         1AVlI/R7eUatQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83F39C595D2;
        Tue, 29 Aug 2023 20:18:55 +0000 (UTC)
Subject: Re: [GIT PULL] flexible-array transformations for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO0FRCAhO5vdQFPA@work>
References: <ZO0FRCAhO5vdQFPA@work>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO0FRCAhO5vdQFPA@work>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.6-rc1
X-PR-Tracked-Commit-Id: 4d8cbf6dbcdaebe949461b0a933ae4c71cb53edc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d6b14cd1e993d2ff98df0cef6d935ce6fd4dbec
Message-Id: <169334033553.16899.11185338834522086852.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 20:18:55 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 14:36:20 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d6b14cd1e993d2ff98df0cef6d935ce6fd4dbec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
