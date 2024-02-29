Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864978284
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230937; cv=none; b=MRBLLZI7Kr/3ht/HsdbbEKmHviF6C11FmCwOaFTjkmbMSH5Q2gOpJ2iXsuumEPSg/BLlrk1skZoPE4LIvH9ohrk/rx6OKfESMyJ7m+f+Bg7Eyf1mfDIbHl0vN20MoK3UsRZwWIwhURM0YngNaWPVf2+XZUq2I+3XvxOi/8zw+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230937; c=relaxed/simple;
	bh=fDc9Uwhm++z7zUnn73jE8m6PTGMIZXn9lNaCfrSaFKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0wabmRw9vb5vjgPqhvwXdn/lJgc6CXdl51LL5XsMoY2CqxJXDDtnDUoBW1sbHQwm7oc2nKhOT9Rtm6h5PE8LtCNuuhiSR3X5TE0UCIOMj+LgWsKkHwsgRwdIXsvKTUCf23x5TUu6bLnfGoNBF+Lk6ZPMdK5XjbJMnflAokb4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B9KciT6Z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B9KciT6Z"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93edfa76dso12127835ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 10:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709230935; x=1709835735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d0x4aOlew+ChlnlW593MwGC8/uLA2yAII6jDpil+AZo=;
        b=B9KciT6ZaaZF4rRQhqyiILzLdNkpla2QbXXkNeuCqrChpu0qtMIaDWenDbQ8rrSIFh
         9XynGDga/vimj3ueeTB3rdqIRVOjTHTM95CYqqb8qeQr22gNsndvohB4T8KofRerc6rN
         48/S2kHkaGM+eNJMxTNvKpqQO0LME4EEwFUmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230935; x=1709835735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0x4aOlew+ChlnlW593MwGC8/uLA2yAII6jDpil+AZo=;
        b=wWZ5zn9xWhrji4vTDe/Fek/VeD3Y5YadSBSQXBxAEwv/0uJIz8W70hTV6QMlaTf0zI
         lDA0V6zn1XBKIle/zO1H3pBqlJ0XAjoTG19A5aV4VUPf+vSl1ze+kZn/XPk8Q+ryn79m
         LuT75ZiyoIfGiPW3FOf7v+XRRC/ybxEp9hPfgkzcnkbbWM7s1kgvEtc2vzTRNe+7kbSX
         fLPOIu9XhOh8+ocU2n5MpHHDgSPqPL7NRB2bKimFd0ddib/G9ScFuL1NoXgWpImCG/8v
         DQkWc6yzAvIJKhbpzCzmsSmRboRZQRgnPAnTuWgMPa4Ds1+GQsmtEcXoz6j7MsK0XP3M
         IqtA==
X-Forwarded-Encrypted: i=1; AJvYcCXjRd4dj3efOI7T6TrUdLzZHembrEVGxu0cXF/hgqGABUKiiQ2fn7juY5LoG34DF5UPlfLYpLfE02zoUNsCbVKRut0ZkkMyowrKqpauLMI+
X-Gm-Message-State: AOJu0YwfGKkz5YfZK6sE7QGwZv6x5j3ilho68HAaKjZ+JgWbXwIvGa4H
	nvm+Kqa8l7WBTO5t/lyNs/7kUYsynSvd/iBgdxZHtkFRLLlZXix1gBSnL9yhSQ==
X-Google-Smtp-Source: AGHT+IFHZRhftFXgpyhoht+oIaLzwS0XuiJOF7tco0dVyJI5zhbRvtaKiuO5uiLkXREbQDVyDJP6vw==
X-Received: by 2002:a17:902:6547:b0:1db:e7a4:90a5 with SMTP id d7-20020a170902654700b001dbe7a490a5mr2736748pln.12.1709230935335;
        Thu, 29 Feb 2024 10:22:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001dcc158df20sm1813098plf.97.2024.02.29.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:22:14 -0800 (PST)
Date: Thu, 29 Feb 2024 10:22:14 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 3/8] kunit: Fix kthread reference
Message-ID: <202402291022.A8E2AB8A@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-4-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:04PM +0100, Mickaël Salaün wrote:
> There is a race condition when a kthread finishes after the deadline and
> before the call to kthread_stop(), which may lead to use after free.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
