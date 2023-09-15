Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29132EE021A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 03:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjIODhu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIODht (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 23:37:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7622716
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:37:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fbbb953cfso1423033b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694749065; x=1695353865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrkAHIjQDGiDP5wEakotxifTSwpH8QMLY2bspVz+a84=;
        b=VacDg1G4fPqQLceZaZVGmHlkMY1eJ5CbVieHp0oF4+iurLvzRyAMmqqlA+nWn6jARx
         DvPLfzS3QYOwJ7s4NPpRK+cAFxjM6UTM2fx+wNU8ukTPXAwMBQ36RMeQakzkWxIhFX4y
         Si0/1B3QuM7M1KkL2lUNt5k02JlJc/1ObmYHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749065; x=1695353865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrkAHIjQDGiDP5wEakotxifTSwpH8QMLY2bspVz+a84=;
        b=ZXAW8wWRH82+YV03ZUb4ZGPq1h5W8uXZARAl0rG43t2mPsRXFNG5eJiXkIQJKVl3CE
         Rm72iP5lN3QsNTyTKkhWaayeALd1oA8eClQUexiTZvfRN9iIJnGT61jFxWfUbb0QubF6
         P7SniFBd9pspZ1tez2CWbHrRVffe+tLZzq+J0ahZl58ieQKFd6d1zQs7nGzJ1/X1Hib5
         eo+f1DpTnZpnZryAuxODrtDuzewKDlbtgk4d5JbLmeWws62ZoLwm6kCvtkJwL959iu9Q
         OlEO+z7w1nnGEiR5OGuSoXQXNL0TkCTaIxwZi+4/TFymJPjHKXsjVeg+jTbMPLwF5tL/
         C7+g==
X-Gm-Message-State: AOJu0YyBVZZrk5WZW5r1nv11tAyvAW4MnLVbSUS2ggWI9VInSnJ9HlZS
        EvsOcG0TDffDC6g5l3mtBbfrFw==
X-Google-Smtp-Source: AGHT+IFKL9tpOx2ny4+YwCrHk5FiqrcmS6CBKI/hcxifOw5XLZvj2VUumvEZKpC3o2Q57QcevfaOvg==
X-Received: by 2002:a05:6a00:189a:b0:68a:6d1a:b812 with SMTP id x26-20020a056a00189a00b0068a6d1ab812mr674679pfh.9.1694749065065;
        Thu, 14 Sep 2023 20:37:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f10-20020aa782ca000000b0068fe7e07190sm2011222pfn.3.2023.09.14.20.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:37:44 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:37:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cpuidle: dt: refactor deprecated strncpy
Message-ID: <202309142037.5D689164B@keescook>
References: <20230913-strncpy-drivers-cpuidle-dt_idle_states-c-v1-1-d16a0dbe5658@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-cpuidle-dt_idle_states-c-v1-1-d16a0dbe5658@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 13, 2023 at 12:23:19AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer. With this, we can also drop
> the now unnecessary `CPUIDLE_(NAME|DESC)_LEN - 1` pieces.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

A very regular strncpy/strscpy conversion. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
