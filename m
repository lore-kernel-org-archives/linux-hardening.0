Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F790C2B9F4
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Jun 2021 19:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC03C613CB
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Jun 2021 19:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhFQTWN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Jun 2021 15:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhFQTWL (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Jun 2021 15:22:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B0179613EC;
        Thu, 17 Jun 2021 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623957603;
        bh=caGavXiiTWPybO6DqNsnHt5xJmkjD88UwYkIYqQ2w8A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bqq7wKlam46E8Tn8cxPHYYiFUVmHJ+dPP79/2+dfWvl6D9D/QMAWedtNPEdKuki9c
         uGCWgg5PEcM50Q3qDxNKpaKmHq/Fxwz2fIlNuoE71fk1fC98orop5xcR1xo8wCiCiS
         aBhev3H3PnZaQSWXQEJbUnbfQNamHzBTeceB8eJ3ACcnl+QqJfKf4S1fjMEoZErzdE
         wu7J6QxVTL94TpG+82rsglI90at7/1XjL6etrbQk/Otwyv3fO8EW6YpV4FA8SbbumO
         AEjpF7m4xqyFP5QID5nmVKAFBaA0Yyj/9ckdyXYnR049BPnFJG3lfXQGX0Cy1CP1lw
         X1lrIDHt60+Jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qed: Fix memcpy() overflow of qed_dcbx_params()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162395760365.22568.16521741419925994690.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Jun 2021 19:20:03 +0000
References: <20210617170953.3410334-1-keescook@chromium.org>
In-Reply-To: <20210617170953.3410334-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     alobakin@pm.me, aelior@marvell.com, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Thu, 17 Jun 2021 10:09:53 -0700 you wrote:
> The source (&dcbx_info->operational.params) and dest
> (&p_hwfn->p_dcbx_info->set.config.params) are both struct qed_dcbx_params
> (560 bytes), not struct qed_dcbx_admin_params (564 bytes), which is used
> as the memcpy() size.
> 
> However it seems that struct qed_dcbx_operational_params
> (dcbx_info->operational)'s layout matches struct qed_dcbx_admin_params
> (p_hwfn->p_dcbx_info->set.config)'s 4 byte difference (3 padding, 1 byte
> for "valid").
> 
> [...]

Here is the summary with links:
  - net: qed: Fix memcpy() overflow of qed_dcbx_params()
    https://git.kernel.org/netdev/net/c/1c200f832e14

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


