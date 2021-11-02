Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C0C43217
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 00:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D045610A5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 00:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhKBAxl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231983AbhKBAxi (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 1 Nov 2021 20:53:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9F7CD61051;
        Tue,  2 Nov 2021 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635814264;
        bh=KY8NdFYmNbJD6Hv/ENXQu1vGKR5Mi5saXr5rYgWcV28=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WmE6Gl1MqePM9p2xOzmNuUECEqaLzKrAxRRTci9Zh+OHcGPAPHCliLWLEP9RU+1J7
         zgGlHRGsnejQCrZn90DEhBbA3a+KZDAJ0QdngBYVvlPAWB86iN9fnQZwGO3DYSwfr2
         Gokn0+qUA+T0K+HfVchyIPuFahjYWwWt7no8/vugUQ7MnbgyYOIVEombAIZ5rq6tEi
         DKRsOVP6o8BsR0o9SbxFGV9UOT72Ey3g+NgTPydbPyDKQyZRBhcKhL0xDV43z0Pz4X
         reOHnk0peAK0LYDw4fc+ccppxJHHNFhpxdgKL/w9Rp9Xopn7WQvK2y3VnmWfkHWXLZ
         08Ihd2i8RsWaA==
Subject: Re: [GIT PULL] overflow updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202111010927.AFA4C0D15@keescook>
References: <202111010927.AFA4C0D15@keescook>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <202111010927.AFA4C0D15@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.16-rc1
X-PR-Tracked-Commit-Id: 95cadae320be46583078690ac89ffe63c95cc9d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dc26d98cfdf756e390013fafaba959b052b0867
Message-Id: <163581426461.14115.5835135141227195104.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 00:51:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 09:35:46 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dc26d98cfdf756e390013fafaba959b052b0867

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
