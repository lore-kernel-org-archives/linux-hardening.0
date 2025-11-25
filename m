Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CE3002A6
	for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110505; cv=none; b=owd6JTZYl/V1Voxmh89+HVslurCuAE8Gpx30SO9cf/l/8vP71pi3eHHbDyJ/BMXN272UJ+ySF3uzZ1kny1OwjG049BbtpsrAT+no70CxMQi98tIBNIurpSwFMIXCXBfa96qRLjD7wcovKzkpSqR2ItomqWhQl4nAl8jYkQ2GYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110505; c=relaxed/simple;
	bh=jsL4T2UPDPxhD8xl6D8pYITWdOgOn16n1Vvm+6LuL64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3oLyyntSnXGh33y8QfcguC7bbQzB1x0aqO0a6MxAFmQSLkrXcOi+vjbNYsiQuFyetgtHp9HicricmjtJzTjNS6UzivSV+x9AS6Rkza4PHWTN2T+ORX+vYY67jYZK5vapo6UuviDsG7liR8PCNqCsP67fd9SaGKyhskW4CLYp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zxi53khp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zxi53khp"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b727f452fffso46465366b.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764110502; x=1764715302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PICSSTOVtSfieJ36Y7geN1Ip3ZesP7jblQQJyY8Iec8=;
        b=Zxi53khpN955CApQ6c1PR4I/If76l8fvMvT10BEVtikiTZpttKjVdvYai3iNchcb8M
         MkTnfC275W1AO/kadLUv+Sbvsuo2s6Ij9qSsyJzQHgmJ0Nwg54SCnHPDiE7PtpFPKb+M
         Eh6OGLLZKI3+QLIwebsKUkKFsOdVFUYOnMYEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764110502; x=1764715302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PICSSTOVtSfieJ36Y7geN1Ip3ZesP7jblQQJyY8Iec8=;
        b=nCNIU+LYk9vxgs1J5Z/LHkCixB+D6Q6GTFA4vlG1WMTPvq1gV3fNSUuyCKU3H0Z0+U
         Ua+wajx7RVybxuPB7jz2v+8DvAtnR4iXeLGP34FivEoWNnYQ4u3xG+rhJ2r5AyJ7geXS
         TWhA01GF+gS4shw+hvnj2GVWSRyaxMmdOEwAv0AescURAyC4q4EclfnUsAUCPiqYfzZW
         Ed+CXJCanF9ZlhmYtwRK0qIHiRUH2UzP4y3vKLMLnGxUC24tMS1f2Re2dB52Ok+dsRXM
         VhPD666HJ7nVGdDOTiptVhtxgc/w4Z+HzuXX19Ow0PvmLICXp/H5K67KLIyGQAdtcu6M
         Higg==
X-Forwarded-Encrypted: i=1; AJvYcCWopEEOt99vvLmYg85s4S1xksNMkYZDGWDU2zVk2TLBVcCju3i2JWyXanJgdoUJ0lcsAt8I5KdjxW6bTfLKwNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrSISJkuIdmHGVzeJkh3nqoUVF8+yw/4mQUDpvSgS3j69Mzsl
	OSvAdfCKXts+p2Ve+kxHDJ+kgVnltd+3nfppf01EdfC4jusmSVzWdnlodiva9kpCDETRwtILovB
	+MoFE4LU=
X-Gm-Gg: ASbGnctmrGMf616WkU6vpfAMO8BBazZkPWpuQDP5HFyIZeH+3mkiyLCfbCWecJZVKAI
	ZLKf1io1QjO8L7YPY04HmYmYBcWwT5CQai4KSgURq37dtjTHxjj2+v8dQktACro/E22tsA37cO9
	uHmGOcmFBueOCdpydhiwSU5AYQ7VWLHhul6KbtcznkBYcYVCktRmBv2QyTLeWq03JLS2tEgWNWh
	QuP8mMxX6EpRlLsMrJCXcQBSHuhFCv856QGocbyL7aTWiCTnGLe8WbeW+4BY/ud/YKrDbQt61Jn
	/odc4eWgKJ/NI/mjPOmuApxcmibQ01Yvnby+GT9hxTPeD5w9Wfmtug7W4DQ2HqZS4dcqmjZzeHe
	O9ucbkomnBCqFMamcE9GbeQuMAHj9Q3APSQds8e1IkxCp+gOXLpe/Dl/aC5m43SDregBsheiqel
	B/QB2l6qj1evNKf3UJ/9aj/xQKb+Nh75y1FI6/15V+qAcdrgSr2pywGa4PlrtB
X-Google-Smtp-Source: AGHT+IGllC9vc0jb5kXc3z9y5VSEvznNmk1rdzzMOyZKhqqZ6PuuTAP+iFfR93+tltOHhT0IIhWVQw==
X-Received: by 2002:a17:907:7f02:b0:b76:25fd:70e5 with SMTP id a640c23a62f3a-b7657172f39mr2348508666b.9.1764110501783;
        Tue, 25 Nov 2025 14:41:41 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5e97sm16191887a12.9.2025.11.25.14.41.38
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 14:41:40 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso470078a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 14:41:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjmb7PuRQ+KgzEEis69HEqoxPNOB75vPEn31ioLTCcPpUuhEDH2H7fMdANFM1kXmrqLGsFgMTxI/pCQNzpvvg=@vger.kernel.org
X-Received: by 2002:a17:906:d553:b0:b04:48b5:6ea5 with SMTP id
 a640c23a62f3a-b766ef1d27emr2056801766b.17.1764110497696; Tue, 25 Nov 2025
 14:41:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122014258.do.018-kees@kernel.org> <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <CAHk-=wjxj---dy5haOvNXjg_Xz-mDQciGL7OnJnpJpjYD9Moog@mail.gmail.com> <b7804333-6030-4bfd-8e0b-4479f87060ce@suse.cz>
In-Reply-To: <b7804333-6030-4bfd-8e0b-4479f87060ce@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Nov 2025 14:41:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6nqPAveRPjrH_=ombtpz00G--RH9_MyC38PzsDHcb0A@mail.gmail.com>
X-Gm-Features: AWmQ_bnHmATmDGg6MkJpXYuB1__YO7XbeBdtXEi7jxM1H4BelwLZXehOF1vhEBg
Message-ID: <CAHk-=wi6nqPAveRPjrH_=ombtpz00G--RH9_MyC38PzsDHcb0A@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 10:56, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> >     #define kmalloc_verify(type) \
> >         BUILD_BUG_ON_ZERO(__alignof__(type) > ARCH_KMALLOC_MINALIGN)
>
> So AFAIU this would be too pessimistic. I'm not sure if the alignment rules
> can be sensibly encoded in build time checks. Perhaps yes, in a similar way
> that we have compile-time size bucket selection via __kmalloc_index().

So I wouldn't worry about it over-much: it's actually pretty unusual
that we have any odd alignment rules for anything that we would
allocate with kmalloc.

And I don't think a 'kmalloc_obj()' case needs to necessarily *handle*
such unusual cases, I just want this to be *detected*.

IOW, what I worry about would be people who use the simple object
allocator mistakenly on auto-pilot.

So if it errors out about "you're trying to use the simple model for
an object that requires non-simple alignment", that is perfectly fine.
Those cases can - and do - use more specialized allocators.

Yes, yes, in a perfect world we'd just handle that case automatically,
but it really is fairly rare, so forcing people to then use some more
involved interface for those cases is maybe not optimal, but it's
perfectly ok.

              Linus
