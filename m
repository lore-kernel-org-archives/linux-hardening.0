Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6006BC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 02:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC05611CC
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 02:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhJOCxm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 22:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232508AbhJOCxl (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 22:53:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B481F61164;
        Fri, 15 Oct 2021 02:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634266295;
        bh=xfa1FDvrYIPbLUuhSPJIPmO7l0zCqArc6ijIUDKEkHo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=KYUn4ELbwLOcfd6ppWPCIcwp5wxJ1CpgHATf11+xDCj8kJsp/BmiMPI1QyoI9g72z
         AEH1RvFqEtucwuyLj37MaNkshxlNeJH1GTpoC82cW6uxmzNAShGfez4w847orhTB+m
         sUIOYsip6HXWoQCUCxfd+r4TXmXAFrgM/6ZGCFjgrW3YRzOktWDTauwkfBlX8AKxkE
         w1d5e9gFGzL9n+rHUdVPzBROEmfFCibtGNm57z3+IivfY9CHdt/0K0vsuCp1en2SwB
         VdJ+C8OR2PBLK94fRV9lCkFxw6revfOfCTwulITmh7TpULew9odd3qdSD+NzMwt73h
         NC/vS2Gb0X6ng==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C4A4327C0054;
        Thu, 14 Oct 2021 22:51:33 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Thu, 14 Oct 2021 22:51:33 -0400
X-ME-Sender: <xms:texoYYf3qltLySHhovM0r6zsyEVmacR7EZsftG1E5sT3topjzISHuA>
    <xme:texoYaPKmCxbAmD27rFZJKXBgfMUmKlJC06moT83rCEEJjfkJQCO3Oyaqwc06mH9o
    caKMReOlSofBYvKN9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddufedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:texoYZgRwWLzVJZ8nV78hf5czVSZ9xumlWLV9YqMR9isxxwt0mZufw>
    <xmx:texoYd95Bs9qcwv9_rQ8Pnl6NYbHi9DWqZPzB6vONjNEbXWsBSqLCA>
    <xmx:texoYUsCGO94_jU5KykYmXp66ZRWeJMZf9fTRfRvKJVNQ93pOq2CJA>
    <xmx:texoYWLQuZO827kiCiEuXRo7Y9Z3mhIca5oqAkVhp5JYN0zHm0ijYMG2cSQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3985121E0066; Thu, 14 Oct 2021 22:51:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
In-Reply-To: <20211013181658.1020262-4-samitolvanen@google.com>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
Date:   Thu, 14 Oct 2021 19:51:11 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Sami Tolvanen" <samitolvanen@google.com>,
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



On Wed, Oct 13, 2021, at 11:16 AM, Sami Tolvanen wrote:
> The kernel has several assembly functions, which are not directly
> callable from C but need to be referred to from C code. This change ad=
ds
> the DECLARE_NOT_CALLED_FROM_C macro, which allows us to declare these
> symbols using an opaque type, which makes misuse harder, and avoids the
> need to annotate references to the functions for Clang's Control-Flow
> Integrity (CFI).
>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  include/linux/linkage.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> index dbf8506decca..f982d5f550ac 100644
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -48,6 +48,19 @@
>  #define __PAGE_ALIGNED_DATA	.section ".data..page_aligned", "aw"
>  #define __PAGE_ALIGNED_BSS	.section ".bss..page_aligned", "aw"
>=20
> +/*
> + * Declares a function not callable from C using an opaque type. Defi=
ned as
> + * an array to allow the address of the symbol to be taken without '&=
'.
> + */

I=E2=80=99m not convinced that taking the address without using & is a l=
audable goal.  The magical arrays-are-pointers-too behavior of C is a mi=
stake, not a delightful simplification.

> +#ifndef DECLARE_NOT_CALLED_FROM_C
> +#define DECLARE_NOT_CALLED_FROM_C(sym) \
> +	extern const u8 sym[]
> +#endif

The relevant property of these symbols isn=E2=80=99t that they=E2=80=99r=
e not called from C.  The relevant thing is that they are just and not o=
bjects of a type that the programmer cares to tell the compiler about. (=
Or that the compiler understands, for that matter. On a system with XO m=
emory or if they=E2=80=99re in a funny section, dereferencing them may f=
ail.)

So I think we should use incomplete structs, which can=E2=80=99t be dere=
ferenced and will therefore be less error prone.
