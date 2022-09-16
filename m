Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5C4ECAAD8
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Sep 2022 08:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIPIHn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Sep 2022 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIPIHb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Sep 2022 04:07:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4983FA24
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 01:07:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so1196892pjb.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=efUD2Cuze1s5fu9A1+CyDLPrdcU/1Kt0bMyNsDXEONY=;
        b=Jn15m+vFx5hwwmK/xwXR0sCWR0XgV3QsV7ccaNanOuS/M5Ti8PPipPZMdKd5Y+zJPm
         GgXlNWlpvOr8dd+Nb4+atVVBoPlkS/Z0RcXfqXlur5FPEaxE9Aot2NLQkXBkqR5fxknU
         qcmU1d4BLDOM6yeo8L7ir66kaxwPHgSV4WzQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=efUD2Cuze1s5fu9A1+CyDLPrdcU/1Kt0bMyNsDXEONY=;
        b=cRBtF7w6V8RkGgzJ3Q7c1sx0ImiBZhUvAbN7kJgjCA0zZvtHxtzUfgiwEga98n49BX
         wZYBGZlNhfyWd3sEWZrwn06QMUwHC9IdEewxEIG4Szx6Mh65cui+8qXniGNl7gvKoGS6
         trIWZ3sWrXL0NBRJUz4rQ5uJxQlx/MwBWxJmI4EUPv/z+u7iWo0eSc8AWo0CwfOnPSay
         PB+avwxJyvqgL0L73NEicjd+8gOJRFWR8nobc5viT9UeUg0y8vH68ffxl9VazzNOo8qE
         zsOaCnfXnhaNtH2crwo1MeyZgwb+e8oyafZpYQ79BxwD+VFQmzJB7+ObIbcPjVIopCN5
         qV4g==
X-Gm-Message-State: ACrzQf0OtsazciJCVR2IqCtaLsHhAcbVZ/aNuTcE/jNm/qj8bewfdvdz
        tHu6EcG84hBxMxKOcEcAinO4C9UGnq24ftUS
X-Google-Smtp-Source: AMsMyM4/znlazRwzEOVAPXReEX1A/RlzXSzwHTL4q0v6nu4NImq0p3KAUU2ExLKgahX4HV+lsKBNJA==
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id om14-20020a17090b3a8e00b0020055854099mr15554975pjb.70.1663315647392;
        Fri, 16 Sep 2022 01:07:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b0017828ae6310sm11876407plh.2.2022.09.16.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:07:26 -0700 (PDT)
Date:   Fri, 16 Sep 2022 01:07:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: harden i2c_mux_alloc() against integer
 overflows
Message-ID: <202209160101.2A240E9@keescook>
References: <YyMM8iVSHJ4ammsg@kili>
 <YyMt2cWtHC2SeG62@work>
 <YyMyKQnWgu0SL6jj@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyMyKQnWgu0SL6jj@kadam>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 15, 2022 at 05:09:45PM +0300, Dan Carpenter wrote:
> It would probaby be useful to mark passed data as explicitly unsafe for
> integer overflows.  Smatch already tracks user data.  And if the user
> data has been capped to an unknown value.  But this would be a
> completely separate flag which says that "this value came from
> size_add/mul()".

I really want a __must_check_type(size_t) attribute or something for
functions, so we can get a subset of -Wconversion warnings, etc.

> drivers/char/tpm/eventlog/tpm2.c:57 tpm2_bios_measurements_start() warn: using integer overflow function 'size_add()' for math
> [...]
> drivers/net/ethernet/intel/ice/ice_flex_pipe.c:2070 ice_pkg_buf_reserve_section() warn: using integer overflow function 'size_mul()' for math

I see size_add() and size_mul() here. I would have expected some
size_sub() opportunities too? Did nothing pop out?

-- 
Kees Cook
