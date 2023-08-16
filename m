Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B5C27C41
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 20:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbjHPUjQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbjHPUiz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 16:38:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130AA2701
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:38:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5657add1073so180907a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218334; x=1692823134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cF1BM3f2bxhcGy+lZOB+pU20s/yGXG20KfnXyoafx1I=;
        b=S1cecA8Y35UFe/B7wgZ82/ZTWMSsufbVjFnSUYcJB3o8aMW/V3gdW/NqqjLGmO+/Nr
         p8v0eiPJZuYK4vEcgNTVWplYOR4aqODDHJvhA5an/IVfLeY6N1sDRsz3rQxNBzwBiMVD
         4gs2IAjxEHrARmE99bg7/U1Ht2qAQtqmWPVuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218334; x=1692823134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF1BM3f2bxhcGy+lZOB+pU20s/yGXG20KfnXyoafx1I=;
        b=em5g9iUARM0m2lPtRDUeZmng+FjBZ9/q98+ZWNd1F5zVKrou+fX383OfyZBHfqKFUN
         a+hc9jJlOF1AHvhY7ebGgbKhA2v6Z9Xecky1l41lZTfb4sE+4vop21JU3eZ2n2mRqblf
         5QN+G6yr1OBssX/vEtKAPThrktePEkO0Gv6j8sCwPE/7rlkywBQxYV0x63oPzrxltQgb
         rmQxvqiKddC4sJTKgKCteZ4ZRmEmFuCyDI9xJV8o3cElLXRapxmTGgaGs8oyd8FDOT8G
         WK0MWdYOtfMPsOMefH7LunnfUsoPQM+jLLOlqlpZ4ohOgvygUySiLnZIH+jEM956C9O1
         UKsA==
X-Gm-Message-State: AOJu0Yx314lpVSq9dyhJWjKb0VkleNd+1IzGAHDYhh9oPvtr+0oXmbyt
        2lwHA1GBLkMog8k0sX19ufquK2ve5tgMbf6eqiE=
X-Google-Smtp-Source: AGHT+IFBs4yFI2ZdF5J+zDBYRSv/8/8CUjxCOKVwBxVARzrU7XVEhR34nZ31QOQcz8vsQ6XyltMRDA==
X-Received: by 2002:a05:6a20:938c:b0:13e:90aa:8c8b with SMTP id x12-20020a056a20938c00b0013e90aa8c8bmr977018pzh.4.1692218334596;
        Wed, 16 Aug 2023 13:38:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i5-20020a63bf45000000b00565cc03f150sm4165109pgo.45.2023.08.16.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:38:54 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:38:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] nouveau/svm: Replace one-element array with
 flexible-array member in struct nouveau_svm
Message-ID: <202308161338.1B73172C@keescook>
References: <cover.1692208802.git.gustavoars@kernel.org>
 <087a1c335228bd245192bbb2fb347c9af1be5750.1692208802.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087a1c335228bd245192bbb2fb347c9af1be5750.1692208802.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 16, 2023 at 12:04:06PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct nouveau_svm with flexible-array member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/338
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
