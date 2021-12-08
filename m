Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0274C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Dec 2021 23:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhLHX0q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhLHX0q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Dec 2021 18:26:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C5C0617A1
        for <linux-hardening@vger.kernel.org>; Wed,  8 Dec 2021 15:23:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x6so13785530edr.5
        for <linux-hardening@vger.kernel.org>; Wed, 08 Dec 2021 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=12eYC9cttLky1xiGkzKZrN85X2r4m8IpTalt9bP6nHY=;
        b=QlyaI3Ku1W5hlIPYgHKuslvFHFWzLFTdq423Ieu6TH5hTrBvHrZGQLiAA0Y2A3UqnQ
         TG2uu6OZ6sCgGywg71Nlh1wTAbDV+IsC6OIoD9k0ezM3qWuscU/NNrsWdyyPvA/FdN3v
         hLMfADD24WDkzP3M92kz41O29cuWzDgIwUnAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=12eYC9cttLky1xiGkzKZrN85X2r4m8IpTalt9bP6nHY=;
        b=ugxCSaISsbaDxKGeJXDIr5zzBiZUUfeaHx54t5PJ3Dcgvllsu9BGGidjjTJ4c8PloB
         nri1mbiqM04EWjwm0OLmvoWuROd0FQ90YTRaPasxhsWHKUUMAAtZgIZ1JIs3BggXvR6X
         /i5VDwYd6wU6OGSRH92A/zI0G8J9X16upqvDd07NqadL56wZDfRNo7hpP56Otc1yWTHc
         0d/XXQD+lHMJ0w/gbn7HAJeXGE0wSrpw7pGSI3ZaHHZn/pe8fLYk+vxYGuSdU0E+Rf8+
         g8Mws6JZ2uNzuGe5A2vfXVr8a3feLHYDVySfGzY9Uiabvly0A+Ej5Y5CT0ULG3i/ivgx
         apGQ==
X-Gm-Message-State: AOAM532yzVLIEtxvC15lxaKmtsW3050+f9yVuwysuzqT123lgys1t0XR
        mMI0UPYNq70wLd9mJLYOh9N6NjLS1HgcaNe7
X-Google-Smtp-Source: ABdhPJwMP2aotTKfhTbOOW19RqP4FL6+EYSjrQ6GDEnSdFMsqfAKIE6z7H9WLhPIVqkR19LBd6CRYg==
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr22956922edb.345.1639005791724;
        Wed, 08 Dec 2021 15:23:11 -0800 (PST)
Received: from [192.168.1.149] ([80.208.69.72])
        by smtp.gmail.com with ESMTPSA id y15sm2701371edr.35.2021.12.08.15.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 15:23:11 -0800 (PST)
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
To:     Kees Cook <keescook@chromium.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20211203100846.3977195-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <037c44cb-c5bc-9a9a-0c16-219bdf858ea7@rasmusvillemoes.dk>
Date:   Thu, 9 Dec 2021 00:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211203100846.3977195-1-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 03/12/2021 11.08, Kees Cook wrote:
> It's common practice to cast small variable arguments to the find_*_bit()
> helpers to unsigned long and then use a size argument smaller than
> sizeof(unsigned long):
> 
> 	unsigned int bits;
> 	...
> 	out = find_first_bit((unsigned long *)&bits, 32);

Those call sites need to be fixed, they are broken on BE anyway. And
your __find_bits_deref does nothing to fix (paper over) that if, say,
the caller uses an u32 to store an 8-bit bitmap.

So NAK.

Rasmus
