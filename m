Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3526DC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Sep 2021 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC9A610A4
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Sep 2021 15:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbhIQP4J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 17 Sep 2021 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhIQP4I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 17 Sep 2021 11:56:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CBBC061766
        for <linux-hardening@vger.kernel.org>; Fri, 17 Sep 2021 08:54:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h3so10012747pgb.7
        for <linux-hardening@vger.kernel.org>; Fri, 17 Sep 2021 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+QhNx1xL4TTv0Q4Zmru2yDL9Dg0TE9nnDuxrWUBBR84=;
        b=UzTRN8S+SFaS0NcA2X93VlLRRLwVuNfxQ7NfzwkE+I7/olmwRoLLJAmuJx30dIORIa
         d0hK4cEU//XVhpq8K6KGV69vJbwzGUnQQUnubK9I2xnkdVgTlCGAQ7msHG/9QTcv6Ycb
         ibLejp56H/G5YUjxLUEPMiLjsES/wNBmzTgyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+QhNx1xL4TTv0Q4Zmru2yDL9Dg0TE9nnDuxrWUBBR84=;
        b=5LWFyfIZZU9R7snVsAGJAkWJFVqBGXCB0hSQm1dpwTVvsvH4Z+/jGI2fCxkEBRDwuU
         R4dSMO8ZaL1yjxHp+qKixsMGD1crmIFOYSZl8OErdNFqB6o3apgidcq137dWV9Bi7+ZG
         DN03xVgvFqt5KRxF4GreHfFEA3fmydsY7CM6iNl4KUZJ+hdJcHScfEfs+jkxgta2cdsW
         Z7U/CmSVgBUruPl4+iCw3xG/F36xFuIvFkk5kKZ2Pxyrp2oan9fd/sJoNdcEh/sbXXME
         bjUbBnPgxZtVpiD5GY9q+Lqf3wCT4/pyEwOU2wW89FBMIto+8VKcg+wmeODDUsMoNDmv
         vzag==
X-Gm-Message-State: AOAM533lt//fQ96ZpgGf02ep+pCqPNMeozHH0Gp/Zj/XK5AQYLV6rSyu
        E0XjRtc6x5R6Psmdd2LYkQBZyg==
X-Google-Smtp-Source: ABdhPJzpWIoc5zT5RwybN9lLYKDIkzgT1DK7K6W4lRjZBgZOR0pFTwHhbVoLjM1hQc9M9qiRyhom1w==
X-Received: by 2002:a62:6244:0:b0:43e:ee5:c7b5 with SMTP id w65-20020a626244000000b0043e0ee5c7b5mr11319098pfb.28.1631894085801;
        Fri, 17 Sep 2021 08:54:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m64sm7006875pga.55.2021.09.17.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:54:45 -0700 (PDT)
Date:   Fri, 17 Sep 2021 08:54:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        rafael@kernel.org, jic23@kernel.org, lars@metafoo.de,
        ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v1 2/6] iio/test-format: build kunit tests without
 structleak plugin
Message-ID: <202109170851.4485B94148@keescook>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-3-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210917061104.2680133-3-brendanhiggins@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 16, 2021 at 11:11:00PM -0700, Brendan Higgins wrote:
> The structleak plugin causes the stack frame size to grow immensely when
> used with KUnit:
> 
> ../drivers/iio/test/iio-test-format.c: In function ‘iio_test_iio_format_value_fixedpoint’:
> ../drivers/iio/test/iio-test-format.c:98:1: warning: the frame size of 2336 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Turn it off in this file.

Given that these are all for KUnit tests, is it possible there are going
to be other CONFIGs that will interact poorly (e.g. KASAN)? Maybe there
needs to be a small level of indirection with something like:

DISABLE_UNDER_KUNIT := $(DISABLE_STRUCTLEAK_PLUGIN)
export DISABLE_UNDER_KUNIT

then all of these become:

+CFLAGS_iio-test-format.o += $(DISABLE_UNDER_KUNIT)

Either way, I think these are fine to add.

Reviewed-by: Kees Cook <keescook@chromium.org>


> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/iio/test/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
> index f1099b4953014..467519a2027e5 100644
> --- a/drivers/iio/test/Makefile
> +++ b/drivers/iio/test/Makefile
> @@ -5,3 +5,4 @@
>  
>  # Keep in alphabetical order
>  obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
> +CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

-- 
Kees Cook
