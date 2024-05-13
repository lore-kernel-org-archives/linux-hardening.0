Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667F3C08A
	for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626627; cv=none; b=dJAPNBnRkYpgx/wq3gJS/Mec4eAVdzgXEGcXyLmoe3JB9nR3X1NPr2BakGuD60ZAVPPQ5ZcEJYfTLfzZhaIGd74dAvQU3jyhMTw7nPkbmaACJO1e5xdG3ij/yoI0M6O+d3W4sscqkVz0p7kNQVRVxf9eWFPTjlAnTdtyFRI/e70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626627; c=relaxed/simple;
	bh=q5wPdG/4nQ7huyx+fHjYRyb5vaRB6g0n6Fi2oJpjudg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbR2QR7EDWMcPTFRjWan5GEujOy2c7Gpk3tmInacOFTOuqGV2Gox0AJZMRQh7VltOu7LTzWkdSoB5uSTg6RGbkJD2zDgzfk8pBFAIXFtKXHBUnjFQU3rC6XO6KlQ5vl8+VEtvBDOkn0RnoHHg/3BgJr8jLEStUF1MnSthpsuCZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WH5YCYqI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WH5YCYqI"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so4242367b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715626625; x=1716231425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Sr9kb5P0bdJ6cwmhx72J5XTZqy5p16gtf0vFcQMPyY=;
        b=WH5YCYqIc8Jge3V/TDdAYdAP9FxsCdf0v/8mvIAgJkeEcji+qwKYD4Qk2p3wdKKANp
         Pvg/RJlUMxDO68KxfJL93NYkgY+GN3AwySDULVBqXtEK02qja+Bo/i0B6YUJ5zjiVihk
         MjMc+uUJl97mvLUsNNG4GO4ic3eFgFQ6wJhm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626625; x=1716231425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sr9kb5P0bdJ6cwmhx72J5XTZqy5p16gtf0vFcQMPyY=;
        b=LB1IXS+WRIje1BEwFeQb8Xytbh1VdUXvjr7DY+UIX9w1sJ2wPjGcaOhSvQovCdUyYk
         6lUM2Iy086uo2bOx3kMCdcwfR4EdZ+14EaQB6tugAQMTJd+dPdXMbXfvuk6XmQWN+smZ
         fZyvH4GIvCipfgsjk3FB6Giu5jUGLDXw5dnsthar0ZYUqTo0kxsG9tZ+7vpiCK35zmRZ
         kECLyOtmeFaFRFFK6bcpceQk8DWZcZR5VKICTEysF7dBs9BFSAZk365PsazUtteHmV+W
         CKlakIXkmFuasfHgLXja78OsL0+OmKw4GJkjxDJsFpU5yz4zaEEjfR84QkGteoLfn81I
         /tdg==
X-Forwarded-Encrypted: i=1; AJvYcCVBlm6VML+YRP7AtAH8OJwGDj5eJ+IGxLXh7m3jHLW/kts9AxmqCO6fMup5KPAEsAgO5JKZtzfvzb8GRkWT2AUdGbAlfQ2Has835IB6HEnl
X-Gm-Message-State: AOJu0YxOG9HxCsI6zn8lM4qzTCwcUxtw2AenoDLoJpx0L+i241iVeEO9
	xShUXjR49cIvZke6lApWHF9D/Y6zOWGa5770bW0u2nKj0WmUc/hxnOLznUnhcg==
X-Google-Smtp-Source: AGHT+IFZy10S65Q1vfaN/XWvg9gq6x4mClMImz+nVw5XGcRK6RvacpVEeTsgn5spmcSloAx5/jBJ3w==
X-Received: by 2002:a05:6a21:2b0a:b0:1af:cd4a:1e1d with SMTP id adf61e73a8af0-1afde1c554bmr8986093637.40.1715626625368;
        Mon, 13 May 2024 11:57:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a7asm84964695ad.140.2024.05.13.11.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:57:04 -0700 (PDT)
Date: Mon, 13 May 2024 11:57:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] net: prestera: Add flex arrays to some structs
Message-ID: <202405131154.BABC943C@keescook>
References: <AS8PR02MB7237E8469568A59795F1F0408BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237E8469568A59795F1F0408BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sun, May 12, 2024 at 06:10:27PM +0200, Erick Archer wrote:
> The "struct prestera_msg_vtcam_rule_add_req" uses a dynamically sized
> set of trailing elements. Specifically, it uses an array of structures
> of type "prestera_msg_acl_action actions_msg".
> 
> The "struct prestera_msg_flood_domain_ports_set_req" also uses a
> dynamically sized set of trailing elements. Specifically, it uses an
> array of structures of type "prestera_msg_acl_action actions_msg".
> 
> So, use the preferred way in the kernel declaring flexible arrays [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions). In this case, it is important to note
> that the attribute used is specifically __counted_by_le since the
> counters are of type __le32.
> 
> The logic does not need to change since the counters for the flexible
> arrays are asigned before any access to the arrays.
> 
> The order in which the structure prestera_msg_vtcam_rule_add_req and the
> structure prestera_msg_flood_domain_ports_set_req are defined must be
> changed to avoid incomplete type errors.
> 
> Also, avoid the open-coded arithmetic in memory allocator functions [2]
> using the "struct_size" macro.
> 
> Moreover, the new structure members also allow us to avoid the open-
> coded arithmetic on pointers. So, take advantage of this refactoring
> accordingly.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

This is a really nice cleanup. :) Fewer lines of code, more readable,
and protected by __counted_by!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
