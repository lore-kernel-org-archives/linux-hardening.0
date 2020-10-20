Return-Path: <SRS0=sPYh=D3=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B1CC433DF
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 10:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33F72222D
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 10:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="snujRkIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbgJTK2v (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:28:51 -0400
Received: from devianza.investici.org ([198.167.222.108]:24951 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388927AbgJTK2v (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Oct 2020 06:28:51 -0400
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CFqbk2p3vz6vJN;
        Tue, 20 Oct 2020 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603189730;
        bh=fH0cm4Oe/u4r+dGE0VGNyyI6K0b7FRS6id7NAUQdJ+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snujRkIKsLaefgofU5UpREq5YfRvZULEwsIyxYvnUGgG+2wXVbHX6IxuBmYoYmwS1
         H/Qmxd5vLN2Zunaase/kzr9H0yzAcCafukXXf8Aa32dvaaarSYWjGMgdcLfanUMowg
         m7WzLnL/9QNMdz2y//dLRYMtfl/kD0gshqlz2ir8=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CFqbk18htz6vJH;
        Tue, 20 Oct 2020 10:28:50 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match that of strscpy.
Date:   Tue, 20 Oct 2020 12:28:49 +0200
Message-ID: <6912124.fRD6ipzQbq@machine>
In-Reply-To: <20201019163449.0a3f4675@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <202010191559.3AC2C3F97@keescook> <20201019163449.0a3f4675@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le mardi 20 octobre 2020, 01:34:49 CEST Jakub Kicinski a =E9crit :
> On Mon, 19 Oct 2020 16:01:27 -0700 Kees Cook wrote:
> > On Mon, Oct 19, 2020 at 09:43:55AM -0700, Jakub Kicinski wrote:
> > > On Mon, 19 Oct 2020 17:23:30 +0200 laniel_francis@privacyrequired.com
> > >=20
> > > wrote:
> > > > -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t
> > > > dstsize)
> > > > +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t
> > > > dstsize)
> > > >=20
> > > >  {
> > > >=20
> > > > +	size_t len;
> > > > +	ssize_t ret;
> > > >=20
> > > >  	size_t srclen =3D nla_len(nla);
> > > >  	char *src =3D nla_data(nla);
> > >=20
> > > Sort local variables long to short.
> >=20
> > Specifically, "reverse christmas tree":
> >  	size_t srclen =3D nla_len(nla);
> >  	char *src =3D nla_data(nla);
> >  	size_t len;
> >  	ssize_t ret;
>=20
> Or even
>=20
>  	size_t srclen =3D nla_len(nla);
>  	char *src =3D nla_data(nla);
>  	ssize_t ret;
>  	size_t len;
>=20
> ;)

I reordered the variables names for the v3.
Just to know, is it a new rule? Because scripts/checkpatch.pl did not repor=
t=20
anything and I was not aware of it.



