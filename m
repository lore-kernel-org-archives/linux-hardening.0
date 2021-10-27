Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4011FC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 14:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E45B60F38
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 14:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbhJ0OGU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbhJ0OGT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 10:06:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD30C061570;
        Wed, 27 Oct 2021 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rZFyHeRVZKV32ARO4cmxe/axEb+Rr/x9yD53+sl/OlY=; b=phKT767jvGh32MVsAxMl47EP5P
        wwCM3/H9RzMOVVZA4ft6XzYW0e6WaC0I6Rv4mhVT5fTAgn0yby2N+wb1MTi6OQQr4EfPzwxaBW7ph
        acuxsIrP+a7pulqN6j2acgdoK7qxYotO7BtbciWoPZ/ZlqTT5XFaQh6oXS7IJbdr5ojYP5udZljfF
        SgYGwV7Td9B2DehJC62rCILdXkZLJQpPjaxXUt4OC9P2ZCW6U/1uSl05L1M+hak9MUl1rW2D3hEE1
        pQN8LydhRrFUCBYsFjfeXd8srrHEKWxF5Ft7rrIsXEELTfdjvI2fN5HCWR4OQiqn1y8dMlvEZsQOI
        I265IATA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfjWe-00CZ1O-0S; Wed, 27 Oct 2021 14:03:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CED530018E;
        Wed, 27 Oct 2021 16:03:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 610572C8E6567; Wed, 27 Oct 2021 16:03:30 +0200 (CEST)
Date:   Wed, 27 Oct 2021 16:03:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 03:30:11PM +0200, Ard Biesheuvel wrote:

> As far as I can tell from playing around with Clang, the stubs can
> actually be executed directly, 

I had just finished reading the clang docs which suggest as much and was
about to try what the compiler actually generates.

> they just jumps to the actual function.
> The compiler simply generates a jump table for each prototype that
> appears in the code as the target of an indirect jump, and checks
> whether the target appears in the list.
> 
> E.g., the code below
> 
> void foo(void) {}
> void bar(int) {}
> void baz(int) {}
> void (* volatile fn1)(void) = foo;
> void (* volatile fn2)(int) = bar;
> 
> int main(int argc, char *argv[])
> {
>   fn1();
>   fn2 = baz;
>   fn2(-1);
> }
> 
> produces
> 
> 0000000000400594 <foo.cfi>:
>   400594: d65f03c0 ret
> 
> 0000000000400598 <bar.cfi>:
>   400598: d65f03c0 ret
> 
> 000000000040059c <baz.cfi>:
>   40059c: d65f03c0 ret

Right, so these are the actual functions ^.

> 00000000004005a0 <main>:
>   4005a0: a9bf7bfd stp x29, x30, [sp, #-16]!
> 
> // First indirect call
>   4005a4: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
>   4005a8: f9401508 ldr x8, [x8, #40]
>   4005ac: 90000009 adrp x9, 400000 <__abi_tag-0x278>
>   4005b0: 91182129 add x9, x9, #0x608
>   4005b4: 910003fd mov x29, sp
>   4005b8: eb09011f cmp x8, x9
>   4005bc: 54000241 b.ne 400604 <main+0x64>  // b.any
>   4005c0: d63f0100 blr x8

That's impenetrable to me, sorry.

> // Assignment of fn2
>   4005c4: 90000009 adrp x9, 400000 <__abi_tag-0x278>
>   4005c8: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
>   4005cc: 91184129 add x9, x9, #0x610
>   4005d0: f9001909 str x9, [x8, #48]

I'm struggling here, x9 points to the branch at 400610, but then what?

x8 is in .data somewhere?

> // Second indirect call
>   4005d4: f9401908 ldr x8, [x8, #48]
>   4005d8: 90000009 adrp x9, 400000 <__abi_tag-0x278>
>   4005dc: 91183129 add x9, x9, #0x60c
>   4005e0: cb090109 sub x9, x8, x9
>   4005e4: 93c90929 ror x9, x9, #2
>   4005e8: f100053f cmp x9, #0x1
>   4005ec: 540000c8 b.hi 400604 <main+0x64>  // b.pmore
>   4005f0: 12800000 mov w0, #0xffffffff            // #-1
>   4005f4: d63f0100 blr x8
> 
> 
>   4005f8: 2a1f03e0 mov w0, wzr
>   4005fc: a8c17bfd ldp x29, x30, [sp], #16
>   400600: d65f03c0 ret
>   400604: d4200020 brk #0x1


> 0000000000400608 <__typeid__ZTSFvvE_global_addr>:
>   400608: 17ffffe3 b 400594 <foo.cfi>
> 
> 000000000040060c <__typeid__ZTSFviE_global_addr>:
>   40060c: 17ffffe3 b 400598 <bar.cfi>
>   400610: 17ffffe3 b 40059c <baz.cfi>

And these are the stubs per type.

> So it looks like taking the address is fine, although not optimal due
> to the additional jump.

Right.

> We could fudge around that by checking the
> opcode at the target of the call, or token paste ".cfi" after the
> symbol name in the static_call_update() macro, but it doesn't like
> like anything is terminally broken tbh.

Agreed, since the jump table entries are actually executable it 'works'.

I really don't like that extra jump though, so I think I really do want
that nocfi_ptr() thing. And going by:

  https://clang.llvm.org/docs/ControlFlowIntegrityDesign.html#forward-edge-cfi-for-indirect-function-calls

and the above, that might be possible (on x86) with something like:

/*
 * Turns a Clang CFI jump-table entry into an actual function pointer.
 * These jump-table entries are simply jmp.d32 instruction with their
 * relative offset pointing to the actual function, therefore decode the
 * instruction to find the real function.
 */
static __always_inline void *nocfi_ptr(void *func)
{
	union text_poke_insn insn = *(union text_poke_insn *)func;

	return func + sizeof(insn) + insn.disp;
}

But really, that wants to be a compiler intrinsic.
