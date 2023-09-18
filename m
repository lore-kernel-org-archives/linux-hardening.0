Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99FECD37B0
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjIRQCv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjIRQCt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Sep 2023 12:02:49 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F54423E
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 09:01:26 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76f2fea104aso77160085a.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 09:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695052602; x=1695657402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bC2phskuIFvD/AaiWBQwD/RidKu+taALyCRQa/nknSE=;
        b=JPcKV78fctlDxzROV1pY51z1qZtxOaQWdBnHbwug6pQW90t7vu8BITt9hvdTknIk4B
         Xjup4pRRHJiJQ4dkPwXmuhhn5faeSuaosRIwCuXBrPxEzIDZTiGg5a3EFUEW9jaMHoTD
         9Kdo6Izxl5qDr4tanJBljNzPe2WVwFu/iACfMAG/AcKaoaxNOLLX/TTv8GuuTIxkdlwj
         iph99vTtlJrDgvvR7MPKkTWB8Zw3KKHmCLQ7m2bzz7o0aiVXQ00TtXgHLE+slx/AKViY
         0sNpVgC57HeB/g+RXK0zF/cAhGWch3hEhs4ggxYbC+hzXWbx5NEHaUXm4dLRZSLk2bc3
         d84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052602; x=1695657402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bC2phskuIFvD/AaiWBQwD/RidKu+taALyCRQa/nknSE=;
        b=EpB7cfT+iDFEcdt7tQecL/52nsmjmxRgOXL+613sUlOihnAkNQTl/cXr1JxKYZfyPT
         6ohRV/RO18W4ME/NR97B8sqxERKKj+BlZTg3ssPL0ZsxylT7mvsR9P+CHQMh1jX3AyGV
         RGuSRa29jcO+XNphJ6CpXj/SfoxSb3bvRUB/fuZYIgUev25/X28sqlPz4SSWyPe1TDRo
         w/oNJ6gGHzwiE9Zbbf6Ioq9or4OTavZoZii8XBXUBo0/GfoJ5S7jSDrJd4GMrjSRCziP
         vs/2DgH1B+gUF1MmP8VexjOw8rAzxc66UBqY5liRI3e9SmRZkypNUEoGy2REEDVPBEal
         C7HA==
X-Gm-Message-State: AOJu0YwS3aqFqU8JIHwtbRU6fC2eYOxdr81U0aSJTBEDuVw6ye2XZRcM
        Qebou5C6SVMP14ZtqOjVSncasAx7TfjCourPhfQphw==
X-Google-Smtp-Source: AGHT+IE4huNJ9ieYLbRr1wXk9YJVyZSV0RaDTxWDJMPdpQYjKG794yWqTTw/d7v2WKKlkf7zMRwoMQ==
X-Received: by 2002:a6b:c94d:0:b0:795:172f:977a with SMTP id z74-20020a6bc94d000000b00795172f977amr9665856iof.1.1695045646340;
        Mon, 18 Sep 2023 07:00:46 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id em8-20020a0566384da800b0042b068d921esm2836235jab.16.2023.09.18.07.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:00:45 -0700 (PDT)
Message-ID: <e6433ada-16db-4d16-801b-9a3fd5460467@kernel.dk>
Date:   Mon, 18 Sep 2023 08:00:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: refactor deprecated strncpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Justin Sanders <justin@coraid.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>
References: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
 <202309142019.23A7D80A@keescook>
 <6338fbac-0177-43eb-be4f-7c586956953f@kernel.dk>
 <CAFhGd8pwtUSJBzepe=GBeyKuhD6ND6aWjeeT477Sdb4YTYDL_Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFhGd8pwtUSJBzepe=GBeyKuhD6ND6aWjeeT477Sdb4YTYDL_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 9/18/23 1:03 AM, Justin Stitt wrote:
>> Change looks fine to me too, but for the love of $deity, please use
>> a proper subject line for these kinds of patches. It's not refactoring
>> anything.
>>
> 
> Fair.
> 
> Perhaps "xyz: replace strncpy with strscpy"?

That's a lot more descriptive, as a) it's actually accurate, and b) this
is what the patch does. You just sent another one with this refactor
wording which makes zero sense, please resend this and others targeted
at block with a proper description.

-- 
Jens Axboe

