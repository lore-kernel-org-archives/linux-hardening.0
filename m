Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79355FA3740
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Oct 2022 14:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiJ0OAX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Oct 2022 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiJ0OAU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Oct 2022 10:00:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287B83B9AB;
        Thu, 27 Oct 2022 07:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2F5DCE26DD;
        Thu, 27 Oct 2022 14:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 021CBC43142;
        Thu, 27 Oct 2022 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666879216;
        bh=AJwhwpeBI7cTTGtqpA1nFwS/kJCC94Aeq1zbEHzb75U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nPC1x+DtmBSo/48xAUA1kv4fDjCkxRhkr4xjvTF8XAvdLt5ViqrGizL51wjaoTOKB
         cIZBO5gS91BKdZ9gdeYd2yXp09tT8PMlWRf5MN8BZo28XY2P/T0c/jCBlDwhpIQUqD
         zeEDbczTZQ7YErjzRPb9aQM8RFWJHZaqksddK7MiRI+IenIZq8Nucbfdu9p9lGSRJ4
         djpjkWHmz6x2n0PAM022BU+tsjsEt1UvGB+mhArNzfhb8fCru4s9yU83Pb6+dUy6Ga
         EDEfqX3t1tjZFFnvnHcCSYG3YsMNMmJU/X0ZIPHPF4dAYdT4fPKp/GDt/0Gv6zviF/
         +vXmiEv2vb4yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E175DE270D8;
        Thu, 27 Oct 2022 14:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] skbuff: Proactively round up to kmalloc bucket
 size
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166687921591.3700.16973059849541139256.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Oct 2022 14:00:15 +0000
References: <20221025223811.up.360-kees@kernel.org>
In-Reply-To: <20221025223811.up.360-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, ndesaulniers@google.com,
        rientjes@google.com, vbabka@suse.cz, asml.silence@gmail.com,
        imagedong@tencent.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Oct 2022 15:39:35 -0700 you wrote:
> Instead of discovering the kmalloc bucket size _after_ allocation, round
> up proactively so the allocation is explicitly made for the full size,
> allowing the compiler to correctly reason about the resulting size of
> the buffer through the existing __alloc_size() hint.
> 
> This will allow for kernels built with CONFIG_UBSAN_BOUNDS or the
> coming dynamic bounds checking under CONFIG_FORTIFY_SOURCE to gain
> back the __alloc_size() hints that were temporarily reverted in commit
> 93dd04ab0b2b ("slab: remove __alloc_size attribute from __kmalloc_track_caller")
> 
> [...]

Here is the summary with links:
  - [net-next,v5] skbuff: Proactively round up to kmalloc bucket size
    https://git.kernel.org/netdev/net-next/c/12d6c1d3a2ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


