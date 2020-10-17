Return-Path: <SRS0=Tg6c=DY=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC05C433DF
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D1B2072C
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="nkuI5qp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437738AbgJQIuY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Oct 2020 04:50:24 -0400
Received: from confino.investici.org ([212.103.72.250]:23661 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437727AbgJQIuX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Oct 2020 04:50:23 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CCxYT5xqxz12pn;
        Sat, 17 Oct 2020 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1602924621;
        bh=3g7WtKA77snN0GymvGDjqGVGEkC8J53DUr8XQaoRVcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkuI5qp3gUbQCSYp5thXJJSyOX0KeyfOUaniVhifKG7wyQZY9mq1jAtZefIj059Or
         sT6hf9UhlOrOLYbTn/WDygxShq4x1OQ/4YIVAVrWanerqOqqdir65hEkpXgGDknD3M
         X+on+OlvqGyznS3QuYrVFC803Y8SUsoQ/NKWCJZY=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CCxYT5NJqz12pJ;
        Sat, 17 Oct 2020 08:50:21 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Jann Horn <jannh@google.com>
Cc:     linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Fix unefficient call to memset before memcpu in nla_strlcpy.
Date:   Sat, 17 Oct 2020 10:50:21 +0200
Message-ID: <2158761.fSYYD8HLTc@machine>
In-Reply-To: <CAG48ez29c0yG=5O9CV8_+8e0LyqJfCczpQVm89uv19O=Fq+wKg@mail.gmail.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201016125216.10922-2-laniel_francis@privacyrequired.com> <CAG48ez29c0yG=5O9CV8_+8e0LyqJfCczpQVm89uv19O=Fq+wKg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le samedi 17 octobre 2020, 01:29:12 CEST Jann Horn a =E9crit :
> On Fri, Oct 16, 2020 at 3:02 PM <laniel_francis@privacyrequired.com> wrot=
e:
> > This patch solves part 1 of issue:
> > https://github.com/KSPP/linux/issues/110
> >=20
> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > ---
> >=20
> >  lib/nlattr.c | 2 +-
>=20
> Your patch touches networking-related code; please include the
> "NETWORKING [GENERAL]" contacts listed in MAINTAINERS when sending the
> next version of your patch series.

I will add the networking maintainers to the next version.



