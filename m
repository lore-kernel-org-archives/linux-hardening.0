Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34518C61DA4
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 17:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjBCRy0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjBCRyS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 12:54:18 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6703611CB
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 09:54:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id r8so6016293pls.2
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FglzRedEledpe7U/HZFQU5fjwrxpiFTlIoZfizmZKxo=;
        b=jbL6W/faZm4W+GkDNARtVIQSEx2ADO2QYfIC86h2ZMHc5o/ZEBFOY5YrRkhNg2iOpB
         /63HbsfHa9WGzx3zbFmY1UfIUIuxKXcouG1MM1zxPt90HwxBo5dELOThuq4wIWGKm/i2
         DiYYIrK7jDHD/1It501CO+Y9SysMFq67N+Mtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FglzRedEledpe7U/HZFQU5fjwrxpiFTlIoZfizmZKxo=;
        b=fWEL/7Mmop+DEK4gUATFqTOetyMFqfht/km95abkk1lc86C3J2hPNsqEqNf3pZpgex
         xEPCVEWu4dM6ttpOKaEgkXply+DHwyRfPwCdjJuspZSC8MMqtr8kxMpOMt1N7ovcagte
         OtFMj6ht0yEQicWsiafBonW5e1YIjf6KzZSD9m1fDFvaNg1AzWfNqcYmq1DKT25+ZmOu
         kErdOOZBMdnmCk8qYbfbAG281KDuzzP8medWE+3yMnQqHq7nZ6uRfGYEJkOWXsWkT/CM
         On/NpqT4SfiAXtL6n3k56Iy2lZXg4f4UFfpPgWeQw33v6uEe4T++VVOZjgqnduuFv2Ka
         ewDA==
X-Gm-Message-State: AO0yUKV1AczuI5NYgWlYodTbSVBHVbMfDYwIOlekTJk3Ws3MVzy8dePu
        FN74Bf+ERHy6qs26ksUkVdTIsQ==
X-Google-Smtp-Source: AK7set/Z7WE5Ld13ny7sgCsxLEEjOYX9qnYiq/CIu1TV+5vNxcdynZYDJopTLqfhZ/z5xziON6sH4Q==
X-Received: by 2002:a17:902:c611:b0:194:5fc9:f55a with SMTP id r17-20020a170902c61100b001945fc9f55amr8907518plr.35.1675446854374;
        Fri, 03 Feb 2023 09:54:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b00192b23b8451sm1889641pln.108.2023.02.03.09.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:54:13 -0800 (PST)
Message-ID: <63dd4a45.170a0220.e6dee.365d@mx.google.com>
X-Google-Original-Message-ID: <202302031754.@keescook>
Date:   Fri, 3 Feb 2023 17:54:13 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xen: Replace one-element array with flexible-array
 member
References: <Y9xjN6Wa3VslgXeX@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xjN6Wa3VslgXeX@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 02, 2023 at 07:28:23PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct xen_page_directory.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/255
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
