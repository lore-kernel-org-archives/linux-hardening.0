Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AC4C7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjE3XIx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjE3XIv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:08:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F7DE5
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:08:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so4010034b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488108; x=1688080108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I1XTjeSWZcGMiJuWL5FVq0CXwJ+1oPVvZhAeV/ZW9Hg=;
        b=c4fmrcom4NDh8NHKSBNUSY9k0wao+F4b7jO+o1GuQ+qpu0ilHov/G220o8+Ox9h4SV
         TNsy+GphzgRm607k6xxkGjPbVKpLlrAApnvHCEZEb7+5c4BJEibcWbcO/6oMExiwdAwO
         UBmDN59ZMnn8jQZuQ/rFDtLP/3OsxSDovSr60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488108; x=1688080108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1XTjeSWZcGMiJuWL5FVq0CXwJ+1oPVvZhAeV/ZW9Hg=;
        b=c+CT7o+MsGnyxTc8mPFU1xVHH56BikKGkmQSeyTgoO9DNzfxufFAE4hFQAqg+23Z7F
         mny5xrzhbHRqQ74Y/37Emby0SgsAeqv00BYIscxE80uDXZ0cA7f6pMpaWtF9lC8eGHkZ
         sgDiO3g/CBpDUgzaD8UiojTmXW+AR2PKQZJ7BMg6l+0MseOme46DvXmH1R7ha+RimVGG
         C2wlpqshSN+cyiKmuYTr8q3ru6voV/oyKnJTJp9Aj5l+tsp+FdlGIots8db+9gl/vqJZ
         BMH3Z6062XTF8LQ/Rf3DYE9o++uVMmcp7RcZFcwmGpkCurayt/FbaINv3I8PfEZf+bX/
         H80A==
X-Gm-Message-State: AC+VfDz6Eco11EFWPCjv4WDD42GbVvCzI/+xj4Yp4WUP7zlxV7MRpETC
        GN6YUVPtt4YocafYKNFg67LZxA==
X-Google-Smtp-Source: ACHHUZ7J6pxCYiDXPce2YlnpWudvs+EEkyDWcM4lsiSyFIay8ZQqbkdVA4ksi4O11VIcUrBrzz7+Mw==
X-Received: by 2002:a05:6a00:16c9:b0:64f:835c:a9ff with SMTP id l9-20020a056a0016c900b0064f835ca9ffmr5606232pfc.12.1685488108392;
        Tue, 30 May 2023 16:08:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g16-20020a62e310000000b0064d74808738sm2068241pfh.214.2023.05.30.16.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:08:27 -0700 (PDT)
Date:   Tue, 30 May 2023 16:08:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/amdgpu/discovery: Replace fake flex-arrays
 with flexible-array members
Message-ID: <202305301608.2982BD3CAF@keescook>
References: <ZHO4/Z+iO+lqV4rW@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHO4/Z+iO+lqV4rW@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, May 28, 2023 at 02:26:37PM -0600, Gustavo A. R. Silva wrote:
> Zero-length and one-element arrays are deprecated, and we are moving
> towards adopting C99 flexible-array members, instead.
> 
> Use the DECLARE_FLEX_ARRAY() helper macro to transform zero-length
> arrays in a union into flexible-array members. And replace a one-element
> array with a C99 flexible-array member.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1009:89: warning: array subscript kk is outside array bounds of ‘uint32_t[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1007:94: warning: array subscript kk is outside array bounds of ‘uint64_t[0]’ {aka ‘long long unsigned int[]’} [-Warray-bounds=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1310:94: warning: array subscript k is outside array bounds of ‘uint64_t[0]’ {aka ‘long long unsigned int[]’} [-Warray-bounds=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1309:57: warning: array subscript k is outside array bounds of ‘uint32_t[0]’ {aka ‘unsigned int[]’} [-Warray-bounds=]
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/300
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
