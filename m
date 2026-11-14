Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680683;
	b=QNGCAzU3GNh6crZw6bS+jGZDK6GCJBko2RwZo/ljxhi/iziak34TviWaO2aUQV2D4c+5
	 z6fiUQBcSj/LbtrX6UAPXEgQGEpxbG8TBNyccBv/Ee2lYv5A3Z0KB8U0RJor7mbaj10dL
	 7xRDKbZlXgBbiU9X4aMzY7DZQv/eYio8BokJsvScEfa/ov7TVmAoc5SprsVtBjzwRifz4
	 E5bcl54F+ZBoi5TzpsM0UdA8Ht5u74EvS57t6gYdSHD1MqsYdgpL3Ud6/Xr5Wcb746nYF
	 qdNdDLgbfxioI1Bzjx/0Jle3VWIx/dzuZPluYqkPHq+sZBzgJs4nEGfVF+ZWgucxNbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680683;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=7Gq0B0cMHNXa81F7NCHx8crSmgQ/6THqEAXao/juk5w=;
	b=li/CByveF93NBTj8FmcM+dBLou9F10OeqoDixMfL1e6vVXk1qIPJUXp1kbrq2ki8SUaN
	 Lt2ghx94fgjtvrT8CFHnsrG9oKLDdSOiTcykHL+pXTh9R9zMKqbvgAplN/aolUIFcbejJ
	 9LQdvvKkfBI3YPn9Mllrc0rtIe4QymkxncCveCsNLOAKzCQ6ctSoMZB7YucXGlSvkxQ2j
	 y7Tnvrv2vbH0Dj1P7fUVeSm0v8Zsx9pqS+IhhlUSw/ohIT+QaDqjm+7u6TOoJofwCBuqK
	 E/xbdaIJgzaxW78kCu9qnbxD7IDpgUFCPooqnyPdg9CJaC1y3wZqbNUcfra2qO9zOQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364B606A323;
	Sat, 14 Nov 2026 18:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C364B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B12A180433;
	Sat, 14 Nov 2026 18:24:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id BD06320028;
	Sat, 14 Nov 2026 18:24:27 +0000 (UTC)
Message-ID: <32e7bdb5b8a4a522566b00763ba13974733290dd.camel@perches.com>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
From: Joe Perches <joe@perches.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski	 <krzk@kernel.org>, "Maciej W. Rozycki"
 <macro@orcam.me.uk>, Geert Uytterhoeven	 <geert@linux-m68k.org>, Andreas
 Schwab <schwab@linux-m68k.org>, Andy Shevchenko	 <andy@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Daniel Scally	 <djrscally@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold
 <johan@kernel.org>, Kees Cook <kees@kernel.org>,  Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus
 Torvalds	 <torvalds@linux-foundation.org>, Linus Walleij
 <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring	 <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan	 <saravanak@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi	 <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Bartosz Golaszewski	
 <bartosz.golaszewski@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 10:24:26 -0800
In-Reply-To: <aviOPo6bZ-WGsndf@devuan>
References: <cover.1794667407.git.alx@kernel.org>
	 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
	 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
	 <aviOPo6bZ-WGsndf@devuan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: BD06320028
X-Stat-Signature: uj3e8mwsshemj8ge6ddf4mc91ri8dw4z
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+e5dSH8m66FQr+sABQJ+LjiDgM+6JENCM=
X-HE-Tag: 1794680667-794125
X-HE-Meta: U2FsdGVkX1/wA9X5ufzvQY1fzLCkRYRaqUgra+6tgFYA68i3lgt6uVjn8g7QfwHoBGUIot+9Ev2Xvr4AKKpjWIgjM6L0KUQIa5y3q8a0q9FfMbcbrbI7rgsHROnPQtix9KjPQvp/bb6JC0Bdaq0bxLevuGFacXxUtH7wLleE7lRzhzJoYKyyxPsjqgmQr+ayJvTlb7hkXBGqBfzwKj1DteUoGxcDbJcJeruRgVHzS5vcQdtL18diKvZaqTMJpj9F8o7L5oc90XlRmOHIyH51lymo9J9MIi8vtcoJIL1p2J3+6xoW8Ui+Dz6Q7+Ijsp9b

On Sat, 2026-11-14 at 17:59 +0100, Alejandro Colomar wrote:
> > A negative of this is that it implies the return should
> > always be tested even though it can be known that the
> > return is effectively bool.
>=20
> I'm not sure I follow.  The attribute is about the arguments, not the
> return value.  Perhaps I don't understand what you mean by "this".

'this' is the return of the strprefix function itself.

It returns either a const char * or a char * or NULL.

Because it can return NULL, then the return value
could/should be tested.
