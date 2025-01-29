Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C81194C6A
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135773; cv=none; b=GEq6J/DdhvMLMCyZWdCAPbaCXVjmZATwOwsVzpiplCm1i9oFZcdaupg0LaOVhlz2xLjd1R9VRu5sV60iJOdKIs6OBgW0nhn9rR254vE3Y61WXPwkkbjunpNJKqLez0apCP8ncQuTCjGiAQYxh65MmVFui/6u4x1m28Hnz5fptUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135773; c=relaxed/simple;
	bh=YCmQYRx23E9bhRSaEYPx2MwQwDJZxOxUzDk2iwuxtRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhzR+QL9H5xcAVYQO+Og1QCYrN+I0JTzEsb7P0tLsACVrVOsoR8AsUYnQ/mnDv01dKQp8R8oR9L+rSRHV9PvPb8Bq7+k27SvSOq9g6UTXz42ztGyNI44KDvB2SJ4J3YKZzugrrpo6gZH2pbrv9TVFEz77x77WO8nPoQ7aisTARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uX6ApJRh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uX6ApJRh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a8b35e168so212054f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jan 2025 23:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738135770; x=1738740570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKO1XdKTTtgBmHcMQL9CkfWcD96N1XKs+6t6kU2T7u0=;
        b=uX6ApJRhLZ0JUs6wG2DvPKVdfnP70UdJLgJ+I34pyJsl5LXMVYISmNpKj8C6R/daeo
         By/y1n5Vtqewpxv9wPApAtyHaYWpuMvZ7/0PoD/V5xj65/KZjsW38BEnqlNqBkQ/ntU8
         UqgBusJMAJMNRzvJISvuQVQfPoo442pGDp4/ZC0HWnCy48ur8DftxOMQ2dvIwi5FrEtq
         Jt38gwXs5fE2zoqew74gxa9vdtnc//aLukptNa/WX0DUtV/c/ydmUrN7Pfe7fgzvixeK
         uGtknlTwkt9sHxVSgjPubEJ/WlRtRrdQsQdSyrahKFGTSqUh03AprhfwwFuMOH0WZzhV
         Bdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738135770; x=1738740570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKO1XdKTTtgBmHcMQL9CkfWcD96N1XKs+6t6kU2T7u0=;
        b=oCzppIyrR9PF3eKCKEljdma6SBOWm10R7qLx+rs1VppBO7kfwNWZanGfOdxOvYWoXx
         sWlcgFtan9onII1FDdaRNtKhWt7VkBxbc9gy7uQ+fvk761kpxrN+YIQ7lSfbvJNCytuM
         scDKJMQyAUY1rhYyHNPj1L0LZ2l52UYyW4CPhzzWHV0Oa8V+wn/x1yCGkj4HZRLMV03X
         eCibBntY/fYANKT1w7Zd7CfvSp/6qAYOEn9s5twWpmP8odfrd164qri2UNvVwNmYDUJk
         V8E6/h9Ukav9jdjjRHc2Y7Lq1MOx1JOM2ETcInS6Bk6rZtVBN8n42SWDzyMOIOuyXgcG
         3x/w==
X-Forwarded-Encrypted: i=1; AJvYcCWdo2aHZve4bP/D3Sm8RezK5rVUMZ60idf4ox3p4oBl7DbP54jC/HLmpn4BehX+q9GPxIPj9JUKow/cY6YXUTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AdAC0fV2ukiv4frbZwq/wP9S0bav2tvEE2WPT2iyKfwiLM6+
	dRPRO6MKasHUUJfDsg68I88fqs2UiNiXKMTx8lBuYRL9+pO5ciiQOKUlYa1QEA0=
X-Gm-Gg: ASbGncuslj85dFM6bIDp0g969KGHc96s7n+tsjKpsd/Ny91juwC3ZEA3CT0OjD8HIud
	PceNe2vFV8VvY6QugQ0JgnsktcqG10WSqsC5kM4NTFKNY3tsD/EYU67P9y72u5LL9VitBJt7QN6
	dQVS8JX0FsH3ovfq7JJEQJ/dXYV1r9e9aSx5G1xIPYOaDFD4vaLgXnA/db+3HbDpnQQC6+qa+iS
	kbtXJkfG8KNV8G6a563oNfWpxMpjCLn4ZpWNH0B4vBepYE7wM26dRSsl7JPGCJabg6NJXTDEQF2
	5Lktf5Kp8M4wHY6yF6wc
X-Google-Smtp-Source: AGHT+IFzQ0WRiCVB+v9XWQR9cAigPzmfMwetHqd2FjS/6WpVX1i9mZKmmPeQIqEqCRB31541sdBtPA==
X-Received: by 2002:a5d:6dad:0:b0:38b:f3f4:5812 with SMTP id ffacd0b85a97d-38c51048ae4mr1756267f8f.21.1738135768487;
        Tue, 28 Jan 2025 23:29:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb04csm16347255f8f.73.2025.01.28.23.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 23:29:27 -0800 (PST)
Date: Wed, 29 Jan 2025 10:29:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <2295987a-7794-4404-834e-9218349a6f45@stanley.mountain>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012955-hypnotic-patronize-8931@gregkh>

On Wed, Jan 29, 2025 at 06:54:48AM +0100, Greg KH wrote:
> On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
> > This is like container_of_const() but it contains an assert to
> > ensure that it's using the first member in the structure.
> 
> But why?  If you "know" it's the first member, just do a normal cast.
> If you don't, then you probably shouldn't be caring about this anyway,
> right?
> 

Heh.  I had a long coversation with someone where I tried to explain four
times that casting the first member was a thing.  In the end, they were
able to accept that it works but only "accidentally."  We merged their
patch as a cleanup.

https://lore.kernel.org/all/20250116193432.716db3a2@gandalf.local.home/

We have quite a bit of code like:

drivers/iommu/iommufd/iommufd_private.h
   243  static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ctx *ictx,
   244                                                      u32 id)
   245  {
   246          return container_of(iommufd_get_object(ictx, id,
   247                                                 IOMMUFD_OBJ_IOAS),
   248                              struct iommufd_ioas, obj);
   249  }

It's just a cast like you say, but it looks like pointer math.  It would
be more readable as container_of_first().

The weird thing is that when people check if (IS_ERR()) on a
container_of() then normally the code is correct, but when they check for
NULL then normally the NULL check is a harmless no-op.

regards,
dan carpenter

