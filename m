Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDBBECAAD4
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Aug 2022 13:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiHaNPp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Aug 2022 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiHaNPo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Aug 2022 09:15:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B39C98CA8
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 06:15:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHl6K0xtgz4xGR;
        Wed, 31 Aug 2022 23:15:37 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
        linux-hardening@vger.kernel.org, christophe.leroy@csgroup.eu,
        ajd@linux.ibm.com, nicholas@linux.ibm.com,
        anshuman.khandual@arm.com
In-Reply-To: <20220817050640.406017-1-ruscur@russell.cc>
References: <20220817050640.406017-1-ruscur@russell.cc>
Subject: Re: [PATCH v4 1/2] powerpc/mm: Support execute-only memory on the Radix MMU
Message-Id: <166195163958.45984.15308325694886524412.b4-ty@ellerman.id.au>
Date:   Wed, 31 Aug 2022 23:13:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 17 Aug 2022 15:06:39 +1000, Russell Currey wrote:
> Add support for execute-only memory (XOM) for the Radix MMU by using an
> execute-only mapping, as opposed to the RX mapping used by powerpc's
> other MMUs.
> 
> The Hash MMU already supports XOM through the execute-only pkey,
> which is a separate mechanism shared with x86.  A PROT_EXEC-only mapping
> will map to RX, and then the pkey will be applied on top of it.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/mm: Support execute-only memory on the Radix MMU
      https://git.kernel.org/powerpc/c/395cac7752b905318ae454a8b859d4c190485510
[2/2] selftests/powerpc: Add a test for execute-only memory
      https://git.kernel.org/powerpc/c/98acee3f8db451eaab9fbd422e523c228aacf08c

cheers
