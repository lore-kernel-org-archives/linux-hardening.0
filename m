Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933322318
	for <linux-hardening@vger.kernel.org>; Fri, 12 Jul 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793507; cv=none; b=blpGXhnbEv768EFPilFUITr49+yBSJtfbFoZ1J5Hb4JWQv1nyB0icGWJRQBzFxmI5vZBJOky35po4m8Nkkk7qJrTryF8OvZHVU+c2hmxXuiPZB/V9m9DBcC7tc+iOCxmcrV7FFbJWuhHKtlE7qqy/vxf3Hf/DjILe7v59Ea6lVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793507; c=relaxed/simple;
	bh=VYT4EUbGnMCQC1n9ebq+pDVC9xpjFj7DYFt7QmAktps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GYqtxn3hW6EFgHPi43pM/rjmWbZmtsnN+NQl5mfcXHRAfnRjhJyicGg7SiIeuC4E27SI0gEGcHD7yK/l00rKDj7cteIZqXKH9Nd27jyx7humG33maM7KJHFLHDxASMiW7UKI2Q7UE3uzs6wjEJ3ZTG8D47qPjtyPe10UGid6YXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkQjljxl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkQjljxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720793504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2DwS+N+WpDe9hXUlwXatDaB5K36zULgGVjjk0aits0=;
	b=HkQjljxlILzTzV1aj+mMzoq99YUaImdsbkQj5kio7EJKjoJu1moa6thlhUZw6ARtpFljpm
	K37lKQDd5fQkMQ4p1bUUzeA4RJNz9vVieSGSlgA80oi/UGUzDFuLKQZosvebsgWdYp/VHK
	TAyvSPCBZi/LxcNRpcxUQtAfUgfcLQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-hVZ3xmMEMaCQiCAAtKygOg-1; Fri, 12 Jul 2024 10:11:42 -0400
X-MC-Unique: hVZ3xmMEMaCQiCAAtKygOg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3678e549a1eso1106758f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 12 Jul 2024 07:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793502; x=1721398302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2DwS+N+WpDe9hXUlwXatDaB5K36zULgGVjjk0aits0=;
        b=GSJ8sOynDMzqBaTCMARxgX4H2L6ZttFEgJsD7ocoEj2LxHTftnrT0Zs+EPiC08leHu
         DMlkEJM45my/uQNqBrtKpQxIohcbRw3SH/phhF3rQXN1snI9RrHIuQAr60PSpWU0OAHE
         29IybmCv9bAsf6BOZSJruzS9IvW7bvkzIQlZ1BtN/SeNjnqrq9j4WhVtxlPZClSmDmVV
         ESgWzS7hEek2+Dg+PDoOU1hDbkfb8ueZBLUkBC0LhcRWaPcjn/Q/E8X6YfN/0c+IFn/G
         JHWqeGQFXwIOgdmmxXaIteZDjurtaKT2CdFtnJqDsvfI9N6J+35QnHSq5hESYnyM4dJT
         HsaA==
X-Forwarded-Encrypted: i=1; AJvYcCXpzh6xeVAiZRjCaLVsxknWVqjutPDh86gKor1MupTkIqyYOZXEOZNTre8x0bwSaSgf0qIj+wtBogW4FcRcuo6aYISKEGyY9FF08dC7Eycu
X-Gm-Message-State: AOJu0YyYtAJ0V0gnTF/7SiJa1vEfu+6GSbcnkmzoH2DYPK8l0kbCqHg1
	+pSuFMaridzR+WSp4M62hYalqq59qJFzz8mIvQBFRFoWKqDwy5vSblHeMmEZUkk6hL69CU00z/N
	2gvaYbtcCNs43EzcCcnT4NK9nPjzgP+wnKrdJzBqkEdpAq3dUcZr42llXDAVdeyqkvA==
X-Received: by 2002:adf:f8d2:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36804fec57emr1911315f8f.34.1720793501794;
        Fri, 12 Jul 2024 07:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf3U4d9gFM4veykTOQEiy8D2ryeNYD+ff/pVMiWh3YGrTu6bLAg3UO2081Jf+2o1pI3Alwgw==
X-Received: by 2002:adf:f8d2:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36804fec57emr1911266f8f.34.1720793501451;
        Fri, 12 Jul 2024 07:11:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e187sm10376600f8f.21.2024.07.12.07.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 07:11:40 -0700 (PDT)
Message-ID: <a24ea2d7-9f48-412c-9a40-9624f6c4f9d9@redhat.com>
Date: Fri, 12 Jul 2024 16:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Kees Cook <kees@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <2d886ba5-950b-4dff-81ea-8748d7d67c55@redhat.com>
 <277007E3-48FA-482C-9EE0-FA28F470D6C4@kernel.org>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <277007E3-48FA-482C-9EE0-FA28F470D6C4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/07/2024 15:34, Kees Cook wrote:
> 
> 
> On July 12, 2024 2:59:30 AM PDT, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> Gentle ping, I need reviews from powerpc, usermod linux, mtd, pstore and hyperv, to be able to push it in the drm-misc tree.
> 
> Oops, I thought I'd Acked already!
> 
> Acked-by: Kees Cook <kees@kernel.org>
> 
> And, yeah, as mpe said, you're all good to take this via drm-misc.

Thanks a lot. If there is no objection I will push it to drm-misc mid 
next week. I may have all required acks by then.
> 
> Thanks!
> 
> -Kees
> 
> 

Best regards,

-- 

Jocelyn

