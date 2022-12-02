Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38793C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 03:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiLBDa1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiLBDa0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 22:30:26 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A67FD9B18
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 19:30:25 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so3338912pgr.12
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 19:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMpX9ooyifhlpKVdRqI6MoSWdq6ucq755VLP9coBufY=;
        b=R6df9ymtMJmKszedVIzWjr9eYOHYizZfPn+4UMr4P1dhnB6er9n00bAllvLMKIM/9/
         XVfZ+37vJ0A7DgqtloE86jmntbqnp6FDvbiIDmNd35vAfHYxYS7QRftuS6SqTyUDRZzK
         qgmBN7BJl4Etm9MK9I2kr/+Oy11wpOVNgBl5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMpX9ooyifhlpKVdRqI6MoSWdq6ucq755VLP9coBufY=;
        b=kOoxImSb2g8fN4ItJKe9n3TxbbOJuYmFAPDM1NdtJdjdEF52SL1ynve3U7qoufcf93
         mUYA5/v/7Zhr6xEnmEc+W/tPNoP1Lg5u+qIrAetOW4r0sN4FnjFrNrjSDu1xAyrY7CCW
         HwqE1xqDJ+Ulj6NcMXoJjolHhFSUGdTF7/6mxyfW5XAv0FZnH82afcJDJPhJM1nc7MJd
         QGQFYmOoZTjFzQj2Z2zmnWapbHcHi8TRPZ2xEtFM7vkMkR39CMlKjPoAlQER3BTASyJs
         Xn//DSBcrhrQM9qFrfBjGU2Dabk3S2FfmHeqqXSigKbUh8FLas570CX/NIYc0IVefJXb
         Ql7g==
X-Gm-Message-State: ANoB5pmkj2WERpNMBpYNf7HlRf6ek7c6qX2RdrgglNGYxKTTeO13AP38
        W7342HfA6HGlE2xUCkST3OOSkA==
X-Google-Smtp-Source: AA0mqf4mo4o5Qv6KPO1JDmJAf9SbFKsb+rn0HnRNyrX0iQddFcvNgo81gDCygAB/RwjVBUtKhBXKzQ==
X-Received: by 2002:a62:a519:0:b0:573:bc35:54ae with SMTP id v25-20020a62a519000000b00573bc3554aemr55441028pfm.79.1669951824690;
        Thu, 01 Dec 2022 19:30:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902c3ca00b001869f2120absm4352357plj.294.2022.12.01.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:30:24 -0800 (PST)
Date:   Thu, 1 Dec 2022 19:30:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] crypto/caam: Avoid GCC constprop bug warning
Message-ID: <202212011928.97A43D01@keescook>
References: <20221202010410.gonna.444-kees@kernel.org>
 <Y4loCFGhxecG6Ta0@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4loCFGhxecG6Ta0@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 02, 2022 at 10:50:48AM +0800, Herbert Xu wrote:
> On Thu, Dec 01, 2022 at 05:04:14PM -0800, Kees Cook wrote:
> >
> > diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
> > index 62ce6421bb3f..d9da4173af9d 100644
> > --- a/drivers/crypto/caam/desc_constr.h
> > +++ b/drivers/crypto/caam/desc_constr.h
> > @@ -163,7 +163,8 @@ static inline void append_data(u32 * const desc, const void *data, int len)
> >  {
> >  	u32 *offset = desc_end(desc);
> >  
> > -	if (len) /* avoid sparse warning: memcpy with byte count of 0 */
> > +	/* Avoid GCC warning: memcpy with NULL dest (but byte count of 0). */
> > +	if (data && len)
> >  		memcpy(offset, data, len);
> 
> This makes no sense.  The if clause was added to silence sparse.
> That then in turn caused gcc to barf.  However, sparse has since
> been fixed so that it doesn't warn without the if clause.

It's _GCC_, not sparse, that is enforcing the nonnull argument
attribute.

> The solution is not to keep adding crap to the if clause, but to
> get rid of it once and for all.

Getting rid of the if doesn't solve the warning. I can switch it to just
"if (data)", though. That keeps GCC happy.

-- 
Kees Cook
