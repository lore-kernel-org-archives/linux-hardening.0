Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563C0CD37B4
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 00:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjIRA0c (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Sep 2023 20:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjIRA0M (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Sep 2023 20:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D15011D
        for <linux-hardening@vger.kernel.org>; Sun, 17 Sep 2023 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694996719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XGw7AdgYIk+RoEKFj7VSzvf+HqUpChJVq9bKRl2ets=;
        b=TkntXe/5AJ6EcuDQjCYYViIbwcnK/MBFNMSSdiCVWUc+bbkdlekPwWfuveoaScnDg8LMvr
        VUdigkqby0j95ULeF2Fg+FM4WXsGCG/Kbcv1X0wRcXVT4p2ogpaDVqQbArce8poBZ00rMN
        a2z0nyLq2EVfWfImwJKVPaIrUfS4NAI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-W7QPni6WNjaOg8EeOpoxwQ-1; Sun, 17 Sep 2023 20:25:17 -0400
X-MC-Unique: W7QPni6WNjaOg8EeOpoxwQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-780addd7382so376973639f.1
        for <linux-hardening@vger.kernel.org>; Sun, 17 Sep 2023 17:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694996717; x=1695601517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XGw7AdgYIk+RoEKFj7VSzvf+HqUpChJVq9bKRl2ets=;
        b=mhLitkqb13n0JAGC0570jqLA+1rpCZuU4MYujjajhcwkG0rJHEmkQnl/hjz+A2wr2o
         CW+Rjt8Dvr4jeScmFgLrNXfMQnFbe/U8PR//KQyyRE9g35V5oqL+g1Q3tW9UFUANNuHo
         /jB/WN5c5pAe2nh1QtnOrgWg++RFzK+yT9SSUPSbtKX0JuJi9qbLQWu20g1YJC5bvbRJ
         Trjl2m6jcgYhToUZQQV0nbNoHUYonqW905396V7xN6QQLySdeC6wBWRnVRF3Ecozg3vc
         FhzEJMtM4hNmxUgmQ+kZnyEMCexZYvCHC2fJRwM8gJmIcwwOaGP3Ofqo3EXBYZ/VrRwr
         FIWw==
X-Gm-Message-State: AOJu0YxBY/EgcVtB0w8VFX08n+fSHUdlZsVDnueJ8l3v0V+10SEsfcex
        KAGJ8pmfWICxzh75F4rz2ilXnRXDmFnKOrA9rMxvtmaitVNCcPBkeal8qoM81H+Kml7OAzgQjt6
        aLMvm3Ivt/Tgbwmx9liBOBZZz507a
X-Received: by 2002:a92:c243:0:b0:34f:f373:ad7e with SMTP id k3-20020a92c243000000b0034ff373ad7emr465810ilo.1.1694996716966;
        Sun, 17 Sep 2023 17:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgUb4xgzcsF6D3DA7oMGkWPNDOVIlzmfnSfqk/GsC4gkgPnWHPQRcOFDq8+Xz2fcLmLDPI0A==
X-Received: by 2002:a92:c243:0:b0:34f:f373:ad7e with SMTP id k3-20020a92c243000000b0034ff373ad7emr465795ilo.1.1694996716745;
        Sun, 17 Sep 2023 17:25:16 -0700 (PDT)
Received: from [10.72.113.158] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m23-20020a635817000000b0056606274e54sm4393724pgb.31.2023.09.17.17.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 17:25:16 -0700 (PDT)
Message-ID: <3c4c7ca8-e1a2-fbb1-bda4-b7000eb9a8d9@redhat.com>
Date:   Mon, 18 Sep 2023 08:25:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
To:     Kees Cook <keescook@chromium.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201510.never.365-kees@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230915201510.never.365-kees@kernel.org>
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
> As found with Coccinelle[1], add __counted_by for struct ceph_monmap.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/ceph/mon_client.h | 2 +-
>   net/ceph/mon_client.c           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
> index b658961156a0..7a9a40163c0f 100644
> --- a/include/linux/ceph/mon_client.h
> +++ b/include/linux/ceph/mon_client.h
> @@ -19,7 +19,7 @@ struct ceph_monmap {
>   	struct ceph_fsid fsid;
>   	u32 epoch;
>   	u32 num_mon;
> -	struct ceph_entity_inst mon_inst[];
> +	struct ceph_entity_inst mon_inst[] __counted_by(num_mon);
>   };
>   
>   struct ceph_mon_client;
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index faabad6603db..f263f7e91a21 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -1136,6 +1136,7 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
>   			       GFP_KERNEL);
>   	if (!monc->monmap)
>   		return -ENOMEM;
> +	monc->monmap->num_mon = num_mon;
>   
>   	for (i = 0; i < num_mon; i++) {
>   		struct ceph_entity_inst *inst = &monc->monmap->mon_inst[i];
> @@ -1147,7 +1148,6 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
>   		inst->name.type = CEPH_ENTITY_TYPE_MON;
>   		inst->name.num = cpu_to_le64(i);
>   	}
> -	monc->monmap->num_mon = num_mon;

BTW, is this change related ?

>   	return 0;
>   }
>   

Else LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Thanks!

- Xiubo


