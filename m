Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846FC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BFF61056
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 20:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJ1Ub6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ1Ub5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Oct 2021 16:31:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A0CC061570;
        Thu, 28 Oct 2021 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ktbd+1DjEnN4yaWsYbMSKPidN4MBJBWV6jtj3Ser1Ds=; b=ISQyit89mNYojQ5T0+rvrFDDOz
        3jSWTlUHFvaXwD3L46+5p//EjAgJtumEXek2uQNtbZLgPS5mEnJFvKw0Bn4AY9ZlwrjvJbZbT0hcM
        huIZPBoxH1ZNgvnpbiRQX1W03VfEP1kIVGrH08XgBDjmHxiREyenA9T37IBetyteCNhVPZ0+w+qf8
        ENv3kqStoefSqWIBCb7lF1Gdz5lITFNlSFyXWuL5zy2/m83Zona5m7DAvS27l76ETuKMV53d03UxE
        Xb1JZtRCvSof9e9BpigYKNZJ1qteqGnABd7SaSQ+pxeh5mcYVGzoU56wu2qF8AGq8htRLYrH0eXVC
        XNoEgb1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgC1K-00CswS-Oo; Thu, 28 Oct 2021 20:29:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A63D798629C; Thu, 28 Oct 2021 22:29:05 +0200 (CEST)
Date:   Thu, 28 Oct 2021 22:29:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211028202905.GO174703@worktop.programming.kicks-ass.net>
References: <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <202110270939.F5C79CC@keescook>
 <YXnC1jqwR2ZKfMdk@hirez.programming.kicks-ass.net>
 <202110271430.2A3980217@keescook>
 <YXqE82jQh4S79uVL@hirez.programming.kicks-ass.net>
 <202110280958.22E5F74@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110280958.22E5F74@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 28, 2021 at 10:12:32AM -0700, Kees Cook wrote:
> On Thu, Oct 28, 2021 at 01:09:39PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 27, 2021 at 03:27:59PM -0700, Kees Cook wrote:
> > 
> > > Right -- though wouldn't just adding __ro_after_init do the same?
> > > 
> > > DEFINE_STATIC_CALL(static_call_name, func_a) __ro_after_init;
> > 
> > That breaks modules (and your jump_label patch doing the same is
> > similarly broken).
> 
> Well that's no fun. :) I'd like to understand this better so I can fix
> it!
> 
> > 
> > When a module is loaded that uses the static_call(), it needs to
> > register it's .static_call_sites range with the static_call_key which
> > requires modifying it.
> 
> Reading static_call_add_module() leaves me with even more questions. ;)

Yes, that function is highly magical..

> It looks like module static calls need to write to kernel text? 

No, they need to modify the static_call_key though.

> I don't
> understand. Is this when a module is using an non-module key for a call
> site? And in that case, this happens:
> 
>                 key |= s_key & STATIC_CALL_SITE_FLAGS;
> 
> Where "key" is not in the module?
> 
> And the flags can be:
> 
> #define STATIC_CALL_SITE_TAIL 1UL       /* tail call */
> #define STATIC_CALL_SITE_INIT 2UL       /* init section */
> 
> But aren't these per-site attributes? Why are they stored per-key?

They are per site, but stored in the key pointer.

So static_call has (and jump_label is nearly identical):

struct static_call_site {
	s32 addr;
	s32 key;
};

struct static_call_mod {
	struct static_call_mod *next;
	struct module *mod;
	struct static_call_sutes *sites;
};

struct static_call_key {
	void *func;
	union {
		unsigned long type;
		struct static_call_mod *mods;
		struct static_call_site *sites;
	};
};

__SCT_##name() tramplines		(no analog with jump_label)

.static_call_sites section
.static_call_tramp_key section		(no analog with jump_label)

Where the key holds the current function pointer and a pointer to either
an array of static_call_site or a pointer to a static_call_mod.

Now, a key observation is that all these data structures are word
aligned, which means we have at least 2 lsb bits to play with. For
static_call_key::{mods,sites} the LSB indicates which, 0:mods, 1:sites.

Then the .static_call_sites section is an array of struct
static_call_site sorted by the static_call_key pointer.

The static_call_sites holds relative displacements, but represents:

	struct static_call_key *key;
	unsigned long call_address;

Now, since code (on x86) is variable length, there are no spare bits in
the code address, but since static_call_key is aligned, we have spare
bits. It is those bits we use to encode TAIL (Bit0) and INIT (Bit1).

If INIT, the address points to an __init section and we shouldn't try
and touch if after those have been freed or bad stuff happens.

If TAIL, it's a tail-call and we get to write a jump instruction instead
of a call instruction.

So, objtool builds .static_call_sites at built time, then at init (or
module load) time we sort the array by static_call_key pointer, such
that we get consequtive ranges per key. We iterate the array and every
time the key pointer changes, we -- already having the key pointer --
set key->sites to the first.

Now, kernel init of static_call happens *really* early and memory
allocation doesn't work yet, which is why we have that {mods,sites}
thing. Therefore, when the first module gets loaded, we need to allocate
a struct static_call_mod for the kernel (mod==NULL) and transfer the
sites pointer to it and change key to a mods pointer.

So one possible solution would be to have a late init (but before RO),
that, re-iterates the sites array and pre-allocates the kernel
static_call_mod structure.  That way, static_call_key gets changed to a
mods pointer and wouldn't ever need changing after that, only the
static_call_mod (which isn't RO) gets changed when modules get
added/deleted.

The above is basically identical to jump_labels. However static_call()
have one more trick:

  EXPORT_STATIC_CALL_TRAMP()

That exports the trampoline symbol, but not the static_call_key data
structure. The result is that modules can use the static_call(), but
cannot use static_call_update() because they cannot get at the key.

In this case objtool cannot correctly put the static_call_key address in
the static_call_site, what it does instead is store the trampoline
address (there's a 1:1 relation between key and tramplines). And then we
ues the .static_call_tramp_key section to find a mapping from trampoline
to key and rewrite the site to be 'right'. All this happens before
sorting it on key obv.

Hope that clarifies things, instead of making it worse :-)
