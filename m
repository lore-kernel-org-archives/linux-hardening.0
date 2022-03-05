Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD4C433EF
	for <linux-hardening@archiver.kernel.org>; Sat,  5 Mar 2022 20:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiCEUoa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 5 Mar 2022 15:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiCEUo3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 5 Mar 2022 15:44:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E11FCC8
        for <linux-hardening@vger.kernel.org>; Sat,  5 Mar 2022 12:43:36 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw13so24121537ejc.9
        for <linux-hardening@vger.kernel.org>; Sat, 05 Mar 2022 12:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rliKIF9LH5HqnoLDDPE/tXAb493Fa2slfHBUMJx2T0A=;
        b=C/WRMoQuEnyBv2MX2nJzq6c+TDU8K5ezbKAeERzK2YUQGeU72z9D001ueiy/wLK/IQ
         yUVWr9G5XLflDvzGkxPoWLAf+ukRweOvRD6qDzvQDSHcSWh3Xjy8RWmV5EfE3d74wNZy
         RjTma4PcM4O4dW9ZRHc8woB+lbOk6yUYsL5QVTEr5lCjTCvCW7ixsqSYmELmu+CoEgK3
         IslLQ1ZMSmJTVO5LySN5tVPMp/AecNRTrYeH45a+iNC5HC/UtzaMkEVX8CI7Hve5Davy
         7VHDaksWw8Cnhg7/oXRNk8CT/7BhqfNgxuBi1EsGX8xZcPLlx/EPk1ZQldqdYICNb6kZ
         tfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rliKIF9LH5HqnoLDDPE/tXAb493Fa2slfHBUMJx2T0A=;
        b=E2gER3ufaqAGblS6K6n2Mfnxc/loRsqN0xKq9yFOc3cNrmKtBdmIQJAu/EOVaNS7ou
         jyoP54+5ygIHPyEuM6yUxbJRcySIQoZwTcUnkIu0Ole6EgOc+ZrHPxg4n4EAW9Eyq+k4
         JgGX3gehkMLiEWaBEZvz60ZkdJEPJsJQtGS7lIR5XGr5ufAn6eXnBsE2l5BtxDILhtSS
         Kc7dJLJe5fR+veOkGPJjPy/Vy//eVzjKWYV7bdoMFpyalhEVbIGtfLGX3x6LhOtQNwEH
         010+NyTNkZyX31sY+c/6cb8/7zRqDCpoWGnUSTkPTOTPvmzlzZr17wMfGqtQ+Wu7Nm/3
         1opg==
X-Gm-Message-State: AOAM532yzJYdShkCZYrV0E5rvbPrzXjb/uhPXmcMqqgTmRDERFjNNwmK
        LHZE2NnmAjJOSyMXs6MhPGAE//8b4d8JRL/t14HNUVwMMut2PA==
X-Google-Smtp-Source: ABdhPJyJYdWhxyeZROovC02Ys+uI2dm0AeK4SAxYBeSo94uLXgOck5bSvhhvh4h6qD+8yihtJHXGkxvxs5R/XkccR74=
X-Received: by 2002:a17:906:c141:b0:6da:b786:3fd4 with SMTP id
 dp1-20020a170906c14100b006dab7863fd4mr3771615ejc.16.1646513014848; Sat, 05
 Mar 2022 12:43:34 -0800 (PST)
MIME-Version: 1.0
References: <202202021501.DA6594BFC@keescook>
In-Reply-To: <202202021501.DA6594BFC@keescook>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 5 Mar 2022 12:43:23 -0800
Message-ID: <CAMo8BfKO-ysOrYFGpZNsorZ-zyMWY5CObC1Oie0ubuXVF=ZCbg@mail.gmail.com>
Subject: Re: How large is the xtensa pt_regs::areg array supposed to be?
To:     Kees Cook <keescook@chromium.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

On Wed, Feb 2, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
> When building with -Warray-bounds, I see this:
>
> In file included from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from arch/xtensa/kernel/process.c:21:
> arch/xtensa/kernel/process.c: In function 'copy_thread':
> arch/xtensa/kernel/process.c:262:52: warning: array subscript 53 is above array bounds of 'long unsigned int[16]' [-Warray-bounds]

I tried to reproduce this by building with -Warray-bounds added to
KBUILD_CFLAGS but couldn't get neither gcc-11 nor the current
gcc trunk to issue this warning. How did you get it?

-- 
Thanks.
-- Max
