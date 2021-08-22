Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C469C4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E78A6121E
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 15:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhHVPmD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 11:42:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:60849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhHVPmD (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 11:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629646875;
        bh=UuZ4UkwOuO4fwAH1RQdX7BwO7s8KIJlRd1rrITNYZF8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bkWeoraEtlYGICWZVAmHVXAPUaOimLrVQkLvkceXD3jPOy8YPo3Q+p3N9S1sQqg9z
         Bw1VXz21feDiw2xUkqgpv5I8sfck4nCsENMcpZ4lrHviqmAsN79veH2TWrzMIsNX6u
         tviBbrpgQELygfXzixS2zzD+j/JrSIioM5yYwy7s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1mh3Zv1wZ2-00PNEV; Sun, 22
 Aug 2021 17:41:15 +0200
Date:   Sun, 22 Aug 2021 17:41:02 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] staging/rtl8192u: Prefer kcalloc over open coded
 arithmetic
Message-ID: <20210822154044.GA8942@titan>
References: <20210822142820.5109-1-len.baker@gmx.com>
 <20210822142820.5109-3-len.baker@gmx.com>
 <202108220751.4E6ADBA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108220751.4E6ADBA@keescook>
X-Provags-ID: V03:K1:Ex3yLNGcyF9sCKaOHtewBBVYxDmatzkvqQg0FQEnAiCb1K1+Uq5
 8vh+dZg2kOmJFmjJus/aLbQDyKQmnhbtkxAyyQ4G4IAyF4OGDYNJ2Vr/x2k+D0XZ4ylXZWY
 L/sV8NfCoQr9ZLdbp35Sw62vI1t40wEsfS2zR3n8PKGKC7+WSYZvfcyy0sktPhrtlaP1wtF
 GWyZxKR11RgPBXHqASReQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6r89wfUABC0=:6Amym4gsOF4STAgzeySpGu
 1d93ReqJBhhjHqR/0ytblkDAJ8z4BpC2ilAucsoVPHbcOtAIyb5z5FIfMBXe5371KaV+VWqPJ
 mZKSuvNT2TrW502+Mbib6Lh96WKGnJ/4J8mvjGO/DRHSMUp3xu/i4VC7KZxa+GtGX47z8S2K/
 1P7xz00eROl/5ig/k91F5b4nqds2iq7yd2qFfJCQ00p9/xhDamWL69aGWmu8ywT7GQJiOyeNX
 QearhqUREO1O5II7jtt3fzgdh+ZduosqsCRGY/qgMne4duhmyWXahTpyEHiwj10wKseZUVqcV
 9sLuoNTj5nQFB0cSiINZKaaAwS0vDzaxNpACQfjnZ65C+4sWvcGIcRL6+wZY6YvAgvPg3TCJK
 LOPaEmKiNI5VC3RstU/+Q0G2XdNEgOINI5eNAu5ps64L1HO51S+udgRWWIkNgh9vpbDE0SRT5
 650r0Bz7S2dlQn37upRPBnHWCYrdW3V0ByR6GA1Hg9UQN5ZRmu9OO2S3v5IZoT5vgjAO+KLT7
 AO6KfLWSeBaIVczP1GOxO8Snsqo8VkPT0DFv1ORhU4dSxzGFvXJe1TVxOt7V3gZ8V/JNSzx8G
 lilysvpUfYHmKmxcxsvdCnN49Y1ohyOxV4gqYHr7WJwCwM0JyIk4QsCJGHM2X8nu9BAaxHIWE
 kLQw23VRTTi7hPn3b7BqEkdyxDtOeSFZjGPw6nrcNB2etIy10S40Tu3ByiXBdmf0OHQOpuKMG
 jH8cSs1vAu6jWwZwwjx0NxGv0DPBuojxNf/XzgZXESgbt6gcUFJTblVep5nQhsiwSYXO20DSR
 dkBf5wu2jv7Oa1/8JP9z/JTrzctmsNmv5T1L85Opmk8cjU+Pcm1oU64pLpQ8UZzn8R5p0oEUS
 Q1jOZ9yXi2yX59noCWKz0KrlcTzGfZ3H+EdrJh90+7HshqUVA3L88si1cKoJEaBIapx/L8i76
 1CvDzXIPWXzD/rutik2Z8PpqFW+pRy/U4T7UdyNQ/Ixq8k/txpk7cfDKZ39yeoe8FU75Vt7Ee
 LtAKBslFVaMUpewK6ukme1C/KOWk+PRHw36ApMYzpN/Psya05ycrbrzdspahx2aO6aUuexk4y
 DxPAJQilHoIJz6ZXGPGR1+YWICXWUqBDdtIDZU2pru/k3TEFBKSgd7KAQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

