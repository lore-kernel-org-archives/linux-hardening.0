Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0919AC433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Nov 2022 13:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKUNKT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKUNKR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 21 Nov 2022 08:10:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC431CDC;
        Mon, 21 Nov 2022 05:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BBD5611C8;
        Mon, 21 Nov 2022 13:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E88D4C433C1;
        Mon, 21 Nov 2022 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669036216;
        bh=Y5K7fPm1WVsI/IgwrwLcUcOcIDTvYazQe69HxLrypT4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KEZdPTQh395/Wz/+LlNkFZMoEiqZCBMJ5IgX14Y5BCtLskTUKXt0lhnwzTDtr7vvz
         iU/uEXOuqUAek7Jupv8ipfWMbgn6RQs+c4LxLPfyvzAuMEujfnfD1VU1CdJvaMHXuB
         JWO50VHZYD9sim69ZVwKdbsDynk5zS15VkUiLzRzKqvbyvpwzkXKqSfLsPJpI+7lgr
         Bo7+PTZZ3ziHDagGN57/Im4MZOoU/b4pyeRLPxTRulQipckXOjNj10EyOI6NhE5vnT
         VaY41XYR0JpNzOr7aOG5FcvHywiV1eQz2L4pF3FQcYMl/bMVaZgm8Visw2FsqTN2Ty
         IV8HoO946SQOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFCC9E29F3E;
        Mon, 21 Nov 2022 13:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv4/fib: Replace zero-length array with DECLARE_FLEX_ARRAY()
 helper
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166903621584.4573.5464755220757238317.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Nov 2022 13:10:15 +0000
References: <20221118042142.never.400-kees@kernel.org>
In-Reply-To: <20221118042142.never.400-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kuba@kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
        gustavoars@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 17 Nov 2022 20:21:52 -0800 you wrote:
> Zero-length arrays are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace zero-length array with flexible-array member in struct key_vector.
> 
> [...]

Here is the summary with links:
  - ipv4/fib: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
    https://git.kernel.org/netdev/net/c/764f8485890d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


