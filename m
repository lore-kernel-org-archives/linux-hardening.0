Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685425;
	b=gYm3ozy+ATtlVoY56jqCrT0Y2I+XRa4e7sBUEhik/hh+J/pN7WvpI1HAGMVSZI4xEvIm
	 7nyilMBDXnlI9mctBJk1oO44phkGatBiAfY7euGC6E6qSo2fJEmJ9/9T+6/Il45RwUc9P
	 JtGOaDErxA5QHZKHjOjf/FpLSWefIm6q8hGI4QaX3KQQa8hECZGMywGA5RbWyhJoyUusp
	 5mRWeZXsPdzO64K5CK8BoF0rhO8WvAUynB+PfHzJthMTD/DmTEE4DIESgFo+D38RbEOn1
	 QPVV4+dYLJCVSPGOaoYnsBXmjFvBPJbibOsxNCZSnKJcWFKCOauLbzfvlkoqR1J+zvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685425;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kotwyQc2jcDdK+BTFlZbgeNN1vaq7rV/ZDbWHVu5Fag=;
	b=jXeR5yKoUjsw+HZkL8GPV42Vn9XLGplIZHs3a30ez7T391AEQC0ESuXTaKCJf5KhZmsb
	 q1wDbywFTL781tmQ7hbbMN88f222OaCXokZJUvaw9+f0Wb7z3j/ydoz87WELRcAOvMgWi
	 pwpMQhzOvvm5haGAl9B3z+nnH90GuQQzRnj9wBALpbJo2LqzVx7li4zyxqxOVxEcVJJwr
	 oVNf1eMMOCqOD9cuTSnYUIGPnt0e4TENk5r0z562EVKDaRlukB4gfShVLApSFV0yn87jm
	 9aVKV1gLsdzm7K+WXMm/7BQYPsb+gui8BdmECk2N5m6XUJ3xKvzJ9DlaD5VeEB1d/lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PCtBEo/A";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BCBFD606A31C;
	Thu, 26 Nov 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCtBEo/A
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 643071F000C0;
	Thu, 26 Nov 2026 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795685425;
	bh=kotwyQc2jcDdK+BTFlZbgeNN1vaq7rV/ZDbWHVu5Fag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PCtBEo/AvFgKdjDhF8NXPkerpPNSpSRTCEeXi5tKqD0QKtG1JsFqB/VRP8cxFvAXI
	 2BNuVRHUAoLsjf476S4RHePZsuCjrxQMWWwhIxEG2tAe+wgNZ8bdxi4iLRgn/a8+kw
	 +FMEvOnRqlXrlvr/vfyYwE/XjVQTAwr5JlLe1DC/o/NWs6COvDVyvi06o/s4gzoxy4
	 +67QQq2h09LEozQ23FwLPFdGxu2IHdcmdNXcYEdnGRhrWzmEgPV/WL2ZKDzBcVfK/c
	 dYPDCz/pnp2RaaJMO6DiboiLdSpCWgrhhR2xHatLH1xb92b40Vk8POlSxlCQcLN04i
	 kblHbWZGx5N0g==
Date: Thu, 26 Nov 2026 10:30:18 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org
Subject: Re: [PATCH v7 0/4] Add strprefix() and fix a bug with it
Message-ID: <26rgsv2owszdciqb3z4smt43dynfgj2h7mtlcnizl4glqtjkpx@wd4mksmndguh>
References: <cover.1795639368.git.alx@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795639368.git.alx@kernel.org>

On Wed, Nov 25, 2026 at 10:03:21PM +0100, Alejandro Colomar wrote:
> 
> Hi!
> 
> str_has_prefix() is based on sizes and lengths, which means it must
> overload the valid length 0 to mean not found.  This is a typical
> consequence of choosing to design an API around sizes and lengths, and
> vanishes when moving to pointer-based similar APIs.
> 
> According to its author (Steven R.), str_has_prefix() was never meant to
> accept an empty prefix, but that's not documented, and there's no
> obvious reason why that would be acceptable for a generic string
> function (as opposed to a function very specific to its original use).
> Anyway, as suggested by Steven, I've added a WARN_ON_ONCE() to catch
> such uses, and also added documentation stating this limitation.
> 
> If the function had been named something like strprefix_len(), that
> design would have made sense, but being called str_has_prefix(), the
> obvious way to call it will result in bugs, because the name contradicts
> its intended use.
> 
> Users of strings need a function whose behavior extends naturally to the
> empty string, and we can do better, by returning a pointer.  And indeed,
> users have ended up using str_has_prefix() with empty prefix, expecting
> it to work (as is natural of a generic string API with that name).
> 
> This patch set adds strprefix(), and uses strprefix() in one place to
> fix a bug reported by Bartosz.
> 

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
