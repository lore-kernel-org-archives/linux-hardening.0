Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B526A0BF
	for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942427; cv=none; b=MzF/HqaRjdu9Hp4kiBul17KQ6t1/m/25tI1KA3XkZJMkgb2cBB3Bgg9QNoRSrKZ2UhM0WAmxbBsVDBhR4aSlo7+0k8F/O+oCz2T2NA/YLA8SjB43IDLtp4hLA99Hn5nLHrub+x3cuR0ilBYf/YxLBGTkqRR7x/b3gfxibUEufA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942427; c=relaxed/simple;
	bh=pQ4UoyDlpkHuiZgOcYbiP4Xig7yGzQ3Q2/+D3ehiXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmucd1QU/yesErwkkPzpiT71mk6EVq4MvlX1mZ5bWBIoSXNgyXfazDM2PoP7VMsaouHgAcui6rhPq5vq1AtQJBbad5dqG5/gR54adrqDmG5vWbXJKUylp02zsAeepjNpcVzW9b1y5cAPYBA6kfhi5OaIrVYAndqbBrv2OVcx+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GQhYK1hd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQhYK1hd"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso10436412a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742942425; x=1743547225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ0mQOw62tpJtHtq3bDP+LhjKb7VU3twZUif4e7fNdo=;
        b=GQhYK1hdsQPc38IdJ6AIvyattcUJJLw0K6nefnDPT46rZvc/BQs5h3hF377S31XDhK
         3KxXg8htAQA1HPmJufoEETmGqsFahje/CjWGlEbF4b/fDpuKuDmG1pbmxk6XsG0vP9Bb
         CU5VaaihLJgMKAFvhoL9BnTJAawhZOR5+Kd5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942425; x=1743547225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ0mQOw62tpJtHtq3bDP+LhjKb7VU3twZUif4e7fNdo=;
        b=eQoBrqzhs5oFkvgFUuNbN2kps8jCk/yOwNTyCE6HYkHgcvMe7rqPK5EjvKqAN23dfA
         yYAzxbenn4QSTrI4ZNIhCxe6ocjM+cmOgdSEitjH1CKWq2eTIbRSylh6Mpexj8R+H+KG
         dhaVGaMdAV+OjhI4YvwbSKrkM5DpM4W1rJiX30x5f2H5DViuJdxlfwDWoHG7+C+Bp3HA
         kJq2+SrmI2z0z1AG3XJPJsvrWA1Sw0PUYkoATIwI+QVxsX9aTQIXW7Hl6sWLcc1rZSh/
         7zXuC2YJV+cIVNiHhwfxol1IQHXGFA+CXuaI7HsbxK2hwNj91qtrHkHKqioSWgEGKsiL
         kOVg==
X-Forwarded-Encrypted: i=1; AJvYcCUHG8h3c3BcG5F1O8eVuRQuhPpCc7BMC96L/42Tp0ncH3RCl6v41G6pRsedXBotZnxP1oOnXUiNR4jL90+tmNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDnEDk60zedg2p8Q5XvmcyUdX8IDJGF5J9air3mjl8pf8+hcf
	pDDfPRJPQEkleRf1A0/RQdbormFyWo12R+tW/9LzSj+Zb8ppvifmeEGLtxl0Uw==
X-Gm-Gg: ASbGncvQLa2jgStNRkGVKeXarE/krPtMme2c1vHtwogKtncwcWWZv4ohv6muFlXJnRo
	J2IEPUaGdf7xg5TSEAx+fa5EjObkBhxlm5d3a1vlTI5c1AxCj9UP2UvV+aI1wrRxi7pmHFrE+Nx
	2SuizRDWVW4T8W1x63G5DkuYd1T0D1jH+l8C1BXCUtoyNesTi2O1OLSEq0Z7Y4MkuP+UV2muySC
	HTIlMHcpEhRlF/uBsPIOLq87RZxqs++CN/ZCkzzt4fsOkGd8IJD2oJlZefRU+1wfKoG8p4iqtLR
	TYFJ4juNYnDI1FDdkEnidTdwopBnCBDl3sJj6JeJLY6VmQV8/yFWaNKFFZNlahQYuhvJC8UdstK
	eUnjXZxY=
X-Google-Smtp-Source: AGHT+IFnMbdSPWJg/PZpthIfsM4Byyr22hmvQEezyxPZc4t6JJRig3bNhZIvvWZylXPImyBG3wYAXA==
X-Received: by 2002:a17:90b:4d07:b0:2ff:69d4:6fe2 with SMTP id 98e67ed59e1d1-3030fe9c932mr32753804a91.16.1742942424766;
        Tue, 25 Mar 2025 15:40:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:b885:47c3:6268:77fb])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301bf61b525sm14937020a91.35.2025.03.25.15.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:40:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:40:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: Kees Cook <kees@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Allison Randal <allison@lohutok.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Add __nonstring annotations for
 unterminated strings
Message-ID: <Z-Mw1gvbkBQ1fZ7y@google.com>
References: <20250310222332.work.202-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310222332.work.202-kees@kernel.org>

On Mon, Mar 10, 2025 at 03:23:32PM -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Francesco Dolcini <francesco@dolcini.it>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

This code is kinda weird, because only 2 bytes actually end up used, and
yet we explicitly initialize it with 3 non-NUL bytes.

This solutions seems fine though, as it is indeed not a C string and
does not desire nor rely on a NUL byte:

Acked-by: Brian Norris <briannorris@chromium.org>

Looks like Johannes already applied it anyway.
