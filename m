Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887291;
	b=2vGzIVcQmW4I5sZDxNV0NdjlApieNGttcLRZwgqqW5QcDsDkOtYLz1qHKmWL1roA6UfY
	 EYlqZL1lBZMgEFxA/+rT5tRl3hSdQCQ0sBjuxslQJMzPcl8Pb6YAGkCzSL5Oggi6vGCED
	 F//v85jGBQRp9qctaTO3ZC4oSK7nbld/OeMP0Z3ng+YFlwM8I7IURksFY/tr2/WFZdxTl
	 Zbop6gdOZxWYZXB8eIuOCqYItW/Yfy9MgF3DinkNKPun3QL9b98/Uq6mr90c/bvomPw3O
	 77ueqbrFs5DxTzfGvBb/WLMVVKwVI5HA2JHebt16iiOEOQm6vsgtCC7sNs/gx0gPRYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887291;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8DY4TUzp8evO7EYLufNjnQuf0+aROvdRw1EKq47FB+I=;
	b=gqczCKvRpSlqaaSxwIcvlE3QCYOoUKupTbsPE8VcWt2GIG8+nr/vPJNPQDsHMysWYxNR
	 W3XMnClD4GAAmK4UnlBsGKknw2wgfJ3m6omo1yohTlOgDXRPdLVKIGAK3fcBkqZRZe7UQ
	 1JpTuwt/KeqkRIzO9aZObqsn2lLKhZxdBvVW38AL6wvDgMgfa/a2RnHPj6565qTuy4eCa
	 zx3Ph6Vq7Yrd/lLejcOVZO0c088ga/6u8rXgak4hLUt6YoBv2kd64vNYmsmp/7I1/IgHe
	 yx2ju8aoYA34uunN7wRJQByEEAHdJSoSyMsL2OAvmIS/NQ5yFk7nCHAfekg1WYNABwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGPrdc1W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AB8C1606A31B;
	Thu,  5 Nov 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGPrdc1W
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0C5D61F0093A;
	Thu,  5 Nov 2026 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887290;
	bh=8DY4TUzp8evO7EYLufNjnQuf0+aROvdRw1EKq47FB+I=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=JGPrdc1WTvMbqA0T4cByajspeoIyncKLUDZ5AcTWZvTXcu1W1E5XUaOgcKHrTtzFG
	 drk9VKaH4SRjmwdoeRDLBGQJDQEPaT66XFi91Cjs7jLgTjPGHeb1DtzA7KnopSvzr5
	 H1WudlrX1WmyeQOP80DgpoALbTvrC7TLrW0zSEKt7P2lKy5Wor7kwzOgKQNjd7y3W3
	 z998Am3t77vTy7bnPVby2gqw8YMCasZhopSfP0GZgDLh/yFURRWApmUIZBz5F2eVuI
	 kCA+bnVxDuluxi8jpOrq9lsVW+t926uCPpY4vGHt+dxMmci2+YxMN2hWkOEZkt/vmh
	 z/NbHbC9HVLHA==
Date: Thu, 5 Nov 2026 15:01:22 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, alx+linux-hardening@kernel.org, 
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
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
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
In-Reply-To: <cover.1793882260.git.alx@kernel.org>

On Thu, Nov 05, 2026 at 01:46:20PM +0100, Alejandro Colomar wrote:
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

I have no idea what causes it but I'm getting so many patches lately
that are subsequent iterations of a series sent with In-Reply-To: header
pointing to a previous thread.

Don't do this. Each new iteration must be a separate thread. Please use
b4 to manage patch series.

Bart
