Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FDCEE6457
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 13:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjIONgt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjIONgt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 09:36:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4432126
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 06:36:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-760dff4b701so32369839f.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694785002; x=1695389802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyfUX0X2fmtB6PX68eelYyAoJB8jxcCYoU3jaj8MsYM=;
        b=ydn4D9Jfxv5BuKoSlCNrEbvb0wmF/UhEs+33XosPhhKT/yK+jMCISrZt2wgU4HM87v
         7KCXIviagDEc8M7npSAwopV0CkjU8APIaZPrZxk+TLvqRSEezoC3ZIpQCjSIBaQxANVK
         biaVcG0RgFfe94C6GxLy9OSgNAXZHmFD38xMHM4ee4yX7mvOaZG/ucotanKldb1ciNIA
         pwD8BOE0GACYkaxnmil2tFmNtlj1vwN+8aw9OqRqby4m/JpHwA6riYYpJZ7MnvSJCba8
         bHCFt6A5CDU3LboM1AyBTUxoRG36YW/tzua93QCiPMyEKHsndpENAp9VlejjaE2tqKn+
         rkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694785002; x=1695389802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyfUX0X2fmtB6PX68eelYyAoJB8jxcCYoU3jaj8MsYM=;
        b=DBuDkxe85Nb00wMn+MP5SiSk0U79TkiDnxHmSs9arEPgHSRa0rLmdHLeer/xiexEKO
         WPGdDCHEELECWxZnEAULDf34WkwgM3i1uy+ZkRUMIwY9rruDav4EPYxHAIEg3iT6yZ7u
         ryH5kj3mPFZQRLP4YXIWaaqom+nIrCaX6mq+OGy7TQSzW1y5R0YllR8lXOdodCsO/8cy
         6SjQtvB1EQMBfnftPbsGh9YiEfsLLK854B8l+VQzpP1kW/ATOLwNIOTRw+JcfMPyBCrZ
         HFqObRFWbFD4Jwm2vvpoIKcey9idJnYo5E76FjsOx19X8idkRoxcSCkrJGizoFIOBE7A
         QXJw==
X-Gm-Message-State: AOJu0YxZoapFtjyVNzC19nJ5cokKeShNw66FNaLzZYOyuEc7uUZh15A9
        BiF5UZ25orRkaTg4CF0LhS6gdw==
X-Google-Smtp-Source: AGHT+IH9FFVy2H1yFJjidsyCoasweVzlcw3vqMkLY4wA397WlW2CuAHpeyoGIJF6lW3TWHiGyUOvwQ==
X-Received: by 2002:a05:6602:17c9:b0:792:6dd8:a65f with SMTP id z9-20020a05660217c900b007926dd8a65fmr1530583iox.0.1694785002301;
        Fri, 15 Sep 2023 06:36:42 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b12-20020a02c98c000000b0042b6940b793sm1024607jap.17.2023.09.15.06.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:36:41 -0700 (PDT)
Message-ID: <6338fbac-0177-43eb-be4f-7c586956953f@kernel.dk>
Date:   Fri, 15 Sep 2023 07:36:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: refactor deprecated strncpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Yang Yang <yang.yang29@zte.com>
References: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
 <202309142019.23A7D80A@keescook>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202309142019.23A7D80A@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 9/14/23 9:21 PM, Kees Cook wrote:
> On Mon, Sep 11, 2023 at 09:09:07PM +0000, Justin Stitt wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>
>> `aoe_iflist` is expected to be NUL-terminated which is evident by its
>> use with string apis later on like `strspn`:
>> | 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
>>
>> It also seems `aoe_iflist` does not need to be NUL-padded which means
>> `strscpy` [2] is a suitable replacement due to the fact that it
>> guarantees NUL-termination on the destination buffer while not
>> unnecessarily NUL-padding.
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Xu Panda <xu.panda@zte.com.cn>
>> Cc: Yang Yang <yang.yang29@zte.com>
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Agreed, truncation is the current behavior, and padding isn't needed.
> (Or more precisely, it's already zeroed and this function is called
> once.)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Change looks fine to me too, but for the love of $deity, please use
a proper subject line for these kinds of patches. It's not refactoring
anything.

-- 
Jens Axboe

