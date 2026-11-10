Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325695;
	b=peY1v6YC8RiyKRlaSRmy7i9mdw5KO7NbNqEmn2oFyXdwb6DFp8S/0QlUbeabEPdnvOvd
	 uAj41oZUV7+Zy0+QRmrj6cuNwjncbxPCW/JeVHg7WQBWYc76PdTKoERBgXTF7XTYQ/E7l
	 uQoqWcxUcdNDdovjhT/2WnXBpi8JDiDyN4+sF5f4W0e6JguaG8LoZEGiniMNx1tQNuxCl
	 Dvj1Jx4XQc5YLPvb4Tu2PpoGE/LK9W7lKNlTS/WkFZWGXmhaAP0p2y9bKI55dtLiBmGIo
	 ntBGk2HogjnwyhAj1zHtMdGAa56JvhJSS9Hf5tgYg5ToncCidlxax5NqNG6NQ6WDKxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325695;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=UAwyQ/bEfICw1lHx5rCY/pV9EvLuRsJGgBLXgqR0Hi0=;
	b=2klRADVVfnKSBNpsM8abmNhlx/msLC4cDSVkAP5rw1CgqwIxQQE/TCbCdrvY9vkObYSZ
	 4Q4XA6cqOE/iq1altZL/6Y7Q8UVpmar68DZKHMsFvdxov1TSrxLJyKxBb0ILgpT2L3Fyu
	 lrDk423kuT4aZZxkWKisBXxHIv6VaH7jOJC5pOf8Acrcfi3NahBqlaSLXkKonfaYIsBZD
	 mfp7WnRFMoQQ3SLsHThBf6oWeB/jY9a6+FqxfayyqNPo6/ecpZfeiYkCINShnp3BGri75
	 CUyrjuIPwJJiiy6COR5IcGQNfABOEdUjBAqyzU85/EPvPzvLumDHrzieBo1M1URXhKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FB60A263E;
	Tue, 10 Nov 2026 15:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA3FB60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C9921A85BC;
	Tue, 10 Nov 2026 15:48:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 679516000A;
	Tue, 10 Nov 2026 15:47:56 +0000 (UTC)
Message-ID: <e7b48186a65a759935fdfdc2003b266d05ee2d4c.camel@perches.com>
Subject: Re: [PATCH v3 1/5] string: Add strprefix(), and deprecate
 str_has_prefix()
From: Joe Perches <joe@perches.com>
To: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki"	
 <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Andreas
 Schwab	 <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, Bartosz
 Golaszewski	 <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, Danilo
 Krummrich	 <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold
 <johan@kernel.org>, Kees Cook <kees@kernel.org>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Linus Walleij
 <linusw@kernel.org>, Namhyung Kim	 <namhyung@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring	 <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan	 <saravanak@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi	 <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Bartosz Golaszewski	
 <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 07:47:55 -0800
In-Reply-To: <556766412884389a7cecfe6affcc9fa3a78f9807.1794323750.git.alx@kernel.org>
References: <cover.1794323750.git.alx@kernel.org>
	 <556766412884389a7cecfe6affcc9fa3a78f9807.1794323750.git.alx@kernel.org>
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
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 679516000A
X-Stat-Signature: jfwhutdpd88zfz37tr54rxpcmsbdz7uh
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+itX/azYWscfSefJ1cEeZtVDBix6JdnqE=
X-HE-Tag: 1794325676-569192
X-HE-Meta: U2FsdGVkX185pC9GD+XhwDY8fHTdpb4bEWMa7jC2vmoDxUm1jtR0t65c4Gtf7cyCvm9M4TppdazpgmUQRhwjk/CxFnV/hUKlqniGchOmsyNAb16mfHvFATFnXjIooXXdQQXJSnIIkhegnkJAYKeuTiaN4ixgIMtRnua1HUa4VNEpVGqk/i1+umqDu0u8ZEWjUZgW4IlcCejQBkAdglRIFYA2fLf73M2AoS28U821DoGSjmwiZ4FLuuVwkNB16ewyGLJT0BKECphGhHwwugANfTpnxmrvKOdIzCMJ8eS+rI0QIx/MTX0a6tNRWuLtWQfa

On Tue, 2026-11-10 at 16:33 +0100, Alejandro Colomar wrote:
> As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> between an empty prefix matching an empty string from a non-matching
> prefix.  This is a fundamental design flaw in this API, and not
> something that can be fixed.
>=20
> As always, this is a consequence of choosing sizes instead of pointers.
> Sizes are often the wrong choice.  In this specific case, pointers are
> more capable of differentiating these cases, as NULL is a special
> sentinel value that doesn't need to overload a valid value.
>=20
> Let's implement strprefix(), a function that returns a pointer
> right after the prefix if found, and a null pointer if not found.
>=20
> We'll slowly migrate existing code from str_has_prefix() to strprefix().

Most uses of str_has_prefix could use the existing strstarts.
