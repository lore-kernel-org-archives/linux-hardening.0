Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82F155753
	for <linux-hardening@vger.kernel.org>; Mon,  6 May 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010677; cv=none; b=qge4odQJPqVf/VBY6SDQlNRSPz+wSfBvf0qbGn7oh/U0bdKetLd8vPDL+CJTz1eLikREG2SdumMhgEkwtnOiXVJbrzYzu+S4zhRMsTSQT4o5eZ489LRPOpm0TCGsp29xEFXtVFlnORa5J/kdaa2JhEy/3zZS3OH9F4PIwzr8Mho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010677; c=relaxed/simple;
	bh=fmEi8zy2BYzKQV1pUEcAJYNE1lGiyqt68S/HH8iGNRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVwA8hdQICOFkvL3Le5vyhomribgjAdVztvBWIEt2p3AqS5F6d900NXdpylBFgxEJkSudWL4Bi8aZbz4zWpeb5iP37Di5qp8QloF4uenqGYCojWdkksrJgJipY95v0jX/MQX27DmlOdCbjoqQXAB/ZEq0+7cDPhmSfJQrjYdSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IPaGlfry; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IPaGlfry"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso2047835b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 06 May 2024 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715010675; x=1715615475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZT0SnIs/02MaTW5fVT9bWl8NEc4i33rHG9BmlMKJ30=;
        b=IPaGlfryY4sMe6LVrfg/j2Omt18j/Wq9+68aZQmqiK6585g7gtdcYfZLE+oaItT6EA
         z0Rc4BtW7P89j4dZ18sGgQXdP1LxhCzZb3BI9Eu9sN3Gvr4zpPx4AocYCucbZaSsiAPQ
         /WC9gs9PBqNais7yaaoxuFJsvhpTvWNzWLB+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010675; x=1715615475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZT0SnIs/02MaTW5fVT9bWl8NEc4i33rHG9BmlMKJ30=;
        b=tmiISsK0by91qUwqmhZ58oaWgPQ/WEoOPRQXsNo9Fz4kEd8gjTnApRkpG6iQ/9BjHA
         O1d1hVj/C5+akgB6NPONbTcBGx31gc1IB4L9GZ0jysoFzn/3iN6TAJvLfokg9hqkTjJM
         Zgm57CtZJ7OrodhJPLAPNKzL/ztJJwtOcJBQEnFwd72DTDBAcH/Ei/Bpt6kblh207RsS
         uRpK20fMMj/+H6oa+JXvVt1sFIKVA4xraiOLAt4AONApU4VEjD0Dts74qc2PwWp+XSre
         lzhd/yHpvgBurxxbh1IWRG2UpAoJLzI1CU41WOewDvGVo7qoFukcXLhpOwizXbUK/9ab
         /7vg==
X-Forwarded-Encrypted: i=1; AJvYcCUIqNJ/UaeePuj7OwSLNbN00Ikx4a4aNw5GlyD25+30e7UF02g2+V1jjijnx7P5WBuKjuv4PV0yqYCmqVUOz0rc6zZE145XsU/zmoTl0Cks
X-Gm-Message-State: AOJu0YxR9KYy+3+IJolZ/k59u3R9r3bl9NCIs7dE3qYFKhFpG0qh0lnw
	N2qxbs9bWOK9H/VaDkBweg1u3r/DUxaVJlFfvMIpB60nTZvDgdCgJSZnwNpFSOq7Ezs4uvliLXQ
	=
X-Google-Smtp-Source: AGHT+IEqWz6K1mwJRhCqCbBA0Av6HQv0svI8UuMxadH0lzdvFFlLmeBRo6SluuH2wnsaFOE8YXXukw==
X-Received: by 2002:a05:6a20:c704:b0:1af:8bc4:c7b6 with SMTP id hi4-20020a056a20c70400b001af8bc4c7b6mr10767852pzb.53.1715010674988;
        Mon, 06 May 2024 08:51:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f24-20020a056a000b1800b006ed0f719a5fsm7888759pfu.81.2024.05.06.08.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:51:14 -0700 (PDT)
Date: Mon, 6 May 2024 08:51:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Youling Tang <tangyouling@loongson.cn>,
	Jinyang He <hejinyang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] objtool: Provide origin hint for
 elf_init_reloc_text_sym() errors
Message-ID: <202405060831.089E820@keescook>
References: <20240430235106.work.680-kees@kernel.org>
 <20240504222402.p24zt6dc2zkyxqti@treble>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504222402.p24zt6dc2zkyxqti@treble>

On Sat, May 04, 2024 at 03:24:02PM -0700, Josh Poimboeuf wrote:
> On Tue, Apr 30, 2024 at 04:51:07PM -0700, Kees Cook wrote:
> > @@ -891,8 +892,8 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
> >  	int addend = insn_off;
> >  
> >  	if (!(insn_sec->sh.sh_flags & SHF_EXECINSTR)) {
> > -		WARN("bad call to %s() for data symbol %s",
> > -		     __func__, sym->name);
> > +		WARN("bad call to %s() for %s symbol %s",
> > +		     __func__, origin, sym->name);
> >  		return NULL;
> 
> Thanks for the patch.
> 
> That warning was already phrased pretty awkwardly which was probably
> part of the confusion.  It could be rephrased to make it a little
> clearer:
> 
> Something like:
> 
>   .cfi_sites: unexpected reference to non-executable symbol 'execute_location'
> 
> And ".cfi_sites" is already in 'sec->name', so you wouldn't need to add
> the new 'origin' arg.

What's so odd is that "execute_location" wasn't being reported at all.
Just ".rodata": 

vmlinux.o: warning: objtool: bad call to elf_init_reloc_text_sym() for data symbol .rodata

But yes, sec->name has what I want, so I can do this easily:

-               WARN("bad call to %s() for data symbol %s",
-                    __func__, sym->name);
+               WARN("bad call to %s() for %s symbol %s",
+                    __func__, sec->name, sym->name);

vmlinux.o: warning: objtool: bad call to elf_init_reloc_text_sym() for .cfi_sites symbol .rodata

I think the symbol is missing because this is coming from
create_cfi_sections()/elf_create_section_pair().

Regardless, I'll send a v2...

Thanks!

-- 
Kees Cook
