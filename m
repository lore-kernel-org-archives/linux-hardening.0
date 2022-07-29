Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50807C19F2B
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Jul 2022 13:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiG2NTc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiG2NT3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Jul 2022 09:19:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D4558F6;
        Fri, 29 Jul 2022 06:19:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSlw50l5z4x1b;
        Fri, 29 Jul 2022 23:19:24 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, paulus@samba.org, tglx@linutronix.de,
        npiggin@gmail.com, Xiu Jianfeng <xiujianfeng@huawei.com>,
        christophe.leroy@csgroup.eu, mark.rutland@arm.com,
        benh@kernel.crashing.org
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220701082435.126596-1-xiujianfeng@huawei.com>
References: <20220701082435.126596-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH -next v3 0/2] powerpc: add support for syscall stack randomization
Message-Id: <165909979124.253830.3036774942147857937.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:03:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 1 Jul 2022 16:24:33 +0800, Xiu Jianfeng wrote:
> This patchset adds support for syscall stack randomization for
> powerpc, which can make harder the various stack-based attacks that
> rely on deterministic stack structure.
> 
> Changes in v3:
>   -add a lead-up patch to move system_call_exception() to syscall.c to
>   avoid disabling stack protector for all functions in interrupt.c
> Changes in v2:
>   -move choose choose_random_kstack_offset() to the end of system_call_exception
>   -allow full 6 (10) bits of entropy
>   -disable stack-protector for interrupt.c
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: Move system_call_exception() to syscall.c
      https://git.kernel.org/powerpc/c/1547db7d1f4481c1f3ec731f3edc724ef3026ede
[2/2] powerpc: add support for syscall stack randomization
      https://git.kernel.org/powerpc/c/f4a0318f278d98d9492916722e85f258c2221f88

cheers
