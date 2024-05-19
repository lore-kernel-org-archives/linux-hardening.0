Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3F1DFCB
	for <linux-hardening@vger.kernel.org>; Sun, 19 May 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716142516; cv=none; b=EBgKkah9r8rgRW+IcC3xulslC1Az2N+1YUy02ajV1xuzgz4KZYsub9EPQQSOqX118izR3uLCTZLW9M+8pw33N0TrKnc8T0BkhX9sLj2zMXrdAGnXeSwc0UCp474PkwLnWOV/F5/jlGzNvz3h3GNc/DsPN5atUM2w2Yolsc8zyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716142516; c=relaxed/simple;
	bh=7aMlUpYXG+D3tRLz8K4ybKHvPVMZ7c7UUXtb/IR5nqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goSe+lxCFeMaMMO9n+U0OMPg6ahKflM++AlFQa9hoamfaIX67NgP3yA+l54WYinGv5wH2L+33DhYO8XXfM4F8LsIBJLf62tvm2VaqIvzgyIaONrx52xW9AzFJ9qntXSCfV1JY1Qpe3n/LrVCyt+m9byFCTyHTn6TbbWyGXOldp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kvt49UDN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kvt49UDN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ed0abbf706so51741375ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 19 May 2024 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716142514; x=1716747314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzOZ7YVghqBo2F/fa+rUY+FNuLS1ZQELoEWyUmcv/zo=;
        b=Kvt49UDN32oVq9iiyjmiXpkIZrp34U5JeMKN4HS3TDga4dOUr6s07QIMzFhbiwOhKr
         hIuCoplTx8fkWq8+Yh80y0NSfUlN0ssvVYs8K0SwdvFS5eYqZsX8avU091QzHVkU/zkZ
         tiggbrDLlXxRotio0tqj/WnpESTqkpA7cvPz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716142514; x=1716747314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzOZ7YVghqBo2F/fa+rUY+FNuLS1ZQELoEWyUmcv/zo=;
        b=MZ/O6N8E+WphulvncN4oboXovdE82wjSPMQGC0rFQ/ebrkg4nhS6OBOZ218GilviDr
         wY0da7BeiCOKBvo9BSXNgDA4KE/24FqGJE+HnfM5SEWWpxrnQaegDOxFK1V+rK9ei7rJ
         Xez/s7V8GS3lfF3yUnJYvz5QnRR45WQUwgZw6Lwk1GxgMucr82jM1RYEUYfG0XW7WrB/
         rgHTyNH5032IBmeGtJKrH0F02u3mhINb0g5D/e7UKGi5fRSABc5NA+jDxt/Rk5/kAFhf
         AIKprpJ84i1fgxdyHoqBx0qn3qyWSQ9uhYmtpFSqGhRzcJIQGuzHDewWmMlZmMBX9zOM
         fc0w==
X-Forwarded-Encrypted: i=1; AJvYcCVYeVctvrZEDXNHjWWoq4d5pWF5S0nYehL8wKnJLkb7csInS2I9LhnihWjHJZRwX8oX7FxoN5IEQPzAGB2KLiFco5t0DXCP9UXQlpsMzCmF
X-Gm-Message-State: AOJu0YweVnuIz0Kd3R+uu06k9kcPIjGfS5uvJXjnv1GV5fydxLHggM+z
	tR8M6lmum+ProXwZwat0Q9WBwtEzCNCPsDnT4at5Eds4pAMLhALbWqE7NZhNzA==
X-Google-Smtp-Source: AGHT+IHJG6+ZH93XGOoEQl/FkVnfWHdRCIs6HlPK6t1up+Q5GVekj0cg3DQc5ikbwdVQdEoYm67uUQ==
X-Received: by 2002:a05:6a00:1992:b0:6ea:afcb:1b4a with SMTP id d2e1a72fcca58-6f4e0283938mr35571943b3a.8.1716142514397;
        Sun, 19 May 2024 11:15:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f28bcaaasm14297466b3a.73.2024.05.19.11.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 11:15:12 -0700 (PDT)
Date: Sun, 19 May 2024 11:15:11 -0700
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
	tony.luck@intel.com, ardb@kernel.org, kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: Re: [PATCH] efi: pstore: Return proper errors on UEFI failures
Message-ID: <202405191114.1DD51BDC1C@keescook>
References: <20240519163428.1148724-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519163428.1148724-1-gpiccoli@igalia.com>

On Sun, May 19, 2024 at 01:33:53PM -0300, Guilherme G. Piccoli wrote:
> Right now efi-pstore either returns 0 (success) or -EIO; but we
> do have a function to convert UEFI errors in different standard
> error codes, helping to narrow down potential issues more accurately.
> 
> So, let's use this helper here.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Ah yeah, good idea!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
