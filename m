Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FED14E2E1
	for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065568; cv=none; b=baVHABgHmE6JRRrdX5hidcV8bKm+RyoeKPuMaFD3QbMO/PVS8XgAwA7kGCFFMjoImv/sdIT9/CXq8S7dJLbrRqllg7t2T2xXhoQod5R4ULhP0WEt45pqYgu4CVIsGApeF+wBVyBjhnkpFGoDNwJaihcwuOxFSej5tX/0rVbBbjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065568; c=relaxed/simple;
	bh=47qf1VJfN1htPuzwcBHn7Dk8utfEzpjninPu15D1DHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY5S6CHT7U0LE08CUYembgOn6LPeHxCF2PiuzMMcmo8avJjZZSoTdmi6RbN+SgpAdQ0lYsqtp9oiFTMox49Fdlp1RvY0SVgAMVpT2cV3zY29TbszXKfvtwxL676IkUVOEbAneIDr69A8L/x2//A+ZUTtSGA3lafJkBX2KR3bimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bUhsoazE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUhsoazE"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so1164083b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714065565; x=1714670365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEArpaPdCkeLMM8e+oCYdabZOyUvDXBNvCNCU3D6sx8=;
        b=bUhsoazEiKVsAiQqTGzXYanKMj8Pzq27+Zql8Qk9Qqme1aSDIVMMwmgYh2aPydQizn
         AV5AHN02njPVBwXTqrzFkC2cWU/XmgTZaoMCHDV5drBzA0NZOxv/Xs7I/CXYRjktLV1g
         TT5g9O0I0JuLSa4mUeRACWnJoMNveeifZgPBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065565; x=1714670365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEArpaPdCkeLMM8e+oCYdabZOyUvDXBNvCNCU3D6sx8=;
        b=jAWmSb8fZlQd9JqWTfgnU9hcmpfYrITTP0wblhhgUqb0xf8CrMc8fgqX985+vYwpo8
         44OFrT/kFhnFy0KWFz19eGXz4I9bLcvOFjX3I/N7wF8wY7UmeoszNMGlsor80A9ktPim
         iCZF8Og0QKpvzb+Zzfqsh7iHni2ChfCCcJeWqHXpxACaw2FHSDz2chxFTo/+QRnV3YwL
         RZUaC3T5TpzKtrwht2jNN3/0Dd0cAghmm9vxIecApzatOZ8A+oIa2usqKuraA6xtDe6B
         9gpv2wrGApnYm8tmeQaiPd6oLQ2HIvBKsNOtD8N3avWKVr4OlZyZVqbp472JYI3Spd7H
         nAWA==
X-Forwarded-Encrypted: i=1; AJvYcCVxo/S2gKWOuB3uRn6ZhvY8Qrkh4FOI1/gZmYrybCALO5DrZKdK/waxl35WroZFhcMy5h6oO7/NZfgAvcasoq0aetnNqK60/zMeQgA+VhIg
X-Gm-Message-State: AOJu0Yzlfg/wVE3jUSVDwbKE/kmK3qrX2JcgSjSKIAxXxwNKf6gMPvJa
	KpUeLutcv/Sm1slHvRvlU+6JFWRKLKMEr8gZzsPCSkYEmet0lqZVD9aB5fnrIg==
X-Google-Smtp-Source: AGHT+IGSQtc03FJYmN67TcOlJEb4jjwUjOrO3E0QvJYydq58tzeFvCMVkx0opll0cr92togJ9vRyLg==
X-Received: by 2002:a05:6a00:1941:b0:6ea:f05d:d2e9 with SMTP id s1-20020a056a00194100b006eaf05dd2e9mr507849pfk.15.1714065565180;
        Thu, 25 Apr 2024 10:19:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n56-20020a056a000d7800b006e6b7124b33sm13379389pfv.209.2024.04.25.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:19:24 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:19:24 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <202404251018.C12E9F23@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
 <ZiotNVLD3ek-9Lwj@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiotNVLD3ek-9Lwj@FVFF77S0Q05N>

On Thu, Apr 25, 2024 at 11:15:17AM +0100, Mark Rutland wrote:
> To be clear, I dislike the function annotation because then it applies to
> *everything* within the function, which is overly broad and the intent becomes
> unclear. That makes it painful to refactor the code (since e.g. if we want to
> add another operation to the function which *should not* wrap, that gets
> silenced too).

Yeah, I find that a convincing argument for larger functions, but it
seemed to me that for these 1-line implementations it was okay. But
regardless, yup, no function-level annotation here.

> I'm happy with something that applies to specific types/variables or specific
> operations (which is what these patches do).

Thanks!

-- 
Kees Cook
