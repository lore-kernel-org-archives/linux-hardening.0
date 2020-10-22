Return-Path: <SRS0=c/1i=D5=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB6C4363A
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Oct 2020 09:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC071223BF
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Oct 2020 09:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="p8pK1fAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509809AbgJVJkn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Oct 2020 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509600AbgJVJkn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Oct 2020 05:40:43 -0400
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944BFC0613CE
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2020 02:40:42 -0700 (PDT)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CH2R948HDz8sgl;
        Thu, 22 Oct 2020 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603359637;
        bh=XxY94iaHlcp4jKd9KbKbHTzlFBmhweU5OGm9X3jo8NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8pK1fAFhn/2XSCc96w7eyvGZgJaQzLor+0lEsg2/LEUHG1UoI3ElqE3GjuB2aDUz
         RRLVwrG9/0Z1NOGbC9th07HoooxFpBNAP52jLAKpzkp7+npFiMUDcWtcyI2PZD8/DK
         4iNIyTiNLCNKGIyQFrtCV1MwLawwEADmMzSpCo3o=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CH2R907qhz8sfy;
        Thu, 22 Oct 2020 09:40:36 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org
Subject: Re: [RFC][PATCH v3 2/3] Modify return value of nla_strlcpy to match that of strscpy.
Date:   Thu, 22 Oct 2020 11:40:36 +0200
Message-ID: <9380410.HkhQdzfPPx@machine>
In-Reply-To: <202010211648.4CBF3805A9@keescook>
References: <20201020164707.30402-1-laniel_francis@privacyrequired.com> <20201020164707.30402-3-laniel_francis@privacyrequired.com> <202010211648.4CBF3805A9@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le jeudi 22 octobre 2020, 01:48:37 CEST Kees Cook a =E9crit :
> On Tue, Oct 20, 2020 at 06:47:06PM +0200, laniel_francis@privacyrequired.=
com=20
wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > nla_strlcpy now returns -E2BIG if src was truncated when written to dst.
> > It also returns this error value if dstsize is 0 or higher than INT_MAX.
> >=20
> > For example, if src is "foo\0" and dst is 3 bytes long, the result will
> > be:
> > 1. "foG" after memcpy (G means garbage).
> > 2. "fo\0" after memset.
> > 3. -E2BIG is returned because src was not completely written into dst.
> >=20
> > The callers of nla_strlcpy were modified to take into account this
> > modification.
> >=20
> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
>=20
> This looks correct to me. Thanks for the respin!

Perfect! You are welcome!

>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>




