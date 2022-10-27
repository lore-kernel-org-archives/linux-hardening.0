Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA872FA3743
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Oct 2022 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiJ0U7l (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiJ0U7J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Oct 2022 16:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428CEC06B5;
        Thu, 27 Oct 2022 13:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1224062552;
        Thu, 27 Oct 2022 20:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CA62C433D7;
        Thu, 27 Oct 2022 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666903832;
        bh=A4E5bckZc2Ra37LNVj7x6T/9k58cNSMtXpbZePCSihk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rb+F7adZJy2QkXeTMgATWrkFonZsdM/ZUKGYeKWEvM4hjtbq+d3eCMvJLenGQiQZH
         kAvVTkEkpA16fq2r5ugirNvQDGpweD3yYaLd9g9UfMe/1VE5nzO/V7bjRims2fkD6O
         pOIpM8IlZsbiy6oa0+hNz69M3/EGio4Su+iRD/Lfpv/XxhBgFBIcXno9B+ZGdngrWh
         MYbD6QSJYOx6BJoRg7wXl0ifjDbG649TQez2uyzgVYM1M5UniDUNJ4BjwHm2ItBwWC
         zm9mhds5sQf02byc9hWeSPSWDH9aKRV8XJuAXK6vkPbgWLtSTcoCgZ8dXhqtXERVRU
         xAnHQmIGz6Drg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56F18E270D9;
        Thu, 27 Oct 2022 20:50:32 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202210271203.1CABE4152@keescook>
References: <202210271203.1CABE4152@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202210271203.1CABE4152@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc3
X-PR-Tracked-Commit-Id: 72c3ebea375c39413d02113758319b74ecd790bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eb72d85acf3357e6d7c88febcc0ad553805364b
Message-Id: <166690383235.21870.10456103204204237625.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Oct 2022 20:50:32 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The pull request you sent on Thu, 27 Oct 2022 12:03:27 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eb72d85acf3357e6d7c88febcc0ad553805364b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
