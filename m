Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16444C43219
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Oct 2022 02:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJNClo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Oct 2022 22:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJNCln (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Oct 2022 22:41:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9F196B61
        for <linux-hardening@vger.kernel.org>; Thu, 13 Oct 2022 19:41:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l4so3503902plb.8
        for <linux-hardening@vger.kernel.org>; Thu, 13 Oct 2022 19:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZJ1ZupV4pNYtfLm2nRk080Y8SXTuWCwx9eOCEUYrnLk=;
        b=mOTc8KRBadMqtPwLlQpMoDRG7Y/LhVh3ONQQ0+J/2DeJP9z2WBpqzM2zCbruFAwGQ2
         Cg9NrAsdBApxkVi7G6+/BmIIhGYCILZRVDKJgLmeZAjnkd+DscSYsrIh2d0DhZEicFJ4
         JC0NBSOAxXyESKVnAJK6Z1UcYpKzjFbwvjdW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ1ZupV4pNYtfLm2nRk080Y8SXTuWCwx9eOCEUYrnLk=;
        b=JC9WHxUUWMuPBEiFXZCvX+E5WitjNqmAHYNdM0An1cImRON4kBPu6rJktdUpPgLtDZ
         iS6IGvyCZkrBnjCZE8Ig9Ly5svPM/Hrqpj94hsbZj39Lv8K2siZG3Gty8ChPxPt4W56j
         lZuy+cmrc2DynxLroCDG1X2VGZiFzNtELI3HwpJrQvhRlLyzbOByJlRMHFPsZC06Uves
         tELddRbX7wSBoVetZo9uE75ySW7y2EvlVw35F0s8AVezFAmrsZLPYgYPahD4v8dWkPfs
         nS+hkdGoE4IcWn3THPFW7xkz37e9+wjZ4RYLDshIWuthsfqX7wPbiS603YUs2nA8vyU9
         m6BA==
X-Gm-Message-State: ACrzQf3nCV4w1l3ntziXdWb2aczHlMrMgXmTSRmMuZZy9vgkNa3kx9fl
        n6DXrxvqI+qAx/gS2Mipcy1cgw==
X-Google-Smtp-Source: AMsMyM4+EvyJIPbh8SsjJ5/w//6R6z4mUB4NPnFpN2sJpNlsISjzDqMI4t1DceTMwEIjNQHzGR0rDg==
X-Received: by 2002:a17:90a:d983:b0:20a:ec04:e028 with SMTP id d3-20020a17090ad98300b0020aec04e028mr14425285pjv.122.1665715301104;
        Thu, 13 Oct 2022 19:41:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001708c4ebbaesm467745plg.309.2022.10.13.19.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 19:41:40 -0700 (PDT)
Date:   Thu, 13 Oct 2022 19:41:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Brauner <brauner@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-hwmon@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] drm/radeon: Replace kmap() with kmap_local_page()
Message-ID: <202210131941.5D2AD4403E@keescook>
References: <20221013210714.16320-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013210714.16320-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 13, 2022 at 11:07:14PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Therefore, replace kmap() with kmap_local_page() in radeon_ttm_gtt_read().
> 
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
