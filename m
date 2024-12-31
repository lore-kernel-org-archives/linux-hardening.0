Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AEC502BE
	for <linux-hardening@vger.kernel.org>; Tue, 31 Dec 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735657665; cv=none; b=fM3P4xyyK+0CNTnn/Obw5q+N9ZYxsUIiNeRVTLSnvSEzGezjrpCfQ3G4w+19aexxA+0I3CLsh/zTaCM7zdToELGpGTy/Zgf1kShYG3f/HxcO93padba0detx0mRtesyKRjWlOw4n/yYT46291MN7CKQ57zuP+5iEs+7OBEV5wZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735657665; c=relaxed/simple;
	bh=7T4DV0auzHCqWowukXCz6tn0seEM3YlHEBwNUYhro+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJFQFuodOkNAFGsWecHS4clDeSpo+BHQu9lUPCHfCog7bhk12p0RqI4pU5ToaeHQGnjH4NiOD5D+P97rHqbKhCqVWCz/XxdkkEDnp4+hdY9J0u0LlzdLFKTMbjC75itu6WGhkqvDTtcZ+dBHcxUL6HndpLwce7tA4Be6qXjBjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M62PwmXM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M62PwmXM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385eed29d17so4884371f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Dec 2024 07:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735657662; x=1736262462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGH6gwG5Xb5ESfXY/MA29Qmw2CKnxkBUQBkmVQ01IGI=;
        b=M62PwmXM48WyY6v7i4+AhAIm1tYKmtc/hIiMM7QwAzv+lQdYa8fOiPeD/7A61gNuv9
         r59dXfZ8914XBQhIYNrpAFESwHQ+/Za+cwdx9VSRDEdzmR66bccyGoDvXQPioc0RIedM
         h6uyFx+lAo7JaAFxTPSOrvgcR2IdYub53VWNFNaaoEokeTAS0eOoXSFXofl1xoyUZylY
         eQp5tOfUb+gjoYad5XizlAmB53wRpp7ezIWEDuSld1Tzk9qnXDv8olGL7BjFFThubJTs
         xJm7c1xKDhJlf12J+pk81jr6rJZAvpRIynwWbxC55Z7YWXK4rFlpsR481SGSM3Mz+JV4
         Pldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735657662; x=1736262462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGH6gwG5Xb5ESfXY/MA29Qmw2CKnxkBUQBkmVQ01IGI=;
        b=p1xE1KbFFbMOX5Tl7aUmB1bXxbZWXDSHcx1gxAIQBpYoniZxKewinK0SLFChQL5Lfq
         YKgRb4F5loJcySU+BddpjTFIUiu7L36rwKDAruQlT+1Qg4hnABu3qHMlQPPaQhRpLFNN
         fqPP4qE7Kj2BaGPA75RfdyxzFJQWaGSg9oZdL0pUs0LG+l2ajIzslxe/mc1AvhfulXiW
         sKoP0XlJMW5Ia7KiyIIiDc8fztqgLH4v0lMtSgJ1Zq9eDRGdGtNjepXWu3Xnxo4eqvbD
         ZLxOkrzVxuh6VkniEJljHJ0lC+0upZYZQrYjWfP5vd0BelWRDPsdLS62i3jrjBzDq6/c
         rvSg==
X-Forwarded-Encrypted: i=1; AJvYcCX3urBBEsZENO3B+h35utGuYSod2YBg/H/QT3+bba/VjXafa9jgG8nHYB4TrSngu4L+HSLBGVqqa7Hbds1H0pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSq0szQRfJfJIg55s1ehiGx9Wy5U+4Oy75Z9wExuJ8u/ThLj3k
	HDRy/2s7GesjYIjI3Qhbd3Rguz/RDgIopCmvfOHlyNuUA51q0PBacz06/RJ95AQ=
X-Gm-Gg: ASbGnct9ufkpCdBSStLg2rUv5Ev/sS2VYBy7X5LnPlHStNcT3qp1xLhhVHhdkn9xGzF
	p+w26EJ1Q6yVvIM3bCBePEmhXU4jUeelVNhip+OZeAbHEE0PaiRSl26gbWs+bbqkD1ZUrSRjLBX
	DqRbgBEJPyQzGvHsdJeErThUwpeF4/Q9JzNSLWKY8UE8YlqJ8zHmbdqT43SY3IYU6tzey6UZC/V
	xwDltZk7M2eq48a2rf14cRWMpl36D4prcSAW+o8ngkg8PUGNGB8YnMSxN7q
X-Google-Smtp-Source: AGHT+IEQX7+jmDBfEFlPjoa5E+KUjabDz97fq64ACPOl/s0+xNhI+LwPww6Bq08B/1q6pymIBBKlkw==
X-Received: by 2002:a5d:5f8b:0:b0:385:fc70:826 with SMTP id ffacd0b85a97d-38a223fd808mr30893285f8f.52.1735657661777;
        Tue, 31 Dec 2024 07:07:41 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6abesm33021317f8f.90.2024.12.31.07.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 07:07:41 -0800 (PST)
Message-ID: <6f2d2843-e676-4d4a-86aa-881378b1adf1@suse.com>
Date: Tue, 31 Dec 2024 16:07:40 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] module: sysfs: Cleanups and preparation for const
 struct bin_attribute
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/27/24 14:23, Thomas Weißschuh wrote:
> The sysfs core is switching to 'const struct bin_attribute's.
> Prepare for that.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Avoid NULL-deref in free_sect_attrs()
> - Avoid double-free and NULL-deref in free_notes_attrs()
> - Also drop 'struct module_sect_attr'
> - Link to v1: https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-module-v1-0-f81e49e54ce4@weissschuh.net
> 
> ---
> Thomas Weißschuh (6):
>       module: sysfs: Drop member 'module_sect_attrs::nsections'
>       module: sysfs: Drop member 'module_sect_attr::address'
>       module: sysfs: Drop 'struct module_sect_attr'
>       module: sysfs: Simplify section attribute allocation
>       module: sysfs: Add notes attributes through attribute_group
>       module: sysfs: Use const 'struct bin_attribute'
> 
>  kernel/module/sysfs.c | 116 ++++++++++++++++++++++++--------------------------
>  1 file changed, 55 insertions(+), 61 deletions(-)
> ---
> base-commit: d6ef8b40d075c425f548002d2f35ae3f06e9cf96
> change-id: 20241215-sysfs-const-bin_attr-module-be05346937a6

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I'm going to wait for a few days if others want to comment and then plan
to queue this on the modules tree for the 6.14 merge window.

-- 
Thanks,
Petr
