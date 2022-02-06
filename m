Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B11CC433EF
	for <linux-hardening@archiver.kernel.org>; Sun,  6 Feb 2022 11:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiBFL6e (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 6 Feb 2022 06:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiBFL6d (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 6 Feb 2022 06:58:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882BBC06173B;
        Sun,  6 Feb 2022 03:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u8y8YnXoDgPdri5nDxHCd/Dt45QdXd7r35iYZRYPKgI=; b=BkygttVrImN6pKWoJ8l/7fwIhJ
        XYVZCmGlNE8ZjFHEW2SPgQkaRnw5X3DNcTza1gdcgv1icWVdRpsVVXmjGl6oPiTKCX3+1Erpse07v
        /9THscrbp3IB/AqKDTtKNITe2JOXT2Q7waWWIZU93z4m/+gHPsTq2CroDf7bf4wdBpW1el7w4DyX4
        Oj3HpoBDTOU3m6rkw4XyoSG7LybN9GZI6vrflgktjE1IzRLUjLN+bUEe4gN8irmKKAaHa7RSw6Rgs
        dU4sm95LpZwPFuyNXDu9rW4WgSbtZTBXIk+AsFYOgnLbrXhaCdKdEyNjl4dd52RxLSts0hojJZ5pp
        7wwim/fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGgBO-00Dsz0-Fz; Sun, 06 Feb 2022 11:58:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEC9898622D; Sun,  6 Feb 2022 12:58:16 +0100 (CET)
Date:   Sun, 6 Feb 2022 12:58:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <20220206115816.GA23216@worktop.programming.kicks-ass.net>
References: <20220202001918.4104428-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202001918.4104428-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 01, 2022 at 04:19:18PM -0800, Kees Cook wrote:
> While the stackleak plugin was already using notrace, objtool is now a
> bit more picky. Update the notrace uses to noinstr. Silences these
> warnings:
> 
> vmlinux.o: warning: objtool: do_syscall_64()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_int80_syscall_32()+0x9: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: exc_general_protection()+0x22: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: fixup_bad_iret()+0x20: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_machine_check()+0x27: call to stackleak_track_stack() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .text+0x5346e: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x143: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x10eb: call to stackleak_erase() leaves .noinstr.text section
> vmlinux.o: warning: objtool: .entry.text+0x17f9: call to stackleak_erase() leaves .noinstr.text section
> 
> Cc: Alexander Popov <alex.popov@linux.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Is it correct to exclude .noinstr.text here? That means any functions called in
> there will have their stack utilization untracked. This doesn't seem right to me,
> though. Shouldn't stackleak_track_stack() just be marked noinstr instead?

This patch is right. stackleak_track_stack() cannot be marked noinstr
becaues it accesses things that might not be there.

Consider what happens if we pull the PTI page-table swap into the
noinstr C part.

> @@ -446,6 +447,8 @@ static bool stackleak_gate(void)
>  			return false;
>  		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
>  			return false;
> +		if (!strncmp(TREE_STRING_POINTER(section), ".noinstr.text", 13))
> +			return false;

For paranoia's sake I'd like .entry.text added there as well.

>  	}
>  
>  	return track_frame_size >= 0;
