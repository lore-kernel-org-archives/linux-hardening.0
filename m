Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F352F9E
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304435; cv=none; b=hq8LqNhkKVNGvCGcVgw9qbhIAhwAZSKAiIIe1Hkr3daYHNHJ39lZcfbZV440o43cMKbXQC9BgE630a5I0CsbW+BPjEL77lageK5iTgkeGsKUHBd/3N6w5x9RLYGjrNGMGMj+nG5jFuxQ9Scxe4pSLhmKR01ZiTY3OkHOdlEc/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304435; c=relaxed/simple;
	bh=O++GJbSeQHQASypDRNP9jRsSp7GFevNaune0N4k1nKw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtOE94NfvXWPhOvqv80rFP2gNeeJFaDpMLES3P/vgcqu59p7UXb2EXlUvbOdCbdigEcA7OnQzfG5eJbdbdrfwTCeqN7PUl6vJS9NAB/XlOHlD2u8iJrV4qvlyuj9oWcWyR3O4Tms+ksxuLgcXuHq9pZcPz/W0aKMS39WovT9Q/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4uIaMKL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4uIaMKL"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3001490ba93so13704641fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Dec 2024 01:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733304432; x=1733909232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ml1ls/MrhNDo+5osRrN12kXbY6/phX5vQl9sdxxG/U=;
        b=a4uIaMKLh3U9Q0WbKUO0ADgObeL3RP57Sat/zA9BgyvPuTUVA/kHUyJ3QEUwL70OCL
         erud9weg047JXkzFX/7npQLrN37cHCq2c9ZK3UtGuXggSVcQGPYIytEVI1jqx8KhRG9C
         QJ+JkyLfH+K0qJ9+BsX/6CbF7Fg2wuh327JonoT6LLBkOADV5wJVbfYPVtAsDSTxRYLO
         8zi8siz4Pjq5PqUvb1YdESrzCAoQSs0QIkZpQWjZchtec6R5GedWzb55rv6zLmsS84CQ
         eP47JE9Rcp4S4FwPKLXWqjAZMpVMeVkSMbRAku8CzOiCVXhjblg8zlIaDyYsgvTdtRFY
         9UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304432; x=1733909232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ml1ls/MrhNDo+5osRrN12kXbY6/phX5vQl9sdxxG/U=;
        b=DnrKP8raGMdtcigaCdfIMmiungqVHVDE8ZLMUcsm98u87HMM6k0n+ILzTU6PuVY4UM
         QNgUa2NnnOmqUauEsZyd078ud5513jMcAm4wGVYtH7rXovlm1ssoQHQvfxMpbbXms5lu
         W95rFv/99BO3saGNTfTjN7LqhRP0qyc5Y+e7fqi0Wtny18y51Ai/ZOxaJVCAdSiIqaAh
         UpZJvmCxydI892vq/Oh3QV9qcJYQFH2IF/Wbw/ShvYxheJMYW3f9y0CcWwiaqSxRESPq
         o3zxQ584521nwFwQhZFaTxep5RfBNm5Ju97gjGpYkdju/24sjJmm2zwJLE5kT2EC9y9Y
         OtkA==
X-Forwarded-Encrypted: i=1; AJvYcCV7A29wcjjo+6loVQtC3hP4GcdCuSqIq31gAeUlYN3K0Cc/FL1OOBP/G7blsNixPPt47Coqo1bWyMJyIW4Bj18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sp9TVPVrnL7EUKutyQwZpjHFp5AMCAeJxDEDnR/ZBX/wrO/h
	JIIAcmGbJUivkOSk53II6aZ8zctsrcZ1HVJUIs6XaWDCiPCAXFV2pq0P7Q==
X-Gm-Gg: ASbGncvVquRJSZNYLstkJjeIZ/meMNCTT3gxIFbH83EYtyf2kFnJBxA2n9dVqk4S6ay
	1SzZ5Fi4xc11Dckr2TSBEWzEBnUnCEw36gV7i1sNtqg+b7VboEDmZK7NedcebROUv6cHf8NXs0s
	OF4kXt0iaBJilBB7Dgo0ANpeGR0kRWygLaDWR7gVOx+FFGhR1/x353YelncUGiQ8dwPz9NsGdgN
	I9PhvyyCEQkXTnIGvUx9CiBMdlB2fKX19j4P4/YNBaz6l2Z5ozq2CAS5+Qk4/2Rsi9Kpy+TRLE=
X-Google-Smtp-Source: AGHT+IGEYBPT4CPBBScvI7Hvfw3wgypnZqJNUkDSqk8TCWcEtO7ok66Mdz3QArzJWK/aol4cYFov9w==
X-Received: by 2002:a2e:be09:0:b0:2fb:382e:410f with SMTP id 38308e7fff4ca-30009d084a0mr29273841fa.26.1733304431877;
        Wed, 04 Dec 2024 01:27:11 -0800 (PST)
Received: from pc636 (host-95-203-13-87.mobileonline.telia.com. [95.203.13.87])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-300110d4800sm3962711fa.83.2024.12.04.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:27:11 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 4 Dec 2024 10:27:09 +0100
To: zuoze <zuoze1@huawei.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, gustavoars@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z1AgbXQVjekn8PWU@pc636>
References: <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
 <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
 <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com>
 <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan>
 <Z09icnP7QuaLg4Qv@casper.infradead.org>
 <Z1ALDmybeJfpIqge@pc636>
 <2dae287b-c645-3773-4f99-fd44902ae589@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dae287b-c645-3773-4f99-fd44902ae589@huawei.com>

On Wed, Dec 04, 2024 at 05:21:12PM +0800, zuoze wrote:
> 
> 
> 在 2024/12/4 15:55, Uladzislau Rezki 写道:
> > On Tue, Dec 03, 2024 at 07:56:34PM +0000, Matthew Wilcox wrote:
> > > On Tue, Dec 03, 2024 at 08:02:26PM +0100, Uladzislau Rezki wrote:
> > > 
> > > I think there are a few other things we can try here.
> > > 
> > > First, if the copy is small (and I still don't have an answer to that
> > > ...), we can skip the vmalloc lookup if the copy doesn't cross a page
> > > boundary.
> > > 
> > > Second, we could try storing this in a maple tree rather than an rbtree.
> > > That gives us RCU protected lookups rather than under a spinlock.
> > > 
> > > It might even be worth going to a rwlock first, in case the problem is
> > > that there's severe lock contention.
> > > 
> > > But I've asked for data on spinlock contention and not received an
> > > answer on that either, so I don't know what to suggest.
> > > 
> > I think, it is not about contention. It is about the extra "attached
> > load" when a data is heavily copied force and back. On each copy path
> > you need to do a scan. Maple tree is not that something can help here :)
> > 
> > Indeed, no contention data. Zuoze, please share this if you can.
> 
> We have enabled perf lock contention and are currently debugging the
> environment. We will share the results as soon as we have them.
> 
Sounds good and thank you for helping to improve this :)

--
Uladzislau Rezki
