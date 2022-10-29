Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7CAC38A02
	for <linux-hardening@archiver.kernel.org>; Sat, 29 Oct 2022 03:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ2DRn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 Oct 2022 23:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2DRl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 Oct 2022 23:17:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9D9AFC1
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 20:17:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y4so6420282plb.2
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd4BB28ylqUVziHfqM61lajVeO2UdyApWimbqI2dNa4=;
        b=BGguppnicqHjW8WfEUzt0WRt/BtvsQBZ/hFQYeUQt7L0+j5PxnRag2L+5pR7ldJmYU
         fxSlt+6U+ssbdD6d90ZD3GEEvaArZ9CItsMeiHNkML+W/y/hV8zS7Fu7/Ma2ZBZyGjwF
         fRFvgWG2IXOYzu8hoN0h3BHns4z72AzKnFWX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd4BB28ylqUVziHfqM61lajVeO2UdyApWimbqI2dNa4=;
        b=FPrMTPurxeFRhPxoJElBj2+7VkXm85Lfp/wnglkhCKY3MM62+WfyVRds/yA9LDGd8e
         30KZuq4GSomOGyeUnrxPOK8Kzq5scFDkEbq9EkGRk+uFJRoe2ODQ38O623np02OKpK6R
         tPcf8Hm9SKfrbaf1nSoUnUZTPQD/8CuGeMha8icZDUa2vAM91XHJy1uSnxAnuz8eaSDc
         aAZ63zprYcyIC9HkrQQuMYK58GQ75bUk1ly2TOuUacMYQtzW0w4AnANamFz/XLWe+Bbu
         ACfirl2Q/Xl+pznhdu9DsJdo7WfwLCuirs7ndJ4qjQOid30zdhQCwFFho2r8cmAbEInj
         +JLQ==
X-Gm-Message-State: ACrzQf2QJ+DFjvF599+tUacjh2FqGaUQgidR8e6dTXCIYq6Nexa4QOIw
        bEyXrI9gmOjKLnZCkQWCH+xo3Q==
X-Google-Smtp-Source: AMsMyM5me638ftMDuCR+ussBeXMeJ3H30jUxnuNmVqvD/NnEcnVWySgFAFBzkL8kvpWSPHr7p2FbHg==
X-Received: by 2002:a17:90b:3803:b0:213:9911:5efd with SMTP id mq3-20020a17090b380300b0021399115efdmr2546152pjb.94.1667013456327;
        Fri, 28 Oct 2022 20:17:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b00186b55e3cd6sm187649plh.133.2022.10.28.20.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:17:35 -0700 (PDT)
Date:   Fri, 28 Oct 2022 20:17:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] igb: Proactively round up to kmalloc bucket size
Message-ID: <202210282013.82F28AE92@keescook>
References: <20221018092340.never.556-kees@kernel.org>
 <20221018092526.4035344-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018092526.4035344-2-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 02:25:25AM -0700, Kees Cook wrote:
> In preparation for removing the "silently change allocation size"
> users of ksize(), explicitly round up all q_vector allocations so that
> allocations can be correctly compared to ksize().
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi! Any feedback on this part of the patch pair?

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 6256855d0f62..7a3a41dc0276 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1195,7 +1195,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
>  		return -ENOMEM;
>  
>  	ring_count = txr_count + rxr_count;
> -	size = struct_size(q_vector, ring, ring_count);
> +	size = kmalloc_size_roundup(struct_size(q_vector, ring, ring_count));
>  
>  	/* allocate q_vector and rings */
>  	q_vector = adapter->q_vector[v_idx];

Thanks! :)

-Kees

-- 
Kees Cook
