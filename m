Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C9C38145
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Sep 2022 22:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIGWZq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGWZp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Sep 2022 18:25:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135755C9C3
        for <linux-hardening@vger.kernel.org>; Wed,  7 Sep 2022 15:25:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e68so2963490pfe.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Sep 2022 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QyjJV/dv4syjEBjDQwkjVgR2N/oSfEod1xoF0knwswc=;
        b=L6mRl8n3ct1fXOW6uKCmPxsWTPsnOB0qpk+ajn9S06Jx894QMKZXGRrWV5hWgwqNqd
         5ofQNxt0rAFDUbFoRvJOFaeOcnm0Vd+v55ZpMMG/Y8+UiO9gZR3FfmhmANsMjaq06DSp
         rVGhHOujJLC4oxElUK9qdObr8b8fCPaRoIAX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QyjJV/dv4syjEBjDQwkjVgR2N/oSfEod1xoF0knwswc=;
        b=qnaYgD1XmqjR7nmrtsIcI/+S+W8APtWA915NbC4pMh/BEE4TRXMfVy+kYnF4anW5AW
         fui5GL7SDXPRRgvXGkdm+C6goJXQwerRhKmeQ0v2EgegippqX6rSL/A2q//TLWrggA3/
         l30h7fhn5A6h/3ePBr/v6uR3szN7vwiOftgA9DWyJSlvEtt4TY7ubQZMJ1mvWf3XHWnE
         4aqsZIQivAJkoC5vm5lKAhwL/dOiuGVXeBTQJuNOu0P8vS5axe0pxIw3hEVCMW/EDoB2
         q7QNkwB22FlBq+lyYcozbYX974/kYsEENdBWfp3i4ncoGWm+qNLc1IFwOUVcvWZvp3nh
         3A2g==
X-Gm-Message-State: ACgBeo27YN3HMsaQCndbZWXG08qw0SDnF6hi45A90D59eFZYc3S+u/lg
        ZZkxEZZed2f8AXJdA80qUcwrDg==
X-Google-Smtp-Source: AA6agR5iHcWDhRr4BDgvhUJzrnupCnLRp/N6JDkJrQZ+IYydlT/KMT7IWLMAtD22CDm1v+X3gIof8w==
X-Received: by 2002:a63:4e44:0:b0:42b:1fff:72d1 with SMTP id o4-20020a634e44000000b0042b1fff72d1mr5323048pgl.432.1662589543549;
        Wed, 07 Sep 2022 15:25:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090a49c700b001efa9e83927sm141953pjm.51.2022.09.07.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 15:25:42 -0700 (PDT)
Date:   Wed, 7 Sep 2022 15:25:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: usb: pwc-uncompress: Use flex array
 destination for memcpy()
Message-ID: <202209071525.AFFA11872@keescook>
References: <YxjpMMUb3WP5Rbu7@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxjpMMUb3WP5Rbu7@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 07, 2022 at 07:55:44PM +0100, Gustavo A. R. Silva wrote:
> In preparation for FORTIFY_SOURCE performing run-time destination buffer
> bounds checking for memcpy(), specify the destination output buffer
> explicitly, instead of asking memcpy() to write past the end of what looked
> like a fixed-size object.
> 
> Notice that raw_frame is a pointer to a structure that contains
> flexible-array member rawframe[]:
> 
> drivers/media/usb/pwc/pwc.h:
> 190 struct pwc_raw_frame {
> 191         __le16 type;            /* type of the webcam */
> 192         __le16 vbandlength;     /* Size of 4 lines compressed (used by the
> 193                                    decompressor) */
> 194         __u8   cmd[4];          /* the four byte of the command (in case of
> 195                                    nala, only the first 3 bytes is filled) */
> 196         __u8   rawframe[];      /* frame_size = H / 4 * vbandlength */
> 197 } __packed;
> 
> Link: https://github.com/KSPP/linux/issues/200
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks! Yeah, this looks very similar to other transformations like
this. And this one even had the flex array already! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
