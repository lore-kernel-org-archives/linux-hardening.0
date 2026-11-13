Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561905;
	b=iJI4vlkZeLh302QtVSf38EE0eE8J8jiJO90buECaQ4vPxyeIOwlYDyOMIWV8et1ycZI2
	 jwspa9u/j+qKYOzyvraIcz+ZPezIy/JwVTYzHvdBJ7mJoGyFHPM/8D53BD5Zh5/NLx6ey
	 wIn3nF4Sigyu3UgngiX5LJI9+F2pT3SrrA4GPjiCjkhEsPuuDY8qVp5ou7Btxm+iOLuB4
	 zQPhj5XAGXCbubCDhqLghD0o52/qAiAtsmIoj/fda0xh6I8Y/toQHqaDLqqPxu0ymbxfy
	 5eELKelh+Uk8f+5Bdg3kzHDwpCgKnBGCa5C99ku4TQnZSaIY5u9slUskmEriwm0IPFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561905;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Y8PJU2qTkV5zoqq3Y06nfgKl3m4JKwY+ZbQmM98l8qk=;
	b=qIJp/Tmfc6c3R0nNuOFCqXDYHtCCw7OW8HmLZGrqgRIXbkfShhIkBgCpRDSpvbhEVbr2
	 YLpPAhqEHxVWChjevQqnP1W9xmXreKicAk57SzJkAvsUdfzo5kxDIil8uuhpXuUZ/Iz7a
	 3Sd9pcaI6iFdtTgHQoipsPHirAZCMoWIY6Z5Am4G0lziyYx9yr2sVpJ+cmwAggR1dG8dq
	 zJN+lXLlYZLAVxz9336wT/EZaAyrhhbwIx6/LZQZYVKbIR9NE4D26mO3JCqTxnhR9pkFN
	 8bw0SgYQomA8MPrQHwHghCqMep06uSaslPiRrQmB89400TMq+d7D4an1R1T70z0wlFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AQx/uk9B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 64CE5606A32D;
	Fri, 13 Nov 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQx/uk9B
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B9C311F000C4;
	Fri, 13 Nov 2026 09:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561904;
	bh=Y8PJU2qTkV5zoqq3Y06nfgKl3m4JKwY+ZbQmM98l8qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AQx/uk9BsCIfMYnd4xxCoB60iMUfPLzBeCEIYDE/+8QvCUZUM95ANZo0nNT5vgVzy
	 eNV+xpDniee1H7YpPAUmATBbLYBfyx/YRKlmVvcXlwef4rlg+zhPhpP5GGVC4FfRG8
	 RqigJs+zVQrtE6tYsBdhrrveKzXMjrz6YRKyAvFJC2Qy4D2vrhjRWeVwLnxe/5GdjK
	 I34gM427KiQiSIzu03rVpdr4FldvwcOORrAY5oZLnPN5i5DaW0Ni7OJufbif8oaxUe
	 QNkOPYGLn8kdnhBRxX9iffDR/fJWYw5qIyTsnSAvSqQZvq+8NqukKT7sgNyW/3WoEX
	 VQDTu4PFZMMTg==
Date: Fri, 13 Nov 2026 10:25:00 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <vjuf6ritphyrfi2befwf4pwrujrl3pmjjkutr2ccsvta3jjcep@5mpgr3dc7263>
References: <cover.1794425425.git.alx@kernel.org>
 <avTIWshl9klX0obF@devuan>
 <avXYmk5sZKS0rm92@ashevche-desk.local>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avXYmk5sZKS0rm92@ashevche-desk.local>

On Thu, Nov 12, 2026 at 05:17:46PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 11, 2026 at 08:57:30PM +0100, Alejandro Colomar wrote:
> 
> ...
> 
> > > Testing
> > > ~~~~~~~
> > > 
> > > I haven't changed the implementation of the function meaningfully, so
> > > haven't re-run tests.  Since the changes since v2 are only about type
> > > safety and diagnostics, I have built again with 'allmodconfig', just to
> > > make sure it still compiles.
> > 
> > Ouch!  It seems I had built before adding WARN_ON_ONCE(), not after.
> > I just saw a compiler error in a background terminal after hitting send.
> > 
> > 	$ make 
> > 	  DESCEND objtool
> > 	  CC      arch/x86/purgatory/sha256.o
> > 	In file included from ./include/crypto/sha2.h:10,
> > 			 from lib/crypto/sha256.c:13:
> > 	./include/linux/string.h: In function ‘str_has_prefix’:
> > 	./include/linux/string.h:619:9: error: implicit declaration of function ‘WARN_ON_ONCE’ [-Wimplicit-function-declaration]
> > 	  619 |         WARN_ON_ONCE(len == 0);
> > 	      |         ^~~~~~~~~~~~
> > 	make[4]: *** [arch/x86/purgatory/Makefile:12: arch/x86/purgatory/sha256.o] Error 1
> > 	make[3]: *** [scripts/Makefile.build:572: arch/x86/purgatory] Error 2
> > 	make[2]: *** [scripts/Makefile.build:572: arch/x86] Error 2
> > 	make[1]: *** [/srv/alx/src/linux/linux/master/Makefile:2244: .] Error 2
> > 	make: *** [Makefile:248: __sub-make] Error 2
> > 
> > Will fix that for v5, and fully test again.
> 
> Are you sure that it's okay to use asm/bug.h APIs in string.h?
> The include/linux/string.h along with the backed C implementations is really
> special in the kernel. Hint: check which stages of kernel boot use it.
>

Agreed. I'd just move the implementation into lib/string.c and not do a
static inline function here.

Bart
