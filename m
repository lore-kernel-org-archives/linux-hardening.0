Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46807C2D0E4
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C7F22252
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 15:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="iPOpvSM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgKTPvq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 10:51:46 -0500
Received: from confino.investici.org ([212.103.72.250]:36825 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgKTPvq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 10:51:46 -0500
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4Cd1Hz5TDSz115q;
        Fri, 20 Nov 2020 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605887503;
        bh=xaqO1+KopYk7SsjxvaHIb9pLWW1k+TeBHLFfUnwp7/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPOpvSM/2l260ZsZLa+8KlHIUP6LBT87h9FDrnKQdt6XqO8mT6Vdxoy/3sUj6E9Vk
         UvW6W+JC2I/KE4G5wBWxZzNkx4nTh1VcElrESrdDZxSpUQy8nOxHgrqtak3es0LbUd
         +01BqGLvoDkka63h1BbWYs3i0zZlC7Vr4v1FbIUw=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4Cd1Hz3rX1z115G;
        Fri, 20 Nov 2020 15:51:43 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Andrew Morton' <akpm@linux-foundation.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dja@axtens.net" <dja@axtens.net>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: Re: [PATCH v6 0/5] Fortify strscpy()
Date:   Fri, 20 Nov 2020 16:51:41 +0100
Message-ID: <6074200.xW2bGMXWAE@machine>
In-Reply-To: <824aad3a91254445b0f30359f1606e2a@AcuMS.aculab.com>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com> <20201119173543.8821881942022fc4f39c4c73@linux-foundation.org> <824aad3a91254445b0f30359f1606e2a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le vendredi 20 novembre 2020, 14:33:53 CET David Laight a =E9crit :
> From: Andrew Morton
>=20
> > Sent: 20 November 2020 01:36
>=20
> ...
>=20
> > Could you please send along a reworked [0/n] cover letter?  Explain in
> > your own words, without requiring that readers go off and read web
> > pages
> >=20
> > - What problem the patchset solves
> > - How it solves it
> > - The value of the patchset (to kernel developers or to end-users) so t=
hat
> > we>=20
> >   can understand why it should be merged.
>=20
> - How much it slows things down.

I will add it for the next version!

> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1
> 1PT, UK Registration No: 1397386 (Wales)




