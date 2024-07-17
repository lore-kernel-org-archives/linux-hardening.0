Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A53FB83
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jul 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214855; cv=none; b=mySlNXEchCIx6Ll+jtJht+RRwkyDBm1woImY2tnTNDPFYfGbooLLRKUwk47MsmJ1OpPq3emBpXC3/ggQfNVatG4oAVtkn3ll3OgObJ4WIBIWH76VsMu/ZuL+IE166HscNe93CFRpYb91z6xbHzYS7pcaXrecQqHtjvPbnVnN29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214855; c=relaxed/simple;
	bh=sQzUg2Q/1MYsGWnhU/zaTOxAtlBYe1TRtcDNO8bXWyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tap4OtVNZltXfcak9eM7v2sPCyMhaH83VPTkKDRN/Wgs4KoaNZVCfBVQikKHFvXs99Amg/ZAcn2IMQaOTy2PqYxYqkmhBfUC1194fLTulGLZ94FrW0Zo5DJvlgixxhNaXjhtLiDCWQBrMh/jV6XsdNjuKWWEgwUikRkcayOG1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SE3AWkhA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE3AWkhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721214852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAGmeywEZ/JgSZ6hAqPsmz089vwWWyWA+lKvknqNmtE=;
	b=SE3AWkhA+4UZaCJekQMUNxUI9cKBoZAZXU1LGG3dxjhyaSgB06lZJDVczgpoPTNGwYLf1r
	s+8nBGvPnKI2f6rg6xfsnAfOVIYhOEP0yOX4kPdcXT6zDidvGMhkUih5aKUN9cWP2p/UoY
	go16Wgh0r/ACUqZjOL6XvY1btn+ijxM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-ls5q1gLYMNyZdbY_cL5H4w-1; Wed, 17 Jul 2024 07:14:11 -0400
X-MC-Unique: ls5q1gLYMNyZdbY_cL5H4w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36805bfd95aso3551299f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jul 2024 04:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214850; x=1721819650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAGmeywEZ/JgSZ6hAqPsmz089vwWWyWA+lKvknqNmtE=;
        b=qenb2MdK8DqfQZDTwDWA/4Wg4ikaE7IKl1a+YNf9+D+agJ1fq9t/TXlba1Q33lpjm/
         W3h1+7aDc1lV4/QyNOg2axtirSOiDILTJVaBcIZVLxU29aOnLeuYc14Fj8o5hIv+BfVu
         S/axo+IGYLUs6agNe7I0rXxa1jts6qjXjFCQzs0uKNbJTS+KoFkesT3LPnQXIdPfu0I6
         23qrCa6VgItkA01IXywp8dU0F8GLiFNjXtPH6DVmi72XnLxhwBOIFcFT5Bh7nO7pMtVi
         2pOoNnOkkW8UbTTUjcCwDdzh6+iK3IyqACUmB7sri4DWD6vtRWvW3pymSMNXhOi+O2Jr
         UL0g==
X-Forwarded-Encrypted: i=1; AJvYcCXqJhZNjCRgXnWfKDSFbQ3T4W0NNxpUlqkp8NT1EGBB4esyzOZK84beeiYo44tln+zdByy7SG+KHiJrEfjTpJsGlLATx/UvtQRedDUSotw/
X-Gm-Message-State: AOJu0Yz6za5Xudgjo6SHimjt9NXlh2FvxCC+D3njMTnhRx0nH5z0E+7R
	H8z/kux4h/D0HYlNeHrkTO04mOzSSxpXmaGDdrLnow5GeeXABg9HrAM6J43L8k78DGepvyFnniI
	nkbW8LJPpel+Wl96Xv1phtc5So4+U31lwTJyfW7dnJ0XZes2HZ5chNtsxak0aITeoBA==
X-Received: by 2002:a5d:5f8c:0:b0:367:943e:f436 with SMTP id ffacd0b85a97d-36831652b7cmr1395261f8f.30.1721214850130;
        Wed, 17 Jul 2024 04:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkv5VJxD9qI1kB5PB9WhCMM3ozFKBNBC+x5bcWuyaH6WTwCYKMg89QMw7W+wtEnk2KMCsWzg==
X-Received: by 2002:a5d:5f8c:0:b0:367:943e:f436 with SMTP id ffacd0b85a97d-36831652b7cmr1395208f8f.30.1721214849630;
        Wed, 17 Jul 2024 04:14:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbec3sm11450684f8f.85.2024.07.17.04.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:14:09 -0700 (PDT)
Message-ID: <f559a33a-6d2e-476d-87f6-cb1887e99b62@redhat.com>
Date: Wed, 17 Jul 2024 13:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240702122639.248110-1-jfalempe@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/07/2024 14:26, Jocelyn Falempe wrote:
> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> callback.
> This patch adds a new struct kmsg_dump_detail, that will hold the
> reason and description, and pass it to the dump() callback.
> 
> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
> function and a macro for backward compatibility.
> 
> I've written this for drm_panic, but it can be useful for other
> kmsg_dumper.
> It allows to see the panic reason, like "sysrq triggered crash"
> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
> 
> v2:
>   * Use a struct kmsg_dump_detail to hold the reason and description
>     pointer, for more flexibility if we want to add other parameters.
>     (Kees Cook)
>   * Fix powerpc/nvram_64 build, as I didn't update the forward
>     declaration of oops_to_nvram()
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>   arch/powerpc/kernel/nvram_64.c             |  8 ++++----
>   arch/powerpc/platforms/powernv/opal-kmsg.c |  4 ++--
>   arch/um/kernel/kmsg_dump.c                 |  2 +-
>   drivers/gpu/drm/drm_panic.c                |  4 ++--
>   drivers/hv/hv_common.c                     |  4 ++--
>   drivers/mtd/mtdoops.c                      |  2 +-
>   fs/pstore/platform.c                       | 10 +++++-----
>   include/linux/kmsg_dump.h                  | 22 +++++++++++++++++++---
>   kernel/panic.c                             |  2 +-
>   kernel/printk/printk.c                     | 11 ++++++++---
>   10 files changed, 45 insertions(+), 24 deletions(-)
> 

[...]

I pushed it to drm-misc-next, with the whitespace change in kmsg_dump.h

Thanks all for your reviews and comments.

Best regards,

-- 

Jocelyn

