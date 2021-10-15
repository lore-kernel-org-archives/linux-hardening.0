Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C6DC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 19:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AE5611C1
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 19:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbhJOTiI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235221AbhJOTiG (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 15:38:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B140B61164;
        Fri, 15 Oct 2021 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634326559;
        bh=AZ5p6oEVThK3Hju2UMF66DeyAGk6wtxhmCc/P49JGZY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=QG1N0CPTSMVPjvRQ/dBLSGz7kCaVVYvN8kYBGIb9n7YZhEASCwZMnHkWb8Ku9NIE1
         BWQraZItdtSwjvKcoM/ZW/ME8P052uovATvI7XZIjvU3UHwg2xFQYRN1/DW22I632/
         6VG0HxKEYsV7oJLb5l/bVQ5gHOe2jnILeRerv9qCRV6Gvaqt86S8SlgjL7Vks35MGg
         yq+qGZ7BY1yu1LC9/kFlKlrJYL51WXrWh1AJri42/nquhEqRnBcqDz3aICfOwrAqhG
         K/YsJ77uvJMtParKPyCafpjSabB309SfL4qbXPT6OWvrXrjZu0FvB4Op4AZyZGQ7UU
         g+h6mVbOsgOhg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id BD6DA27C0054;
        Fri, 15 Oct 2021 15:35:57 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Fri, 15 Oct 2021 15:35:57 -0400
X-ME-Sender: <xms:HdhpYVS3E_KDyVr09KiFeRY-MRjhWyiP5lu9oyj7m8uUBvi_wdK2Fg>
    <xme:HdhpYeyigOqf6ue2VNZzUSfaFQbPmHDAwSHRbl7aibVBsXwOkPJA4_vmRM5V8CKPC
    dw68ollmPaLCgFKmps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhephfelhfdugeetvdfhfeeuveevtdegueekhfffheetffdtleevtdeh
    tdeivdeuvedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:HdhpYa2-FTzPO0fAaKG4u5I9xftlZGa5Z8lb1HIFmkQtMFU0IwF8hw>
    <xmx:HdhpYdAJ8TAAORamFxldXaN_0t3V3NNYgSNg7w9g050ccioVUns5-w>
    <xmx:HdhpYejRdQ3UIOSEhz8ASRxIybaVFlpSKGowGWwyOoDGNyBPQHCUlw>
    <xmx:HdhpYTauFATTZqnctJ6ZvWlWOjq_qCIVZQOBhDLGKHtHvAiSPK0gy8d-H7o>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 626A821E0066; Fri, 15 Oct 2021 15:35:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <ecbe49c8-b30b-456c-931a-cc65647b0958@www.fastmail.com>
In-Reply-To: <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com> <8735p25llh.ffs@tglx>
 <87zgra41dh.ffs@tglx>
 <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
Date:   Fri, 15 Oct 2021 12:35:37 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sami Tolvanen" <samitolvanen@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Sedat Dilek" <sedat.dilek@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 15, 2021, at 11:42 AM, Sami Tolvanen wrote:
>>   https://lore.kernel.org/lkml/alpine.LFD.2.00.1001251002430.3574@localhost.localdomain/
>>
>> That said, I still want to have a coherent technical explanation why the
>> compiler people cannot come up with a sensible annotation for these
>> things.
>
> I can only assume they didn't think about this specific use case.

I must be missing something here.  Linux is full of C-ABI functions implemented in asm.  Just off of a quick grep:

asm_load_gs_index, memset, memmove, basically everything in arch/x86/lib/*.S

If they're just declared and called directly from C, it should just work.  But an *indirect* call needs some sort of special handling.  How does this work in your patchset?

Then we get to these nasty cases where, for some reason, we need to explicitly grab the actual entry point or we need to grab the actual literal address that we can call indirectly.  This might be alternative_call, where we're trying to be fast and we want to bypass the CFI magic because, despite what the compiler might try to infer, we are doing a direct call (so it can't be the wrong address due a runtime attack, ENDBR isn't needed, etc).  And I can easily believe that the opposite comes to mind.  And there are things like exception entries, where C calls make no sense, CFI makes no sense, and they should be totally opaque.

So I tend to think that tglx is right *and* we need an attribute, because there really are multiple things going on here.

SYM_FUNC_START(c_callable_func)
  ...
  ret
SYM_FUNC_END

extern __magic int c_callable_func(whatever);

Surely *something* needs to go where __magic is to tell the compiler that we have a function that wasn't generated by a CFI-aware compiler and that it's just a C ABI function.  (Or maybe this is completely implicit?  I can't keep track of exactly which thing generates which code in clang CFI.)

But we *also* have the read-the-address thing:

void something(void)
{
  /* actual C body */
}
alternative_call(something, someotherthing, ...);

That wants to expand to assembly code that does:

CALL [target]

where [target] is the actual first instruction of real code and not a CFI prologue.  Or, inversely, we want:

void (*ptr)(void) = something;

which (I presume -- correct me if I'm wrong) wants the CFI landing pad.  It's not the same address.

And this all wants to work both for asm-defined functions and C-defined functions.  This really is orthogonal to the is-it-asm-or-is-it-C things.  All four combinations are possible.

Does this make any sense?  I kind of thing we want the attributes and the builtin, along the lines of:

asm("call %m", function_nocfi_address(something));

or however else we wire it up.

(And, of course, the things that aren't C functions at all, like exception entries, should be opaque.)
