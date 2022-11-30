Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D80DC4708D
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Nov 2022 09:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiK3JcW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Nov 2022 04:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiK3Jb4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812C66C8D;
        Wed, 30 Nov 2022 01:31:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqr6mR0z4xN4;
        Wed, 30 Nov 2022 20:31:36 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YySE6FHiOcbWWR+9@work>
References: <YySE6FHiOcbWWR+9@work>
Subject: Re: [PATCH][next] powerpc/xmon: Fix -Wswitch-unreachable warning in bpt_cmds
Message-Id: <166980023574.3017288.3366504099438296796.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:55 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 16 Sep 2022 15:15:04 +0100, Gustavo A. R. Silva wrote:
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
> 
> arch/powerpc/xmon/xmon.c: In function ‘bpt_cmds’:
> arch/powerpc/xmon/xmon.c:1529:13: warning: statement will never be executed [-Wswitch-unreachable]
>  1529 |         int mode;
>       |             ^~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/xmon: Fix -Wswitch-unreachable warning in bpt_cmds
      https://git.kernel.org/powerpc/c/1c4a4a4c8410be4a231a58b23e7a30923ff954ac

cheers
