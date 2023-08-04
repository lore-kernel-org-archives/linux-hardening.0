Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C5C001DB
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Aug 2023 17:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjHDR3y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Aug 2023 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjHDR3y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Aug 2023 13:29:54 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE749F4
        for <linux-hardening@vger.kernel.org>; Fri,  4 Aug 2023 10:29:50 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55e1ae72dceso1552222eaf.3
        for <linux-hardening@vger.kernel.org>; Fri, 04 Aug 2023 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691170189; x=1691774989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4vdhRUtg9vt+FoZL7q0xAtAfLYBhNs3NC9GBHaD1o4=;
        b=GLAfMARBv+SZka30ple40Vmfo4lfaiOyW30EbkESLtrDz5c/DB5IyxfU7W9i5Baf3u
         31Zzecz/CBM2SoIQz22XYxHwrIswsKL/rLLNFaG6sxF5L7cc4zJNa8kyQhJXzvYrsS8q
         dmtq6b13+1Mw4qhW3Hk3Uwt4QV5SIIeGiQ26s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170189; x=1691774989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4vdhRUtg9vt+FoZL7q0xAtAfLYBhNs3NC9GBHaD1o4=;
        b=Djsc2nbIFUdXz0dtc7I56i9SYs8H7D8xMAXB0XLTRDQQxY73y+Wx2eh/D2F938AhEc
         vkinaaJsdGi/tLJlpb7xbPTvjKTVPwfZG7Fj1/+W5A2uW3bbEcGUA+HkLOixp/+F6j95
         rCbPmhu0Mqfqq5dBtBOLKvs9TvDGiPhAmuzPpXEgLsEqBH7dXnwhvlw1Tt9R8pHPyxg8
         SQRgbrSOfXz5W0cACdVH4LPNTKJaErTSl+/hJLKnLlIwngrvBB0EZ1lEXKRv7OEsCBvm
         SWBfkJuUPeJIcTlAyujaZqOX90+FxatZHi4dAyBpVfrjgcJjUi92UdJpdr7qonzuTktm
         DpVg==
X-Gm-Message-State: AOJu0YwLfVhwB5w/yoM6q+JwP+6ytdyoVcBHV/y9JXrChyO0++QwoI8+
        Z+x4nvJBaBONkzmhdx1rYgktuw==
X-Google-Smtp-Source: AGHT+IFgh5CF2i5h/8VoLtSl3dKgvdkpF8uKzXgQIOyt/Q679nwX+1DqZQk2AhGuKKxzKDbJ9mMWwg==
X-Received: by 2002:a05:6358:79c:b0:135:62de:ff7d with SMTP id n28-20020a056358079c00b0013562deff7dmr2095914rwj.8.1691170189380;
        Fri, 04 Aug 2023 10:29:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a63d649000000b0055c090df2fasm1368776pgj.93.2023.08.04.10.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:29:48 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:29:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] virtchnl: fix fake 1-elem arrays in structs
 allocated as `nents + 1` - 1
Message-ID: <202308041029.74FF3CCD@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-2-aleksander.lobakin@intel.com>
 <202308040126.ADDA993@keescook>
 <49b0d7bd-2bc1-c994-7780-35554a399242@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b0d7bd-2bc1-c994-7780-35554a399242@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 04, 2023 at 05:42:19PM +0200, Alexander Lobakin wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Fri, 4 Aug 2023 01:27:02 -0700
> 
> > On Fri, Jul 28, 2023 at 05:52:05PM +0200, Alexander Lobakin wrote:
> >> The two most problematic virtchnl structures are virtchnl_rss_key and
> >> virtchnl_rss_lut. Their "flex" arrays have the type of u8, thus, when
> >> allocating / checking, the actual size is calculated as `sizeof +
> >> nents - 1 byte`. But their sizeof() is not 1 byte larger than the size
> >> of such structure with proper flex array, it's two bytes larger due to
> >> the padding. That said, their size is always 1 byte larger unless
> >> there are no tail elements -- then it's +2 bytes.
> >> Add virtchnl_struct_size() macro which will handle this case (and later
> >> other cases as well). Make its calling conv the same as we call
> >> struct_size() to allow it to be drop-in, even though it's unlikely to
> >> become possible to switch to generic API. The macro will calculate a
> >> proper size of a structure with a flex array at the end, so that it
> >> becomes transparent for the compilers, but add the difference from the
> >> old values, so that the real size of sorta-ABI-messages doesn't change.
> >> Use it on the allocation side in IAVF and the receiving side (defined
> >> as static inline in virtchnl.h) for the mentioned two structures.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > This is a novel approach to solving the ABI issues for a 1-elem
> > conversion, but I have been convinced it's a workable approach here. :)
> > Thanks for doing this conversion!
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> Thanks a lot!
> You gave Reviewed-by for patches #1 and #3, does it mean the whole
> series or something is wrong with the patch #2? :D

Hm, maybe delivery was delayed? I see it on lore:
https://lore.kernel.org/all/202308040128.667940394B@keescook/

-- 
Kees Cook
