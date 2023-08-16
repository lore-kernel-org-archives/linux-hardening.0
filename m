Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EF6C25B4F
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 20:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbjHPUjQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbjHPUjA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 16:39:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742792708
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:38:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdf98a6086so18498695ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218339; x=1692823139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mebqjsm4NZp8ScdZvCRAS9NYd++02rPC44UvNuMOWag=;
        b=B+9GwZKIjimcZET39jiEv3WT0GoLENkoUfDXOud4xZGq1bLQ1uxHedO/2+FXbu7uVA
         Y9WlkpPr4WpBzxpKyuS8Pvf+B1kG+L9oA4H2PNzOk4n1hZl3E0VlEt2/uWNI9vGw0Lv1
         Uug01LJbx6MbgyC/oVAaHSUyikQJHyIlZe/Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218339; x=1692823139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mebqjsm4NZp8ScdZvCRAS9NYd++02rPC44UvNuMOWag=;
        b=LHehgJ6sYs06O7t5dWMfPZuOLEBgM+TIuXWpJyiyc2u5bHeBDXgn4FVbGl+S8t8jOc
         hcw8S16a5IqZADnVPWbcO6qlL90J3x47aMjh/pKqHdpwvEM1tNF8qO2J8qkk9qgsnzDY
         ZDLgA9vHymsIEjEvy/Jrp9KC3ccGGQR8uv6sZweRCGsPxHorsjaPVGlqzqUNEvRWYifn
         CuWLj+C079ntfsfz0ZgtvW4zZ3NKdivDsMCqMjmjmoArNPOuKP4OUV7E/3wJbz9n7ZqN
         0N01BrEE3rTZHiHWpv7rM+2WG9lJgXNY66Jy7w4VPL0STvLxpK5NWjSEzgi817a+SE4h
         kuug==
X-Gm-Message-State: AOJu0Yz7lZRG80CvkjIx+YGwKZmI5MD1m8nqbd3LBHDQ6BsnuLg3fQcm
        X+3ma0V3ZdMn4dtGY9qtvrg8R/6r1WKMy7EgoTw=
X-Google-Smtp-Source: AGHT+IH8TNVv8K24tYufYWfhj6FReA3GRy3bUNjldrAPON0uLm7g+SZDkIHCoYjL1zNAe1G0wAMRyA==
X-Received: by 2002:a17:902:c94e:b0:1bb:598a:14e5 with SMTP id i14-20020a170902c94e00b001bb598a14e5mr2728850pla.43.1692218338963;
        Wed, 16 Aug 2023 13:38:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001b7fd27144dsm13607893plg.40.2023.08.16.13.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:38:58 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:38:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] nouveau/svm: Split assignment from if
 conditional
Message-ID: <202308161338.C7162E7@keescook>
References: <cover.1692208802.git.gustavoars@kernel.org>
 <6b900e80b5587187c68efc788f5b042ca747d374.1692208802.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b900e80b5587187c68efc788f5b042ca747d374.1692208802.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 16, 2023 at 12:05:06PM -0600, Gustavo A. R. Silva wrote:
> Fix checkpatch.pl ERROR: do not use assignment in if condition.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
