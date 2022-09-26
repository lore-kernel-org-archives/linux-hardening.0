Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B56C6FA82
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiIZWCe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIZWCL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:02:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B38E6DEB
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:02:05 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so7723371pgb.13
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UWb8wOcddtfIJyUFHBW5IFK0MRMvmDGvIdsfGhwq6fs=;
        b=dC8LNQiZOc8Y9cleQx7I90Ilxgksx1StItiDqfDAw5kcu+wbT6Svs4BKe6de3VBEa8
         2Vz0EVtEAeXZQrz5wyhwgRc1V1hk3ZBnZN5xcRPZGY/PEC3WDGhqxxwUHRJQdJVtRYP3
         f+4j6TzqwFY0fyt3pnKplYB3IrwAqWudnuM18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UWb8wOcddtfIJyUFHBW5IFK0MRMvmDGvIdsfGhwq6fs=;
        b=NujU5DiVy+N6x4mWOc9bh64VWbJe8CbpMi9stki/XoRq6STGynELk0/jfqg/R92VE3
         ZWjqgfSfJ+eT4kI67l2avbJ+XzRFvV4biQCUO5XrfB7Wy6907ys9ig3va/+gmv9h/s7N
         mZ7twVoMIOaflW6nOLlJsL7NQGF4PGJEUNiBOMg2IVaJbUCAyOtpKlkjNvWi/JGQE7sa
         xQG2yeKXAtZSETUZpAGe+l48BcFTz0TZbll5ieMBCmc09BRiTlJzV9M7vs/ezDbWeYuW
         Fci3Yw1awE2g8hqCRTvCvD5n++tA6/oeBsjg1+ZIH9KxDEtaHD5UQvEIPnseLONW6sYN
         WxKw==
X-Gm-Message-State: ACrzQf1r0qB8SDfZqYUHrygzg/zDlUCQOZseiB3Z8ziHWuI++eRwiDOq
        t1Uh7UEBn47IVah169SDlopOkQ==
X-Google-Smtp-Source: AMsMyM7++pwLxo9jbIU4Zan+KiWB3G+z82cHwCpvQIpOj2QII3T8ZRtHBoCOWvcGBn2icNismTMwTA==
X-Received: by 2002:a63:3348:0:b0:439:db24:8b02 with SMTP id z69-20020a633348000000b00439db248b02mr21383347pgz.425.1664229724728;
        Mon, 26 Sep 2022 15:02:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b001754a3c5404sm11444207pld.212.2022.09.26.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:02:04 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:02:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] i2c: acpi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261502.AA269D2@keescook>
References: <YzId7dQGWxMyXHEU@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzId7dQGWxMyXHEU@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:47:25PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/218
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
