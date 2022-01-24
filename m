Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E69C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbiAXR5J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbiAXR5J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:57:09 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E24C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s+FOZvZXvf/omT6ZFSLUjltRlW8XbozoONLwIkmpQHg=; b=GvJpsGc93u1We+bK1AVP4e2Sq0
        890EoTTIVxJhPCWAA09Ew/aIh3NSXlPpOl+AO7c2HUtmKzD3ZMNigPMOhaYmKzI+YPi/X4rbsXyHK
        zFNGqQwQLrqh8J+Io/eE0aWmU8k01ZZqkC51JC52QtLzCO7YJLEgN0Qlfd4GaiyDT4fvQ3Uiid/7Z
        8jI+drtLQy69CRvAAFgrwZllXxW9D3fXPHdkp+cbfGZU+lVqE08fdwAJ4wRqaOfWiOXlbb/LT91Jz
        zR8C8DCWloP6n1tW3fou/mAyTgjH5n0U9wbAkkmSth63ajp458mLnx1cJv1jMgsJW8CgOYNH9lluV
        Stxqds1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56844)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nC3aP-0000je-Lf; Mon, 24 Jan 2022 17:57:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nC3aL-0001on-8E; Mon, 24 Jan 2022 17:56:57 +0000
Date:   Mon, 24 Jan 2022 17:56:57 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [PATCH v5 00/32] ARM vmap'ed and IRQ stacks roundup
Message-ID: <Ye7oabF/ewS0pSKw@shell.armlinux.org.uk>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 24, 2022 at 06:47:12PM +0100, Ard Biesheuvel wrote:
> This v5 series is a combined followup to
> 
> - IRQ stacks support for v7 SMP systems [0],
> - vmap'ed stacks support for v7 SMP systems[1],
> - extending support for both IRQ stacks and vmap'ed stacks for all
>   remaining configurations, including v6/v7 SMP multiplatform kernels
>   and uniprocessor configurations including v7-M [2]
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20211115084732.3704393-1-ardb@kernel.org/
> [1] https://lore.kernel.org/linux-arm-kernel/20211122092816.2865873-1-ardb@kernel.org/
> [2] https://lore.kernel.org/linux-arm-kernel/20211206164659.1495084-1-ardb@kernel.org/
> 
> This work was queued up in the ARM tree for a while, but due to problems
> with the vmap'ed stacks code, which was difficult to revert in
> isolation, the whole stack was dropped again.
> 
> In order to prevent similar problems from occurring this time around,
> the series was reorganized so that the vmap'ed stacks changes appear at
> the very end, which also results in a more natural progression of the
> changes.
> 
> Changes since v4:
> - incorporate fixups to avoid build failures on Clang related to
>   literals in subsections,
> - switch from the ID map to swapper_pg_dir as early as possible when
>   onlining a CPU on !LPAE, to ensure that the stack is mapped,
> - use SMP_ON_UP patching to elide HWCAP_TLS tests on SMP+v6,
> - clean up __switch_to() for Thumb2 a bit more,
> - add patch to make the vmalloc_seq counter SMP safe,
> - use enter_lazy_tlb() hook on !LPAE to ensure that the active_mm used
>   by a kernel thread has a mapping for its vmap'ed stack,

Hi Ard,

I still have the original code in devel-stable, and being a guaranteed
stable branch, it's not something I'll be dropping... Please can I have
fixes on top of what is already there please?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
