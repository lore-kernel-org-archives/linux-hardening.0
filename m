Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB5657BE
	for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708209908; cv=none; b=JjF7iPW79DmO3ymCvBtje+oucSbtzfp2xZUtML3Pa+4eFjj4uHE4pPnNL8f1P/hbzZM/IG8W1qtanNwiHS8VeHLgQ0/ujZ+PsDeJVH7H6C1yyDmNJzxWGt98aq8F+ILZGJtqKm1aBhwHWvJDbXiBE2H5EKWpvIyNK366GsE9w+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708209908; c=relaxed/simple;
	bh=urM+nLCqAhqOanY4utAYiFvmTeBTP9vM1GuLdCAu7dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nom6Xy89Ht5owEMHrBIoEb30MuxC6F7FRnfrYPLz3g+zubI8ip9kxqplfLJKJjcqaE0DMAoPiTgfz765gHU9jqCqTaItudRR7dmwMfMga3RLlDF2qORqUlTPJCgy7TvT+bbUQUXkQ5utFjAbQ3wPYxU6Ft3kJnVL5esCjqi8KMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kzRoPuDU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kzRoPuDU"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1556368a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 14:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708209905; x=1708814705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zYveub7yYw/4yOK4qfAyNaSqjm09WW1iA3q80zNNrI=;
        b=kzRoPuDU1k7WdDDWHWFIgd4yz75FvLnn0aJYYAL3SndOZpcv77XLMTIQHNuPvOVqat
         7BW2yeWSAjm6YhG6dGfoN+Nvg3BpRWI50TU4gzN1WhHL9xk2ALAZZ+XWx2CEJGyT/XPS
         Aiu1M30MDTXYfHh2xiIWjTJnyBDOVUQLOqN1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708209905; x=1708814705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zYveub7yYw/4yOK4qfAyNaSqjm09WW1iA3q80zNNrI=;
        b=SXAsw6x2nzHJWnkoolnVRS3vOejVOSf+TCK3xiOElw1JUZyEMq9DWGAbr9yO5z7/iG
         N/jSXTLgDTK6TOITmtVQyjJ7yFPifoLwTlv1tiEhB+7pDEoQOvhQVUob4EaequDimpKj
         l3F+qnhLjgdnr6Pbe80VYIERJ9sdyF7G0NN8uFCvFH+V3sWn3uqzvCCQmZ51R8mgpggR
         tsc49rCzXAcAqWQRyeu0SPvI4ZXUP3km2/MFfzVMU5kakkGbsGDDtUrMeQc/BVgbOiFU
         6a/yuIz8yvAlhmAKkkVifeKP6xEJqI8urC6NhN1VlVi6NXwWInaruumEonjXmZcVI3di
         MZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVzISYPBxdPQ0c0bEQOEFpmml1wxVbz3Ia278616qkwLDJIg21Qf2y5+4DNzBIp06uym9J9jgPLt30YFdmcCpKOcsSBoR+azwAKiHZrw4jP
X-Gm-Message-State: AOJu0YzXmnSq8vn7t72HBjeSqmmOFf5w6kL7YC1E1fegocUon++2cR/B
	l2XL2erjV1wLq+qOJPK4YhzpC+tqQ75B0Zz7gNDNc3lDnWvws2upG2x4i7+OQg==
X-Google-Smtp-Source: AGHT+IGfBwCI/zJRAfkI3/3guXIHn5ScNJfsMg7yf6ZXenaRb2Xqpg5ydDYfgeE6X+Dq0UeBGs5IJw==
X-Received: by 2002:a05:6a20:9c97:b0:19e:bca3:213f with SMTP id mj23-20020a056a209c9700b0019ebca3213fmr11331029pzb.52.1708209905129;
        Sat, 17 Feb 2024 14:45:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a528300b002990d91d31dsm2270321pjh.15.2024.02.17.14.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 14:45:04 -0800 (PST)
Date: Sat, 17 Feb 2024 14:45:03 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Check return from set_memory_rox() and
 friends
Message-ID: <202402171444.C121486@keescook>
References: <63322c8e8454de9b240583de58cd730bc97bb789.1708165016.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63322c8e8454de9b240583de58cd730bc97bb789.1708165016.git.christophe.leroy@csgroup.eu>

On Sat, Feb 17, 2024 at 11:24:07AM +0100, Christophe Leroy wrote:
> arch_protect_bpf_trampoline() and alloc_new_pack() call
> set_memory_rox() which can fail, leading to unprotected memory.
> 
> Take into account return from set_memory_XX() functions and add
> __must_check flag to arch_protect_bpf_trampoline().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks for doing this! This seems to hit all the right error paths that
I can see.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
