Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E7C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 00:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiLBA7y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLBA7x (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 19:59:53 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B523769C4
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 16:59:51 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d14so1501150ilq.11
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 16:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gZg4mZ+Y6hG3RyPNuo5TnwMGDFqNZx0oxGGFZyG9gs=;
        b=s02BtCOyTCmiPXAGRGmaTM96neMNIKFFywoAQ7I7mHGhCI9vdng089AXCHfdmREQm0
         TNGUp11MIwXhIU4Dm+yR/TPN/GnvRN/JfLRua6ProivCGOpe1jCs/8isu98NmMC5+OWx
         ynAx9NSlaiuNwyvbSQ6DhjHgVoZcVsOEbuvXwQhgL7yFkX7RnxZzy1KTVTguEOsDxMTX
         jB55x1l97b8X9jzjsktoR4J2pZUvXymKnAYW1CAyGrJHLO9G4EOhRwfcrgWOI+0VwPcX
         Vl2PFvOUZd4J+yCdXvypiHAcs1+VvIeLFZEvEz7Q+LSuO9qxTQXiht0rzHJV2dWYRS2e
         fYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gZg4mZ+Y6hG3RyPNuo5TnwMGDFqNZx0oxGGFZyG9gs=;
        b=FGX6o7WdL15ObBiCia7WdFvEIK5mvNFOILjaI7GvcX6X+KFWhyeJPBzj3/P0+v/eS6
         bYP/Gbm5Znaz4iPFifhz9bhXLgYmwsMcxyKNlW+sGpcAsGDo4h7xZgEk4mhEn6lxCPV2
         hb9qwdsMor0azrnXh8A8a0q1WuNTHSzx+GNO2xK9J/Gar3s9iTO0aUYAkVQ8m+tEMja+
         QL/TN43F9ByoxBUXjMalaJfMgplAoLuftsmaG4l0WwQNaGNf/0t2vCGaBy5oahHZeAzE
         zo5+Cd1GHYIu848qE7yeqBqF3LzfvIeBW13fG78z1nRIHN3DVOJXxK8Bv0rn7uWVhEr7
         X9vg==
X-Gm-Message-State: ANoB5pnPJKSN/To+noRA5cs0PzTBn/dn/8fKBH6gHzS5TM8IgN21QKld
        wy5ynm10+UlZinQ19AayO5Vvua8PtFV6YlGgc3d22nW6nP697g==
X-Google-Smtp-Source: AA0mqf4PK5ZJJZ4p/WZvUg80NUj8mfpbio/mn2njsWlMvSQTxCD16JrMrXpBinqu4KFXKOcx825t6TGOeM7b8IHtg30=
X-Received: by 2002:a05:6e02:216a:b0:303:129a:8157 with SMTP id
 s10-20020a056e02216a00b00303129a8157mr11125353ilv.38.1669942790467; Thu, 01
 Dec 2022 16:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20221028210527.never.934-kees@kernel.org> <Y2TVXDfQUwlYFv9S@gondor.apana.org.au>
 <20221201115244.GC69385@mutt> <Y4iZn9jC3VqBHEtU@gondor.apana.org.au>
In-Reply-To: <Y4iZn9jC3VqBHEtU@gondor.apana.org.au>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 2 Dec 2022 01:59:39 +0100
Message-ID: <CADYN=9J2tP7GG80-mzmUe3ad9-OTd_jbE7Y2yMafvwADLLjz9g@mail.gmail.com>
Subject: Re: [PATCH] crypto/caam: Avoid GCC constprop bug warning
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 1 Dec 2022 at 13:10, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Dec 01, 2022 at 12:52:44PM +0100, Anders Roxell wrote:
> .
> > I think that was fixed in sparse release v0.5.1 [1]. The workaround 'if
> > (len)' was introduced back in 2011, and the sparse release v0.5.1 was
> > done in 2017. So it should probably be safe to remove the 'if (len)'  or
> > what do you think?
>
> Could you please send a patch? :)

Please ignore my previous email... since its not the 'if (len)' statement that
GCC comlains about.

Cheers,
Anders


>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
