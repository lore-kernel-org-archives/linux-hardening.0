Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C57DC0015E
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 14:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjHIOU2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Aug 2023 10:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjHIOU1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Aug 2023 10:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA701FD2;
        Wed,  9 Aug 2023 07:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F8F6378E;
        Wed,  9 Aug 2023 14:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82F39C433C9;
        Wed,  9 Aug 2023 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691590823;
        bh=hRfZueMl4NMwyHkHFGihvLCgiJFxeSZASc0mte3oji0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NmOD5dOGP21qN+kGFvVv+KXLc00qxgW8oOFQD4eYbDl6QUXcF48BT6l8kB/M0gZYO
         sRqF8PSTJtThQbpjAgmCUvCxmOn+i/PTldNrD7ECZ8r+SOkm6DRR6ekVFGvJb9KTgt
         6h4sMu/rpw7/Jk8Y4jff1QTFqEhsJ5mVQbEsEoH6oPdKwfmyMRhBCRCmf5Rg0uK1Ql
         fASngWMBIUHavnysA8YbxLgreBCJdhivrHX17murbI9haPnfU8bvWuABrWhPamMiYK
         XQHuVceh4YbTQ/FVzUs4GoSEQC4d5ie9BrT7td4f+yDXha4lgJs3EleZSkTQmBGofh
         6XvDbp8wzytmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B9ECE33093;
        Wed,  9 Aug 2023 14:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169159082343.5601.4592059782635361468.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 14:20:23 +0000
References: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
In-Reply-To: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        ndesaulniers@google.com, linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 02 Aug 2023 00:21:58 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Favor not copying strings onto stack and instead use strings directly.
> This avoids hard-coding sizes and buffer lengths all together.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: cpu: refactor deprecated strncpy
    https://git.kernel.org/riscv/c/12d61a1bc28e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


