Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019375;
	b=aw5CE1V0NMj6vPYbzNUWXbvO72LISJWzHuHDpiqZHTG2jcOWW3cL7CVwctzLg5yIM6Wj
	 6m2rlKXUYr95tL2zR4fv2yNGsV84cVDALQAJoI7JVJXzXtPfqAuQ9n092+RBGNxLwCxOE
	 Y/x4aA7+CId2DgDh186Oqkf38AAXDG33tmOhdgDuGJwzWKmmuq+/CvPOwUiiFR0uT0CZ2
	 PwmxcTzJ9vVE2EG21t+KN4O/hyq3+hfRroY+9KNl1EAl5kvuhB5GoTKQyw1FnK6/imaRz
	 i16epAAO9tjgNrMUtJvhQ6LXcK3pL6lhXZJG+tXhXpzl9EzDQKRKE/z/O1mShh+576w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019375;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=MffxbctNv2bCdVZsb9rc7DcML5n2OMFxNMjPQqh/vjQ=;
	b=pFhmV1lwWbSwO4ZmY59y7TKHJoEOBjHHW0hPgfWEigndu5wZcNEWD1EIkrtfGdrQg+BJ
	 tsItbwlOp3GKC9wxWKEa3mvtkNdK6O9U9wndkGOK8dupbVm+8vlNcpCO8tgd704/QuemP
	 2vCZtQNeS9iXYtc3i8yFqVotJ1huX1h76lG/v0OU/zB+S1a8mapn/uY9ubkDWggraKMX9
	 jvFgk8rkuJFi2Z8b+IO3RMif/M/vki2laabv0AuVO1akmTNIB83OK580gBhp1Y23RDGKZ
	 mtlPZwEX+l3WO0r4XgD9B2EBifIkrDTjgxFhvEXQiRt283AjDBCHrJ4RHIykwC9ETwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49671606A32D;
	Sat,  7 Nov 2026 02:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49671606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 133DF92009E; Sat,  7 Nov 2026 03:42:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0F88292009B;
	Sat,  7 Nov 2026 02:42:52 +0000 (GMT)
Date: Sat, 7 Nov 2026 02:42:51 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
    Bartosz Golaszewski <brgl@kernel.org>, Alejandro Colomar <alx@kernel.org>, 
    linux-hardening@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>, 
    Andy Shevchenko <andy@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
    Danilo Krummrich <dakr@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
    Kees Cook <kees@kernel.org>, 
    Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
    Len Brown <lenb@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
    Sakari Ailus <sakari.ailus@linux.intel.com>, 
    Saravana Kannan <saravanak@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, 
    linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
In-Reply-To: <auyV47xUCr1EJ7A3@ashevche-desk.local>
Message-ID: <alpine.DEB.2.21.2611070239050.17804@angie.orcam.me.uk>
References: <cover.1793876837.git.alx@kernel.org> <cover.1793882260.git.alx@kernel.org> <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb> <auyOkL1Vb1iKicS9@devuan> <auyV47xUCr1EJ7A3@ashevche-desk.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Nov 2026, Andy Shevchenko wrote:

> > But yeah, I can send them as separate threads, if that's the preference
> > here.
> 
> Yes, in Linux kernel majority of the maintainers (a bit of speculation,
> I haven't counted, but it feels like this to me) do want separate threads.

 Cf. Documentation/process/submitting-patches.rst, section "Explicit 
In-Reply-To headers".

  Maciej
