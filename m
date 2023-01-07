Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0782C677F1
	for <linux-hardening@archiver.kernel.org>; Sat,  7 Jan 2023 03:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbjAGDkW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 22:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbjAGDkU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 22:40:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEBF392CF;
        Fri,  6 Jan 2023 19:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFA55B81F67;
        Sat,  7 Jan 2023 03:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94473C43392;
        Sat,  7 Jan 2023 03:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673062816;
        bh=thCvlrZlqYnb3OcMTSgDe+HD0TYa2VCQSo8wYGdOx+k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SWo1F1QRf87ubl4G+5lNxhy7yP3ESba33DNXRRPqdREH0HRaRy4DUuXbAZ6Y6Ytz9
         p90x5lH4o2JcCCfGEzTCgWHR/oQyfGmF9od5217tXgqPcYHxK7oMN4qwKjl1fvGYsv
         F38ZVwEokM20M6hRaYAJogZi8cbuEG96gD/4Vrskm49icSvykz3l3ICG10r28rFTgI
         yp/RHvScyK777ZqRwihvodkJW9t5CF0VA3/204kwhw7OafyZpbxOTKTJCnB0CnbD9C
         /aV4QUDYpjuQCU05vtV8xsoPR0p4nkGe2qgqaWuyzaA5bZMnQFJ0P/lJOhBzDr+wBg
         4IZVivf29zvng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F80BC395DF;
        Sat,  7 Jan 2023 03:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv6: ioam: Replace 0-length array with flexible array
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167306281651.4583.5175258501631877655.git-patchwork-notify@kernel.org>
Date:   Sat, 07 Jan 2023 03:40:16 +0000
References: <20230105222115.never.661-kees@kernel.org>
In-Reply-To: <20230105222115.never.661-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     davem@davemloft.net, kuba@kernel.org, justin.iurman@uliege.be,
        edumazet@google.com, pabeni@redhat.com, gustavoars@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Jan 2023 14:21:16 -0800 you wrote:
> Zero-length arrays are deprecated[1]. Replace struct ioam6_trace_hdr's
> "data" 0-length array with a flexible array. Detected with GCC 13,
> using -fstrict-flex-arrays=3:
> 
> net/ipv6/ioam6_iptunnel.c: In function 'ioam6_build_state':
> net/ipv6/ioam6_iptunnel.c:194:37: warning: array subscript <unknown> is outside array bounds of '__u8[0]' {aka 'unsigned char[]'} [-Warray-bounds=]
>   194 |                 tuninfo->traceh.data[trace->remlen * 4] = IPV6_TLV_PADN;
>       |                 ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/ioam6.h:11,
>                  from net/ipv6/ioam6_iptunnel.c:13:
> include/uapi/linux/ioam6.h:130:17: note: while referencing 'data'
>   130 |         __u8    data[0];
>       |                 ^~~~
> 
> [...]

Here is the summary with links:
  - ipv6: ioam: Replace 0-length array with flexible array
    https://git.kernel.org/netdev/net-next/c/0b5dfa35da03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