On Sun, Aug 22, 2021 at 07:59:51AM -0700, Kees Cook wrote:
> On Sun, Aug 22, 2021 at 04:28:20PM +0200, Len Baker wrote:
> > Dynamic size calculations (especially multiplication) should not be
> > performed in memory allocator (or similar) function arguments due to t=
he
> > risk of them overflowing. This could lead to values wrapping around an=
d
> > a smaller allocation being made than the caller was expecting. Using
> > those allocations could lead to linear overflows of heap memory and
> > other misbehaviors.
> >
> > So, use the purpose specific kcalloc() function instead of the argumen=
t
> > size * count in the kzalloc() function.
>
> It might be useful to reference the documentation on why this change is
> desired:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#open-code=
d-arithmetic-in-allocator-arguments

Ok, I will add this info to the next version. Thanks for the advise.

> Here and in the docs, though, it's probably worth noting that these
> aren't actually dynamic sizes: both sides of the multiplication are
> constant values. I still think it's best to refactor these anyway, just
> to keep the open-coded math idiom out of code, though.

Ok, I will change the commit message to note this. Also I will send
a patch to add this info to the documentation.

> Also, have you looked at Coccinelle at all? I have a hideous pile of
> rules that try to find these instances, but it really needs improvement:
> https://github.com/kees/coccinelle-linux-allocator-overflow/tree/trunk/a=
rray_size

I think my script is even worst ;) but find some arithmetic to improve :)
I will take a look. Thanks for the info.

> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Regards,
Len

> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> > ---
> >  drivers/staging/rtl8192u/r819xU_phy.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/r=
tl8192u/r819xU_phy.c
> > index ff6fe2ee3349..97f4d89500ae 100644
> > --- a/drivers/staging/rtl8192u/r819xU_phy.c
> > +++ b/drivers/staging/rtl8192u/r819xU_phy.c
> > @@ -1195,17 +1195,17 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct =
net_device *dev, u8 channel,
> >  	u8 e_rfpath;
> >  	bool ret;
> >
> > -	pre_cmd =3D kzalloc(sizeof(*pre_cmd) * MAX_PRECMD_CNT, GFP_KERNEL);
> > +	pre_cmd =3D kcalloc(MAX_PRECMD_CNT, sizeof(*pre_cmd), GFP_KERNEL);
> >  	if (!pre_cmd)
> >  		return false;
> >
> > -	post_cmd =3D kzalloc(sizeof(*post_cmd) * MAX_POSTCMD_CNT, GFP_KERNEL=
);
> > +	post_cmd =3D kcalloc(MAX_POSTCMD_CNT, sizeof(*post_cmd), GFP_KERNEL)=
;
> >  	if (!post_cmd) {
> >  		kfree(pre_cmd);
> >  		return false;
> >  	}
> >
> > -	rf_cmd =3D kzalloc(sizeof(*rf_cmd) * MAX_RFDEPENDCMD_CNT, GFP_KERNEL=
);
> > +	rf_cmd =3D kcalloc(MAX_RFDEPENDCMD_CNT, sizeof(*rf_cmd), GFP_KERNEL)=
;
> >  	if (!rf_cmd) {
> >  		kfree(pre_cmd);
> >  		kfree(post_cmd);
> > --
> > 2.25.1
> >
>
> --
> Kees Cook
