Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4192BFC60
	for <linux-hardening@vger.kernel.org>; Fri,  3 Apr 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204615; cv=none; b=t1XZ+q+amt0n9M5a+ku+GQ+0WeTAqNr5eL5rJjDBLSpTyEBxZV0MRS+cGlfedTOJGfd3EwioAc9XFSuX4i+HZG6Jd49/cEGrDqUJnfHimR4ycHH6axrOtPX93+ys+ewcJiMUum7cuUGdZ8jlhj++LOKwhUJv8VoDKSVmweYqQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204615; c=relaxed/simple;
	bh=+9CZK+gYzdke0WanUIsRXs+ijCNvWG8v6vSqD5cwkZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZAV/w1WZSAKMD4aCjQHG/4ojT6bl9A1KfYwVKS9L5CXqztf9LpfjAfDWhYoti5LRKbOPr4J5OjlBj2VFZ5jPbmrq4EzLtERSh1GKhk0em76+jxIYG9x1DzbsVe6SqiDGUkYYY+/NDRapjmNJyOqnW7Uwo9i8Tdl7p355vzIq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYmlNsIo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYmlNsIo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso14802255e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 Apr 2026 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775204613; x=1775809413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnwWJRlzvo+TcqTX7rjkQ/PhcRI0dDJhSQ3DGzMwyDA=;
        b=iYmlNsIoGpMWIF3q/zt2yvKv6u7Znet0fJ+GQmSFwLrbHBM0935UNmKFY244eCXY7A
         XiSxUz9jZA4v0cnGK7kT8Kt4WUtr/MVwMuMCP8wSa0vcmkmzmu0vr9t9O8C0r9XC6g2n
         NFdrLkrcFnS+iTgXVSWJPxya+bfN+T+QxqvklCeeDOTIvRt5o6e0kDVsA6XLjMIIreU4
         hy++VrWv664xJZDeChpkQDCjiY58KxCtdSF2Q/vHv58aSKWCjlraN4LHaRoktE5u7yw1
         6t+NRmp6hzFgVqAudNAsnYZk+LpRpOqFmNk97fQR50smO5UuNAc+B4JDJs4RzyyfpyCf
         /PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775204613; x=1775809413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnwWJRlzvo+TcqTX7rjkQ/PhcRI0dDJhSQ3DGzMwyDA=;
        b=fPwl+ZEatNhr6rG7aUx2FGhSfVSNb4N4AcrebtSuKUIy1T2mFqYz4TgLj3ijIGu/yT
         bEqXE1dkYOcNMY2N8qxXrNDoXaFT+npIE2pml/FK6GD5YUzFGXEkGjyxa2akd3ZVrpTR
         /NiVQHEhhUR6sKsrTdzatb5CKrC6avryyxEcrFiZHpxWjtkvHPb2SvGZH3vXmk08/v17
         XGEnrbUi857g9kdmrzApxg/29D0PL2uDZHiD9MTqQ9lYw/SPOSQKEswX7I7C8uytSe9J
         l74rk4o3GkU9C4zFmamawQyNJfW2rpOseGGLLOdyRA2/nfjn2i2qHpe8NRN8UJBzlXzV
         rZhg==
X-Forwarded-Encrypted: i=1; AJvYcCX1k/UqLUVC8v6fk8aL9ymQ4+BK58ZLFR0RsHt7c96q6er+nasI7qWlWir/Oam2PWRVPsuOdNAAyuTAvfMCpJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDaedSWjwnW/QSKFJZGYVVLuZ9rAGVB3s+aRqngF2r9Uccz/Nj
	oq3aU1wXrbwp5dM7rg709Qkf2OUm9rBDQNJTS0dI8RnvRgn8/p/V1oMh
X-Gm-Gg: ATEYQzwvyVdHBV7hAFcNEkjAMuamJyNRvL+JzrTfsbcYxFFKG5SkG4t1ZPdasjoBtXb
	r93Eq8Zvt70z/61uvukMRMeoBKAdZMw36hheHR2O15sjvtfxlBeOvyDt/3ILRysvoeeXcf/FV7L
	RibktaR2BIr+g/C9egAMIxiZtVqfkwwXKChwL8SLE4sAMI6+0/GUAUCp8HZDkA6AOMyDoJd5fIv
	0VYa7c5S9y7+mzrW99g6hU9ZgzPWiWX7euz5jIuT0Reg/VhGH93Ca4zkMe/l2Hecw7yRwgAEJl8
	Kuo5ZL/BMC2UJvn3d7/0KlQJiKhwQ+coubcU0CuQkgZuXy6VNGzVJwchyePBichUIJCwvUj4h9g
	Ltk2jifxfGbXfa/rTveesRqokveTHk0M/AzLnO7S0DHFnwF6IYhppiRmwE6C3r8tKiN7Q0vmQ3J
	tRHEvbciYBhWMeCLxmcS909DQJrJZQlZQui4FUhJR7EaWxb+ak0xzg+tMon2BC
X-Received: by 2002:a05:600c:1d1d:b0:488:7ebd:78 with SMTP id 5b1f17b1804b1-4889977cbb7mr32423555e9.14.1775204612546;
        Fri, 03 Apr 2026 01:23:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm327110915e9.3.2026.04.03.01.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:23:32 -0700 (PDT)
Date: Fri, 3 Apr 2026 09:23:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <20260403092330.0382a39e@pumpkin>
In-Reply-To: <202604010835.IWCsUV7z-lkp@intel.com>
References: <20260330132003.3379-3-david.laight.linux@gmail.com>
	<202604010835.IWCsUV7z-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 08:15:22 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20260327]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/fortify-replace-__compiletime_lessthan-with-statically_true/20260331-041123
> base:   next-20260327
> patch link:    https://lore.kernel.org/r/20260330132003.3379-3-david.laight.linux%40gmail.com
> patch subject: [PATCH next 2/3] fortify: Optimise strnlen()
> config: x86_64-buildonly-randconfig-001-20260331 (https://download.01.org/0day-ci/archive/20260401/202604010835.IWCsUV7z-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010835.IWCsUV7z-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604010835.IWCsUV7z-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: __fortify_undefined  
>    >>> referenced by fortify-string.h:290 (include/linux/fortify-string.h:290)
>    >>>               vmlinux.o:(parse_early_param)
>    >>> referenced by fortify-string.h:218 (include/linux/fortify-string.h:218)
>    >>>               vmlinux.o:(parse_early_param)
>    >>> referenced by fortify-string.h:290 (include/linux/fortify-string.h:290)
>    >>>               vmlinux.o:(setup_boot_config)
>    >>> referenced 2103 more times  
> 

I'm not sure how this can happen.
The references are all behind a __builtin_constant_p() check.
I haven't tested the actual config, but allmodconfig compiled for me
with clang 18.

	David
