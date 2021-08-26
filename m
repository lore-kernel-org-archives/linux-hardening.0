Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4982DC432BE
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 23:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2299960F91
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 23:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhHZXZC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhHZXZB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 19:25:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D476260E8B;
        Thu, 26 Aug 2021 23:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630020253;
        bh=vLbg/rOKXJxRQLaFHT5woV57pEypVhgBxoCpcb5Lzlg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=iDNj0DtcrqzTaSOsN1GRUllGceWEce5c1JYSKuhVipTHim6rubdMz5jqna0S6yEIf
         bm4bkYgpIuC/J4WXROCavLX4kJZf4ftpom6bw6OG8JwAmGBl+yKBV3oQZt70yhZPpe
         80UpAULCFoLRzEMYy/4GdfZAcQaUUpp9ZsBsJ82sSobJAgIUKFKDRcDybMxU0/1Sj7
         XV5SHZJUFIKviKS0xGeAsMDoNfIAxtVWyC7HvNIThCDQlRe1OTBzZJTPJTHwuUiUIj
         8+BIjmLUsTh+oRYjiJOlk+gO1DUC3rmvoEm3e0VttTjVN5RaAHvd82pNR4ialjRYs1
         SUe67zRjeSz0w==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id F279027C0054;
        Thu, 26 Aug 2021 19:24:11 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Thu, 26 Aug 2021 19:24:11 -0400
X-ME-Sender: <xms:myIoYZo4fAo3elsjBHy8-cTiskHxe0-bkPgFhCRM_Wt8U2sMfByQxA>
    <xme:myIoYbqRrBNSQ1-qwhBCfuVKjyjXwnAoOzfG77nL_Xsk1QNYYUgejRVfjw7W_UATJ
    1Rp0w89CrrqhmnPQ7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeegjefghfdtledvfeegfeelvedtgfevkeeugfekffdvveeffeetieeh
    ueetveekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:myIoYWOAPwZP0E1PVxP0KwmlFHtTf14kccot6cT81Yk1NIz7pGc75A>
    <xmx:myIoYU4IijAVcMpV9qlR31L5vM59iko-7SciVOgQVZuFozWOfwLjiA>
    <xmx:myIoYY5hZzZHDGH48xyrIGISNqscX_Q2xzvKVZQ3T2dRxFn9Pao23Q>
    <xmx:myIoYatHq5kzxfR9Lpwegp7VLp9yiPw2WdLUVRYncaFuMhJgDRk3Ye5kKCk>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E7336A0378F; Thu, 26 Aug 2021 19:24:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <959b3e65-97c9-4e00-87c5-f4a31c6739de@www.fastmail.com>
In-Reply-To: <CABCJKueE=_WCLkVDmPss-Bo-1VWaX7W6SSNx33rQCO+eEv_Lzg@mail.gmail.com>
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-8-samitolvanen@google.com>
 <b2b0247a-39ad-097b-8fab-023ee378c806@kernel.org>
 <CABCJKueE=_WCLkVDmPss-Bo-1VWaX7W6SSNx33rQCO+eEv_Lzg@mail.gmail.com>
Date:   Thu, 26 Aug 2021 16:23:50 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sami Tolvanen" <samitolvanen@google.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Sedat Dilek" <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_07/14]_x86:_Use_an_opaque_type_for_functions_not?=
 =?UTF-8?Q?_callable_from_C?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On Thu, Aug 26, 2021, at 3:11 PM, Sami Tolvanen wrote:
> On Thu, Aug 26, 2021 at 9:54 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> > > The kernel has several assembly functions that are not directly callable
> > > from C. Use an opaque type for these function prototypes to make misuse
> > > harder, and to avoid the need to annotate references to these functions
> > > for Clang's Control-Flow Integrity (CFI).
> >
> > You have:
> >
> > typedef const u8 *asm_func_t;
> >
> > This is IMO a bit confusing.  asm_func_t like this is an *address* of a
> > function, not a function.
> >
> > To be fair, C is obnoxious, but I think this will lead to more confusion
> > than is idea.  For example:
> >
> > > -extern void __fentry__(void);
> > > +DECLARE_ASM_FUNC_SYMBOL(__fentry__);
> >
> > Okay, __fentry__ is the name of a symbol, and the expression __fentry__
> > is a pointer (or an array that decays to a pointer, thanks C), which is
> > at least somewhat sensible.  But:
> >
> > > -extern void (*paravirt_iret)(void);
> > > +extern asm_func_t paravirt_iret;
> >
> > Now paravirt_iret is a global variable that points to an asm func.  I
> > bet people will read this wrong and, worse, type it wrong.
> >
> > I think that there a couple ways to change this that would be a bit nicer.
> >
> > 1. typedef const u8 asm_func_t[];
> >
> > This is almost nice, but asm_func_t will still be accepted as a function
> > argument, and the automatic decay rules will probably be confusing.
> >
> > 2. Rename asm_func_t to asm_func_ptr.  Then it's at least a bit more clear.
> >
> > 3. Use an incomplete struct:
> >
> > struct asm_func;
> >
> > typedef struct asm_func asm_func;
> >
> > extern asm_func some_func;
> >
> > void *get_ptr(void)
> > {
> >     return &some_func;
> > }
> >
> > No macros required, and I think it's quite hard to misuse this by
> > accident.  asm_func can't be passed as an argument or used as a variable
> > because it has incomplete type, and there are no arrays so the decay
> > rules aren't in effect.
> 
> I considered using an incomplete struct, but that would require an
> explicit '&' when we take the address of these symbols, which I
> thought would be unnecessary churn. Unless you strongly prefer this
> one, I'll go with option 2 and rename asm_func_t to asm_func_ptr in
> v3.
> 

Do you have a sense for how many occurrences there are that would need an &?

> Sami
> 
