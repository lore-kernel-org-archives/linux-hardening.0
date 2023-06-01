Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01ABC77B7E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 20:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFAUWM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFAUWD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 16:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B0810E4;
        Thu,  1 Jun 2023 13:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 956E164988;
        Thu,  1 Jun 2023 20:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB9CEC433D2;
        Thu,  1 Jun 2023 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685650820;
        bh=BsmB3TQT0UqKDYGfBMXSuKQ4Y303rceDlGSh2ELAoAE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QdOa9tCnbNQAChJM6Emg4vuZfL2cpnLL8U2OJV12cuUcXqYHNdU2Z/PnPNhGdYxMK
         aOWMML0vZAy+BB/VorJEnrY1hlDuUVOWx9CEGc4Yyy0dTAui3/D7xSiE/RtOV6VCln
         Bl13cTh8RbcTJFDF6fBjvQMpgzKU+CuESI5xvsjRFGqKtQmZlH9dDfD8mbWHgq8nIY
         93vE/tj2Jv/EVMPKRuuZDyGW7/xi6D1koCf7Mjts4U8NMLGJnCqtXACZ9jbMKNano5
         aKIDZhi6IkaHqTS+ndkaPYN/1a2i+dHLMLbmxi5Bw4be56RolorRMCYhxS6dkkaIoJ
         Xdwuzw0hguPIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFCA7C395E5;
        Thu,  1 Jun 2023 20:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168565081984.8603.17593394447980152382.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Jun 2023 20:20:19 +0000
References: <20230601160025.gonna.868-kees@kernel.org>
In-Reply-To: <20230601160025.gonna.868-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        linux@leemhuis.info, joanbrugueram@gmail.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, masahiroy@kernel.org,
        conor.dooley@microchip.com, ndesaulniers@google.com, hi@alyssa.is,
        heiko.stuebner@vrull.eu, gustavoars@kernel.org,
        ajones@ventanamicro.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  1 Jun 2023 09:00:28 -0700 you wrote:
> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> 
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
> 
> [...]

Here is the summary with links:
  - [v2] riscv/purgatory: Do not use fortified string functions
    https://git.kernel.org/riscv/c/0f84097ab015

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


