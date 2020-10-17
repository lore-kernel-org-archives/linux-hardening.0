Return-Path: <SRS0=Tg6c=DY=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA5C433E7
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 08:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898CE2072C
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 08:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="JqIpq0q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392796AbgJQI47 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Oct 2020 04:56:59 -0400
Received: from devianza.investici.org ([198.167.222.108]:49257 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390465AbgJQI46 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Oct 2020 04:56:58 -0400
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CCxj45bmvz6vMH;
        Sat, 17 Oct 2020 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602925016;
        bh=w5aR7XO8JpFBcxAWpql9L9JWqMdmUlAwoBa7SHxO0dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqIpq0q+7DuwB/umrcGT7w29x6BWESbGgRL9HnSFHsQb4Fw85z6zXEFxj01k50lVT
         xA1lL1GGEgufIZqS6M49yQgWC3QBdyeefc/F+zvI8F0mfL+sltW4ZWTNnyEiunTK2J
         Zr2ephawvwul1hO5QOeitG1gt9gifzV802RT/iSY=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CCxj44C9Hz6vLp;
        Sat, 17 Oct 2020 08:56:56 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Jann Horn <jannh@google.com>
Cc:     linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Modify return value of nla_strlcpy to match that of strscpy.
Date:   Sat, 17 Oct 2020 10:56:55 +0200
Message-ID: <5345693.Gt269SmXlT@machine>
In-Reply-To: <CAG48ez2gpW-O9wQQ5u55jsr3PhQbPYPjyur=AfgP--5H==96uQ@mail.gmail.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201016125216.10922-3-laniel_francis@privacyrequired.com> <CAG48ez2gpW-O9wQQ5u55jsr3PhQbPYPjyur=AfgP--5H==96uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le samedi 17 octobre 2020, 02:41:33 CEST Jann Horn a =E9crit :
> On Fri, Oct 16, 2020 at 3:02 PM <laniel_francis@privacyrequired.com> wrot=
e:
> > This patch solves part 2 of issue:
> > https://github.com/KSPP/linux/issues/110
> >=20
> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > ---
> >=20
> >  include/net/netlink.h |  2 +-
> >  include/net/pkt_cls.h |  3 ++-
> >  lib/nlattr.c          | 31 ++++++++++++++++++++-----------
> >  net/sched/act_api.c   |  2 +-
> >  net/sched/sch_api.c   |  2 +-
> >  5 files changed, 25 insertions(+), 15 deletions(-)
>=20
> [...]
>=20
> > diff --git a/lib/nlattr.c b/lib/nlattr.c
> > index ab96a5f4b9b8..83dd233bbe3e 100644
> > --- a/lib/nlattr.c
> > +++ b/lib/nlattr.c
> > @@ -713,29 +713,38 @@ EXPORT_SYMBOL(nla_find);
> >=20
> >   * @dst: where to copy the string to
> >   * @nla: attribute to copy the string from
> >   * @dstsize: size of destination buffer
> >=20
> > + * @returns: -E2BIG if @dstsize is 0 or source buffer length greater t=
han
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
> > + * The result is always a valid NUL-terminated string.
> >=20
> >   */
>=20
> What about tcf_proto_check_kind()?

Good catch!
I just searched for "if (nla_strlcpy" in the code to propagate change.
I will add it to the next version!



