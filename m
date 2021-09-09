Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B854DC433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 16:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C73161132
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 16:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhIIQKq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Sep 2021 12:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhIIQKp (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Sep 2021 12:10:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2585610FF;
        Thu,  9 Sep 2021 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631203776;
        bh=ofy0LrNyZaYuGTM0RdHHw037z4NDVWpyH/JpmR75fQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQLF3U/WBLP5uAl5aFk+7C7+oHSGf5aW0KGtjrJJIkicK7v33J96TvOEcdvz5+50m
         SeyWzPBT2wbKQcO4guk8AcKUkjnekugucbVGfIE5XhClvxY3n03yXK/pK8XIlxJ4n0
         cWZLS6W9tiudvsk4pBXmWXQGzYJYTLIJd5tLdiUYv+TCoXsVo8I5e3PUjETSTlBqMC
         biu6JnvaQcKwrcVxB82QXE5a5Gif9+FdAMf/qGqzLKWj3tL8UkGakLXmJx5c0gC13R
         anU48DdOlvzMHWGmQSW1nPy0OCb+23lJB1tBtWeNPYR1Np4mNa36lVYSYXt/YLJ49M
         GADTvLRk+RDdw==
Date:   Thu, 9 Sep 2021 17:08:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm: Use init_uts_ns.name instead of macros
Message-ID: <20210909160859.GE5176@sirena.org.uk>
References: <20210901233406.2571643-1-keescook@chromium.org>
 <202109090848.129A49E8BD@keescook>
 <YTowAX7szcAP7ItU@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <YTowAX7szcAP7ItU@kroah.com>
X-Cookie: I have become me without my consent.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 09, 2021 at 06:02:09PM +0200, Greg Kroah-Hartman wrote:

> I can't see a rebuild locally here without this patch attached, so how
> much of a problem is it right now?

It's triggering for me all the time here FWIW.

> And isn't -rc2 ok?

Lots of trees base off -rc1 so unless people change their workflow to
merge up -rc2 it'll impact submitters.

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE6MZoACgkQJNaLcl1U
h9BKVQf+MWv4pdnM4lqJnATLUtpNAoTli/lOSi86mH0obPIlcyYJmRHgdDxiIJz8
wHfBk4x3Ei5xo4P07fVBYm3mXuH/EHEiP2+842mFWTPmoRytH79drwwqU+E1cbuu
VyVn96DN0nSNkK5gvtlJJK3SemB2Du1fzgw5XbO7I6nu6YpE7C9ICGLjOJu6it8z
tsM+IIo7MCTYeMFo04JiLOSnvf7NoRAKLQNDD2OuLUjGNGSyxzKKW6Y7nOHNfj1O
mmMGZbSdB2CAzgU3LHG4+85duWaV+5OsoMpppjF0sii5Vnh8NHRpNhBZQBO80PYf
zz860eq9xk+I5ZsvVXUjd3bhU4jF8A==
=hv1h
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
