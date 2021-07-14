Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE15C07E9A
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jul 2021 07:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603F061360
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jul 2021 07:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhGNH6g (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jul 2021 03:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238287AbhGNH6g (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jul 2021 03:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626249345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKNSjjM802KvMrx63TD9dldCquu7NoZNgxi8GRD2Gak=;
        b=iZUYG61U9HVDEaZJNBsUI2QHZK5k85nSLoU0JSCJSzmdSQ+i7QhTBsLQk1/t62HwdPp6gP
        gos/NayR5pKaQUjE8oLstTM0uep5H97qdCoJImYXwn9U+Iz7apWzP3Njv5n0Nh5/1aR056
        f9uu5KMcVD5+sFNP+kwrzZiqEdHsjX8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-3bvj2Ym4PiuOhcg5ppt2zQ-1; Wed, 14 Jul 2021 03:55:44 -0400
X-MC-Unique: 3bvj2Ym4PiuOhcg5ppt2zQ-1
Received: by mail-wm1-f72.google.com with SMTP id f16-20020a1c6a100000b0290210c73f067aso202200wmc.6
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jul 2021 00:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KKNSjjM802KvMrx63TD9dldCquu7NoZNgxi8GRD2Gak=;
        b=IzfZeJ4ShWIJXV5JIarKqcxVBGY1CODt/1yB+ZDyHcIp3QPCXQlvcB1pdCwHihrITW
         3Cw3DOcm4JYb8/7yAeIps6Cz90KBUwh9GA1eSaBPFpGGNhlM6Qwx19HyOPDrkdbwEAm/
         SM1+uSZuCBSgya2gYqm930dbyM+rb3K/TMsG6KRYEA7/CmRuJOP5k3KOKufWrkvZwydn
         Wyjifk0ARhV9Ku0OyTN2GOHoLcNM6gZyadiMVmPf3C044tYFhe3visg11JPFzBLif9ct
         NlkHE8Oif19+cO/H70VLiVgRduOheDmB8fvriQswdi+BHat7nhmKYtTS1d4gFnZil2ff
         UiDA==
X-Gm-Message-State: AOAM531N6jtK1/ztkDs/2IZ12YsTyy+/xgBGFssSPbe2iBf+yhOrk8j+
        9T6fqCfogSm1IV5GV9GE0wT1lO6akxwqC4GkRuK57ie8Cw9tKF4eFzDQ/8pm9k+ho0OW8YP4QRQ
        Gy94C2lKBKlAH39bdq7ArPWYcoslQ6BLnS4ofeUy+SlWMjmZFftkNVaUUG28sE/0V9rPF1RnCZs
        QX
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr2572671wmm.95.1626249342866;
        Wed, 14 Jul 2021 00:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPC0tGdcUFvZnpstDfAQ01JyPVMlLbBqvaeL7rYzx6wNBKXZDSnZOOsdONWObmqxHxUedaVw==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr2572632wmm.95.1626249342518;
        Wed, 14 Jul 2021 00:55:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60d5.dip0.t-ipconnect.de. [91.12.96.213])
        by smtp.gmail.com with ESMTPSA id o7sm1785450wrv.72.2021.07.14.00.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 00:55:42 -0700 (PDT)
Subject: Re: [PATCH v2] mm: page_alloc: Fix page_poison=1 /
 INIT_ON_ALLOC_DEFAULT_ON interaction
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        bowsingbetee@pm.me, Mikhail Morfikov <mmorfikov@gmail.com>,
        stable@vger.kernelo.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210714031935.4094114-1-keescook@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3c3868ea-7dc6-6b00-83a8-d8ed131ff6e6@redhat.com>
Date:   Wed, 14 Jul 2021 09:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714031935.4094114-1-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 14.07.21 05:19, Kees Cook wrote:
> From: Sergei Trofimovich <slyfox@gentoo.org>
> 
> To reproduce the failure we need the following system:
>    - kernel command: page_poison=1 init_on_free=0 init_on_alloc=0
>    - kernel config:
>      * CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
>      * CONFIG_INIT_ON_FREE_DEFAULT_ON=y
>      * CONFIG_PAGE_POISONING=y
> 
>      0000000085629bdd: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      0000000022861832: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00000000c597f5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      CPU: 11 PID: 15195 Comm: bash Kdump: loaded Tainted: G     U     O      5.13.1-gentoo-x86_64 #1
>      Hardware name: System manufacturer System Product Name/PRIME Z370-A, BIOS 2801 01/13/2021
>      Call Trace:
>       dump_stack+0x64/0x7c
>       __kernel_unpoison_pages.cold+0x48/0x84
>       post_alloc_hook+0x60/0xa0
>       get_page_from_freelist+0xdb8/0x1000
>       __alloc_pages+0x163/0x2b0
>       __get_free_pages+0xc/0x30
>       pgd_alloc+0x2e/0x1a0
>       ? dup_mm+0x37/0x4f0
>       mm_init+0x185/0x270
>       dup_mm+0x6b/0x4f0
>       ? __lock_task_sighand+0x35/0x70
>       copy_process+0x190d/0x1b10
>       kernel_clone+0xba/0x3b0
>       __do_sys_clone+0x8f/0xb0
>       do_syscall_64+0x68/0x80
>       ? do_syscall_64+0x11/0x80
>       entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Before the 51cba1eb ("init_on_alloc: Optimize static branches")
> init_on_alloc never enabled static branch by default. It could
> only be enabed explicitly by init_mem_debugging_and_hardening().
> 
> But after the 51cba1eb static branch could already be enabled
> by default. There was no code to ever disable it. That caused
> page_poison=1 / init_on_free=1 conflict.
> 
> This change extends init_mem_debugging_and_hardening() to also
> disable static branch disabling.
> 
> CC: Alexander Potapenko <glider@google.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: linux-mm@kvack.org
> Reported-by: bowsingbetee@pm.me
> Reported-by: Mikhail Morfikov <mmorfikov@gmail.com>
> Fixes: 51cba1ebc60d ("init_on_alloc: Optimize static branches")
> Cc: stable@vger.kernelo.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> Link: https://lore.kernel.org/r/20210712215816.1512739-1-slyfox@gentoo.org
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   mm/page_alloc.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3b97e17806be..1f19365bc158 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -840,21 +840,24 @@ void init_mem_debugging_and_hardening(void)
>   	}
>   #endif
>   
> -	if (_init_on_alloc_enabled_early) {
> -		if (page_poisoning_requested)
> -			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> -				"will take precedence over init_on_alloc\n");
> -		else
> -			static_branch_enable(&init_on_alloc);
> -	}
> -	if (_init_on_free_enabled_early) {
> -		if (page_poisoning_requested)
> -			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> -				"will take precedence over init_on_free\n");
> -		else
> -			static_branch_enable(&init_on_free);
> +	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
> +	    page_poisoning_requested) {
> +		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> +			"will take precedence over init_on_alloc and init_on_free\n");
> +		_init_on_alloc_enabled_early = false;
> +		_init_on_free_enabled_early = false;
>   	}
>   
> +	if (_init_on_alloc_enabled_early)
> +		static_branch_enable(&init_on_alloc);
> +	else
> +		static_branch_disable(&init_on_alloc);
> +
> +	if (_init_on_free_enabled_early)
> +		static_branch_enable(&init_on_free);
> +	else
> +		static_branch_disable(&init_on_free);
> +
>   #ifdef CONFIG_DEBUG_PAGEALLOC
>   	if (!debug_pagealloc_enabled())
>   		return;
> 

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

