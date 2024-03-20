Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D71755C
	for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902617; cv=none; b=RzigEUACEJ2ACqKt1PqLI5QCs0ayd8BggE82I6GyNAoNu7RbMPkzNW0u61O8P8cOFw+80s7zP4kOOXKlhKxku/J/lUKg7un2rfYWlegrrPZv1hAlMccM/gvh9tRg9Gd1qAPkHr873CaVcndB5EWK8qQYsBOfqikGnIuwF77iZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902617; c=relaxed/simple;
	bh=BfvY3vyLR6lXc/XFMQ0qkGmpXmDZdpmrBKNycQGWXU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRPC7/3nYd+Ek8hFkYMl64D5QX8PKgpf9x7ZCcSPzMbTppBjSd/85kMd6feDv/HfOmd6W00XMHGTbzxtJl6NqKMoBzLKU/kW5ii9VdrJoot+9kjSmfhxgQJ3QuxM5XeNH0NVmfVTf1etxuRLm6+t6ZvzDda9Kj5K203lbIdLf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DNghZSKb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DNghZSKb"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0025ef1efso23585295ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 19:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902615; x=1711507415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6fFauTTG4W/mn5n1JHyH5xPf3JyfWAj7waGLeqk3zI=;
        b=DNghZSKbb+nZ0jz0xHSDiD5ILl/k+Ymy5cPumn3vg3ENIJPXDjGM8oT2zqARxNpjpN
         BdeIiQLHOv6dwQS/xgbzEZWWW1X95qJ21PHWv9umLj0jFP+oGanOucQPpo8hKvtNv+uh
         mIhUqnPr89pk5Ytrk4+KXdQUGEJnBm/Ayj/E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902615; x=1711507415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6fFauTTG4W/mn5n1JHyH5xPf3JyfWAj7waGLeqk3zI=;
        b=PTbs6NoS/By2Cvyx4gXiW5pY/+f2L1xBP3bI237Ab/W9Uo+UmL0rhOcnw6fziejJOi
         Hm/u4fEToWTTrgJYrkSqHBjAvUYP6E+986WSFjjhHkFpC3tg0KO8FzCOS/8xBjdb/a0x
         sUAK/F5t1jUmgNt5kaNon78ESyKhzvBkRvJ6/gxMlQFWPoGKXO/+KesnJt7WAAUz0Ebk
         scEO9EzvEzU8N5tL1cLFolliDNYSC8FfaY13ZuhEaz/9AyD549qeM+aJLqvcs1GUTsNV
         tnI7whjgLtBbvJ22T3ge/bk5voq3QWrsD5Z8XA3seLM5+d0al62FMV1FsHmln/zwJ35v
         Ta3A==
X-Forwarded-Encrypted: i=1; AJvYcCWpuIJDMetsxgm8ojTYdsHFhi5jDXgjLShqbsxnZR/uPtTjRhMhfzydpyZpFGoReVEa1mYBtv6CrF/2/fAYzyYdco6dV++k8PmlXTr2k3Nb
X-Gm-Message-State: AOJu0Yzj6Cu5StL7qQZYDz0PQEzpU/wBB5IIt0Jdv55WswWpQ2F3kkaP
	xC5ZkxLZwJRAOpyz1ozhhl0jocEzX3PqtQ+96jbMSBjInG+LgeHwcP4d0VCM0w==
X-Google-Smtp-Source: AGHT+IEWmlMM501UpoKPpKqkmGwRAMYGO6OYBvdUB6jJX5Jkb9LM3OMFZqUtjh4V2htoBunvlx5FxA==
X-Received: by 2002:a17:902:7798:b0:1dd:ae5b:86f1 with SMTP id o24-20020a170902779800b001ddae5b86f1mr15575726pll.29.1710902615342;
        Tue, 19 Mar 2024 19:43:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b001e0501d3058sm1548080pln.63.2024.03.19.19.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:43:34 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:43:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: mv_u3d: replace deprecated strncpy with
 strscpy
Message-ID: <202403191943.942C08892@keescook>
References: <20240318-strncpy-drivers-usb-gadget-udc-mv_u3d_core-c-v1-1-64f8dcdb7c07@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-usb-gadget-udc-mv_u3d_core-c-v1-1-64f8dcdb7c07@google.com>

On Mon, Mar 18, 2024 at 11:31:53PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's opt for the new 2-argument version of strscpy() which guarantees
> NUL-termination on the destination buffer and simplifies snytax. The
> NUL-padding behavior that strncpy() provides is not required as u3d->eps
> is already zero-allocated:
> |	u3d->eps = kzalloc(size, GFP_KERNEL);
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
