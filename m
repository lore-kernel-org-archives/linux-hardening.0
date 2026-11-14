Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672311;
	b=b99/Y9oEseIEe67rs9IugI0itzJgSrbduKzfRXHDC6B2gXC16jg5oQVkyJZ68f8t/DId
	 5ZU2Njds/MVeSe1/q0luG5qIpdneG3wpXAFRelp/A4EMvNkaoakdvAmUwnCbEMjJE340i
	 6dNUAXjNTvNjmKibktyCJvcy01szUrUShRbAWmpaI+aIb4K3oEjkl1H/FEqhdDVZY/yba
	 bbpC2nnnBfvZxA+cpEp/083gDYMLJc/5VkHfhupeoTVTbjnN243tKYg3nDd2xuwKv3J5i
	 ZvLP/kuXYPltJDvzEwVKNiZ3UP1XbPv3acchZKsmSh073DFqhmKyo9wyM6PNJQ46ZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672311;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 X-HE-Tag:X-HE-Meta;
	bh=DFprDqeitAohGQBNUqbTScTRGFkLWD6LBy7p4Hf2Oug=;
	b=Z38w0EtFcvfQIH2CpZhCCop+tMn5BkiAF0p5EO3fNl3piz2ugsfQQvC1ctJGowcj+UvR
	 34qeY2rHEP+euAewSGAfrIIrcowguv5RaDmcvJzZhDWW+1xAGZHUBNroIF1EPisTlIbJ7
	 oGjFk0FQ3W8rDHaD75DaJFMvkguemnk2xj/TsFG5wAAj4dl2tVJOjTN5K0TKnQy2CijSe
	 PXRHRQCuV1ys2no0ugjhnraSgio28JrH1xJyty77VJnSZdqcXM/n9HI3Hqp4/UVaA9gZU
	 08tZO0jdLQckruxJNQaTQHvpHoWx24iRooaLAFgqawYFIfJD5jJmSCv1xjx8vO5WckA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C74606A32E;
	Sat, 14 Nov 2026 16:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0C74606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 767B61C2178;
	Sat, 14 Nov 2026 16:05:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 5DCC920028;
	Sat, 14 Nov 2026 16:04:57 +0000 (UTC)
Message-ID: <7d45a8e02dc9407e6b95893d6be1591aadc24cb9.camel@perches.com>
Subject: Re: [PATCH v6 10/19] platform/x86: hp-bioscfg: Rename local variable
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
	linux-gpio@vger.kernel.org
Date: Sat, 14 Nov 2026 08:04:56 -0800
In-Reply-To: <ec94f69d2925d2362e8bde4ca1b1f7f3893c0315.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
	 <ec94f69d2925d2362e8bde4ca1b1f7f3893c0315.1794667407.git.alx@kernel.org>
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
X-Rspamd-Server: rspamout06
X-Stat-Signature: 53j8wsp5a6fg8jee3ieegcukhmx6jmya
X-Rspamd-Queue-Id: 5DCC920028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+VpTC8Lusxqpz614Tq+eazLtqtBrx4Gk0=
X-HE-Tag: 1794672297-714223
X-HE-Meta: U2FsdGVkX1+BbvtYcCNS4mqHYhJp9woIZQnDyR5UFPRP9xREt7YESjGfQjrAX8BcPqWZF1pdF7Woo/3NsgHlUT88E5IEiirUHXZHryg09FKQIJSf8ghtqfKMeJgnAEw36uGW6+4rzK4BRo5yYGxsVvx9ZX3rXE5BdILW9WqVmbFQbJWhOQPb0xHr9Bi351Jw5ClC0gAdnQLE1OFrhUgh5gwHNTP6v4fhzsxROqM025v6N/YZuicpiDz2lr7BQL2t4ahguLxUKIjPMascKQou9VVAOxL5pGgfnUUW3KF1QqlLcmfQogM215x+vAK7kz8N

On Sat, 2026-11-14 at 16:23 +0100, Alejandro Colomar wrote:
> strprefix shadows a function of the same name.  Let's rename it.
[]
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/dri=
vers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
[]
> @@ -87,13 +87,13 @@ int hp_populate_security_buffer(u16 *authbuf, const c=
har *authentication)
>  		 */
> =20
>  		/* append UTF_PREFIX to part and then convert it to unicode */
> -		strprefix =3D kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
> +		prefix =3D kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
>  				      authentication);
> -		if (!strprefix)
> +		if (!prefix)
>  			return -ENOMEM;
> =20
> -		auth =3D hp_ascii_to_utf16_unicode(auth, strprefix);
> -		kfree(strprefix);
> +		auth =3D hp_ascii_to_utf16_unicode(auth, prefix);

unassociated defect but the auth buffer isn't apparently sized
so some write beyond buffer seems possible.
