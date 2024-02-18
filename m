Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B807FC1D
	for <linux-hardening@vger.kernel.org>; Sun, 18 Feb 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247221; cv=none; b=jwti/tOPKdrCY2WIZIVAfHUONL6FGzORw+D5cAEmlkC9B2uYZqmQ1ik5K1eW1nAeQ0dClEb02YEPYz5aKTiDoFuMqcONRpO32NyWa9gMVkPz154fHV9n4VwrZKHLjqX5TioYIy2vOU0/69KLOJDjH6KmKmjRraZOd4HyrNl3Yx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247221; c=relaxed/simple;
	bh=HFou+Ynhj8r45qIYynVJq3BPxFIXGbuKAoHIGhaH17M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCS94IVQwQ1f5AOzhQKdgAHMh32ai8XLmDn9uAaDUetLUail8v+/kV3J+fHY/HZA2GAixvJFkkrx4CrVNZuGkrjIpU1f5DEksZL6HSsCNcHEI5/Ti9TL2Mc50H3V6p442xEOBNgdUao3VrXgGnyZZMeKp0HtTPP2u679jbSNqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CfENhN4+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfENhN4+"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1482305a12.2
        for <linux-hardening@vger.kernel.org>; Sun, 18 Feb 2024 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708247220; x=1708852020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pYjP8Elq30R0i6ycDkBbNUM938GG/2nOBO34J/gBts=;
        b=CfENhN4+7of4UE9gjPzdZOhi2bMwCVSCAGl3GBKhH6SFsZ3u62gWEJ7wMEaKRfaDW6
         wphwf1ieqcQmWlzhDt2mCiOwZEouB3WdlTyC+jmN+megcEs8dqAltFuoBSrzJr2MXp1n
         G2xrB4mxSKP68DMz3akurQweDLE3bw8eeVlwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708247220; x=1708852020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pYjP8Elq30R0i6ycDkBbNUM938GG/2nOBO34J/gBts=;
        b=SRdEY/mznUF40H1Vc4a3CLI7VtuFd0ZratCaD3YCCCTkjiKq3rQNbHD8gSB0PtFC+/
         m2VxF6+jiFTuj9/g1G73TPGffbLuIjyVsF7MeUa7i5c2uXB5r7XacdO632P3oMrsv3Hg
         eptLlczM8+tBsq1Yx6T1gjCq5mpfbnLSRbg8QyYaaUNtkZTxXx3+ZX1fH7H4bsrrx/T+
         LfpmbZF6QThStxU+CAi5+4uYgYIWhcHv4qTPVPNHnjYU352Ie/An1obBvbb6Fw2cLxfw
         npglKBGAFt2z9H/kAVXX4Aw/W0OlcVJD4fz7SRulthC7v9IKr1OFFUf0/yaWosUnfcKH
         pcIg==
X-Forwarded-Encrypted: i=1; AJvYcCXczxdg29fbwmarf+CTKdkisrXp5d7VTJvcD92Bfd2lmySkbwMJPXip6ScOuqsaarbgWTZPOe2RtLOaQ6SHgXG/Kw9yqADJDIecZhn28UHL
X-Gm-Message-State: AOJu0YyFisXuzJykr0b8/7QPBmjgwWWTeQflORMTciZ7WeLJi+Yf/vUk
	Uz/yVw7RT1dP8Gaj3OEuwAuEL/bNbuSGOqwQEARRQiZMqdoIHA39UwW3GUYOTSFJA3fIxJHGRow
	=
X-Google-Smtp-Source: AGHT+IHE3MbZ/4iRpYOBLF5b91QTfJN5jdx5IDOudYN6UjSGzsBL2ieEcjeoydWDpFek6WFz9QfxRg==
X-Received: by 2002:a62:cec9:0:b0:6e4:1a29:732f with SMTP id y192-20020a62cec9000000b006e41a29732fmr991819pfg.12.1708247219780;
        Sun, 18 Feb 2024 01:06:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c18-20020aa78812000000b006e1464e71f9sm495605pfo.47.2024.02.18.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 01:06:59 -0800 (PST)
Date: Sun, 18 Feb 2024 01:06:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] PM: hibernate: Don't ignore return from set_memory_ro()
Message-ID: <202402180106.25E08136F5@keescook>
References: <be49c794567f3bd00ae16e91b54fe8cfe6cb4999.1708245599.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be49c794567f3bd00ae16e91b54fe8cfe6cb4999.1708245599.git.christophe.leroy@csgroup.eu>

On Sun, Feb 18, 2024 at 09:40:58AM +0100, Christophe Leroy wrote:
> set_memory_ro() and set_memory_rw() can fail, leaving memory
> unprotected.
> 
> Take the returned value into account and abort in case of
> failure.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

More set_memory* consumers! :) Error paths look good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
