Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB7C43334
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 13:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiFXNQb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiFXNQ0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 09:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300852503
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1EE361E9C
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8F4C3411C;
        Fri, 24 Jun 2022 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656076584;
        bh=a1IpGJcaEYyuRQLPpHLw8JtdGWWNBfbzhPFQOqjpZRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3+M1cNSLEeV8xDLZexeYNMvCweZHa5ZfsUUwoCE9rIP9RYEIBaNmIM96QOVdObLV
         eBDfxE9xZEltN4LVVa0hRcaK5WvWigxF2YbACXaZRvfeq0+aGd95iRLYxAM0DmKsiI
         YCHkVYnHkxqRQ8pK9ep4L7ZLCrjXDhVOsmpP0Fs8ekRlQQDkRoSpEJcK/WUlp8ZNj2
         +C8ztchHfYVzbWtlrE2XdXJyZH2OstXFEa7V/Qm8CjCUwsPcEg0b/pYNKpET+qorkc
         lKsLoSq811WdfEzDyan0fZVP97Z3x8XQrI8tx+BN47OSWmZL4D3FQYs/bDDyQ49pxS
         GvjNO3wOYuF7g==
Date:   Fri, 24 Jun 2022 14:16:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 20/26] arm64: head: avoid relocating the kernel twice
 for KASLR
Message-ID: <20220624131617.GF18561@willie-the-truck>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-21-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-21-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 04:45:44PM +0200, Ard Biesheuvel wrote:
> Currently, when KASLR is in effect, we set up the kernel virtual address
> space twice: the first time, the KASLR seed is looked up in the device
> tree, and the kernel virtual mapping is torn down and recreated again,
> after which the relocations are applied a second time. The latter step
> means that statically initialized global pointer variables will be reset
> to their initial values, and to ensure that BSS variables are not set to
> values based on the initial translation, they are cleared again as well.
> 
> All of this is needed because we need the command line (taken from the
> DT) to tell us whether or not to randomize the virtual address space
> before entering the kernel proper. However, this code has expanded
> little by little and now creates global state unrelated to the virtual
> randomization of the kernel before the mapping is torn down and set up
> again, and the BSS cleared for a second time. This has created some
> issues in the past, and it would be better to avoid this little dance if
> possible.
> 
> So instead, let's use the temporary mapping of the device tree, and
> execute the bare minimum of code to decide whether or not KASLR should
> be enabled, and what the seed is. Only then, create the virtual kernel
> mapping, clear BSS, etc and proceed as normal.  This avoids the issues
> around inconsistent global state due to BSS being cleared twice, and is
> generally more maintainable, as it permits us to defer all the remaining
> DT parsing and KASLR initialization to a later time.
> 
> This means the relocation fixup code runs only a single time as well,
> allowing us to simplify the RELR handling code too, which is not
> idempotent and was therefore required to keep track of the offset that
> was applied the first time around.
> 
> Note that this means we have to clone a pair of FDT library objects, so
> that we can control how they are built - we need the stack protector
> and other instrumentation disabled so that the code can tolerate being
> called this early. Note that only the kernel page tables and the
> temporary stack are mapped read-write at this point, which ensures that
> the early code does not modify any global state inadvertently.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/Makefile         |   2 +-
>  arch/arm64/kernel/head.S           |  73 ++++---------
>  arch/arm64/kernel/image-vars.h     |   4 +
>  arch/arm64/kernel/kaslr.c          |  87 ---------------
>  arch/arm64/kernel/pi/Makefile      |  33 ++++++
>  arch/arm64/kernel/pi/kaslr_early.c | 112 ++++++++++++++++++++

Heh, how long before we get a decompressor in here too?

Will
