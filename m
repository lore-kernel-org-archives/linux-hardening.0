Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC112F58D
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594639; cv=none; b=DgSXywVXL8rYFS96KRMTD6VEA3gq+KBRg0lkqxkaCfhWgY+qVON/yZ4nx2JHXLbVP809LmiNAEKXKvd/BNXtVGydMnUpkMv0ebQOv7BwMCTpK/U3HYk3H+EL0G59CnRGRDw+Cc1GxBe8KTdG1VSns9nsqdz6uYTogb/sr1KLkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594639; c=relaxed/simple;
	bh=GGpAKEpoycwjSWcYUqnZv8ZhAZUkHxo5m5D9dqJxuNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chnG0q0b6A+bpXsoYhWiHQqR59i5NYbGD/kpwys9SiLHV01Zkc73h+q8caFV/mfBUeuXzc44P4hmUCdQdxeid96votaaEIfLugIMr9VFsP4mrDELLkT/mM/3bxiOj9AFPw1B5CZACIR6BgzQMvIjQ9Y/HnJFP2amZ81gAzMiIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jQgW0CgZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jQgW0CgZ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6effe9c852eso6405654b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714594636; x=1715199436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzZlykvaZE49hrAwdEmOhVJUm5xEaSWSbmXs/qt6Y88=;
        b=jQgW0CgZjKAOEc1i32X+GqrG9yW5MdlKY2k8Efxwz8nU+RLfUYZ5CXsF9mPSY/nz/P
         TjHq3AOx7LGAUILxHTHsBT+P9AhvIqMmLnHYQefRI1QvPuOn5+4+ESQPa0eUFQCEJ/Ur
         kRwqbnyPYATUVSO5wbd/dd3DiAwwSK02MyjOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594636; x=1715199436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzZlykvaZE49hrAwdEmOhVJUm5xEaSWSbmXs/qt6Y88=;
        b=JN457J9pimTl5Rp2g1FP3prfR17ITJ11SrGVQfkXIb0pePl+qE4cCEPfReoO7SVo4T
         Z7XUXFad5UP4DQp6+V6XG9DhkEy3/AWmcpjc1JaifVdHgigE+S5WUyOlXDcl4TTqFc0U
         q/ZxrgerGjK2tGWklqWkeX3uPjIstegiv9dyzhgzSFi6qLZid6cplmqljalraD+iSssd
         jsqTpn9KVdfsG568zVvyaLjmXCwSOYDbWQmvPnQMRUoNUjXyvOPNC3aXNHMQj4hsiMP6
         67gWeTcA7+auZWbfWploeICJe02KIUaWZAQ/P0F0xDa6KLXg8X6Ia5L5erapNRg4SHpZ
         WrAw==
X-Forwarded-Encrypted: i=1; AJvYcCXzx1I02UpZ0Ajy8CssLzVq4l2s5C8YnJCkkUyXZ4BgnOKu9RIl8qljl29pN04tdUfuh4yS4dBOmYQ4tWSwcZ5DCmaDlI6E6xeBEv2yk0H9
X-Gm-Message-State: AOJu0YwTqMHa5XtEUmt4xFETkpk4PLqQr8VXGYtY5L5vntNGGOkYwfrI
	iARBrnwDKh3QXaEIxHRyt0hPDu1klX3nYR+XLm4aCZl3WXprUGXLr21HbsvjLQ==
X-Google-Smtp-Source: AGHT+IGbzYi1d+ldsT9LN6hCvo5dwU6UWZPN8BaXQ/g+gSm91//aeds7KiSLXD8zvIV8i+uTgvZrTQ==
X-Received: by 2002:a05:6a21:6d82:b0:1ac:d96a:4fd6 with SMTP id wl2-20020a056a216d8200b001acd96a4fd6mr4640333pzb.23.1714594636355;
        Wed, 01 May 2024 13:17:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j19-20020aa783d3000000b006eaf3fd91a1sm23012143pfn.62.2024.05.01.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:17:16 -0700 (PDT)
Date: Wed, 1 May 2024 13:17:15 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: <202405011317.9896F210@keescook>
References: <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Wed, May 01, 2024 at 05:02:42PM +0200, Erick Archer wrote:
> The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
> trailing elements. Specifically, it uses an array of structures of type
> "batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
> declaring a flexible array [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions). In this case, it is important to note
> that the attribute used is specifically __counted_by_be since variable
> "num_vlan" is of type __be16.
> 
> The following change to the "batadv_tt_tvlv_ogm_handler_v1" function:
> 
> -	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
> -	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
> 
> +	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
> +						     + flex_size);
> 
> is intended to prevent the compiler from generating an "out-of-bounds"
> notification due to the __counted_by attribute. The compiler can do a
> pointer calculation using the vlan_data flexible array memory, or in
> other words, this may be calculated as an array offset, since it is the
> same as:
> 
>         &tt_data->vlan_data[num_vlan]
> 
> Therefore, we go past the end of the array. In other "multiple trailing
> flexible array" situations, this has been solved by addressing from the
> base pointer, since the compiler either knows the full allocation size
> or it knows nothing about it (this case, since it came from a "void *"
> function argument).
> 
> The order in which the structure batadv_tvlv_tt_data and the structure
> batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
> type error.
> 
> Also, avoid the open-coded arithmetic in memory allocator functions [2]
> using the "struct_size" macro and use the "flex_array_size" helper to
> clarify some calculations, when possible.
> 
> Moreover, the new structure member also allow us to avoid the open-coded
> arithmetic on pointers in some situations. Take advantage of this.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Thanks for the tweak!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
