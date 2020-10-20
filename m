Return-Path: <SRS0=sPYh=D3=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CE5C433DF
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 13:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0A2224B1
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 13:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="ERnYS/e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406937AbgJTNFs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:05:48 -0400
Received: from devianza.investici.org ([198.167.222.108]:45677 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406897AbgJTNFs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Oct 2020 09:05:48 -0400
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CFv4n6Pfbz6vKN;
        Tue, 20 Oct 2020 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603199145;
        bh=4KzOpWttfTkCsGWcPtGHucbNXiI5WkoO0UD+mnafjCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERnYS/e8P9duVebrkszf7nysoWhCaEVXUmlpx/83Puq5UDenswE4QtpV86P7DMKMz
         lIsbB1CNBz3KFgH55IQ++g/s7z8IK99llCFxuBSDxtWQC8evTEdG4ncve0ZPSLja4L
         n3pqYgrjt81fxWkk1stZKjIZod2UDsxkdV5Ekeos=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CFv4n4nB9z6vJN;
        Tue, 20 Oct 2020 13:05:45 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match that of strscpy.
Date:   Tue, 20 Oct 2020 15:05:44 +0200
Message-ID: <3157734.8NJyI8pP3B@machine>
In-Reply-To: <202010191559.3AC2C3F97@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201019094355.4f6f3826@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <202010191559.3AC2C3F97@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le mardi 20 octobre 2020, 01:01:27 CEST Kees Cook a =E9crit :
> On Mon, Oct 19, 2020 at 09:43:55AM -0700, Jakub Kicinski wrote:
> > On Mon, 19 Oct 2020 17:23:30 +0200 laniel_francis@privacyrequired.com
> >=20
> > wrote:
> > > -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsi=
ze)
> > > +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t
> > > dstsize)
> > >=20
> > >  {
> > >=20
> > > +	size_t len;
> > > +	ssize_t ret;
> > >=20
> > >  	size_t srclen =3D nla_len(nla);
> > >  	char *src =3D nla_data(nla);
> >=20
> > Sort local variables long to short.
>=20
> Specifically, "reverse christmas tree":
>=20
>  	size_t srclen =3D nla_len(nla);
>  	char *src =3D nla_data(nla);
>  	size_t len;
>  	ssize_t ret;
>=20
> > > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > > index 41a55c6cbeb8..f0bf64393cbf 100644
> > > --- a/net/sched/cls_api.c
> > > +++ b/net/sched/cls_api.c
> > > @@ -223,7 +223,7 @@ static inline u32 tcf_auto_prio(struct tcf_proto
> > > *tp)
> > >=20
> > >  static bool tcf_proto_check_kind(struct nlattr *kind, char *name)
> > >  {
> > > =20
> > >  	if (kind)
> > >=20
> > > -		return nla_strlcpy(name, kind, IFNAMSIZ) >=3D IFNAMSIZ;
> > > +		return nla_strlcpy(name, kind, IFNAMSIZ) > 0;
> >=20
> > Bug.
> >=20
> > >  	memset(name, 0, IFNAMSIZ);
> > >  	return false;
> > > =20
> > >  }
>=20
> Have you been able to exercise the changed code paths? (I would have
> expected this to immediately fail, for example.)

Unfortunately no...
As I said in the cover letter I only tested the modifications on char* and =
the=20
tcf_proto_check_kind function seems not to be called in my VM...
I will try to trigger it though!



