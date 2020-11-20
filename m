Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26B9C63777
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 09:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04A5223B0
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 09:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="dmmoHeCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKTJko (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:40:44 -0500
Received: from devianza.investici.org ([198.167.222.108]:32879 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgKTJkn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 04:40:43 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4Ccs3r0wPLz6vPh;
        Fri, 20 Nov 2020 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605865240;
        bh=PbWUrb7U17LvC7vdhx246zZkpUWYUniGXQoPakvg+tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmmoHeCUJNteqD2LffKlSylmuSZ/RAr9peLSSlkI3sYTVkUQ/etNyUoJbNnsI31o8
         w+H26vDX4hzquiRN8/geZ3nQDmyHvBSad/d3dQwWJwGVohgm12KGfMiJacdElR99O+
         uFTC99BF/ZDaivNJ+xIVbO8hpIQW+lZxuqiALhJg=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4Ccs3q5Nv1z6vLB;
        Fri, 20 Nov 2020 09:40:39 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net, keescook@chromium.org
Subject: Re: [PATCH v6 0/5] Fortify strscpy()
Date:   Fri, 20 Nov 2020 10:40:38 +0100
Message-ID: <5676804.6kI0aEeX2c@machine>
In-Reply-To: <20201119173543.8821881942022fc4f39c4c73@linux-foundation.org>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com> <20201119173543.8821881942022fc4f39c4c73@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le vendredi 20 novembre 2020, 02:35:43 CET Andrew Morton a =E9crit :
> On Thu, 19 Nov 2020 17:49:10 +0100 laniel_francis@privacyrequired.com wro=
te:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > Hi.
> >=20
> >=20
> > I hope your families, friends and yourselves are fine.
>=20
> Thanks.  You too ;)

Thank you!

> > This patch set answers to this issue:
> > https://github.com/KSPP/linux/issues/46
>=20
> I fail to understand what this patchset has to do with that
> one-element-array issue :(

I think I linked another issue totally not related with that one...

> > I based my modifications on top of two patches from Daniel Axtens which
> > modify calls to __builtin_object_size to ensure the true size of char *
> > are returned and not the surrounding structure size.
> >=20
> > To sum up, in my first patch I implemented a fortified version of strsc=
py.
> > This new version ensures the following before calling vanilla strscpy:
> > 1. There is no read overflow because either size is smaller than src
> > length
> > or we shrink size to src length by calling fortified strnlen.
> > 2. There is no write overflow because we either failed during compilati=
on
> > or at runtime by checking that size is smaller than dest size.
> > The second patch brings a new file in LKDTM driver to test this new
> > version. The test ensures the fortified version still returns the same
> > value as the vanilla one while panic'ing when there is a write overflow.
> > The third just corrects some typos in LKDTM related file.
> >=20
> > If you see any problem or way to improve the code, feel free to share i=
t.
>=20
> Could you please send along a reworked [0/n] cover letter?  Explain in
> your own words, without requiring that readers go off and read web
> pages
>=20
> - What problem the patchset solves
> - How it solves it
> - The value of the patchset (to kernel developers or to end-users) so that
> we can understand why it should be merged.
>=20
> Thanks.

I will do it, moreover Kees Cook already told me that cover letter should=20
suffices itself (e.g. if the issue disappeared on GitHub).
So I will rework the cover letter for the v7!



