Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881812;
	b=GHlOg+s2qpGvu7fOgzNhwbVFnBAqtyIkJFwSvtRisuQmW3LjGjAW5HGQ358hzkzF7LlB
	 v++9vqx3n7R4CjDjNN2Rd9sWoKdVGhRSE4aBIi9/+RaXDcS3nUl+stE05FdhTatXqhou3
	 d10J6lDJxTWfBeYH6t+oXqArwYPh1zu0ooewRhDyYH0u1h3tR1HsTnN/o0czHReJ9fd23
	 BcGN/rj4Eo036LByyxQSyw5TLYyfQjyHmkoje+dRnH1Q2IaWHWBB7HSPj0KWrXq5ckyiN
	 1bQbXzClB5/d2ASD4m+L17tg2U+nIDuIyi4lLWVy8Em4/VSh+RyoeLROudG54cFYrsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881812;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cIWk54h6Vq4bsOr7750uEgxbFnfqnwYUM+V3ysYbmaU=;
	b=Qqe+D/lt3M8684Yay+9LTK+yHW6AgwQIZ3g1yO0g21+7/dWZ0U7ZHcm1/gV/858c+Aqu
	 YYCN51oiGY2aGWvTgCxl6Q3urfvGjdimK21Mxmwiz+4zQwK7hnO46hpcQRN5nuM8slp2P
	 0uzlCbwAzvgJgOd9aDR44oKkU44/i/5YOWTmgNK9tPp5Nv4g9z/PwAUq+dsmJCwG8Z/r1
	 jvqG0KtjhiVxRixnzfBypDmTpvT4rYn8py6SQOFVV8kKA6BA6JsAZTpW1lx9rvJb4lztv
	 DGiFP8uhOEa5g+cJUC4KH09CsjBX396jZ6kcp8h6l31auKNDX4sKKjs/ZuVPrYduC3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/GX2LJp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 44CCA606A328;
	Thu,  5 Nov 2026 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/GX2LJp
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A5AF11F00919;
	Thu,  5 Nov 2026 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881811;
	bh=cIWk54h6Vq4bsOr7750uEgxbFnfqnwYUM+V3ysYbmaU=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=K/GX2LJpW2XXldwtDKRUXjgoB4hbdX5MSA8/4PscwxkFT5zrCO7k4J8ROPcK4yiTF
	 fr9fk4NUxfKEMEwuRqeqHHT6KB0xfLHLyH6Dx1r0zafOnac2SEltgykvM8ZWOmBLSW
	 axYhLu6o2RC/85RWVPZTNcvrd2YPqkaNxljC7yJ6jC0Q9fNiTOtZRwRySVMgY2n0Jk
	 Zn8g9zCvTJkP/3+BIXj27F7px9h2fPU1YyxaPqQyO4TRdebIN3/cDSCL8G2szfsqqD
	 N7iUHyV1shT41krE0gmLba9GkC/HmMTh07SsGy5o3x/ZxCILoiJJwFV1bQdrdyrYSu
	 bwkqA0Bk4HlRQ==
Date: Thu, 5 Nov 2026 13:30:08 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, alx+linux-hardening@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
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
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <i6htkk2ggfh5fdgooihazeaqlnx25seyb3y77qyvldu2efj4ud@4dgvnv2xpbl2>
References: <cover.1793876837.git.alx@kernel.org>
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
In-Reply-To: <cover.1793876837.git.alx@kernel.org>

On Thu, Nov 05, 2026 at 12:12:55PM +0100, Alejandro Colomar wrote:
> Hi!
> 
> str_has_prefix() is based on sizes and lengths, which means it must
> overload the valid length 0 to mean not found.  This is a typical
> consequence of choosing to design an API around sizes and lengths, and
> vanishes when moving to pointer-based similar APIs.
> 
> This patch set adds strprefix(), deprecates str_has_prefix(), and uses
> strprefix() in one place to fix a bug reported by Bartosz.
> 
> We can later work on replacing the other uses of str_has_prefix(), which
> might hide similar bugs.
>

Thanks. As Andy said, we'd need kunit tests for that. I can also fold it
into my series that actually triggered the problem if you like.

Bart
