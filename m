Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB18C6FA82
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 14:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiI0Ovp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiI0OvL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Sep 2022 10:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B64EE26;
        Tue, 27 Sep 2022 07:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 328B761A14;
        Tue, 27 Sep 2022 14:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99125C43470;
        Tue, 27 Sep 2022 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664290216;
        bh=jB5siogusOcKXvYF/OL9C7cDiSZqSCGB14hV5AyzrEQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EFEkuG7qnOHyWeiLsWUJk1DM/yKO509rf6co3JsiG3iTMCfRmr54UwgOujIiuahFZ
         IXbTmKCpxWG2Jdvhu2FwpSLguXYN/c/laZ9DbiwOV27rTrGSRZXvHvFnpLpaEgW90B
         mmxtvvBq/yG+j2X9jvdLtVDuFqkJCQ6TOm41K7dcL12IJFayvGLZzQaTHVJtCBb7bD
         v7X0Whmcl2+SRvF8QzwzBrUbkh1vtgKLX5rXyhSAe1O9aCO0RyrXYq/khd8636N5hZ
         MtnTA88+Rel8r7tCWlqZyoZ4YyiYe2EdD+fqIUvtwI2fvyLhkQzUnukyi2PLPyh2Ci
         J+5I8bNtvQNBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EE73E21EC6;
        Tue, 27 Sep 2022 14:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NFC: hci: Split memcpy() of struct hcp_message flexible array
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166429021651.22749.12436522168132240366.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Sep 2022 14:50:16 +0000
References: <20220924040835.3364912-1-keescook@chromium.org>
In-Reply-To: <20220924040835.3364912-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     krzysztof.kozlowski@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Sep 2022 21:08:35 -0700 you wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated. This
> split already existed for the "firstfrag" case, so just generalize the
> logic further.
> 
> [...]

Here is the summary with links:
  - NFC: hci: Split memcpy() of struct hcp_message flexible array
    https://git.kernel.org/netdev/net-next/c/de4feb4e3d61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


