Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8385EC32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 14:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiIZO1i (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiIZO1E (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 10:27:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EF714091;
        Mon, 26 Sep 2022 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FIHRxSY6V+zzl15F4vvObYqxHLfDtkzR9cwonipMTy4=; b=gvrdtGfYanGL5Zv0aDMToZN85f
        +xqWVNEQnFt5COC6g8v2Vtsw900/hQjSCEAAArEl6LemRrxzyUmGTygvB3+ujY6oKmZ/odrLtahEP
        eaadMPRHDyYAxjCQTSbwEy9sx3Pc63jDaDiW7hyaauMFMqP2ESXJ/gIpdKDUgSqzsDhwAK4n2VayX
        Bv+UrTWjnmSk4cGEo8bv3xtK4yWhx2vqhtQkLAUV5ia8PlWKA90afqen7TRND7r436u/quR21gItg
        bN2orRDwoMTEjyFEI7brjAbFTHf5TalCLcTC1skSRts4y7bThtfeyIEGT2haZaPPAQbwxqk+IskVd
        UdQAQmRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocnOQ-00ASmC-3H; Mon, 26 Sep 2022 12:39:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81D9D3002F1;
        Mon, 26 Sep 2022 14:39:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41A152B123E2B; Mon, 26 Sep 2022 14:39:21 +0200 (CEST)
Date:   Mon, 26 Sep 2022 14:39:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        hjl.tools@gmail.com
Subject: Re: [PATCH v5 00/22] KCFI support
Message-ID: <YzGdeYzoZ1uC1CO/@hirez.programming.kicks-ass.net>
References: <20220908215504.3686827-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 08, 2022 at 02:54:42PM -0700, Sami Tolvanen wrote:
> KCFI is a forward-edge control-flow integrity scheme in the upcoming
> Clang 16 release, which is more suitable for kernel use than the
> existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
> LTO, doesn't alter function references to point to a jump table, and
> won't break function address equality.
> 
> This series replaces the current arm64 CFI implementation with KCFI
> and adds support for x86_64.
> 
> KCFI requires assembly functions that are indirectly called from C
> code to be annotated with type identifiers. As type information is
> only available in C, the compiler emits expected type identifiers
> into the symbol table, so they can be referenced from assembly
> without having to hardcode type hashes. Patch 6 adds helper macros
> for annotating functions, and patches 9 and 20 add annotations.
> 
> In case of a type mismatch, KCFI always traps. To support error
> handling, the compiler generates a .kcfi_traps section for x86_64,
> which contains the locations of each trap, and for arm64, encodes
> the necessary register information to the ESR. Patches 10 and 22 add
> arch-specific error handlers.
> 
> To test this series, you'll need a ToT Clang toolchain. The series
> is also available pn GitHub:
> 
>   https://github.com/samitolvanen/linux/commits/kcfi-v5

As mentioned at plumbers, my only concern is somewhat excessive use of
CFI_CLANG as oposed to something more compiler neutral. But I suppose
that's something we can cleanup/fix when GCC grows support for this.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

(as in I ran kCFI + call-depth-tracking + FineIBT on a bunch of
hardware)

HJL, can you look at adding kCFI support to GCC ?
