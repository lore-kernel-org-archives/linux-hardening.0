Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBB5C433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Sep 2021 11:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679CC61004
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Sep 2021 11:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhIFLpb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Sep 2021 07:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhIFLpa (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Sep 2021 07:45:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A8B6056B;
        Mon,  6 Sep 2021 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630928666;
        bh=hC5aPFrcJXwbmvjAje6ve3g5ksRe+uHuix3L09NNEV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewzHkc4zSgJrADj9ahsPtGZXlDqwdosotrGK6DuC6g/5wIXWEKEQQTI82xGltsPTd
         pbgrEDuzgEtQ8WI8HPYdVOePN3gzLU2p2ybimTzHXJXnE014KyeTMddocnCBpFIjZR
         FISq63FVHNtirACoFmUzRZZQ4Zq9FHg98XPETfJCLx0KVa0xgSBbASBnkB7SES6Rzx
         HRk4ChefTDblw9H+ks76yYSeyvAcl6JL7K/8Q/PkomXnkxFRtHahD8kYEWE7HTdICs
         oIbJJqhZSf4YYndt82K73QEfdSzLn0+aFimgi5R7L6Z9B4Z3VZRncX5o1z00mgl0Vd
         RVDqTqYwNoENw==
Date:   Mon, 6 Sep 2021 12:43:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20210906114350.GB4309@sirena.org.uk>
References: <202109022012.756B6B5B79@keescook>
 <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
 <45312958-B844-4B4C-9808-8205866675A1@chromium.org>
 <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
 <202109051123.11E4E31@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <202109051123.11E4E31@keescook>
X-Cookie: I smell a RANCID CORN DOG!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 05, 2021 at 11:31:44AM -0700, Kees Cook wrote:
> On Sun, Sep 05, 2021 at 10:36:22AM -0700, Linus Torvalds wrote:

> > > Yeech. Yeah, no, that was not expected at all. I even did test merge builds against your latest tree before sending the Pull Request. This has been in -next for weeks, too.

> > Sadly, I don't think linux-next checks for warnings.

> Oh, I thought I'd gotten such reports from sfr before, but certainly the
> 0day bot and others have yelled loudly about new warnings (from earlier
> iterations of this series in -next).

Yes, Stephen will report new warnings in the configs he tested and
there's a bunch of people who like to go around fixing warnings whenever
they do appear though only in the more common configurations.

> > > What was the build environment?

> > This is actually just bog-standard gcc-11.2 from F34, and an allmodconfig build.

> Ah, fun. Yeah, I'm behind on versions, it seems. Default gcc version on
> latest stable Ubuntu release is 10.3. I will go retest on the devel
> release.

If you're looking for coverage on this stuff it's also good to check
with clang as well, it's sufficiently different that it often triggers
extra stuff (eg, turning on -Werror broke i386 allmodconfig for clang-10
since that triggers some stack frame size warnings which are now
errors).

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE1/vUACgkQJNaLcl1U
h9Cf2Qf/XxqoOJVy17BQ8WlyOMfwUSZl8yxck50R61Fkj3TDtAnU89NtCmKleen1
u8ReMG75E0DjgKcwZ9SkQoMf0gUdplD+kKsvTAGvM2PvNGsUsnIt/ga97LuLztNz
3e1J1s7mcEqSiwg10dukT/Qw4YuaMdA5GCuLcUYkROJY65q+du9ACRJeeH3i5+US
Bfw8MBbdAzJ/iEhRdFT32BqJ3FFNDhdk+cVZL12ZO9K8YDu/LJZJqzgeJ/t1/9Bb
F6CvE6YWL6PoqnHNxjL7lfVvLbP9IIcrurXgwozU2Od4M8CxcRWR8mGmSf59xlD7
k2hzt8WrX47o/PZaUHcj8HV8yTJfqQ==
=fxh3
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
