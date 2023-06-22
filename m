Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24144EB64DD
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 20:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFVUKF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Jun 2023 16:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjFVUKD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Jun 2023 16:10:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048812117
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 13:10:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6687446eaccso4397130b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687464601; x=1690056601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYBy4agZ+KdBreGb8i62JIVz4X9MAhRX6m8qzaJt3g8=;
        b=JdPrcgZ11nmSN5JnRqhTwTXM+Uegw7fEE8Vnd1cnBhMjln2MO7/ucKgZNYmtqB6VuG
         IHDXlyR3rIOCsosRfk3Fo71wbaJoMLkRVVfiGqans3ywNGb0w8jlRzAQ8Hfr3mJsth62
         /va8tsLMaXh8HYfF5kSxCEL4j0rsBtcMjIjNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687464601; x=1690056601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYBy4agZ+KdBreGb8i62JIVz4X9MAhRX6m8qzaJt3g8=;
        b=iBCVP+ErEnwGcfr1ReNpnPDZ6xxtXm/M4j5B8XEWUVyRuV6v8M8p6Il7I9ZeDrcqEb
         JZ0+L8Fm6CjfI0CsaE+ezhfNdltBtW9v2KAprk0EVS+FLmdFiJkQvOJQPIL4nrwbJViY
         8TwScEusOG+BwWyCKpT5BCVyN31dACsS/vLCQuiLUFoNJc9LMbNEzvYoVSZenB5bTHkE
         f1/3/gwHFdheyoFO9WziHGEpZ3ZX3qAcgXpWbhYTsWXRNswYrkI2uZ0X7lcGcCydEQJy
         iNrsgOlUMSdJuv7lCFe1uP6QR0dEEmFOqBqk1ANS4HcvUew6P6bPZzob4Z1McjV3VxWf
         SEiQ==
X-Gm-Message-State: AC+VfDznrgBBkAsoW3PWwDXCIZWE6aLtKckNTbuZvTu/uQEFrNue3p+g
        6a5dPBCtG1Yt1W3/PXoeIKRwkA==
X-Google-Smtp-Source: ACHHUZ4deznPRyCjw65rMtFd2vJ0q9EXRx0bzgQnun51Vs0tYnAUm/sSZkCDNisNN1TouaeAcNNmIQ==
X-Received: by 2002:a05:6a00:15ca:b0:66a:4fc7:ad04 with SMTP id o10-20020a056a0015ca00b0066a4fc7ad04mr5348470pfu.14.1687464601182;
        Thu, 22 Jun 2023 13:10:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s17-20020aa78d51000000b0065440a07294sm5011181pfe.95.2023.06.22.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:10:00 -0700 (PDT)
Date:   Thu, 22 Jun 2023 13:10:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Jann Horn <jannh@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: Re: [PATCH v3 1/1] Randomized slab caches for kmalloc()
Message-ID: <202306221307.6CF63BAC20@keescook>
References: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
 <20230616111843.3677378-2-gongruiqi@huaweicloud.com>
 <3fdc76f0-6c45-c405-0024-d1d69b5bf068@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fdc76f0-6c45-c405-0024-d1d69b5bf068@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 22, 2023 at 03:56:04PM +0200, Vlastimil Babka wrote:
> On 6/16/23 13:18, GONG, Ruiqi wrote:
> > index a3c95338cd3a..6150e9a946a7 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -337,6 +337,55 @@ config SLUB_CPU_PARTIAL
> >  	  which requires the taking of locks that may cause latency spikes.
> >  	  Typically one would choose no for a realtime system.
> >  
> > +config RANDOM_KMALLOC_CACHES
> > +	default n
> > +	depends on SLUB
> > +	bool "Random slab caches for normal kmalloc"
> > +	help
> > +	  A hardening feature that creates multiple copies of slab caches for
> > +	  normal kmalloc allocation and makes kmalloc randomly pick one based
> > +	  on code address, which makes the attackers unable to spray vulnerable
> > +	  memory objects on the heap for exploiting memory vulnerabilities.
> > +
> > +choice
> > +	prompt "Number of random slab caches copies"
> > +	depends on RANDOM_KMALLOC_CACHES
> > +	default RANDOM_KMALLOC_CACHES_16
> > +	help
> > +	  The number of copies of random slab caches. Bigger value makes the
> > +	  potentially vulnerable memory object less likely to collide with
> > +	  objects allocated from other subsystems or modules.
> 
> When I read this, without further knowledge, why would I select anything
> else than the largest value? It should mention memory overhead maybe?

Yeah, good idea.

> Also would anyone really select only "2" and thus limit the collision
> probability to 50% and not less? "4" also seems quite low for the given
> purpose? Could we just pick and hardcode 8 or 16 and avoid the selection, at
> least until there's some more experience with the whole approach?

I assume it was for doing performance (speed or space) analysis for
people interested in tuning it. The default is 16, which is what most
folks will end up with. i.e. I'm not sure I see a benefit to dropping 2
and 4, since I imagine people will either want the highest value (16),
or the ability to do a full comparison of each setting.

Regardless, I would be fine if we dropped 2 and 4, since I am focused on
the maximum number (16) of hash buckets. :)

-Kees

-- 
Kees Cook
