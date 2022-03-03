Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ABC433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Mar 2022 17:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiCCRoQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Mar 2022 12:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiCCRoP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Mar 2022 12:44:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF02FFE0
        for <linux-hardening@vger.kernel.org>; Thu,  3 Mar 2022 09:43:29 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 9so5207502pll.6
        for <linux-hardening@vger.kernel.org>; Thu, 03 Mar 2022 09:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3mNZQL2VC2uYb431PEz6jnFD5ZTmVgeO3AWfSaB6+TY=;
        b=TSou/dg3MxKfuVnSlJ7/9Ygb6rTt3uj1IAV4FuRAP0EFPtQzGCi18SqZsbllXX+6S8
         ntcMT0x0I5bMkPvRf+RymUl7ybQA3dv1GWojQ1350VFS3FT8qE2h7SFFXSceT7yfD2T8
         voM8RJe8gyMdGEmB0QSQndTKjgdU+d71aw2BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3mNZQL2VC2uYb431PEz6jnFD5ZTmVgeO3AWfSaB6+TY=;
        b=59FOsu295vtG37e2U3VtZz8QMnfXdExh6viQA9Z6RfnUgmUKvZ0YsfYZWpe2kmQ4z1
         AuAtb63V1itNlzwPy3AALvC4rvwJnBA/ngXQQCrMPTiIyZzETOhEEFyxCDzGxZexhUEZ
         sFvzvVxEP1NIQgjUipWJp4xMxmX8aXGvluBaMKh9GwhcobQ5YnkTjIMLjJuTXczTVqzk
         Z3NJZNhUvi0/KH+0IjuxOdLGFWHPTME9dlUuqlxWWiCf8m7aJzXoNFQ7PckQ+uZX8cZ6
         OfY4VnYDU0/c1TnC6hYRNQ8aSVAHn2/SFwmHrEMrLS4WJVf6cZnBDYrFj/ELWLRAXVpH
         L8ow==
X-Gm-Message-State: AOAM532gs6gNYRhB1QLiViX5tKR4bOocbuBOshP1ht97U3kSPca+TbD5
        JJaQyG7BOV6bwxSNHZBuj2aSNw==
X-Google-Smtp-Source: ABdhPJwuuWN6vPSVt7Mv7dHURNIv9eDx1oLiv+vp7zPxRp6zIMVlyTuNFHJ/8c8jo+dQfkkeI/rm5Q==
X-Received: by 2002:a17:902:d2cd:b0:14f:c169:dc6f with SMTP id n13-20020a170902d2cd00b0014fc169dc6fmr36769598plc.170.1646329409448;
        Thu, 03 Mar 2022 09:43:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t9-20020a655549000000b0036570f81245sm2536433pgr.84.2022.03.03.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:43:29 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:43:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/display: Fix Wstringop-overflow warnings
 in dc_link_dp.c
Message-ID: <202203030937.5BFE3EF@keescook>
References: <20220303172503.GA1731116@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303172503.GA1731116@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 03, 2022 at 11:25:03AM -0600, Gustavo A. R. Silva wrote:
> Fix the following Wstringop-overflow warnings when building with GCC-11:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:493:17: warning: ‘dp_decide_lane_settings’ accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]

Can you "show your work" a little more here? I don't actually see the
what is getting fixed:

enum dc_lane_count {
	...
        LANE_COUNT_FOUR = 4,
	...
        LANE_COUNT_DP_MAX = LANE_COUNT_FOUR
};

struct link_training_settings {
	...
        union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX];
};

void dp_hw_to_dpcd_lane_settings(
		...
		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
{
	...
}

static enum link_training_result dpia_training_cr_transparent(
		...
                struct link_training_settings *lt_settings)
{
	...
                dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
                                lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
	...
}

Everything looks to be the correct size?

-- 
Kees Cook
