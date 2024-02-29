Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB870AC7
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230971; cv=none; b=BEQbQswPlbqWnBG49mynYWa+RFDhYuPspYGyqiSwtHp3D2U7rhjOTPv9OhJGjMkIp+Gf4H4GngsKNuvZ68ZJ/FG4Rj53NJH00cLYEirKlmXs4i0NQkgyGqr9qqlfKXTtKJCEjxywqb7pTR67s0q8ldvWlzB/dqF+HAFTktpSyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230971; c=relaxed/simple;
	bh=g80ZHMfkap5e1XvdbqJdFJDCZAoVlfr93qwV4iryYMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+/l6PG8T0OyFLNgHa2pCMiL2NlY9G2VyIElYFKJdFsNeckKqiPeFcrhcQU6B4+h91VhhWM1IOgzmCKs1y19+S7Zv7L9WLbqIL3l5rC6aB3KjD3qPpM5JJF1vfGc1OtAlBQisIYi2gilIq674jtdd5xL5ZM9BFl+KXsqWE3K5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NHD3BP2H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NHD3BP2H"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso900944a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709230969; x=1709835769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SME3hkkQyGOJtg72h1VtA8SKZ4fgYrx6Seh5LXcBQ8Y=;
        b=NHD3BP2HmpZYqK4Q5E35+nXruIJPzrSQyLpUi4XNguSxfkVoOmJsSl1BEQf0TBLCX+
         TbH3MdWSFEWkq8D4u25f0Ljh7+ycO3DD5CTc93Sl6RUuc75jXzLNdXE7iaE+9Q+v8pJY
         7CyO4t8HdmhowkEtiYNEp54rP4rGvMHgdcpS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230969; x=1709835769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SME3hkkQyGOJtg72h1VtA8SKZ4fgYrx6Seh5LXcBQ8Y=;
        b=fXmM+Oss+szG+ByzwQnFjOZ7ytBnxlvaPgMNjUDCdK9n/9zWQu2i7+WmDVdtoavW9b
         1GSZhV//9221EoQOaRtOf96iSUAYYG9f7V26mC5/CZty+KzHfUwsDWJLUB4TLTIUIMMS
         1LxD+LELhTJjdUTs1Hfjs/El5hxacMMPldlo+2ZMGhdY4Icgwl3fhMP4WgLsBZIvksV3
         PDT7h3haVq2PCOPRaEk9gKqzXO45+px2qUz/h3+eL8zfr98T3rhJCdt81UrcpC6ryXmJ
         y0n1kNQ9fbq/0wQXVMXOOpeU7p+nplxhxKwhFbSEWIg2DWAd5liiv+iI7H/JSmfuTPdF
         4JwA==
X-Forwarded-Encrypted: i=1; AJvYcCXhy4gYqKPEXSRrlNl/T9lmzxl9ugHJOGE19MfMLxp7CETJNqD+7Yl2fUOwnAl+A7v4+5oS47uvHanNaFToqL5xLaBDy24JC/Jak5XN2III
X-Gm-Message-State: AOJu0Yy8jOltvZfr/fGyxbWCZ4e7YEgYM3f9/MXRb4ksZQuzfAjaBo5M
	6JqFcZ9Sofm4arS2y5qZ3ZfeIjSIT4dH200rwMVp5LUTnnDOMO2NISdbbYdLsg==
X-Google-Smtp-Source: AGHT+IGYdlTHCZzP2Rg0F0nElhv750jePTpguZzrPB+4WF7VZs5zNJs7UO3cl1UWFqPeurqTqikR6A==
X-Received: by 2002:a17:90a:4a02:b0:29a:f233:2882 with SMTP id e2-20020a17090a4a0200b0029af2332882mr2856150pjh.12.1709230969105;
        Thu, 29 Feb 2024 10:22:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c88-20020a17090a496100b0029a7a2fbb25sm1930138pjh.57.2024.02.29.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:22:48 -0800 (PST)
Date: Thu, 29 Feb 2024 10:22:48 -0800
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
Subject: Re: [PATCH v1 4/8] kunit: Fix timeout message
Message-ID: <202402291022.E3529BD@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-5-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:05PM +0100, Mickaël Salaün wrote:
> The exit code is always checked, so let's properly handle the -ETIMEDOUT
> error code.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
