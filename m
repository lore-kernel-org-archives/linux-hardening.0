Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C2EC28CF5
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 19:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiAZTsm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 14:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiAZTsl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 14:48:41 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E3C06173B
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 11:48:41 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id c189so556307qkg.11
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cnaHKagfwHGqaznD5wm3EjdQSvy1XNpSCppZJHrSIys=;
        b=aGK97rakYCe9gtm+vNOzkSTyJolrONWbZ2NnD9qv8O+uupRm9HbODyTEdYDKGwqyfw
         eaJRbjvPqJlKnLVLWFxBfMNyyTuO+af5C/c11/hnXA/g57VtO+Y0nCxWYwFulgIoVFF7
         YxD07u+wy/R+NlTHMhpICG1UdViVU9ig95K42g31xhHuB3swuZPH9AcqL4tJBURZDmNs
         NWQA5kPDpffdLTHusFW8rrzpTCjPhMMaSYL0GBQcIbMPxS+E87YuUaTmIjD5vCURAtP8
         fZP2DLxhpLki+8DFHIpfVJwxW/A57IlJhbXvIompriWORNmJ40RTqWuXNVTc0KNHREzF
         Yf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cnaHKagfwHGqaznD5wm3EjdQSvy1XNpSCppZJHrSIys=;
        b=PiBe4PjTFUDCPrcZLYtfgMTfDU8brvWmgi3P7GDLpzc1a/waKoepkbL3TysuWT2ktD
         xhGKFKdgSz1Qs+KnRy0rSUZVZdq7ZnaemYm0p6EZIajXZXfWAnAK1kpbbATZOa2Kmkfw
         /0xg5Dz3vNc1WgfS7YAp5qMD3rG6FtSjqDgdqs06qQrWPmxO666Vyd7R6yipcaiNkgSQ
         u4vbXT3LVVeERFTPoLyJz3IxfH8kqlUV3j7GC/x6OOAU7s87pHYwhGFXQum0y8s9ZusU
         8NzGzNiF4I7Rlz1dCSt+aLVm3cLu49+7CRgfH8BorzCHbcrUrRU3cbcSUCZ4dW/cW1Is
         w+Ng==
X-Gm-Message-State: AOAM533f19dmPOE+AeJrIHOLViQrcOEllTp8LP7DhmpGQVpCIlLgpZI9
        TdCnr+kmBmPSFkMMe0S8Twk43g==
X-Google-Smtp-Source: ABdhPJyt3NXcmKd1A/0E+XHc7xXKnQSpbQx+rb7XFiJW9mvwHA7ZYU1u822P32XYn5DgApDo+ociPA==
X-Received: by 2002:a37:b0c:: with SMTP id 12mr211117qkl.667.1643226520231;
        Wed, 26 Jan 2022 11:48:40 -0800 (PST)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id f2sm101432qti.61.2022.01.26.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:48:39 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:48:39 -0500
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] eeprom: at25: Replace strncpy() with strscpy()
Message-ID: <20220126194839.GA3763384@maple.netwinder.org>
References: <20220118182047.3385295-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220118182047.3385295-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

On Tue, Jan 18, 2022 at 10:20:47AM -0800, Kees Cook wrote:
>Use strscpy() instead of strncpy(), since its use has been deprecated[1].
>
>[1] 
>https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Along with your other fix to restore the missing kzalloc(), I tested 
this change on 32-bit arm system, and it worked as expected.

Tested-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Cheers,
-Ralph
