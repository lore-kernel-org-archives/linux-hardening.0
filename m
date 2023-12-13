Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RS3q3rzJ"
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D4799
	for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 16:39:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso762816366b.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 16:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702427990; x=1703032790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vbEQ0KJGdaL7UqnKRRl9MeOERVPcRtBuLGCRgVFRaFo=;
        b=RS3q3rzJCyhcnyzMr2m8Z4vXoplUUBN/ICrefzhXuaJp6FDaiOL/uTlKgewk5oEREv
         +4pQiXG+HKU9YWgngbBilth4FSldf+ONMNYie4PV7BVu0F2csyFrmIfhcHu5txYfhXp+
         NpxYk0WQbqCHHafh5YLSfjloQz0p07QlCh0Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702427990; x=1703032790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbEQ0KJGdaL7UqnKRRl9MeOERVPcRtBuLGCRgVFRaFo=;
        b=tZAAIjTWD4A3ZtfazVi14g3k3ogrktmy5Xoql6fbv6UG7sgVjCU0pc/JjkHXWAwIdO
         zJ3dRBHYOtpkwMhqXIAyXVax7d26ZrgqRXQBGjviD3HsvSO9b4GiinYIjz3DA2H/E709
         siV/roBZA3l5HJV8k3+aoHHp2zM5VzPbE8Y+ykuLhq8ZXTszc2bZwNwgEzCXZywvniZO
         ViDLrFgHspkK/koM5KX/oYZJdzw6Qnm23XjlnebNxDzVUJ4YCmehzl3+Qys011Lit0i/
         ohOLYxXeZyWNxGr0OXWpscvuoBt3w19FyeO7rgjjg/72KeBQJYaYuBPKQDv3B92rCdh3
         JiOQ==
X-Gm-Message-State: AOJu0Yz4v2YUmOODMeFo/Xgk4m2QaC4K5WuGiRe09HLOXS5qHFA64ZZe
	DvqqzBJTcOMOJpoazSmBbUHCNuxt2y/1qc80TgkJB+Ju
X-Google-Smtp-Source: AGHT+IFAT3n0vz48hNQeF/VeuQIZnt0bucZHCs9pxH9pExo7U9FKHtCdDRkH8X3/dI66GnbmBYgDsg==
X-Received: by 2002:a17:906:1742:b0:a1d:c2bc:9e4d with SMTP id d2-20020a170906174200b00a1dc2bc9e4dmr3417778eje.97.1702427989951;
        Tue, 12 Dec 2023 16:39:49 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id kv18-20020a17090778d200b00a1dfc541282sm6939213ejc.225.2023.12.12.16.39.48
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 16:39:48 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso762814266b.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 16:39:48 -0800 (PST)
X-Received: by 2002:a17:906:d8cd:b0:a19:a19b:78bb with SMTP id
 re13-20020a170906d8cd00b00a19a19b78bbmr3094683ejb.126.1702427988541; Tue, 12
 Dec 2023 16:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
In-Reply-To: <20231212231706.2680890-12-jeffxu@chromium.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Dec 2023 16:39:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
Message-ID: <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 15:17, <jeffxu@chromium.org> wrote:
> +
> +**types**: bit mask to specify the sealing types, they are:

I really want a real-life use-case for more than one bit of "don't modify".

IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is ok"?

Or when would you *ever* say "seal this area, but mprotect()" is ok.

IOW, I want to know why we don't just do the BSD immutable thing, and
why we need this multi-level sealing thing.

               Linus
