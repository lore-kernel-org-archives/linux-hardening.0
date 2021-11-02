Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F923C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 21:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1084A6109F
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 21:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhKBVFh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhKBVFh (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 17:05:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68B61608FE;
        Tue,  2 Nov 2021 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635886981;
        bh=z+hVzXNghIcbV+r8KbOGewHIfEFdNzsSyt90QW7QRoo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=rFW0exD5vK/pXZPsXsQl49M+NpDymOQSvFwCUSrQr6XM+BcrOGpr0PpVsPBpM1RWP
         GXWKI2JAaiIUsl18nFq91mVODofEKa6ZcYUdv1d5SIn7DHfnKbk/bbvM1rOckjVdRx
         CYnfhdK2zgFDlpiEwIBrivTSBfrFiTriaMyXhqAQ1Q7eNp8aT+LD3TULnJfpja3GIQ
         x2ATYtVduUW5TAU9L/wesjwSoyNY5VoC4lJpv4JjdvE5N13tuvlLZqVkL/9iy9k5z+
         OCxBJJ3v/jhUsO8qaxvOJIHGglQRELjX8J4xkeeyCkSBJ6z/D+L3gRM/cdlIzxuX2V
         rgVCOZmn0e0vQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5771C27C0054;
        Tue,  2 Nov 2021 17:02:59 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Tue, 02 Nov 2021 17:02:59 -0400
X-ME-Sender: <xms:gqeBYR0vGizdHmm2QaIQehhBwYOsIF_y08PfssyQ9v1j5E9OmrQNFA>
    <xme:gqeBYYE5LCqAAObb-tKSp9PJ7Syhw0iL0QoybYPSsCColrtL7YQ3I1Mno28Cy026N
    DbfMD22GHw7aObteDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:g6eBYR66yoi2Q11gWBWpuVHqtebkwTeFRz0ZrQAdtnr7WxOSjKCEhg>
    <xmx:g6eBYe2eEz4eICHCodRuBhbkZViSulaawxefnRV_vgLSmdGT2nTrQg>
    <xmx:g6eBYUFd41PhoiKGIKhVybgHZggigsDifm8bnvGoyJHLIr6GtggZUg>
    <xmx:g6eBYX-HZ4wP9AQvGtw3xbTU3jpWEzc129aEYfGbMyIQ3wksTZdOwxbyb6o>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E1DF421E0073; Tue,  2 Nov 2021 17:02:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <90a14299-ce56-41d5-9df9-f625aae1ac70@www.fastmail.com>
In-Reply-To: <202111021040.6570189A5@keescook>
References: <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <202111021040.6570189A5@keescook>
Date:   Tue, 02 Nov 2021 14:02:38 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kees Cook" <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Ard Biesheuvel" <ardb@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Sedat Dilek" <sedat.dilek@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On Tue, Nov 2, 2021, at 11:10 AM, Kees Cook wrote:
> On Tue, Nov 02, 2021 at 01:57:44PM +0100, Peter Zijlstra wrote:
>> On Mon, Nov 01, 2021 at 03:14:41PM +0100, Ard Biesheuvel wrote:
>> > On Mon, 1 Nov 2021 at 10:05, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>=20
>> > > How is that not true for the jump table approach? Like I showed e=
arlier,
>> > > it is *trivial* to reconstruct the actual function pointer from a
>> > > jump-table entry pointer.
>> > >
>> >=20
>> > That is not the point. The point is that Clang instruments every
>> > indirect call that it emits, to check whether the type of the jump
>> > table entry it is about to call matches the type of the caller. IOW,
>> > the indirect calls can only branch into jump tables, and all jump
>> > table entries in a table each branch to the start of some function =
of
>> > the same type.
>> >=20
>> > So the only thing you could achieve by adding or subtracting a
>> > constant value from the indirect call address is either calling
>> > another function of the same type (if you are hitting another entry=
 in
>> > the same table), or failing the CFI type check.
>>=20
>> Ah, I see, so the call-site needs to have a branch around the indirect
>> call instruction.
>>=20
>> > Instrumenting the callee only needs something like BTI, and a
>> > consistent use of the landing pads to ensure that you cannot trivia=
lly
>> > omit the check by landing right after it.
>>=20
>> That does bring up another point tho; how are we going to do a kernel
>> that's optimal for both software CFI and hardware aided CFI?
>>=20
>> All questions that need answering I think.
>
> I'm totally fine with designing a new CFI for a future option,
> but blocking the existing (working) one does not best serve our end
> users.=20

I like security, but I also like building working systems, and I think I=
 disagree with you. There are a whole bunch of CFI schemes out there, wi=
th varying hardware requirements, and they provide varying degrees of fi=
ne grained protection and varying degrees of protection against improper=
 speculation.  We do not want to merge clang CFI just because it=E2=80=99=
s =E2=80=9Cready=E2=80=9D and end up with a mess that makes it harder to=
 support other schemes in the kernel.

So, yes, a good CFI scheme needs caller-side protection, especially if I=
BT isn=E2=80=99t in use.  But a good CFI scheme also needs to interopera=
te with the rest of the kernel, and this whole =E2=80=9Ccanonical=E2=80=9D=
 and symbol-based lookup and static_call thing is nonsense.  I think we =
need a better implementation, whether it uses intrinsics or little C hel=
pers or whatever.

I=E2=80=99m not saying this needs to be incompatible with current clang =
releases, but I do think we need a clear story for how operations like s=
tatic call patching are supposed to work.

FYI, Ard, many years ago we merged kernel support for the original gcc s=
tack protector. We have since *removed* it on x86_32 in favor of a nicer=
 implementation that requires a newer toolchain.


