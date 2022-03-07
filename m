Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB33C433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Mar 2022 12:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiCGMj5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiCGMj5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Mar 2022 07:39:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70D419A9;
        Mon,  7 Mar 2022 04:39:03 -0800 (PST)
Received: from nazgul.tnic (nat0.nue.suse.com [IPv6:2001:67c:2178:4000::1111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C9DD1EC0373;
        Mon,  7 Mar 2022 13:38:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646656736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rV0+tZuhGoDxY69jUN7iTJa185bniGGbHQV7C81Odz0=;
        b=izJE9st1GWUDeJQkgmfjNE3OplstXHOuFVJPLsXikqQYHJR8rD7PE0Ujs7MGP1IArmUpxj
        H7c/L/5pdnzUv01eBaaiIoZ32IsjcAYSBteNl2A9Lkkg4GRGJhO2DiROkupIaiVcXI/UmR
        EbKZ6EQ9pPtXNJYqAyTpV/l21ctnV8A=
Date:   Mon, 7 Mar 2022 13:38:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwml@vger.gnuweeb.org, x86@kernel.org
Subject: Re: [PATCH v1 0/2] x86: Avoid using INC and DEC instructions on hot
 paths
Message-ID: <YiX81kD/668UdFBr@nazgul.tnic>
References: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Mar 07, 2022 at 06:45:56PM +0700, Ammar Faizi wrote:
> In order to take maximum advantage of out-of-order execution,
> avoid using INC/DEC instructions when appropriate. INC/DEC only
> writes to part of the flags register, which can cause a partial
> flag register stall. This series replaces INC/DEC with ADD/SUB.

"Improvements" like that need to show in benchmark runs - not
microbenchmark - that they bring anything. Just by looking at them, I'd
say they won't show any difference. But I'm always open to surprises.

Btw, you don't have to send all your patches directly to me - there are
other x86 maintainers. IOW, you can use scripts/get_maintainer.pl to
figure out who to send them to.

Also, I'd advise going over Documentation/process/ if you're new to this.
Especially Documentation/process/submitting-patches.rst.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
