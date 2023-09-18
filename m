Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B62CD13D2
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 00:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjIRA0d (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Sep 2023 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjIRA02 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Sep 2023 20:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0594211C
        for <linux-hardening@vger.kernel.org>; Sun, 17 Sep 2023 17:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694996740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJdGHYJg1hgtR/OBv+kksXjfIjKSJaQgEUNRz4rnSZ4=;
        b=dekIwHSllSuiLfRyNhEbGI0Ak0bXwaqWGZFev4iuqF19SZhDvVoprCiTcFSXayEE69IPLs
        ie1nG2s1YZINWclNZLVnjQJt4CF3Sobfvo3bRFecu89xZD8A0GQ33neFfRVh9TrTh7wRto
        yWef4Ay1k1+wDkm0HRcY9JG5qB5VQks=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-JUlNrg1vMuiW_mrHvDRBBQ-1; Sun, 17 Sep 2023 20:25:38 -0400
X-MC-Unique: JUlNrg1vMuiW_mrHvDRBBQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2748ef8b3c7so1928269a91.1
        for <linux-hardening@vger.kernel.org>; Sun, 17 Sep 2023 17:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694996737; x=1695601537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJdGHYJg1hgtR/OBv+kksXjfIjKSJaQgEUNRz4rnSZ4=;
        b=RuqBNf4YwyMJvf631rOuDT6UF5MOuYp36y4XGzQVKR7zh2UrxGNIH3/I/ySc4xFbZF
         buGC9HWeCeRwTLh/QNPaX6EitwzGcmuk5GI8g9/HFb6vek/uRj2W2Hbp4OVgkYljO+cL
         XojjfK29k+svX1ULXFbF9idPMeboGmUFx7cIpMYMyiHTKia6H+iEtgCiIGYdIvQ5cBQm
         I4Pl8+if57P1kvfiyezBPE7SMtxzbvP46koEEHUvrL/fQteP87xmFV4OsIpRAIxt5t+M
         CqPAiESx4bdHuhZ/brt5f7W9rlZx/kod4aVD0/JKMZVPwqkqxVaBWNSEzMYHKyjFr/x/
         1hSw==
X-Gm-Message-State: AOJu0YwZg0Z+bFmboaeRBi58ZVj3UcEsNU3hEPtn2HU0r0PtD8QT1uKt
        aqbwJUZhxW3+WhRehlZ6dnX/PdMFc9/p0JS9mG5+f53d5/zn3rdfv75N+wMIdZKjujT5HmU2mai
        AKDiuTpPMExT7hc6ajaoB4ZVdBY9V
X-Received: by 2002:a17:90a:fd0f:b0:26d:2b42:cdae with SMTP id cv15-20020a17090afd0f00b0026d2b42cdaemr5172614pjb.3.1694996737001;
        Sun, 17 Sep 2023 17:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLXF0oBCb3Jg8l98K1Q8D+w9gzQ6POlmU6bqJG7rj6YyYltCayunR+jeerTVRAYQhzNW9o9g==
X-Received: by 2002:a17:90a:fd0f:b0:26d:2b42:cdae with SMTP id cv15-20020a17090afd0f00b0026d2b42cdaemr5172602pjb.3.1694996736663;
        Sun, 17 Sep 2023 17:25:36 -0700 (PDT)
Received: from [10.72.113.158] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090a178800b0026f39c90111sm6713718pja.20.2023.09.17.17.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 17:25:35 -0700 (PDT)
Message-ID: <246eda77-09c9-ae8a-996a-44d69fca84a4@redhat.com>
Date:   Mon, 18 Sep 2023 08:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: Annotate struct ceph_osd_request with __counted_by
To:     Kees Cook <keescook@chromium.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201517.never.373-kees@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230915201517.never.373-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On 9/16/23 04:15, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct ceph_osd_request.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: ceph-devel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/ceph/osd_client.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index bf9823956758..b8610e9d2471 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -278,7 +278,7 @@ struct ceph_osd_request {
>   	int r_attempts;
>   	u32 r_map_dne_bound;
>   
> -	struct ceph_osd_req_op r_ops[];
> +	struct ceph_osd_req_op r_ops[] __counted_by(r_num_ops);
>   };
>   
>   struct ceph_request_redirect {

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thanks!

- Xiubo


