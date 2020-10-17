Return-Path: <SRS0=Tg6c=DY=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4947DC433DF
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7D7206DD
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="RmNh/B7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411718AbgJQJCC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Oct 2020 05:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408830AbgJQJCC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Oct 2020 05:02:02 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Oct 2020 02:02:02 PDT
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A5C061755
        for <linux-hardening@vger.kernel.org>; Sat, 17 Oct 2020 02:02:02 -0700 (PDT)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CCxd21jK2z8sfY;
        Sat, 17 Oct 2020 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602924806;
        bh=L2ijpPjFdZWcOqKj57Rd6T1zMBwUEjWUJvQi9tHbBhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmNh/B7/NXyeGtT2Tw8EsmEQ7Z2iGwVMh4lZ/N/nQYb3hlvcV2KlYwsltJH4MOsUd
         GfoeAEuzIwv2R94yT3HAzu+kfLNZHY/r7E2dUh/geUTylQn97WYWRgNyFTqy8fIWjI
         o9RCO1G/ApEtgIUvn9Syg/9HHfGxxP6DBSEh1sbE=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CCxd20JN3z8sf9;
        Sat, 17 Oct 2020 08:53:25 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Modify return value of nla_strlcpy to match that of strscpy.
Date:   Sat, 17 Oct 2020 10:53:20 +0200
Message-ID: <4277076.SKpFQfNsve@machine>
In-Reply-To: <202010161620.3B240DBCC1@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201016125216.10922-3-laniel_francis@privacyrequired.com> <202010161620.3B240DBCC1@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le samedi 17 octobre 2020, 01:23:10 CEST Kees Cook a =E9crit :
> On Fri, Oct 16, 2020 at 02:52:15PM +0200, laniel_francis@privacyrequired.=
com=20
wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > This patch solves part 2 of issue:
> > https://github.com/KSPP/linux/issues/110
>=20
> As with the others, this needs a full commit log (imagine someone
> doesn't have access to read that issue, etc).

I will reexplain the whole problem into the commit message to give more=20
context to it in the next version.

>=20
> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > ---
> >=20
> >  include/net/netlink.h |  2 +-
> >  include/net/pkt_cls.h |  3 ++-
> >  lib/nlattr.c          | 31 ++++++++++++++++++++-----------
> >  net/sched/act_api.c   |  2 +-
> >  net/sched/sch_api.c   |  2 +-
> >  5 files changed, 25 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/include/net/netlink.h b/include/net/netlink.h
> > index 7356f41d23ba..446ca182e13d 100644
> > --- a/include/net/netlink.h
> > +++ b/include/net/netlink.h
> > @@ -506,7 +506,7 @@ int __nla_parse(struct nlattr **tb, int maxtype, co=
nst
> > struct nlattr *head,>=20
> >  		struct netlink_ext_ack *extack);
> > =20
> >  int nla_policy_len(const struct nla_policy *, int);
> >  struct nlattr *nla_find(const struct nlattr *head, int len, int
> >  attrtype);
> >=20
> > -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize=
);
> > +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsiz=
e);
> >=20
> >  char *nla_strdup(const struct nlattr *nla, gfp_t flags);
> >  int nla_memcpy(void *dest, const struct nlattr *src, int count);
> >  int nla_memcmp(const struct nlattr *nla, const void *data, size_t size=
);
> >=20
> > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > index d4d461236351..f42db07c399b 100644
> > --- a/include/net/pkt_cls.h
> > +++ b/include/net/pkt_cls.h
> > @@ -4,6 +4,7 @@
> >=20
> >  #include <linux/pkt_cls.h>
> >  #include <linux/workqueue.h>
> >=20
> > +#include <linux/errno.h>
> >=20
> >  #include <net/sch_generic.h>
> >  #include <net/act_api.h>
> >  #include <net/net_namespace.h>
> >=20
> > @@ -512,7 +513,7 @@ tcf_change_indev(struct net *net, struct nlattr
> > *indev_tlv,>=20
> >  	char indev[IFNAMSIZ];
> >  	struct net_device *dev;
> >=20
> > -	if (nla_strlcpy(indev, indev_tlv, IFNAMSIZ) >=3D IFNAMSIZ) {
> > +	if (nla_strlcpy(indev, indev_tlv, IFNAMSIZ) =3D=3D -E2BIG) {
>=20
> I would make these tests all be "< 0" rather than specifically -E2BIG.
>=20

You are right, it would permit to add more -ESOMETHING to nla_sltrcpy witho=
ut=20
changing the caller each time.

> >  		NL_SET_ERR_MSG_ATTR(extack, indev_tlv,
> >  	=09
> >  				    "Interface name too long");
> >  	=09
> >  		return -EINVAL;
> >=20
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
> >=20
> > +	if (dstsize =3D=3D 0 || WARN_ON_ONCE(dstsize > INT_MAX))
> > +		return -E2BIG;
>=20
> Cool, yeah, good to include.
>=20

Thank you!

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
> > -		dst[len] =3D '\0';
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
> > +	dst[len] =3D '\0';
> > +
> > +	return ret;
> >=20
> >  }
> >  EXPORT_SYMBOL(nla_strlcpy);
>=20
> Otherwise, I think this looks good. (Though same note about
> zero-padding.)
>=20
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index f66417d5d2c3..ed411d6c29fc 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
> > @@ -935,7 +935,7 @@ struct tc_action *tcf_action_init_1(struct net *net,
> > struct tcf_proto *tp,>=20
> >  			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
> >  			goto err_out;
> >  	=09
> >  		}
> >=20
> > -		if (nla_strlcpy(act_name, kind, IFNAMSIZ) >=3D IFNAMSIZ) {
> > +		if (nla_strlcpy(act_name, kind, IFNAMSIZ) =3D=3D -E2BIG) {
> >=20
> >  			NL_SET_ERR_MSG(extack, "TC action name too long");
> >  			goto err_out;
> >  	=09
> >  		}
> >=20
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 2a76a2f5ed88..3e89c666d1e8 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1170,7 +1170,7 @@ static struct Qdisc *qdisc_create(struct net_devi=
ce
> > *dev,>=20
> >  #ifdef CONFIG_MODULES
> > =20
> >  	if (ops =3D=3D NULL && kind !=3D NULL) {
> >  =09
> >  		char name[IFNAMSIZ];
> >=20
> > -		if (nla_strlcpy(name, kind, IFNAMSIZ) < IFNAMSIZ) {
> > +		if (nla_strlcpy(name, kind, IFNAMSIZ) !=3D -E2BIG) {
> >=20
> >  			/* We dropped the RTNL semaphore in order to
> >  		=09
> >  			 * perform the module load.  So, even if we
> >  			 * succeeded in loading the module we have to




