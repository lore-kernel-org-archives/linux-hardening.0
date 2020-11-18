Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41186C5519F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 10:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681C822266
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 10:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="Bb540L+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKRKlT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Nov 2020 05:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRKlS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Nov 2020 05:41:18 -0500
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEE0C0613D4
        for <linux-hardening@vger.kernel.org>; Wed, 18 Nov 2020 02:41:18 -0800 (PST)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CbfVf2zZvz12bF;
        Wed, 18 Nov 2020 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605696074;
        bh=2uVQ4gbL83h2xGaxhd0hiYWQvp6NMuPOvRkp/C09/nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bb540L+7qyysExHy3yqNbdbnOvuwdCifGEVBhEMns+RxS0sBcjfeDl86448qNb2cQ
         VcoZkxMMAtJPjSkmU6KWU41lmzIG4fnDwerubPx+dZlhbxNg0pv5Lk7YQLfgHRYP+C
         hTK07uUrN0yryQTI23UwH0FtUx3cxBSPVnzpPsFw=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CbfVf20FZz12Zs;
        Wed, 18 Nov 2020 10:41:14 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC PATCH v4 0/5] Fortify strscpy()
Date:   Wed, 18 Nov 2020 11:41:13 +0100
Message-ID: <4657036.ZfE1bQA0bl@machine>
In-Reply-To: <202011171404.2CFCB24344@keescook>
References: <20201116145012.24471-1-laniel_francis@privacyrequired.com> <202011171404.2CFCB24344@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le mardi 17 novembre 2020, 23:06:07 CET Kees Cook a =E9crit :
> On Mon, Nov 16, 2020 at 03:50:07PM +0100, laniel_francis@privacyrequired.=
com=20
wrote:
> > This patch set answers to this issue:
> > https://github.com/KSPP/linux/issues/46
> >=20
> > I based my modifications on top of two patches from Daniel Axtens which
> > modify calls to __builtin_object_size to ensure the true size of char *
> > are returned and not the surrounding structure size.
> >=20
> > To sum up, in my first patch I implemented a fortified version of strsc=
py.
> > This new version ensures the following before calling vanilla strscpy:
> > 1. There is no read overflow because we either size is smaller than src
> > length or we shrink size to src length by calling fortified strnlen.
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
> Thanks! This looks really good. You can drop the "RFC" parts, and for
> v5, please use
>=20
> 	To: Andrew Morton <akpm@linux-foundation.org>
>=20
> and add to Cc:
>=20
> 	linux-mm@kvack.org
> 	linux-kernel@vger.kernel.org
>=20
> I think going via -mm is the most sensible, since that's where the other
> fortify pieces landed.

You are welcome and thank you for the reviews!
I rebase it on Linus Torvalds' tree and I send the V5.



