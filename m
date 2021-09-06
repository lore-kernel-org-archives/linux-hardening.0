Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A392BC4321E
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Sep 2021 05:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888F261054
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Sep 2021 05:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhIFF2n (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Sep 2021 01:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbhIFF2m (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Sep 2021 01:28:42 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E2C061575;
        Sun,  5 Sep 2021 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1630906056;
        bh=wRP6H3xLozP+d9ZCC0YyBnN4YegkYGX8jU5kAZtJ8wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e7DBWt2dHzczZJHJC3Fxf1pVNLIJvvXAhYy3hSn8gmqQ0T5iDw6h02QhhOPzn3OSb
         I0sXOP3TQ0NiAAqdcAP0h0YQNGe0ZK6+KCH4+9rHKfhm1xAd8nlZ6WpYIyqo39PtI5
         Wjzos/xJTVK5xydm+3aAMh3Hry/Rm7HTdN/0o8iSkCqy6VUbFYN15ZoafJ7wLwZooh
         QVUCIkLT1xEwmiAyh06BhKm068ElOo/PJ8cHtVUtH0WcNwt+H1XyA5uOMbXZbhmWV0
         y2CY1x31lpnbn/GlHIiq5zjbdmi/D5ByV6KYLMQqAhub8E4Qy5+cnR36x8nCfupORF
         98TFtuf+A2Y2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H2xjx0Fs0z9sVw;
        Mon,  6 Sep 2021 15:27:32 +1000 (AEST)
Date:   Mon, 6 Sep 2021 15:27:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] overflow updates for v5.15-rc1
Message-ID: <20210906152731.43a9c67e@canb.auug.org.au>
In-Reply-To: <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
References: <202109022012.756B6B5B79@keescook>
        <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
        <45312958-B844-4B4C-9808-8205866675A1@chromium.org>
        <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=Sbf_q1jPPWfNEYdPkEF9el";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--Sig_/=Sbf_q1jPPWfNEYdPkEF9el
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sun, 5 Sep 2021 10:36:22 -0700 Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>
> On Sun, Sep 5, 2021 at 12:38 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Yeech. Yeah, no, that was not expected at all. I even did test merge bu=
ilds against your latest tree before sending the Pull Request. This has bee=
n in -next for weeks, too. =20
>=20
> Sadly, I don't think linux-next checks for warnings.

Yes, I do.  And report them.  I did not get these warnings for some
reason.  One of my builds is an X86_64 allmodconfig, currently using

x86_64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
--=20
Cheers,
Stephen Rothwell

--Sig_/=Sbf_q1jPPWfNEYdPkEF9el
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmE1psMACgkQAVBC80lX
0GwyLQf/dS0qDqLBYPog4aARLifKVXXjCe0+Apz4UYnDZAofwYOi6ACDjoVp8yMA
ei8RDDZjlL6xdBcYZkXh0eK4tBljlWxT6kiEYkM/wkZvIOD4fSqbTZWXP+NDNevi
D4EQwVsR42jEg0vHS+q6kry5a5lMnhBWObdnCTGjzMntpYActiTSxzDi6xSZlrP3
R9cZbnn60MN8vv2oPXA44FR9UFGHlfS7j9sk5Zl7ge8lUlxORnF/9PTmNVPcRSWL
23YS+dRDYSIi73tfV4ugfosr3dAesFU/11VySmjqqIwLkS1k1y5rZ8x4ViSvr5WK
iO2PNDo5nNVhfskYaHjeZjnK7+n3HQ==
=2YWD
-----END PGP SIGNATURE-----

--Sig_/=Sbf_q1jPPWfNEYdPkEF9el--
