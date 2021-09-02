Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE367C83029
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Sep 2021 16:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE94660698
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Sep 2021 16:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhIBQ4Q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346378AbhIBQ4N (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Sep 2021 12:56:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846ECC061575;
        Thu,  2 Sep 2021 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rzf/6LcMzbI/PQP7yFlRIA7pmDSDhpmLqpTRt4zcusM=; b=KA0wsFCq85MvWpCbZrfWAzFK9
        DFF3VTTxKeQwwxkQ3ZwEssNR7QluZij19whJHnhW+i+XfQ79kjrQW4hMhY/bF/TXx5/kvN/OjBCkW
        +7bkjwNzX/hrFMk51unl46AAG2zLcUlGeyITeTNUFDf5Z9XFTxuqFPnybr7P5Ynmc54aJAoJbpZFN
        ILRTPWqJZuM48e2TqGNBsnA9KyAItSgKjTcW5HmDJDaPybw9R+7waM4Cq/AOGxBy8A9C0cPvr8+b1
        nRMn1a+G0/6zKfjGyz7N0MhaOhkAjYqVhiIel9nMuGLmM+/j0YksZAQPlDXPzu4Yhw7ZzFrOhLbMO
        5iPUXz2Vg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48096)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mLpzI-0001iR-BC; Thu, 02 Sep 2021 17:54:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mLpzH-00081q-Ns; Thu, 02 Sep 2021 17:54:51 +0100
Date:   Thu, 2 Sep 2021 17:54:51 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2]: ARM: Enable THREAD_INFO_IN_TASK
Message-ID: <20210902165451.GJ22278@shell.armlinux.org.uk>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <202109020904.976207C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109020904.976207C@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 02, 2021 at 09:07:42AM -0700, Kees Cook wrote:
> On Thu, Sep 02, 2021 at 08:54:26AM -0700, Keith Packard wrote:
> > Placing thread_info in the kernel stack leaves it vulnerable to stack
> > overflow attacks. This short series addresses that by using the
> > existing THREAD_INFO_IN_TASK infrastructure.
> 
> Very cool! Thanks for working on this. If you want, you can refer to the
> KSPP bug for this too:
> https://github.com/KSPP/linux/issues/1

Not so fast. It's buggy. I've rejected this "solution" before.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
