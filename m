Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D521A424
	for <linux-hardening@vger.kernel.org>; Wed,  7 May 2025 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619386; cv=none; b=pkfn0yp/GI8wDBl3Qjyhjnpgb6WBwznYNN1fepa/MWgoJ52e6f695HK6KX86ITxpzXvU1uV8BinG5xQnx6UZW2diZ2fF6WHTAUG2cXN77a+9OiKX+BmYGw/FsmlI/OkzVLYsmMlXnXfPk3wDdqz9AOtJLanxqzKiv1YtTH2PWvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619386; c=relaxed/simple;
	bh=RP5a2DXYCc4NkXftdYvHqTpKJQbNZ20V9GPvzZyBXLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrDnmPPFw2iUGtiOJzIFPHlbn1j61tpn5f1XRHW+IMJV5zcYFK/sTnVNAHT8fPGyFPq3qehqRencnZvVRJb22+bLUbDXmC6lWbwVdCNllH/Yosk245I8zGRC37drSaKnxgYP/2xAuX7xNad58138JFYgeDWXtNyUnFnFFAfWGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DIzxHI8e; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DIzxHI8e"
Date: Wed, 7 May 2025 14:02:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746619372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHpBgnMWGjdZKdQrg4rQ9wQFeDbCjxDr7o/BymUk+1Y=;
	b=DIzxHI8e+tNQs5EzOib3d/NvXOcIOCYvnv5u2uU6y2k2vJQ7QVKcw5MbVhMxdIr29E1/D0
	aKuDWXfz5kVpcquPcCsxUob8d4zaG+G9K2pt8xE40Lqmtf/uEXOtfbmCGNCsluP/iGxPtd
	TZt0a5EbRPl3pKVBDmfitITi2NVODcU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	kasan-dev@googlegroups.com, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/3] Detect changed compiler dependencies for full
 rebuild
Message-ID: <20250507-mature-idealistic-toad-59c15f@l-nschier-aarch64>
References: <20250503184001.make.594-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503184001.make.594-kees@kernel.org>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Sat, 03 May 2025, Kees Cook wrote:

>  v3: move to include/generated, add touch helper
>  v2: https://lore.kernel.org/lkml/20250502224512.it.706-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20250501193839.work.525-kees@kernel.org/
> 
> Hi,
> 
> This is my attempt to introduce dependencies that track the various
> compiler behaviors that may globally change the build that aren't
> represented by either compiler flags nor the compiler version
> (CC_VERSION_TEXT). Namely, this is to detect when the contents of a
> file the compiler uses changes. We have 3 such situations currently in
> the tree:
> 
> - If any of the GCC plugins change, we need to rebuild everything that
>   was built with them, as they may have changed their behavior and those
>   behaviors may need to be synchronized across all translation units.
>   (The most obvious of these is the randstruct GCC plugin, but is true
>   for most of them.)
> 
> - If the randstruct seed itself changes (whether for GCC plugins or
>   Clang), the entire tree needs to be rebuilt since the randomization of
>   structures may change between compilation units if not.
> 
> - If the integer-wrap-ignore.scl file for Clang's integer wrapping
>   sanitizer changes, a full rebuild is needed as the coverage for wrapping
>   types may have changed, once again cause behavior differences between
>   compilation units.

I am unsure if it is too much detail, but I'd like to see some of these 
infos in include/linux/compiler-version.h, too.

Kind regards,
Nicolas
