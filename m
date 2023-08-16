Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F5C27C42
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Aug 2023 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjHPUz5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 16:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346330AbjHPUzo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 16:55:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8F2724
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:55:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-56546b45f30so5401246a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692219342; x=1692824142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C00XHrqX2JehVx2BBEXfXecV7OVkf6gSj4eigV0sDaQ=;
        b=Wd+2qwQqJLbcXOZfZxHK7QeYcunXx/JB1n8i5nb0p6eHz8dT9PSiVtuZHXF9om1+hX
         afleLuXxjUJI+9b6oL+ivcB0pCk60ar2sDz6igfDLeBu8b+zpuhIB3GoyLlDBFfcGP0S
         eF8L6NfDlEdKuwAYRfjUf1/T0y843DHuXwRPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219342; x=1692824142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C00XHrqX2JehVx2BBEXfXecV7OVkf6gSj4eigV0sDaQ=;
        b=RfpxDbijxEx1vPngeO+ET0O+tO6IxMHX5i5CTVow87G+4rraDXNl85GCXsptT6tgTL
         sTpQFoyUcMA+1cXuhMKGdnZAV2Icc/FPVhjIAyl1JxvKlBegNQ+bHx+IF71TO17W7kds
         ZEaMRf7ojYDaj7YzrRmElnGbEdwmtLFKejE325SyQZQ0SPDKfuxMRzKe5/RN+vAXoBVs
         z/0o9048pUmRB2ewIuJzg1e6u0ewot/50tYIQhvMPjjnkJ5JKjiS8ZZWW4GU9dEUUZ3f
         ITI3sUf5q5sz45Me9RddOsEOdGRaPvLZO7BSH4dsBoZgwI0Zt4d2KiYZy0haSYeAU/x7
         U6IA==
X-Gm-Message-State: AOJu0Yy16D01r+KHXLpEl3FDbrlUnHv5c3HjK78bJ+ADF7e0ujCAIv5j
        b+TS6GuffBGRK20BDYaZl5Ci7w==
X-Google-Smtp-Source: AGHT+IHJW+AH5vlrIhdUlHgmZMHwz/lc7DRwSMYiYs0PBq1i1vK5obxcxfHOGdznenzbMzBFW6xmFA==
X-Received: by 2002:a17:90a:d988:b0:262:f0e6:9e09 with SMTP id d8-20020a17090ad98800b00262f0e69e09mr2633351pjv.14.1692219342574;
        Wed, 16 Aug 2023 13:55:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0026b26181ac9sm178867pjc.14.2023.08.16.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:55:41 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:55:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Waqar Hameed <waqar.hameed@axis.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v2] iio: irsd200: fix -Warray-bounds bug in
 irsd200_trigger_handler
Message-ID: <202308161355.9EC0D12C@keescook>
References: <20230810035910.1334706-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810035910.1334706-1-gongruiqi@huaweicloud.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 11:59:10AM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 with -Warray-bounds enabled:
> 
> In file included from drivers/iio/proximity/irsd200.c:15:
> In function ‘iio_push_to_buffers_with_timestamp’,
>     inlined from ‘irsd200_trigger_handler’ at drivers/iio/proximity/irsd200.c:770:2:
> ./include/linux/iio/buffer.h:42:46: error: array subscript ‘int64_t {aka long long int}[0]’
> is partly outside array bounds of ‘s16[1]’ {aka ‘short int[1]’} [-Werror=array-bounds=]
>    42 |                 ((int64_t *)data)[ts_offset] = timestamp;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> drivers/iio/proximity/irsd200.c: In function ‘irsd200_trigger_handler’:
> drivers/iio/proximity/irsd200.c:763:13: note: object ‘buf’ of size 2
>   763 |         s16 buf = 0;
>       |             ^~~
> 
> The problem seems to be that irsd200_trigger_handler() is taking a s16
> variable as an int64_t buffer. As Jonathan suggested [1], fix it by
> extending the buffer to a two-element array of s64.
> 
> Link: https://github.com/KSPP/linux/issues/331
> Link: https://lore.kernel.org/lkml/20230809181329.46c00a5d@jic23-huawei/ [1]
> Fixes: 3db3562bc66e ("iio: Add driver for Murata IRS-D200")
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
