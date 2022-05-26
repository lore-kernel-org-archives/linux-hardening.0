Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4FFC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 26 May 2022 00:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348021AbiEZAJc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 May 2022 20:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348088AbiEZAJR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 May 2022 20:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCD663E0;
        Wed, 25 May 2022 17:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DAFE6163B;
        Thu, 26 May 2022 00:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93A74C3411A;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653523753;
        bh=XV4oZrjPfbR5oR+jF5srjLSwxd5iasPpT2BfrMR255k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z1aLgHQIuYsAcepNzQO2D5eiGkkYcVRs+GITA8k8vh/cA2GhB7y7X6izm7NhklBIk
         Gd6hWqAOTb4BvDfneaJI9pD4Id8UNqFhtqvjedJ+CSuGeADJ2rbSfE++ojCmFnVC1L
         Qxt1WxyVOMSHXW+NaY1s1usnazn13UdhUqTCbThluL6cpRlipE8KwX3riOqDn9y1OX
         P5zYmxNPSKS6O6FjJF6X92EcXg9ttWju+/Dmf2I7fAj4wC42112YFYySARiQ2a48sy
         gkJUlvAdiKoSqr73n0NEnIpiCU1EJYg86dyazonSjcTO+hUrMBp7EIseLgfeOH5dLN
         0BEdKby5XsPaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81E23EAC081;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
Subject: Re: [GIT PULL] Misc hardening changes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524222701.GA7784@embeddedor>
References: <20220524222701.GA7784@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524222701.GA7784@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/size_t-saturating-helpers-5.19-rc1
X-PR-Tracked-Commit-Id: 746f1b0ac5bf6ecfb71674af210ae476aa714f46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62e5873ec96bc2cfe809a1bc123af8101989ef5f
Message-Id: <165352375352.5177.12718744830755925647.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 00:09:13 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 17:27:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/size_t-saturating-helpers-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62e5873ec96bc2cfe809a1bc123af8101989ef5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
