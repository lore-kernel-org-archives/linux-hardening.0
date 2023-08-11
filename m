Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1427C41513
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Aug 2023 03:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjHKDe1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 23:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjHKDe0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 23:34:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7578A2D6D
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 20:34:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686be28e1a8so1215916b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691724865; x=1692329665;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol08JEKu7oqSkPybwCjqbHvzJEYD13kIWrCXt9fqhPA=;
        b=RM3Hcdg2buvo+7MBfeCcTgRzDJzIFNaSr4GX0g0i2DGfzJpDqxVPwKdK1XxDFje7DZ
         i69P7k9yZcNPGt7bKp3XbYBudkh0gf59uKKBQfXHJQJqo6n9UA9GU+s0lkTQRcDL6dH7
         yWbN0rxPPZbBBQ5a52XIqMvGTagTwEZgGxplTC2896VUwStmXu8NJlZIi1ZA6lqHAa20
         iEy96KnhgeiYrs7BCUJ1DEe8rWR/XljpbvwgoFURVGGDCY2mKX/qjMzQfb+0TkkbR6kE
         eqOrNchRxnqyV9fB/ILmeiPDrChEEBD+Qu/pf4wj7nTMJgXsVDR0MkcenvkqsYvCRBq0
         RI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691724865; x=1692329665;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol08JEKu7oqSkPybwCjqbHvzJEYD13kIWrCXt9fqhPA=;
        b=hCWv2KcLPhwerY6QfSe3kDhbFnUEsp/cwiQ7yJaByYPAMeUlLpSp10QY/9rWMHFWh9
         bJ+A4kclJ5+mre0JY9/WpgBZQt9O0Ant00nQuCT6p1sTuT8Pp5a3Q9sFKBuOoRCmOmek
         ohf8gO5CS1J62btRhkfvj9IpfWRGRoCaW78Z4EiEkCiPReHkUWrROcN8xvTt/9ZZHH9t
         HeWFn2wXm5ToMFL4HQVEu1dCMpUIm5kEvNu81T7icSSuf8JBt2Akc/D2AwIyBLHjent7
         XjSJIOWAyvAAYehEpmMsnJ4lq+XLPNvrk+gozMZ/OYuTxqlw5coAPzZTvSIpSofASEIP
         cNNA==
X-Gm-Message-State: AOJu0YycBeZQgPTjjMFQR9JHpWLYe3eQ3+35ACG5pepOiT04QHRxU3b9
        1h/vzdHJml2uLSXLr6cAP/o+vg==
X-Google-Smtp-Source: AGHT+IFMa5VFjaKScdXL8YdPq85Bi5eNzrHQcNg3xR10Oi+GyB/N1JnY7GmII2iLlkXP9If0A6y5kQ==
X-Received: by 2002:a05:6a00:ccd:b0:687:570:5021 with SMTP id b13-20020a056a000ccd00b0068705705021mr805514pfv.15.1691724864885;
        Thu, 10 Aug 2023 20:34:24 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id f22-20020a637556000000b005655811848asm2097438pgn.43.2023.08.10.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:34:24 -0700 (PDT)
Date:   Thu, 10 Aug 2023 20:34:24 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Aug 2023 20:34:23 PDT (-0700)
Subject:     Re: stable-rc: 6.1: gcc-plugins: Reorganize gimple includes for GCC 13
In-Reply-To: <202308102030.76B5309D1@keescook>
CC:     naresh.kamboju@linaro.org, stable@vger.kernel.org,
        lkft-triage@lists.linaro.org, Greg KH <gregkh@linuxfoundation.org>,
        sashal@kernel.org, anders.roxell@linaro.org,
        linux-hardening@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     keescook@chromium.org
Message-ID: <mhng-3d8b7678-3ebc-4665-8b58-94b44be0fd7c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 10 Aug 2023 20:30:52 PDT (-0700), keescook@chromium.org wrote:
> On Fri, Aug 11, 2023 at 08:47:53AM +0530, Naresh Kamboju wrote:
>> > > # first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
>> > >    gcc-plugins: Reorganize gimple includes for GCC 13
>> [...]
>>
>> > Commit e6a71160cc14 ("gcc-plugins: Reorganize gimple includes
>> > for GCC 13") was added in v6.2.
>>
>> This commit is needed.
>>
>> >
>> > I think you're saying you need it backported to the v6.1 stable tree?
>> > ("First bad commit" is really the first good commit?)
>>
>> First good commit.
>> We need to backport this patch for linux.6.1.y
>
> Okay! Thanks. :) Yeah, this could probably go to all the stable kernels,
> if someone wants to build with GCC 13 on older kernels.

I'm also sligtly lost in the bug report, but IIRC the GCC include 
changes were really a GCC version issue not a kernel version issue.  In 
other words, any kernel would be impacted if it's built with the newer 
GCC so this should be backported aggressively.

So

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
