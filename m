Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C7C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 16:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A2A6109E
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 16:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhJOQY5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236598AbhJOQY5 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 12:24:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A510604DB;
        Fri, 15 Oct 2021 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634314970;
        bh=yThbssGrc0NqhJCJciVSOLwdJ3xsnZpy7ynah9IDzjc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=lYOu8edKHuQbRSL/wGuTXlaXasBfYAfN7FTaCQyYMjjyuBs2Va3CZWVJEcI/y2Yzl
         6vxWj0N4i2Q7IvTvUn39GNE7p287Kp1LOL4bhevh9Y1ydrOgKuDSd21LMq+m3V83ZT
         NYhzYaaJ7jbM97TL3d/6BmnKebyhcL4B30RbcMo7GKr7rXM5KwqPToeNiX6+XWzqAT
         WQP3bd24A2ZudEhkQaClfRXg0g1sQ5h0Tm6+Hi5gQfHAOjUCbM7JymxAIEDThXKeGR
         kXNmc5WsIjApnLywAYuTjOKNGunpJelflf32K51VcP3Mljcd/T6T9iJyowum4877yS
         THelCJ7YMklMg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A482727C005A;
        Fri, 15 Oct 2021 12:22:48 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Fri, 15 Oct 2021 12:22:48 -0400
X-ME-Sender: <xms:2KppYYHZXc5F5814GuviBQt3dBPMqTAe0JUJV4z8kZGLCGlUelmp5w>
    <xme:2KppYRWeQdgPQcdge5LwC622kGmkflWN2ZlcdAfq06vaJt7APC76YjSoYOCwbCU_t
    iAo4ibBexziw9S66ts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:2KppYSKFs_BxNt8MPsCSd3Yt4phhexq-QIIRpk_0ACGioKc0CA6-RA>
    <xmx:2KppYaGnR0Lq_Oe8tejDTU163rQhIuANvunN6fnlNIhEyYkNK_b2yg>
    <xmx:2KppYeXJzPshJpwXSicxkvhdEfrw-LVlndq2de9HLrL8vhhp2CkL4Q>
    <xmx:2KppYXOfvXRd_SOq3yEJrwB-Cn41d9yFKsL5J-a37dW2qLNHqe_J-uHxowg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 50FAA21E0063; Fri, 15 Oct 2021 12:22:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <eda70a35-33a8-43b4-a839-65f2a1f91bb5@www.fastmail.com>
In-Reply-To: <8735p25llh.ffs@tglx>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com> <8735p25llh.ffs@tglx>
Date:   Fri, 15 Oct 2021 09:22:27 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     "Kees Cook" <keescook@chromium.org>,
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



On Fri, Oct 15, 2021, at 8:55 AM, Thomas Gleixner wrote:
> On Thu, Oct 14 2021 at 19:51, Andy Lutomirski wrote:
>> On Wed, Oct 13, 2021, at 11:16 AM, Sami Tolvanen wrote:
>>>=20
>>> +/*
>>> + * Declares a function not callable from C using an opaque type. De=
fined as
>>> + * an array to allow the address of the symbol to be taken without =
'&'.
>>> + */
>> I=E2=80=99m not convinced that taking the address without using & is a
>> laudable goal.  The magical arrays-are-pointers-too behavior of C is a
>> mistake, not a delightful simplification.
>
>>> +#ifndef DECLARE_NOT_CALLED_FROM_C
>>> +#define DECLARE_NOT_CALLED_FROM_C(sym) \
>>> +	extern const u8 sym[]
>>> +#endif
>>
>
>> The relevant property of these symbols isn=E2=80=99t that they=E2=80=99=
re not called
>> from C.  The relevant thing is that they are just and not objects of a
>> type that the programmer cares to tell the compiler about. (Or that
>> the compiler understands, for that matter. On a system with XO memory
>> or if they=E2=80=99re in a funny section, dereferencing them may fail=
.)
>
> I agree.
>
>> So I think we should use incomplete structs, which can=E2=80=99t be
>> dereferenced and will therefore be less error prone.
>
> While being late to that bike shed painting party, I really have to ask
> the question _why_ can't the compiler provide an annotation for these
> kind of things which:
>
>     1) Make the build fail when invoked directly
>
>     2) Tell CFI that this is _NOT_ something it can understand
>
> -void clear_page_erms(void *page);
> +void __bikeshedme clear_page_erms(void *page);
>
> That still tells me:
>
>     1) This is a function
>   =20
>     2) It has a regular argument which is expected to be in RDI
>
> which even allows to do analyis of e.g. the alternative call which
> invokes that function.
>
> DECLARE_NOT_CALLED_FROM_C(clear_page_erms);
>
> loses these properties and IMO it's a tasteless hack.
>


Ah, but clear_page_erms is a different beast entirely as compared to, sa=
y, the syscall entry. It *is* a C function.  So I see two ways to handle=
 it:

1. Make it completely opaque.  Tglx doesn=E2=80=99t like it, and I agree=
, but it would *work*.

2. Make it a correctly typed function. In clang CFI land, this may or ma=
y not be =E2=80=9Ccanonical=E2=80=9D (or non canonical?).

I think #2 is far better. I complained about this quite a few versions a=
go, and, sorry, the word =E2=80=9Ccanonical=E2=80=9D is pretty much a no=
n-starter. There needs to be a way to annotate a function pointer type a=
nd an extern function declaration that says =E2=80=9Cthe callee follows =
the ABI *without CFI*=E2=80=9D and the compiler needs to do the right th=
ing. And whatever attribute or keyword gets used needs to give the reade=
r at least some chance of understanding.

(If there is a technical reason why function *pointers* of this type can=
=E2=80=99t be called, perhaps involving IBT, so be it.  But the type sys=
tem should really be aware of C-ABI functions that come from outside the=
 CFI world.)

It looks like clear_page might be improved by using static_call some day=
, and then proper typing will be a requirement.

Would it help if I file a clang bug about this?
