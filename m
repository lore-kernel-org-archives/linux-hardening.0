Return-Path: <SRS0=Tg6c=DY=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9298BC433DF
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 08:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3312072C
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 08:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="jWCkAo+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437737AbgJQIuE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Oct 2020 04:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437727AbgJQIuE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Oct 2020 04:50:04 -0400
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C292BC061755
        for <linux-hardening@vger.kernel.org>; Sat, 17 Oct 2020 01:50:03 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CCxY46tJNz12pr;
        Sat, 17 Oct 2020 08:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602924600;
        bh=I3ToySX3cxAQkqCxeDB+7Ip2WsbCgI5o38gV2FN5ujQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWCkAo+I1zwt/r4sXA+9nXRQXZRqEG5Im7Y4AedKiGEdvxSGx8TwcNUwdk2pB/1sj
         prIp7qWUUkYAbgSQCLDbi51yUlZLbt5RXZGJUj6Lb+vNGm3ijtyTpp8HgUTkZ8t28f
         4L9KKUQcOrPLGX4sJAv6XH6fHBFnPk0B5+hzjomI=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CCxY46FGcz12pJ;
        Sat, 17 Oct 2020 08:50:00 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Fix unefficient call to memset before memcpu in nla_strlcpy.
Date:   Sat, 17 Oct 2020 10:50:00 +0200
Message-ID: <12824789.NeILaJ7Kvc@machine>
In-Reply-To: <202010161618.8E214473@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201016125216.10922-2-laniel_francis@privacyrequired.com> <202010161618.8E214473@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le samedi 17 octobre 2020, 01:19:59 CEST Kees Cook a =E9crit :
> On Fri, Oct 16, 2020 at 02:52:14PM +0200, laniel_francis@privacyrequired.=
com=20
wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > This patch solves part 1 of issue:
> > https://github.com/KSPP/linux/issues/110
> >=20
> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > ---
> >=20
> >  lib/nlattr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/lib/nlattr.c b/lib/nlattr.c
> > index 74019c8ebf6b..ab96a5f4b9b8 100644
> > --- a/lib/nlattr.c
> > +++ b/lib/nlattr.c
> > @@ -731,8 +731,8 @@ size_t nla_strlcpy(char *dst, const struct nlattr
> > *nla, size_t dstsize)>=20
> >  	if (dstsize > 0) {
> >  =09
> >  		size_t len =3D (srclen >=3D dstsize) ? dstsize - 1 : srclen;
> >=20
> > -		memset(dst, 0, dstsize);
> >=20
> >  		memcpy(dst, src, len);
> >=20
> > +		dst[len] =3D '\0';
>=20
> I don't think this is right: callers are likely depending on the entire
> destination buffer to be zero-padded. I think you probably want:
>=20
> 		memset(dst + len, 0, dstsize - len);
>   		memcpy(dst, src, len);
>=20
> (but double-check my pointer math)
>=20

I did not understand that the content has to be zero-padded, now your comme=
nt=20
on github is clearer!
I will modifiy it for next version and check the math on the paper.

> >  	}
> >  =09
> >  	return srclen;




