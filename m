Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92006C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Sep 2022 02:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiI3CVZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Sep 2022 22:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiI3CVN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Sep 2022 22:21:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08005EC548;
        Thu, 29 Sep 2022 19:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 009CF62222;
        Fri, 30 Sep 2022 02:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 667B0C433D7;
        Fri, 30 Sep 2022 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664504468;
        bh=4mNFG8nO0P4QYrHxhMlUH5dx3DYNOj9mjVaYxqSfbHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HkRyizvUoyovdGrp4QvxCxrybFNPZ4HwXirccWSvix2oXYVgJ9+V+5dc5oF6sur6n
         fQKIebUAzQ1OItDq9vbvTcpP3VuMEix2zCkaPyU4d1zQHPlph69Ir76sgbi1m9WJTJ
         TzkX2Sa9xMhqU7ggPpQVFWZm82zF7cI39BuhazbMfCnHonbhUM54QD4putGYDF8T1m
         85ozu66yLkCsOWE2cktdJQun5ymXs4sww4ijTXa5VxJIu6dN4HxsT1FSvJK7x9JhTk
         pHXv9QTIgNT59zW74W18Nqld31FKJtcDmsgPp/ODD+Ns/MstTbzymsWMf4UT+PSu0t
         e2Ca9cE4LssSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52CBEE49FA3;
        Fri, 30 Sep 2022 02:21:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: cls_u32: Avoid memcpy() false-positive warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166450446833.30186.9803422615203501142.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Sep 2022 02:21:08 +0000
References: <20220927153700.3071688-1-keescook@chromium.org>
In-Reply-To: <20220927153700.3071688-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     jhs@mojatatu.com, edumazet@google.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        syzbot+a2c4601efc75848ba321@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Sep 2022 08:37:01 -0700 you wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), use unsafe_memcpy(), as the sizing,
> bounds-checking, and allocation are all very tightly coupled here.
> This silences the false-positive reported by syzbot:
> 
>   memcpy: detected field-spanning write (size 80) of single field "&n->sel" at net/sched/cls_u32.c:1043 (size 16)
> 
> [...]

Here is the summary with links:
  - net: sched: cls_u32: Avoid memcpy() false-positive warning
    https://git.kernel.org/netdev/net-next/c/7cba18332e36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


