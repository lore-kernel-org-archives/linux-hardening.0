Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC01BC58
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138112; cv=none; b=ZmzhQQGM/4t0zwo5PPMnswGYOO2MbvNkjjpzQQGHa405HpNZa+hBsLcp/I/6Ttqhl/X8JkziqI+pXftBTv0hNqfFbovUqDS0jH4nZqbfmLZIyAFon5OIVOyvVABL4BPBmibcXCqFpGwAU115ntErdKYThrg82nwSRff6CIA5f8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138112; c=relaxed/simple;
	bh=u7/FoYb551+6GiEJx2PLVrRRol56CFg9Lgrs6ZHrVGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXp+Ofa9vjzDvNOamr/FmX+f/7KUwUitEnbRF0KW3ObVg5eoNZrJ2NdYp+KzzFPYSOZNXRol4BhpNykMRxKVe8mNIFI7kr3xCI2o0bHxSM4vrEtJiWg0b3+9vxeftCL/1EtPUncknXhdmqRVsfUtGlt+OxhxzBHL0G0YS9EXcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SDZwewWG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDZwewWG"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8df34835aso2075485a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707138111; x=1707742911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57ai5j/KdXT8Xuudktal72yNjlF1/d5qdT3nTQk3sYc=;
        b=SDZwewWG+NQIkeC5kHbN5QjrbnCn0YhohNSrRHvUdrvUD2rXWHN9iCXStKdAlJhZ1c
         N5420yjHUEONYx6VhZlcw7WaXz5yDR6kASxcYEbi86RxdjEA9Zi6dfvtsx17aFCkwfxH
         ddvWU7cT9PGayuRtYsLJHGvCJXjwsROm9OB6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138111; x=1707742911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57ai5j/KdXT8Xuudktal72yNjlF1/d5qdT3nTQk3sYc=;
        b=Ka55YXVUIYm632keNwoSihyMUVqH3KuEVrklrJY6saH/PpR4qDFdfjamPiAw6+DYye
         E8wbPTnd94HJvZjJuH9wrR38MdgLW+7q6t9cQ2C9wmIQg9xKQzMdtd8w5VAARPfzMayD
         dXDLgYdVdP5KKMFc83drbEttkF/6TE56Kihg43IK0r9YZODqL4eipOy98DKmMMboJDyW
         QVl+yXLHUjhdjhZC0oYoq8BAdajcevYzavDTjNDN6zvfI5JipRKH0G7JUL8pWNRW9pYE
         BPWTdvDKNWD7YXjKuhzU6QlDFzws2y3vlNvmelxn8BOVd38VyHmapuBGG4/TiXcjDr3I
         Rb8w==
X-Gm-Message-State: AOJu0Yw3Q/zNqyXXHH4Tkwyd+8R+Lr5uvBenDiCVaGHJt9yisXsSvqYo
	LaCvvJTffthVsksfz/LkM/edoe6eyXCKMmZd7h0/J5iQb5t4WlSA7d3qzX+hTw==
X-Google-Smtp-Source: AGHT+IFe46ojQoH2YselLfpT2gtd5+tRvTVNZVqNDtKHKqs4ZRDAvyBfalg9/6eSbk6JPFFd2KNgDg==
X-Received: by 2002:a05:6a21:339d:b0:19c:9c76:e9b2 with SMTP id yy29-20020a056a21339d00b0019c9c76e9b2mr8360893pzb.13.1707138110568;
        Mon, 05 Feb 2024 05:01:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtUWfFSyD5FOGxTMeDCC5sR5gUOAGgcddh8KV/jODNhPn5ACeCKZ3SkqqhVQVpNQraBpC/C1/0tXH2vZKCoyMeSgRjv8RKjZSYXvIGngozhzeSa/rU+CFomNmjTNw8z/lWkx5sC7C8VFqoseDjplggWGRcH7U0J54E28KmSIsCwLP/K6HmevdIjmnwQHT47IHbtlkFVatwH/c18MX95YHvZUWmhxR56RksDd0/ZQfPKkxxPz3sH6mexzOyY+H3hVeuwDE5yeC5Af1o86/PZytEPQ60NHI480KqDdZHH2SaGg1gF3HsPGBqN6dVTRipIvNLrDeCqiK27uPMD7wkobpvF/jZMInY1YW2+2Sir81+QAu2Z6A7VRbZh31vBe2u9NlcWFbRmHdrrqI+aywr5Ca49yqEXBLEjPEis65uNn1MR6zraDeR3OceSvEwQzxRqdoyAt/+OTUDeZu69MrtUNLv
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o133-20020a62cd8b000000b006e033804fa8sm3691905pfg.101.2024.02.05.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:01:50 -0800 (PST)
Date: Mon, 5 Feb 2024 05:01:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 2/4] string: Allow 2-argument strscpy()
Message-ID: <202402050459.892907C59C@keescook>
References: <20240205122916.it.909-kees@kernel.org>
 <20240205123525.1379299-2-keescook@chromium.org>
 <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>

On Mon, Feb 05, 2024 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
> > +/*
> > + * The 2 argument style can only be used when dst is an array with a
> > + * known size.
> > + */
> > +#define __strscpy0(dst, src, ...)      \
> > +       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> > +#define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
> 
> (dst), (src), (size) etc.

I normally don't do this when macro args are being expanded into
function arguments. I've only done it for when macro args are used in
expressions. Am I missing a side-effect here, or is this more about
stylistic consistency?

-- 
Kees Cook
