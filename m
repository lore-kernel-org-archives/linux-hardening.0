Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63525C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 02:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJRCx5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJRCx4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 22:53:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC52D86FA1
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:53:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fw14so12715488pjb.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQY3W7hRKh2A3mmRwaSR5zMANSUXerkDNjuNxhhUVMQ=;
        b=T4EstTAc8ZqL0hkcgqQE1JkVr/qcAw+Ir6jEvpi4OV2kvFODb5E7k4DmdGHwn/Fp1s
         azy0qiMEBS+g/92IdHzbDBBLUhPA6mrjfJtSaKq5JwE4igc6yOsJN3cpLxKmu4r5d36/
         0KlP4W6yEo1uhW846C/VuwvP62WJfHaq4Ojqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQY3W7hRKh2A3mmRwaSR5zMANSUXerkDNjuNxhhUVMQ=;
        b=Jy99HFUMzXUNqaiGMkjnUmZS+aZEsSHQJlQwjWDok3NTNkMKBW2LwJ4bGlaCnkMaao
         98frseI7PJZF+qKu9NTz7Nh6vlVeAxQrp/m98UCs3xjIw0f6IYs+RdrQznpmnkeqNmPF
         QRgqck+lMmxoQDpHxnw2W9c5ax3bPcI+NEKhO+JOtcQwmFfH+FF4MtfoI8DNm90AFyN2
         Tl4MLUihgKOimE+FsGuPqLzcxbC2P0AwrHP56ifvprACS3V3c7a6lCqiN5T4MnEdy/1+
         gTbgkubQB544HwWoiU07U/eSK2x08mZNEnFG48apeudX5EcuZCkNctj+TeyKcO3vtffd
         GWbg==
X-Gm-Message-State: ACrzQf3YLVIiz9+u1cWXRQmBy6wE/1r6tdlJriI/TOIBo8pDVG9NW3Yf
        ngnLc0bdFLp2S6zP6EFQYrdPSg==
X-Google-Smtp-Source: AMsMyM4VySz82tfsQkg7rqBGDxZ2dolN0viseOzqMsyFFd9ok/rnzj8rF4XLPfUEnvJ8tOkZCB4PuA==
X-Received: by 2002:a17:90b:1644:b0:20b:1cb4:2c9a with SMTP id il4-20020a17090b164400b0020b1cb42c9amr38015024pjb.193.1666061635017;
        Mon, 17 Oct 2022 19:53:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l3-20020a654c43000000b0046ae818b626sm7034638pgr.30.2022.10.17.19.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:53:54 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:53:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/6][next] airo: Avoid clashing function prototypes
Message-ID: <202210171950.B5F2676D7F@keescook>
References: <cover.1666038048.git.gustavoars@kernel.org>
 <ab0047382e6fd20c694e4ca14de8ca2c2a0e19d0.1666038048.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0047382e6fd20c694e4ca14de8ca2c2a0e19d0.1666038048.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 17, 2022 at 03:36:20PM -0500, Gustavo A. R. Silva wrote:
> [...]
> @@ -6312,16 +6326,16 @@ static int airo_get_mode(struct net_device *dev,
>  	/* If not managed, assume it's ad-hoc */
>  	switch (local->config.opmode & MODE_CFG_MASK) {
>  		case MODE_STA_ESS:
> -			*uwrq = IW_MODE_INFRA;
> +			uwrq->mode = IW_MODE_INFRA;
>  			break;
>  		case MODE_AP:
> -			*uwrq = IW_MODE_MASTER;
> +			uwrq->mode = IW_MODE_MASTER;
>  			break;
>  		case MODE_AP_RPTR:
> -			*uwrq = IW_MODE_REPEAT;
> +			uwrq->mode = IW_MODE_REPEAT;
>  			break;
>  		default:
> -			*uwrq = IW_MODE_ADHOC;
> +			uwrq->mode = IW_MODE_ADHOC;
>  	}
>  
>  	return 0;

Sometimes you use the union directly, sometimes not. What was your
heuristic for that?

Regardless, looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
