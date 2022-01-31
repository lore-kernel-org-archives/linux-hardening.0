Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F93C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 14:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiAaO2l (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 09:28:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235914AbiAaO2l (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 09:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643639321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qW2Coi1Uic7Qf1tqHd53E/M9HXyj1fUW7arE1jMIDv8=;
        b=FkfeEjoM8sWeiVMwftWJ+bwHtya6iyRoiwzYsgrTEZcb6bT1YZUUCgSBqRhwmt9qeB2dQA
        AwE/YwQ+WlLLG2QflCpZ3aYBoWRntdAOpwJTrK8rdNUiu1dMcaQbSZeoiye8iiOXJWiUnC
        x2dV1hWjNbZ2oXfz7JkbsIZGigJtwRg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-sVDZhoGHOp-dLJkyfzIcWA-1; Mon, 31 Jan 2022 09:28:39 -0500
X-MC-Unique: sVDZhoGHOp-dLJkyfzIcWA-1
Received: by mail-wm1-f69.google.com with SMTP id bg23-20020a05600c3c9700b0034bb19dfdc0so3011217wmb.1
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 06:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qW2Coi1Uic7Qf1tqHd53E/M9HXyj1fUW7arE1jMIDv8=;
        b=kUmB5od07/gbAx/xGGMUgKpZWyBkOkv0laVC5iUNxnjUf0ORVul3S/yeIoGFalwhic
         3PfrATMXddOSgS3bhDmWqZ1nMNF/OiJUNpaIohai+EB264v5LDnWRncHoA2dUCxKT7Yl
         IdWWb/F0sc7EnLoP+BSp6nMU8CaMFYQVyiQOAY70eO+Csmzbb60/5eBQ1nYZOIe7Tfak
         8JeWfQUAyfFeNGPbOLZFRbwn97lMRsR98YMFJZgAqBfpPBqDagHFxkN27K8p47ImO6nW
         fe4rCsWGs4gLto+u/2irXW5KP8ZZgqP7KPW2FuUbKOHVsGgCBWqOBtsmajQiNvVw6MyX
         WaLQ==
X-Gm-Message-State: AOAM530ApRevR0VSV75F6u/KHywbjxHtvIInaW7bNDN1qvD3nd701p/t
        zBh/d/4368quTfJLv2ONeW1wwih47TeFeagFeQlGOUzOwain7LO9Jyp+OorlieCu/gOPAGDScQp
        rN+AjoYiIZLmBa43Qx9v6Rz8Rh5qQ
X-Received: by 2002:a05:6000:144e:: with SMTP id v14mr1968554wrx.603.1643639318425;
        Mon, 31 Jan 2022 06:28:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6by6jWPbqgxRgrFVc2mX9xcBPy8jCx9c0K1SgFy72aSEt4hc/jWE2FpAvxwNgkFSjExNHag==
X-Received: by 2002:a05:6000:144e:: with SMTP id v14mr1968541wrx.603.1643639318232;
        Mon, 31 Jan 2022 06:28:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id f6sm12074802wrj.26.2022.01.31.06.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:28:37 -0800 (PST)
Message-ID: <f36cdc92-c52a-664e-dad9-fccfa5c187d5@redhat.com>
Date:   Mon, 31 Jan 2022 15:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] mm/usercopy: Detect large folio overruns
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20220110231530.665970-1-willy@infradead.org>
 <20220110231530.665970-4-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220110231530.665970-4-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11.01.22 00:15, Matthew Wilcox (Oracle) wrote:
> Move the compound page overrun detection out of
> CONFIG_HARDENED_USERCOPY_PAGESPAN and convert it to use folios so it's
> enabled for more people.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/usercopy.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index dcf71b7e3098..e1cb98087a05 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -164,7 +164,6 @@ static inline void check_page_span(const void *ptr, unsigned long n,
>  {
>  #ifdef CONFIG_HARDENED_USERCOPY_PAGESPAN
>  	const void *end = ptr + n - 1;
> -	struct page *endpage;
>  	bool is_reserved, is_cma;
>  
>  	/*
> @@ -195,11 +194,6 @@ static inline void check_page_span(const void *ptr, unsigned long n,
>  		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
>  		return;
>  
> -	/* Allow if fully inside the same compound (__GFP_COMP) page. */
> -	endpage = virt_to_head_page(end);
> -	if (likely(endpage == page))
> -		return;
> -
>  	/*
>  	 * Reject if range is entirely either Reserved (i.e. special or
>  	 * device memory), or CMA. Otherwise, reject since the object spans
> @@ -259,6 +253,10 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  	if (folio_test_slab(folio)) {
>  		/* Check slab allocator for flags and size. */
>  		__check_heap_object(ptr, n, folio_slab(folio), to_user);
> +	} else if (folio_test_large(folio)) {
> +		unsigned long offset = ptr - folio_address(folio);

Nit: I'd have added an empty line.

> +		if (offset + n > folio_size(folio))
> +			usercopy_abort("page alloc", NULL, to_user, offset, n);
>  	} else {
>  		/* Verify object does not incorrectly span multiple pages. */
>  		check_page_span(ptr, n, folio_page(folio, 0), to_user);

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

