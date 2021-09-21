Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FF5C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 06:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A00261175
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 06:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhIUG5w (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Sep 2021 02:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhIUG5w (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Sep 2021 02:57:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFBC061575
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 23:56:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b20so18877264lfv.3
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2lP0KhRVUvQyWZhQ488eOsEIqUPPJSp/sF1BR/yQXNA=;
        b=NEpQsDXXuNMWEsogXhwZXw4ypkov14vzvRBxhT2TQD+U5CiVQ5t64wtt0SugLK5OQs
         HYua+NHNtV34Js5j1qfF3xrqCpUs+dG1ZvRltYVj6DokNycwnox+8LhdumLUL4S2Zx1N
         i5+CtjaG4+43ZCjC1Pdc/+supfjsgYP3RXW70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2lP0KhRVUvQyWZhQ488eOsEIqUPPJSp/sF1BR/yQXNA=;
        b=HY9Eg0i6f9Q4Tn4auZ0zy8PnP3Gm0ljgjog0T8NGOj+AMucqRNXf7POJ4zOqDsTAvZ
         Cgqv37rH2Q0YRrUN2EHoPC4fFVoeJgXA1a/Cb3uP+P70SBg6xupj5/jQs3UMmeoqWys0
         nsh4OZisPq/MqSYNgZ93v4oumRIdUhR3PhP0Et7LaU5/jBebmFw1Lk6UHIb/0JqQvJ64
         +1ysZFGc8eF6kWZN5yk2SbGPdyBpFh4F6BfZV5pabM+AlCtB0gyu+2pU1yg1wvY2jR5/
         lw6krl9eMbHbhZwO9QhlUD7KbJSmzcBf4f+p7O3KPqc22+HlumvsTrAk8TgAHwm3Aae2
         L1bw==
X-Gm-Message-State: AOAM533uHewEjGIOoqQSvT80pVm3iHUDOiJrM84pF/Ls0Q1dW1o6+xBT
        hO8OFBy+qml4mXtuRVaJPl6kEBxOGGBUMzQI
X-Google-Smtp-Source: ABdhPJzmHrM5oxs0FqUN8u4NwCUaVUzt1evboU4++WOUrYJxYEr2dBeXzvQMRUp6ttPU5Wm/bDxShw==
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr9411631lfg.550.1632207382109;
        Mon, 20 Sep 2021 23:56:22 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p19sm656144lfr.210.2021.09.20.23.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 23:56:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] test_overflow: Regularize test reporting output
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-3-keescook@chromium.org>
 <CAKwvOdnYYa+72VhtJ4ug=SJVFn7w+n7Th+hKYE87BRDt4hvqOg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <eb6d02ae-e2ed-e7bd-c700-8a6d004d84ce@rasmusvillemoes.dk>
Date:   Tue, 21 Sep 2021 08:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnYYa+72VhtJ4ug=SJVFn7w+n7Th+hKYE87BRDt4hvqOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 21/09/2021 00.10, Nick Desaulniers wrote:
> On Mon, Sep 20, 2021 at 11:09 AM Kees Cook <keescook@chromium.org> wrote:
>>

>> @@ -544,10 +544,7 @@ DEFINE_TEST_ALLOC(kmalloc,  kfree,      0, 1, 0);
>>  DEFINE_TEST_ALLOC(kmalloc_node,         kfree,      0, 1, 1);
>>  DEFINE_TEST_ALLOC(kzalloc,      kfree,      0, 1, 0);
>>  DEFINE_TEST_ALLOC(kzalloc_node,  kfree,             0, 1, 1);
>> -DEFINE_TEST_ALLOC(vmalloc,      vfree,      0, 0, 0);
>> -DEFINE_TEST_ALLOC(vmalloc_node,  vfree,             0, 0, 1);
>> -DEFINE_TEST_ALLOC(vzalloc,      vfree,      0, 0, 0);
>> -DEFINE_TEST_ALLOC(vzalloc_node,  vfree,             0, 0, 1);
>> +DEFINE_TEST_ALLOC(__vmalloc,    vfree,      0, 1, 0);
>>  DEFINE_TEST_ALLOC(kvmalloc,     kvfree,     0, 1, 0);
>>  DEFINE_TEST_ALLOC(kvmalloc_node, kvfree,     0, 1, 1);
>>  DEFINE_TEST_ALLOC(kvzalloc,     kvfree,     0, 1, 0);
>> @@ -559,8 +556,14 @@ static int __init test_overflow_allocation(void)
>>  {
>>         const char device_name[] = "overflow-test";
>>         struct device *dev;
>> +       int count = 0;
>>         int err = 0;
>>
>> +#define check_allocation_overflow(alloc)       ({      \
>> +       count++;                                        \
>> +       test_ ## alloc(dev);                            \
>> +})
>> +
>>         /* Create dummy device for devm_kmalloc()-family tests. */
>>         dev = root_device_register(device_name);
>>         if (IS_ERR(dev)) {
>> @@ -568,23 +571,22 @@ static int __init test_overflow_allocation(void)
>>                 return 1;
>>         }
>>
>> -       err |= test_kmalloc(NULL);
>> -       err |= test_kmalloc_node(NULL);
>> -       err |= test_kzalloc(NULL);
>> -       err |= test_kzalloc_node(NULL);
>> -       err |= test_kvmalloc(NULL);
>> -       err |= test_kvmalloc_node(NULL);
>> -       err |= test_kvzalloc(NULL);
>> -       err |= test_kvzalloc_node(NULL);
>> -       err |= test_vmalloc(NULL);
>> -       err |= test_vmalloc_node(NULL);
>> -       err |= test_vzalloc(NULL);
>> -       err |= test_vzalloc_node(NULL);
>> -       err |= test_devm_kmalloc(dev);
>> -       err |= test_devm_kzalloc(dev);
>> +       err |= check_allocation_overflow(kmalloc);
>> +       err |= check_allocation_overflow(kmalloc_node);
>> +       err |= check_allocation_overflow(kzalloc);
>> +       err |= check_allocation_overflow(kzalloc_node);
>> +       err |= check_allocation_overflow(__vmalloc);
>> +       err |= check_allocation_overflow(kvmalloc);
>> +       err |= check_allocation_overflow(kvmalloc_node);
>> +       err |= check_allocation_overflow(kvzalloc);
>> +       err |= check_allocation_overflow(kvzalloc_node);
>> +       err |= check_allocation_overflow(devm_kmalloc);
>> +       err |= check_allocation_overflow(devm_kzalloc);
>>
>>         device_unregister(dev);

I'd prefer if such a local helper macro was defined immediately prior to
the sequence of uses, and then #undef'ed at the end.

Other than that:

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
