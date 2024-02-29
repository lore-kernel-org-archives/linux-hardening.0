Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48B7D06F
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231168; cv=none; b=I1SBKUCTpFVLPgqk57rL4uzTk8h6R4Z+8pDceajhOnl0bFrLbFeeAvSSF6umIcIrPAgqy0TVPTXOjlLNlbJOLxv4xPE6ZEfItiz/QEbhUFUi0+aIdG/HVNUujaLoLjSFjGit8LpguFFT6zcSIDi61f2fDsIzWI2Xv4wHQFi6CMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231168; c=relaxed/simple;
	bh=GMRN6SUrrHoEIDYQZaXbYank+mE4jIYwZGljGX8JzRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMawmzOFQrgdXKGWrDi0xyTn53OAPGDQcnCKwD4PQP/fxWdR5ESJMxJDmpGAfDQOkVeQr6NWvRheH75Tcmus69P5x/pFEAflAVsbUfPB4+R7Jj/YSBfpxgWppOPM6oIwfK7M/0lNrnBc2fDD9+rI52pYY45CvB2ZPWShn88cWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GWtPP+Gs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GWtPP+Gs"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc13fb0133so10492515ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 10:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231165; x=1709835965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=onsMWwzpvtENple3SFlR2LMD09MQgc6sYAmAsDrNdvU=;
        b=GWtPP+Gsy8M3uLFQ3Bn8eCkaLfwMSCXbCoiwv7X9D6CXKax2kNaR0Yit3mNLBqIftB
         UBUbEj3tonKTijg/2l0GXZlW1Y1C5l4OuQ6c7+OlA8nofTANoAHX5RPdp3PVZcuzyOP8
         oK8vndSURR2ikGP6Tv+IZmb/ahraIVLlxtEwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231165; x=1709835965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onsMWwzpvtENple3SFlR2LMD09MQgc6sYAmAsDrNdvU=;
        b=ZU/OTyso12ZP8PURQ7+bMUENGuQfSleT4PfR9cALPFNETsi7IS5/hlRTpD5LlRvlWd
         sZXYoSMZrzGqLAEl1t9Pgfw6Zw2agF8CHoT1RyqXMM3pGCsgmjD9fFHD9SUFzsYDLdqo
         lwRc+b8vxhTUsDVb5dzxCExXt/OT8R9Nh5HS6cyhjiagUxIUDPN9/PjGzHjerhqtjA2x
         vH9NXTs1BiLWkoUQh2fl8zL2FwmLMueDfiShJilBDlCntPiuA5nZ4gYju5XesTs/TPno
         NpCpIKXNcXHJxJeMYEbx88usbecR71uCsGCymHXqcoqcpKP1WrCJU8s/588QW3I3GPOb
         NXQw==
X-Forwarded-Encrypted: i=1; AJvYcCW6FtNefZluCZ200RfCNcCo3bmcUxpm4t0Wmfx6OkLsuWI5PqeAuGRdUOJvM514JgU4NZKCTurALtGSMQaA0w2ook3GCZsaHQE9K2hNjDsn
X-Gm-Message-State: AOJu0YzusgCWcmN8NBOKpwwHICo5evuy4Nwz4mKYHzAxzJTMOZR/Xz6x
	FPlEkzNuJ381W0dnwVkFKs+b9HxHZ5/fygr319xk9Uvfua7uue8mu2myWWOgfg==
X-Google-Smtp-Source: AGHT+IFaOyXib1ZvD8HKP8qWNtoqD6PNUUwUwDcIGpR6CELmVt23qtsOEdbZ9mepYl+BYt4oLI9EwA==
X-Received: by 2002:a17:902:a3c7:b0:1db:c6ff:664a with SMTP id q7-20020a170902a3c700b001dbc6ff664amr2752373plb.53.1709231165470;
        Thu, 29 Feb 2024 10:26:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b001da1fae8a73sm1821003plg.12.2024.02.29.10.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:26:05 -0800 (PST)
Date: Thu, 29 Feb 2024 10:26:04 -0800
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
Subject: Re: [PATCH v1 7/8] kunit: Print last test location on fault
Message-ID: <202402291025.0BAEBC1@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-8-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-8-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:08PM +0100, Mickaël Salaün wrote:
> This helps identify the location of test faults.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Much more detailed error!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
