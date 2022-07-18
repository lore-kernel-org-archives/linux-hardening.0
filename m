Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCEAC43334
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jul 2022 15:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiGRPE0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiGRPEZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Jul 2022 11:04:25 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63F5610AD;
        Mon, 18 Jul 2022 08:04:24 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26IEu3b6021466;
        Mon, 18 Jul 2022 09:56:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26IEu2Km021465;
        Mon, 18 Jul 2022 09:56:02 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 18 Jul 2022 09:56:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-hardening@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
Message-ID: <20220718145601.GE25951@gate.crashing.org>
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com> <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com> <20220717195448.GB25951@gate.crashing.org> <87k08bdqm1.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k08bdqm1.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jul 18, 2022 at 01:52:38PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > Can't we simply have a small simple implementation of these functions in
> > arch/powerpc/boot/?  This stuff is not performance-critical, and this is
> > not the first time we hit these problems.
> 
> prom_init.c isn't in arch/powerpc/boot :)

Ah duh :-)

> It's linked into the kernel proper, but we want it to behave like a
> pre-boot environment (because not all boot paths run it) which is why we
> restrict what symbols it can call.
> 
> We could have a prom_memset() etc. but we'd need to do some tricks to
> rewrite references to memset() to prom_memset() before linking.

You can do it in its linker script?


Segher
