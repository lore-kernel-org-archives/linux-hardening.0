Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCDDC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 18:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiAXS6j (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 13:58:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343561AbiAXS4f (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 13:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643050594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmJVF3D4x24T0ZfBgEiGjVTIdFS2FiU3zC/rm7HZ71k=;
        b=UBsX8t7tAUwtAWb6ENnWdHzp95zO2kLM+hfNK4ZWFiOnLujQOrJonURZyEpEQSgm9+vfmr
        P+nPi2I+9BP4TDcVmyakukTWqGfkavp68cozzxQaR7vo4sKDBZZqF82MgOiAZdKkS9bhKa
        6PhMcL1YGgLY+BsPaJjssqyvGwI1F5k=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-V6PVf8G-MxKiTGx15n9v3g-1; Mon, 24 Jan 2022 13:56:33 -0500
X-MC-Unique: V6PVf8G-MxKiTGx15n9v3g-1
Received: by mail-io1-f69.google.com with SMTP id v190-20020a6bacc7000000b006046d11e61dso12873578ioe.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 10:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OmJVF3D4x24T0ZfBgEiGjVTIdFS2FiU3zC/rm7HZ71k=;
        b=x+aL3wVLfzOKrHSwZp78VaQtx5tbAtjuFJi+9e8I0LjvA3h7cAWmMnT+GkE+Fmk2ky
         vhdh6EKWjftfsuL6ZBnffn+FKnErJTLuhIqwExGkG/YyVI/COeX583Wg2LAh34rdt9RT
         KjI9lP3UQzBiduZdg1392eQG1MuVop+MGwycJfXvxnEhCuMtc5tUyIhTnTundNNN9QXN
         cs9kOQKE8aJx4l0pnXzmFVck8sE9UyRcfKq5RGy+aQd3KNkpVqi1anI5w6CTfQ3x+3BQ
         C5c709nY3mN94p3OT0X1JsKa0JXTHqlH0GOTRfaInFFKTihgiqKkWfIScvyjSg84/tQ9
         0ysA==
X-Gm-Message-State: AOAM532dEg/mPfAMIxaZ1kCjNm2N7nAjVllo0f6RJhQHOrDkv4LQ3A3W
        VR7BHEb6qmY/n4wI5AW8GHAuJrKoTeeVXmU1Cb2hjTYaNKNDLiYn+isjjzM0OhZmVCi5iM7gyGS
        ubHDvvesHi+v7+ttfI2nowFYf3NW/
X-Received: by 2002:a05:6e02:1648:: with SMTP id v8mr9493342ilu.286.1643050592804;
        Mon, 24 Jan 2022 10:56:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUqwnG4LX6ZXdLQROl5ZTg/5K5xkSA6GPAXQwKR1q5FUNoabgTH0XU1cWTt8kmPKmKuywIrQ==
X-Received: by 2002:a05:6e02:1648:: with SMTP id v8mr9493326ilu.286.1643050592493;
        Mon, 24 Jan 2022 10:56:32 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0::2b4c? ([2601:280:4400:a2e0::2b4c])
        by smtp.gmail.com with ESMTPSA id h8sm6822557iow.15.2022.01.24.10.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 10:56:32 -0800 (PST)
Message-ID: <8f457c89-28ed-71d1-5afa-2386abec6da9@redhat.com>
Date:   Mon, 24 Jan 2022 13:56:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] kasan: test: fix compatibility with FORTIFY_SOURCE
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-hardening@vger.kernel.org
References: <20220124160744.1244685-1-elver@google.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20220124160744.1244685-1-elver@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=npache@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 1/24/22 11:07, Marco Elver wrote:
> With CONFIG_FORTIFY_SOURCE enabled, string functions will also perform
> dynamic checks using __builtin_object_size(ptr), which when failed will
> panic the kernel.
> 
> Because the KASAN test deliberately performs out-of-bounds operations,
> the kernel panics with FORITY_SOURCE, for example:
> 
>  | kernel BUG at lib/string_helpers.c:910!
>  | invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>  | CPU: 1 PID: 137 Comm: kunit_try_catch Tainted: G    B             5.16.0-rc3+ #3
>  | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>  | RIP: 0010:fortify_panic+0x19/0x1b
>  | ...
>  | Call Trace:
>  |  <TASK>
>  |  kmalloc_oob_in_memset.cold+0x16/0x16
>  |  ...
> 
> Fix it by also hiding `ptr` from the optimizer, which will ensure that
> __builtin_object_size() does not return a valid size, preventing
> fortified string functions from panicking.
> 
> Reported-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Marco Elver <elver@google.com>

Looks good! Thanks for posting this Marco :)

Reviewed-by: Nico Pache <npache@redhat.com>

> ---
>  lib/test_kasan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 847cdbefab46..26a5c9007653 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -492,6 +492,7 @@ static void kmalloc_oob_in_memset(struct kunit *test)
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
> +	OPTIMIZER_HIDE_VAR(ptr);
>  	OPTIMIZER_HIDE_VAR(size);
>  	KUNIT_EXPECT_KASAN_FAIL(test,
>  				memset(ptr, 0, size + KASAN_GRANULE_SIZE));
> @@ -515,6 +516,7 @@ static void kmalloc_memmove_negative_size(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
>  	memset((char *)ptr, 0, 64);
> +	OPTIMIZER_HIDE_VAR(ptr);
>  	OPTIMIZER_HIDE_VAR(invalid_size);
>  	KUNIT_EXPECT_KASAN_FAIL(test,
>  		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
> @@ -531,6 +533,7 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
>  	memset((char *)ptr, 0, 64);
> +	OPTIMIZER_HIDE_VAR(ptr);
>  	KUNIT_EXPECT_KASAN_FAIL(test,
>  		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
>  	kfree(ptr);
> @@ -893,6 +896,7 @@ static void kasan_memchr(struct kunit *test)
>  	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
> +	OPTIMIZER_HIDE_VAR(ptr);
>  	OPTIMIZER_HIDE_VAR(size);
>  	KUNIT_EXPECT_KASAN_FAIL(test,
>  		kasan_ptr_result = memchr(ptr, '1', size + 1));
> @@ -919,6 +923,7 @@ static void kasan_memcmp(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  	memset(arr, 0, sizeof(arr));
>  
> +	OPTIMIZER_HIDE_VAR(ptr);
>  	OPTIMIZER_HIDE_VAR(size);
>  	KUNIT_EXPECT_KASAN_FAIL(test,
>  		kasan_int_result = memcmp(ptr, arr, size+1));
> 

