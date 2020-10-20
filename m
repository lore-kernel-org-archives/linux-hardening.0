Return-Path: <SRS0=sPYh=D3=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233B8C433DF
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 10:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9A622253
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 10:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="QHnw8ZYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbgJTKRT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:17:19 -0400
Received: from devianza.investici.org ([198.167.222.108]:44237 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387470AbgJTKRT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Oct 2020 06:17:19 -0400
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CFqLN61fVz6vJN;
        Tue, 20 Oct 2020 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603189036;
        bh=VO71o6TChOuzbjr/a6r94ZFtbk3wqA0h7Tas2l3wPEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHnw8ZYHeTxkD1/DnUQ9D+KvAA5S17x7PGX9QqyONyn8M4A0hzLzW+g9XnCozpA7q
         1cQZC8Ky/0GLZE9TPsKwUuk8pulchJWW3IkvbQMdWuAB15M1Wws5S2RyDTn6zwKuYT
         qpKmATcMNdSy1/Hp2RErjLdeY169AvPe8RQGogTU=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CFqLN4jRkz6vJH;
        Tue, 20 Oct 2020 10:17:16 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-hardening@vger.kernel.org, davem@davemloft.net
Subject: Re: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match that of strscpy.
Date:   Tue, 20 Oct 2020 12:17:15 +0200
Message-ID: <27174519.SfbcIoB6Yp@machine>
In-Reply-To: <20201019094355.4f6f3826@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201019152331.20583-3-laniel_francis@privacyrequired.com> <20201019094355.4f6f3826@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le lundi 19 octobre 2020, 18:43:55 CEST Jakub Kicinski a =E9crit :
> On Mon, 19 Oct 2020 17:23:30 +0200 laniel_francis@privacyrequired.com
>=20
> wrote:
> > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > index d4d461236351..85f4ac779399 100644
> > --- a/include/net/pkt_cls.h
> > +++ b/include/net/pkt_cls.h
> > @@ -4,6 +4,7 @@
> >=20
> >  #include <linux/pkt_cls.h>
> >  #include <linux/workqueue.h>
> >=20
> > +#include <linux/errno.h>
>=20
> Stray include.

I removed it from my patch.
Did you use a tool to see this include is not used? If yes, which one?

> >  #include <net/sch_generic.h>
> >  #include <net/act_api.h>
> >  #include <net/net_namespace.h>
> >=20
> > diff --git a/lib/nlattr.c b/lib/nlattr.c
> > index 07156e581997..d692716bda78 100644
> > --- a/lib/nlattr.c
> > +++ b/lib/nlattr.c
> > @@ -713,30 +713,39 @@ EXPORT_SYMBOL(nla_find);
> >=20
> >   * @dst: where to copy the string to
> >   * @nla: attribute to copy the string from
> >   * @dstsize: size of destination buffer
> >=20
> > + * @returns: -E2BIG if @dstsize is 0 or source buffer length greater t=
han
>=20
> I don't think this is correct format for kdoc.

I corrected it.
I will take the habit to run scripts/kernel-doc on my modifications.

> > + * @dstsize, otherwise it returns the number of copied characters (not
> > + * including the trailing %NUL).
> >=20
> >   *
> >   * Copies at most dstsize - 1 bytes into the destination buffer.
> >=20
> > - * The result is always a valid NUL-terminated string. Unlike
> > - * strlcpy the destination buffer is always padded out.
> > - *
> > - * Returns the length of the source buffer.
> > + * Unlike strlcpy the destination buffer is always padded out.
> >=20
> >   */
> >=20
> > -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> > +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsiz=
e)
> >=20
> >  {
> >=20
> > +	size_t len;
> > +	ssize_t ret;
> >=20
> >  	size_t srclen =3D nla_len(nla);
> >  	char *src =3D nla_data(nla);
>=20
> Sort local variables long to short.
>=20
> > +	if (dstsize =3D=3D 0 || WARN_ON_ONCE(dstsize > INT_MAX))
>=20
> You can make it > U16_MAX, attr len is 16 bit.

Done for v3!

>=20
> > +		return -E2BIG;
> > +
> >=20
> >  	if (srclen > 0 && src[srclen - 1] =3D=3D '\0')
> >  =09
> >  		srclen--;
> >=20
> > -	if (dstsize > 0) {
> > -		size_t len =3D (srclen >=3D dstsize) ? dstsize - 1 : srclen;
> > -
> > -		memcpy(dst, src, len);
> > -		/* Zero pad end of dst. */
> > -		memset(dst + len, 0, dstsize - len);
> > +	if (srclen >=3D dstsize) {
> > +		len =3D dstsize - 1;
> > +		ret =3D -E2BIG;
> > +	} else {
> > +		len =3D srclen;
> > +		ret =3D len;
> >=20
> >  	}
> >=20
> > -	return srclen;
> > +	memcpy(dst, src, len);
> > +	/* Zero pad end of dst. */
> > +	memset(dst + len, 0, dstsize - len);
> > +
> > +	return ret;
> >=20
> >  }
> >  EXPORT_SYMBOL(nla_strlcpy);
> >=20
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index 41a55c6cbeb8..f0bf64393cbf 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -223,7 +223,7 @@ static inline u32 tcf_auto_prio(struct tcf_proto *t=
p)
> >=20
> >  static bool tcf_proto_check_kind(struct nlattr *kind, char *name)
> >  {
> > =20
> >  	if (kind)
> >=20
> > -		return nla_strlcpy(name, kind, IFNAMSIZ) >=3D IFNAMSIZ;
> > +		return nla_strlcpy(name, kind, IFNAMSIZ) > 0;
>=20
> Bug.
>=20
> >  	memset(name, 0, IFNAMSIZ);
> >  	return false;
> > =20
> >  }




