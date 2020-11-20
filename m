Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4DAC63798
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E1422404
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 09:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="CVubdfDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgKTJlt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:41:49 -0500
Received: from latitanza.investici.org ([82.94.249.234]:40917 "EHLO
        latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgKTJlt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 04:41:49 -0500
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4Ccs570zRhz8shR;
        Fri, 20 Nov 2020 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605865307;
        bh=tBQjbRxRmmM2FXxuzx0z8uEn2WQkoLKnaGfyzbzpCgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVubdfDFqnnBICaQzyN+eSK85jPOR6A6MS1rU9To5YB1+JDFSUeTDJAxPnVc150rW
         OGktopcDfBcaW49glL2gCtgZk4kJ7yHf3/pFVxQWPM4QdkkgPVwA962FGxdzaUOq+K
         bxxV6lSfNXyTvhm9fph81PM4ddmIH8BKiK+FHTlM=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4Ccs563Jh5z8sgs;
        Fri, 20 Nov 2020 09:41:46 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org, Daniel Micay <danielmicay@gmail.com>
Subject: Re: [PATCH v6 1/5] string.h: detect intra-object overflow in fortified string functions
Date:   Fri, 20 Nov 2020 10:41:45 +0100
Message-ID: <2634935.IsWps63H46@machine>
In-Reply-To: <20201119173822.779c253bd946f7da30155cc8@linux-foundation.org>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com> <20201119164915.10618-2-laniel_francis@privacyrequired.com> <20201119173822.779c253bd946f7da30155cc8@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le vendredi 20 novembre 2020, 02:38:22 CET Andrew Morton a =E9crit :
> On Thu, 19 Nov 2020 17:49:11 +0100 laniel_francis@privacyrequired.com wro=
te:
> > From: Daniel Axtens <dja@axtens.net>
> >=20
> > ...
> >=20
> > Cc: Daniel Micay <danielmicay@gmail.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
>=20
> This patch should have your signoff as well, as per
> Documentation/process/submitting-patches.rst "Developer's Certificate
> of Origin 1.1".
>=20
> I think it would be best to send out a v7 to address this and the cover
> letter issue, please.

Will be done for the v7!
I just read the documentation page, rebase on Linus Torvalds tree and send =
the=20
v7!



