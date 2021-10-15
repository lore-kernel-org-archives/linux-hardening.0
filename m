Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2290C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 17:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6C161164
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 17:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhJORgs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhJORgr (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 13:36:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 649ED61151;
        Fri, 15 Oct 2021 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634319280;
        bh=eDQnKq79Pn+tsR6e9shj0tLh3ap+B4EafzAtoTAIySU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=izjlETbHv6qGLz4DWk3ivH0ocwgzvmlVfvRjff3W3FKurciMi9CbUcEtqE1wEGxUo
         CK5ctY04cWtLYLZ3cAu2XtSz5scatEmKSFoOCQAsWEeDXluQxVNN20nFWyzUqK/BQ5
         C3odNOXmR2nZmLVAx7gCGuetgTyha/rvf1M6Ewg6m7TSHbFZ3nTsvDDxYaimYRND1+
         j9R/ISO42OksE/Q95sdYusi5qb0qig7m9w3oLptlJ9KV7Y3GuOohcrD64tsOnqdyVt
         tY5EGdj6ybrwA4rXd5MQqXv/a+p1MzMLUlzx8sXOMFkiHZSYBg8bxkz+76Ies5zKHQ
         6qkpfk3xeOCtA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 50BF927C0054;
        Fri, 15 Oct 2021 13:34:38 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Fri, 15 Oct 2021 13:34:38 -0400
X-ME-Sender: <xms:rrtpYXW-J2-cIntHb9SswL8GQ_ntJZaAhE11if2AiTLVxsTIwsfonw>
    <xme:rrtpYflR21qsbu-DeH_P43A9x0XGCehDbx2VEbsf08KQhwy-xThdAoAOc17ombm1A
    0KXcfJbNs-B4oP0v3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:rrtpYTb18zEF1W7CopzUfmN_6vKdperAWY6YVON0omUsg01U3IXNVA>
    <xmx:rrtpYSVY2ZlqaixTUm6IpX4liWvBCb9dU70vPm9rRvHIAeWSOyK0Hg>
    <xmx:rrtpYRmKG1scLCGUqudk-nPy1UD9ufHvj01WUNrxRGv-DJeqPoD7Gg>
    <xmx:rrtpYafUzNwiS_sVtYSyTLPLpRyLqCrBeq1gNOfle6gSGxDDOFe0VGAoXQ8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 23E1421E0066; Fri, 15 Oct 2021 13:34:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <1c8baf32-169e-4f53-9637-7e6383f20dfe@www.fastmail.com>
In-Reply-To: <CABCJKufhd3=6PR=WmteJBQ5xBnmvzQb7h3cJxDSJZjLHSSH22g@mail.gmail.com>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com> <8735p25llh.ffs@tglx>
 <eda70a35-33a8-43b4-a839-65f2a1f91bb5@www.fastmail.com>
 <CABCJKufhd3=6PR=WmteJBQ5xBnmvzQb7h3cJxDSJZjLHSSH22g@mail.gmail.com>
Date:   Fri, 15 Oct 2021 10:34:16 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sami Tolvanen" <samitolvanen@google.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On Fri, Oct 15, 2021, at 9:47 AM, Sami Tolvanen wrote:
> On Fri, Oct 15, 2021 at 9:22 AM Andy Lutomirski <luto@kernel.org> wrot=
e:
>>
>>
>>
>> On Fri, Oct 15, 2021, at 8:55 AM, Thomas Gleixner wrote:
>> > On Thu, Oct 14 2021 at 19:51, Andy Lutomirski wrote:
>> >> On Wed, Oct 13, 2021, at 11:16 AM, Sami Tolvanen wrote:
>> >>>
>> >>> +/*
>> >>> + * Declares a function not callable from C using an opaque type.=
 Defined as
>> >>> + * an array to allow the address of the symbol to be taken witho=
ut '&'.
>> >>> + */
>> >> I=E2=80=99m not convinced that taking the address without using & =
is a
>> >> laudable goal.  The magical arrays-are-pointers-too behavior of C =
is a
>> >> mistake, not a delightful simplification.
>> >
>> >>> +#ifndef DECLARE_NOT_CALLED_FROM_C
>> >>> +#define DECLARE_NOT_CALLED_FROM_C(sym) \
>> >>> +   extern const u8 sym[]
>> >>> +#endif
>> >>
>> >
>> >> The relevant property of these symbols isn=E2=80=99t that they=E2=80=
=99re not called
>> >> from C.  The relevant thing is that they are just and not objects =
of a
>> >> type that the programmer cares to tell the compiler about. (Or that
>> >> the compiler understands, for that matter. On a system with XO mem=
ory
>> >> or if they=E2=80=99re in a funny section, dereferencing them may f=
ail.)
>> >
>> > I agree.
>> >
>> >> So I think we should use incomplete structs, which can=E2=80=99t be
>> >> dereferenced and will therefore be less error prone.
>> >
>> > While being late to that bike shed painting party, I really have to=
 ask
>> > the question _why_ can't the compiler provide an annotation for the=
se
>> > kind of things which:
>> >
>> >     1) Make the build fail when invoked directly
>> >
>> >     2) Tell CFI that this is _NOT_ something it can understand
>> >
>> > -void clear_page_erms(void *page);
>> > +void __bikeshedme clear_page_erms(void *page);
>> >
>> > That still tells me:
>> >
>> >     1) This is a function
>> >
>> >     2) It has a regular argument which is expected to be in RDI
>> >
>> > which even allows to do analyis of e.g. the alternative call which
>> > invokes that function.
>> >
>> > DECLARE_NOT_CALLED_FROM_C(clear_page_erms);
>> >
>> > loses these properties and IMO it's a tasteless hack.
>> >
>>
>>
>> Ah, but clear_page_erms is a different beast entirely as compared to,=
 say, the syscall entry. It *is* a C function.  So I see two ways to han=
dle it:
>>
>> 1. Make it completely opaque.  Tglx doesn=E2=80=99t like it, and I ag=
ree, but it would *work*.
>>
>> 2. Make it a correctly typed function. In clang CFI land, this may or=
 may not be =E2=80=9Ccanonical=E2=80=9D (or non canonical?).
>
> Technically speaking the clear_page_* declarations don't need to be
> changed for CFI, they do work fine as is, but I included them in the
> patch as they're not actually called from C code right now. But you're
> right, we should use a proper function declarations for these. I'll
> drop the changes to this file in the next version.

If you were to call (with a regular C function call using ()) clear_page=
_erms, what happens?  IMO it should either work or fail to compile. Cras=
hing is no good.

>
> I wouldn't mind having a consensus on how to deal with exception
> handlers etc. though. Should I still use opaque types for those?
>

Yes, as they are not C functions.

> Sami
