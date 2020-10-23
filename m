Return-Path: <SRS0=thHn=D6=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E5C4363A
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Oct 2020 15:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893A121D47
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Oct 2020 15:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="YhYSKXxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465665AbgJWPPM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:15:12 -0400
Received: from latitanza.investici.org ([82.94.249.234]:43525 "EHLO
        latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465662AbgJWPPM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Oct 2020 11:15:12 -0400
X-Greylist: delayed 106472 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 11:15:11 EDT
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CHnpj6bg5z8sfZ;
        Fri, 23 Oct 2020 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603466109;
        bh=xrzfXBanp0mZ0wD0TDNdDaKsHaPTHuPJOdUq/1FcMqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhYSKXxwz/ysMAb2ivI8QK975QNdDoum9gJTw7gNHqvUWAXTR0iaI0uoq5/ruJW7l
         kgBp5pmnwS2dxbeE9xjBsgUiLznqNyHEr+aJSficemTDiz4PZ3n/Uaf+G4DIjLnCOH
         3DAWC5a7A6jfZBfmT2OtWI7wiWSbp7a51BTdT1D4=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CHnpj19zdz8sfY;
        Fri, 23 Oct 2020 15:15:08 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Jakub Kicinski' <kuba@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [RFC][PATCH v3 3/3] Rename nla_strlcpy to nla_strscpy.
Date:   Fri, 23 Oct 2020 17:15:08 +0200
Message-ID: <1915509.OMjZjUUbeY@machine>
In-Reply-To: <b55d502089c44b3589973fa4e0d90617@AcuMS.aculab.com>
References: <20201020164707.30402-1-laniel_francis@privacyrequired.com> <20201022160551.33d85912@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net> <b55d502089c44b3589973fa4e0d90617@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le vendredi 23 octobre 2020, 10:07:44 CEST David Laight a =E9crit :
> From: Jakub Kicinski
>=20
> > Sent: 23 October 2020 00:06
> >=20
> > On Thu, 22 Oct 2020 13:04:32 -0700 Kees Cook wrote:
> > > > > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > > > > >=20
> > > > > > Calls to nla_strlcpy are now replaced by calls to nla_strscpy
> > > > > > which is the
> > > > > > new name of this function.
> > > > > >=20
> > > > > > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.c=
om>
> > > > >=20
> > > > > The Subject could also be: "treewide: Rename nla_strlcpy to
> > > > > nla_strscpy"
> > > > >=20
> > > > > But otherwise, yup, easy mechanical change.
> > > >=20
> > > > Should I submit a v4 for this change?
> > >=20
> > > I'll say yes. :) Drop the RFC, bump to v4, and send it to netdev (alo=
ng
> > > with all the other CCs you have here already), and add the Reviewed-b=
ys
> > > from v3.
> >=20
> > Maybe wait until next week, IIRC this doesn't fix any bugs, so it's
> > -next material. We don't apply anything to net-next during the merge
> > window.
>=20
> Is this just a rename, or have you changed the result value?
> In the latter case the subject is really right.

I changed the result value so it mimics the return value of strscpy.

> FWIW I suspect  the 'return -ERR on overflow' is going to bite us.
> Code that does p +=3D strsxxx(p, ..., lim - p, ...) assuming (or not
> caring) about overflow goes badly wrong.

Normally, I updated all parts of the code that check the value returned by=
=20
nla_strscpy.
But, if I understood correctly you are afraid of this type of code:
nla_strscpy(p, nla, p_len);
p +=3D strncat(p, something, lim - p, ...);
Am I correct?

> To my mind returning the full buffer length (ie include the '\0')
> on overflow still allows overflow be checked but makes writes
> outside the buffer very unlikely.

Maybe I can keep the original behavior and add a pointer as argument which =
is=20
used to contain -ERR?

> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1
> 1PT, UK Registration No: 1397386 (Wales)



