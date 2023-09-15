Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD6CEE021D
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 04:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjIOEav (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 00:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjIOEau (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 00:30:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F47F2710
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:30:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fc9a4ebe9so1550430b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694752245; x=1695357045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsL0E9wvxns4U7l/ZwCaHkG93dEorgZ6k1wpN9ixUXY=;
        b=DIsqJTf82JyWJW+1mtEnCHlHX8ditJOAKl2Cywbw9IDfq5uBjzayUiv/0aWJpsdrxJ
         KlecA9RgYU53Xkp5udIoKF+uxbQsymlMDjyUFUlweie7itLUD+WAR9HzA/9RvMRX6+jw
         n/MPpEJ80XS0QgizDQSobUcehFRSyTVk2A40Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694752245; x=1695357045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsL0E9wvxns4U7l/ZwCaHkG93dEorgZ6k1wpN9ixUXY=;
        b=qasjK60XxQbx3+WXLRNObj1N4SP/Hq3PLraKJqaWzdtPiVu9/EW5gqIEmtUewrQOku
         AFM/j2D67jMQmm+FVlqcwikCDsSbmDbuUxgfUPfeJF454DLa0TpqnqNexmHoH7hZ/Ubk
         IpZGOU3oPjJkhI8GVCwLsCn4c8m6fmzhxHuSmsYEjKotWV4trtL63D5VoD9z0MCdIfZw
         MtMA2EVE0sORsn8iqIDRxdOhVxBbn7FGDtciaBlkC/ip86Lh5q3QuMyHiEUHlvBB1+m5
         2ki7TdZYG3EjFgPix0tnDp3o8f/E5AYFWRvSjHRNfCxMk/c6ub9AFhcAUwNahEoTNzVl
         +Vog==
X-Gm-Message-State: AOJu0Yy1SB7q+cnlssTP+AUEA06LbP2sr1yUrwJ2jmeHejPLP45OS7yY
        n0OJdm3pNWZ79Zl1lxFuFcZnOA==
X-Google-Smtp-Source: AGHT+IHQxJBzE959LD14CEM1tohj88xdcd7+u7zKv8kSGIXuEzf6ekyCP/qKCPCuomlgXxkHpjJDxg==
X-Received: by 2002:a05:6a20:3255:b0:14d:6309:fc94 with SMTP id hm21-20020a056a20325500b0014d6309fc94mr747971pzc.36.1694752244954;
        Thu, 14 Sep 2023 21:30:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0069026841829sm2049947pfo.113.2023.09.14.21.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:30:44 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:30:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>
Subject: Re: [PATCH] drm/modes: refactor deprecated strncpy
Message-ID: <202309142129.46C1EAE2E2@keescook>
References: <20230914-strncpy-drivers-gpu-drm-drm_modes-c-v1-1-079b532553a3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-drm_modes-c-v1-1-079b532553a3@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 14, 2023 at 06:08:44PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer and doesn't incur the
> performance loss of unnecessarily NUL-padding.

How did you decide it didn't need %NUL padding?

I suspect it should have it, as I see what looks like full struct copies
happening in places:

        struct drm_mode_modeinfo umode;

	...
                struct drm_property_blob *blob;

                drm_mode_convert_to_umode(&umode, mode);
                blob = drm_property_create_blob(crtc->dev,
                                                sizeof(umode), &umode);

Can you send a v2 using strscpy_pad() instead?

Thanks!

-Kees

-- 
Kees Cook
