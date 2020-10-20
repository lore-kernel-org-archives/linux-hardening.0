Return-Path: <SRS0=sPYh=D3=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E30FC433DF
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 10:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4F42224F
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 10:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="UZK9TsNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbgJTKTB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733223AbgJTKTB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Oct 2020 06:19:01 -0400
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C715C061755
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2020 03:19:01 -0700 (PDT)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CFqNM2BZ5z8sgt;
        Tue, 20 Oct 2020 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603189139;
        bh=VdOiczFK7NJZwAgzkZQ5t6jM8sozS7MFUIciGWipgk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZK9TsNOYwWwzgbPgeHFsRNwcpxj1cTH7HWYTUZn8HTEFv2OthQw1ULWCfDwJZvWU
         LyTtM3U2cULZE/7a3rrq/fsyxvuVfoZK/6ZUV4uG54hoZh0mwlZbGc0ofshW/mJ2N6
         WRdXaiC2MKGa0ebgbOGNVJgBs02VjFNPi6Vrhyr0=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CFqNL5jbNz8sgQ;
        Tue, 20 Oct 2020 10:18:58 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC][PATCH v2 0/3] Fix inefficiences and rename nla_strlcpy
Date:   Tue, 20 Oct 2020 12:18:58 +0200
Message-ID: <2449441.JnRqNryMRx@machine>
In-Reply-To: <20201019163412.28c81fc4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <202010191557.C2653B0A@keescook> <20201019163412.28c81fc4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le mardi 20 octobre 2020, 01:34:12 CEST Jakub Kicinski a =E9crit :
> On Mon, 19 Oct 2020 15:58:36 -0700 Kees Cook wrote:
> > On Mon, Oct 19, 2020 at 09:45:15AM -0700, Jakub Kicinski wrote:
> > > On Mon, 19 Oct 2020 17:23:28 +0200 laniel_francis@privacyrequired.com
> > >=20
> > > wrote:
> > > > To sum up, the first patch fixes an inefficiency where some bytes in
> > > > dst were written twice, one with 0 the other with src content.
> > > > The second one modifies nla_strlcpy to return the same value as
> > > > strscpy,
> > > > i.e. number of bytes written or -E2BIG if src was truncated.
> > > > The third rename nla_strlcpy to nla_strcpy.
> > > >=20
> > > > Unfortunately, I did not find how to create struct nlattr objects s=
o I
> > > > tested my modifications on simple char*.
> > > > This is why I tag this patch set as RFC.
> > > >=20
> > > > If you see any way to improve the code or have any remark, feel free
> > > > to comment.> >=20
> > > You follow semantics of strscpy, yet rename to strcpy. Wouldn't it be
> > > more intuitive for developers to rename to nla_strscpy?
> >=20
> > It's closer to strscpy_pad() but that seems a long name. What's
> > preferred from the NLA perspective?
>=20
> I think the pad part is pretty much implied in the netlink world.
> All this stuff goes to user space, so we can't have uninit memory.
> We may get more informed opinions once this hits netdev@.

I will rename it nla_strscpy for the next version and we will discuss the n=
ame=20
with the netdev list.



