Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45F1C6B2
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001735; cv=none; b=mV4p7x6OxXULoMYmjSqFhBuAYwxA1/pnMDWBCBdUs3TGrS5SWDm77kh6sstOSJndu/PiW7CxSKrFIQKZQ8IyQy3fydiLiD/hrQcAB4yK917llwakwJkqzCGOTuCORDgcaAR6NGJEqyzmlg2Bbgt+l0ayMOJCTQezs6jsno4o2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001735; c=relaxed/simple;
	bh=DSJFzOsv6rlg79WxSIPGVP/9YIfZ4OCwNzOOqAGK8MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWtSYx4Bmn/X1g2Gt11MaSMSV8h5EZEFGBLVr4nocuJj06lXOSDeh9KqFtn+QSjAKuo49PriPzreVRDaBarlkJmfIVQ3zcudfctfteWNfcw/sZgqUyrQp2BHuRTQKMC3DWoM1YxDCcIIFH15k+UpDpAOL6BvEokKfcMgUBLecK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fypHewm4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fypHewm4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f44b59f8daso16656115ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717001733; x=1717606533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aQ6eDxNzZ/xIi69wu94KNqBxtdc8KgNJMph2iqDUWs=;
        b=fypHewm4wCELMoZDAxOd4hjjnPVQbRj8097rSguoCZ5m9RQdHQN3ZvXRPTPa3yBNpg
         /gFcDX+q9R3+GcV+X8nd8p6upowNXC+Ok8tiYqqvx6P/sGYOXN0BhxOcgQaKGBfDLpuo
         /xIgsU0v5Q7qbF8sBK12ILQ7e6Us3YbrkM5vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717001733; x=1717606533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aQ6eDxNzZ/xIi69wu94KNqBxtdc8KgNJMph2iqDUWs=;
        b=r52BFgkQnl2qgOehK7DWLDE7ksAf6OXb1UcilNaNAMoVU+Yg1Uh8ffg7k6c+XUiEN8
         WhYbnDXzaWX5yFoCDchTJC8IIdb7qjWjM3S5AKgmpaL61qq0+neYDVPSbKKbVwVg0NA5
         ejDdT4MzLE3wCgIxt02FoRKUWObeDE1TjTF+Glk/3q1ARk8APNGuRlcQkbDd+RWP61rn
         GuYtxQxSKcpI0JtiCnnb0uMRs13fQPpFA/tLAmgUHVQrLUo25u0vbthsY9drU/MC/rtV
         6GnNIA1UJAYGvUX43bFna9xCL2ABMlpC2YIBi8808ocxIsIfb0w0pJdlyH78MUpBQQ23
         xasQ==
X-Gm-Message-State: AOJu0YzmxByJYz2IlJhDIZFoLyk8uIXe0dmpaXS2Y/5fGUFyLlovv6jJ
	QRfOeiaiGYX4zXz5laTHCn1cLXjU/hzITL9YCZd+JpA2vByEcjjWHEnLk+D1F26UHQfpwaYSF+s
	=
X-Google-Smtp-Source: AGHT+IEEoRaY2/H3OEz1Q134ClmccE8jK834MaTqWdnV9Gm+Hd3B234LWRSFePDSbbqwxuXDH3n8FQ==
X-Received: by 2002:a17:902:d50b:b0:1f4:5911:198b with SMTP id d9443c01a7336-1f459111c52mr167318665ad.55.1717001733582;
        Wed, 29 May 2024 09:55:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9683besm101150305ad.138.2024.05.29.09.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 09:55:33 -0700 (PDT)
Date: Wed, 29 May 2024 09:55:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-hardening@vger.kernel.org
Subject: Re: __fortify_panic() question
Message-ID: <202405290950.7E61121D80@keescook>
References: <79653cc7-6e59-4657-9c0a-76f49f49d019@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79653cc7-6e59-4657-9c0a-76f49f49d019@quicinc.com>

On Wed, May 29, 2024 at 07:36:25AM -0700, Jeff Johnson wrote:
> 'make W=1 C=1' on x86 gives the warning:
> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?

Hm, I can't reproduce this currently (but yes, it looks like arm vs x86
is mismatched). What tree is this?

> Looking at this I see for ARM there is a prototype for __fortify_panic() in
> arch/arm/boot/compressed/misc.h
> And there is a matching implementation in arch/arm/boot/compressed/misc.c
> 
> But for x86 there is only the implementation in
> arch/x86/boot/compressed/misc.c
> There is not a prototype in arch/x86/boot/compressed/misc.h.
> 
> The easy fix for this would be to add a prototype to
> arch/x86/boot/compressed/misc.h.

Yeah, I think this is the right solution.

> But it seems strange to me to add a prototype to a header file that is only 
> for the benefit of the callee and is not the prototype/header used by the 
> caller, in this case the one in include/linux/fortify-string.h

The stuff in boot/ doesn't tend to include fortify-string.h (since it's
sort of "outside" the kernel), hence the need for additional prototypes.

-- 
Kees Cook
