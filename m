Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3932CC433EF
	for <linux-hardening@archiver.kernel.org>; Sat,  5 Feb 2022 01:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377500AbiBEBiy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Feb 2022 20:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiBEBix (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Feb 2022 20:38:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFBDC061345
        for <linux-hardening@vger.kernel.org>; Fri,  4 Feb 2022 17:38:52 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h12so7196493pjq.3
        for <linux-hardening@vger.kernel.org>; Fri, 04 Feb 2022 17:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MA7V18Af7JMkGZ9oe2f8NpWbpf5Pf2CxDZqgZ+912es=;
        b=VRGyRIeP41YIWE2ETD0nG8Sw+b2e0xAgt7GcNjENvS7PgAwz3xlzFS14IOhcRUnAa1
         Vt6MEnMcWP9RvefkEIGyZ99MIj5L5TJia0SKt2BjZzycoBy+xxpynQHrn+v+BY59MhL0
         Dk5hwEWSRfFUGjy+UbF5CKgwd/b3H2XrGa4M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MA7V18Af7JMkGZ9oe2f8NpWbpf5Pf2CxDZqgZ+912es=;
        b=vZQ31GvjedEUHNz6pBf1Bvg68ve35Fcn+aj2Gdocx0ON6DVnQOTpRON0GrP4MUB+oB
         p9S02qCY8hdoZCeRdOsFZvu1b4GhRzQkZhkB51keXu8Fpk57O91affreBAl9gECiVvIC
         hP3Hw2uDIWI8nMyxfkg2Z+w/M2mlSzJt7dAycR6NEtY3gdoCrKowAeIENKIfE2S5nVhu
         Q3ok6xwfuIUUmRf/yjHCo+rLWq/om1wKddWW8ggwkXCQEMMYRCKaop/Fy0dZq0BWulQ5
         iwXkhVlwU7UA63K61eTBVVOsFhugG3nDCEmSfl63sI7K547iikd5fgkRewa0e6F/IDWy
         OA7g==
X-Gm-Message-State: AOAM530EzDsfvHnXnL7+3Z1o7mpSMY+vArlsL+dlnsA59yuaZA+g+twz
        DgMOxQiP0JRij7ARXxs4Hwi9cQ==
X-Google-Smtp-Source: ABdhPJxKoRxYw29M3XV8L9Ky8wDWUNlkXyJpF0Q1bH1Rb+NMN3smndw5L50QOjq4XIdijw+bpkdNbA==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr5893133plo.74.1644025131907;
        Fri, 04 Feb 2022 17:38:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm13931560pje.34.2022.02.04.17.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 17:38:51 -0800 (PST)
Date:   Fri, 4 Feb 2022 17:38:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Uma Shankar <uma.shankar@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drm/dp: Fix off-by-one in register cache size
Message-ID: <202202041738.9C2835B@keescook>
References: <20220105173310.2420598-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105173310.2420598-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Ping. This is a OOB read fix. Can something send this to Linus please?

-Kees

On Wed, Jan 05, 2022 at 09:33:10AM -0800, Kees Cook wrote:
> The pcon_dsc_dpcd array holds 13 registers (0x92 through 0x9E). Fix the
> math to calculate the max size. Found from a -Warray-bounds build:
> 
> drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_pcon_dsc_bpp_incr':
> drivers/gpu/drm/drm_dp_helper.c:3130:28: error: array subscript 12 is outside array bounds of 'const u8[12]' {aka 'const unsigned char[12]'} [-Werror=array-bounds]
>  3130 |         buf = pcon_dsc_dpcd[DP_PCON_DSC_BPP_INCR - DP_PCON_DSC_ENCODER];
>       |               ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/drm_dp_helper.c:3126:39: note: while referencing 'pcon_dsc_dpcd'
>  3126 | int drm_dp_pcon_dsc_bpp_incr(const u8 pcon_dsc_dpcd[DP_PCON_DSC_ENCODER_CAP_SIZE])
>       |                              ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Fixes: e2e16da398d9 ("drm/dp_helper: Add support for Configuring DSC for HDMI2.1 Pcon")
> Cc: stable@vger.kernel.org
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Link: https://lore.kernel.org/lkml/20211214001849.GA62559@embeddedor/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20211203084333.3105038-1-keescook@chromium.org/
> v2:
>  - add reviewed-by
>  - add cc:stable
> ---
>  include/drm/drm_dp_helper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 30359e434c3f..472dac376284 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -456,7 +456,7 @@ struct drm_panel;
>  #define DP_FEC_CAPABILITY_1			0x091   /* 2.0 */
>  
>  /* DP-HDMI2.1 PCON DSC ENCODER SUPPORT */
> -#define DP_PCON_DSC_ENCODER_CAP_SIZE        0xC	/* 0x9E - 0x92 */
> +#define DP_PCON_DSC_ENCODER_CAP_SIZE        0xD	/* 0x92 through 0x9E */
>  #define DP_PCON_DSC_ENCODER                 0x092
>  # define DP_PCON_DSC_ENCODER_SUPPORTED      (1 << 0)
>  # define DP_PCON_DSC_PPS_ENC_OVERRIDE       (1 << 1)
> -- 
> 2.30.2
> 

-- 
Kees Cook
