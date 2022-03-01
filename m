Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA20C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Mar 2022 16:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiCAQf3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiCAQf2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Mar 2022 11:35:28 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FB8513FB1;
        Tue,  1 Mar 2022 08:34:47 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nP5SV-0006n6-01; Tue, 01 Mar 2022 17:34:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 91177C28F1; Tue,  1 Mar 2022 17:30:20 +0100 (CET)
Date:   Tue, 1 Mar 2022 17:30:20 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Yanteng Si <siyanteng01@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mips: Implement "current_stack_pointer"
Message-ID: <20220301163020.GB13091@alpha.franken.de>
References: <20220224060432.1855897-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224060432.1855897-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 23, 2022 at 10:04:32PM -0800, Kees Cook wrote:
> To follow the existing per-arch conventions replace open-coded uses
> of asm "sp" as "current_stack_pointer". This will let it be used in
> non-arch places (like HARDENED_USERCOPY).
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Yanteng Si <siyanteng01@gmail.com>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/Kconfig                   | 1 +
>  arch/mips/include/asm/thread_info.h | 2 ++
>  arch/mips/kernel/irq.c              | 3 +--
>  arch/mips/lib/uncached.c            | 4 +---
>  4 files changed, 5 insertions(+), 5 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
