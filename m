Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329738;
	b=myInRoaUGJF0omjwrCfQFU5H6p2dLcGghk6F93ZHORUhWQxWZqNK49fp+H84sH9sP8hb
	 HFCJKBbAUP9wpAwg5MWo0GWTicUz46KjjpbFB45CBkUNf1yvkC55RZziADQYkTFtAgM7E
	 AbtdFttcxXmcFBkh3EnfMWuDGvMwRszMSYG2zQCfJ/pKgFE4ghn/QzBzzNy/7gKRJIzMD
	 esZ2rSKxyEaJMonoUDCh4XY2tLYca36WN6dxu/uSycfeYAXCqPUIqMaiG8gy/xJYg2xrq
	 UMvQvZtUgFoO0xeHBy3ow3CuszvoPhuEUxeDg4fTP7szHxKQxkesAnvw/sv98xucqow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329738;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=AKLE7YpnIqYAnbWA+4wYCxI5SV41OwnN5LISeJG0bg0=;
	b=1eqUwv0mhSJ5ULPsDd9MaXBnmQkg+WOFcmcIueZiHRhseM0GkNK/lwrGWWqJ3UhKdhjT
	 VyX2CaQF6EAN3jzwchxfv5GYOTL5Ni71SLlP0TtRqU3YR78b0DBJLrUWEHEps0qgm2q8G
	 PhuL0zdl5lEZfppUNhdwK4z0zr3JVuP7PC5rJi5dB6oCyA/3kq9dzG8w0RmRmTVgiZ9uR
	 p2ufF42rGK9Zuut5draRMPXjczqBgdaJ6L/uUKI34jfzQ/X4PAO0u5RmX7QfehTM2ETbR
	 0rsh8K5sNP5VuqaRGhU40vFzCJhge8gfVoaoIf7PBVC1hG0NSb0yXhI9e18/13WmN9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="JprRx/k7";
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F84606A31C
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 16:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F84606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=JprRx/k7
DKIM2-Signature:  i=1; m=1; t=1794329735;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LWhhcmRlbmluZ0B2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:t/IPZd2Jl5Q0Rm8Dkcb4jR6dj42H
   CBc3aU2K0yhAN5tMxaIjEcovgQp+E51O1bKCIfJoHjpnqoz+KJl+2U1O0WluzkfM0Z+KXQcTjJr
   l5poQUdF3KAREY9H7LSgIgpVtr2ZuXG5fz60WGKPgeb+3bIIOHfb8xhQloHTLVsS6ve6/1hqn0/
   igNqE3QvxyV97YY6T1XhFXE2wSb6I5cTwMtlQwv+ggZjR6oZyZVqq6X8mRGEOlhoQjdlIg6be8c
   0wWs6uWtQ4RKWOj7otmAyWBUkH0kH86VXB6TWVNRMwkn0LW6K/d6ENDwQ++KZwbXtE2aMy/GJ7b
   agFrtB52MQbQFQ==;
Message-Instance:  m=1;
 h=sha256:
   pTPucTSeN7FiAcTbwd26SP2/xGT3y7mvwH+yXNpsbrU=:
   sIWPeZ/PYrYvpupT/XR2hBn9mdKXTy/6ZsHnKedALWA=,
  sha512:
   f4rT301rhLkctpr2y2vY0hof4tkas6sidyqjoZY/sE3Q6d6I6E/lTLToYwPZ07tiNo9v1WaytJXUzZr3rGzD9A==:
   hZPwlvh+QAcNIhK2j+Wtvc2rTE5oBvRLe5LNI0D97WLmZwJTZgwwMNKPs2hyKtJvIbtAOTEouMPnljvTgrVw0g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329735; x=1794934535; i=w_armin@gmx.de;
	bh=AKLE7YpnIqYAnbWA+4wYCxI5SV41OwnN5LISeJG0bg0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JprRx/k7rkpnhFwtxSUvm1Cw/VOG6QnXOj0ghOYEriK1F2yIwPWFvb4DnIkjeJpS
	 Rn/J0/tw5ETeRdw9QvfWTBn1XyBan7hSPb729VrQwFh8T5MjCAZ/Cw0SB9n7e8gbe
	 JZBHge9YZLu3rJIcPGt6h7Zu7l9yRVPGpoaShXno41hPLouCn8/KdCsjA0YHZrTp7
	 J4kwSvoKWLxRoMjMUQqVyTKaDgtnYci9nH/ehInqrbWElGP7F5o6ycIq0q6PV0Rs4
	 Jlmt8jI7a5G9VM5rVq2mstdHJlXmLvDThwymn9zvG/q6Ud5QKVzZrsYe7Sc6I+dx1
	 Uu3quwY9XOg9WG/Lhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1wrUNb476H-00gaJf; Tue, 10
 Nov 2026 17:55:35 +0100
Message-ID: <f7d8dc2f-80ef-4181-9657-ad9ab39abeca@gmx.de>
Date: Tue, 10 Nov 2026 17:55:33 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] string: Export strnchrnul()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, jorge.lopez2@hp.com, hansg@kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>, platform-driver-x86@vger.kernel.org
References: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OpL23yiyrwE/QnP8nj6hmK3bHqbCumxcy1gyrs07uA2tt/6u35K
 ybbi/Qisr0In5VuOlO1v2ALf3ERVBmGWb/YLbORTx4PyErOkytvekVdivocGd7vDCWR2wCx
 DUhbcZCOBeAVKITsK3MPuQWVWhgvOFCXNpgVMN0kZhnOPtswYVs6ZFq/oAaY+Kq/f0bREhi
 y51laby3VKb2q1cLcchSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MRyjP1stf1s=;vohirWWi5Y5nP/Lhkyk62sn3ftn
 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
 Ko/m/

Am 10.11.26 um 17:41 schrieb Andy Shevchenko:
> Export strnchrnul() for users that may be compiled as modules.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Reported-by: Armin Wolf <W_Armin@gmx.de>
> Closes: https://lore.kernel.org/r/1969fb5a-38ef-4b4b-9d2f-cb9a4348b968@g=
mx.de
> Fixes: 0bee0cece2a6 ("lib/string: add strnchrnul()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20
> Assumed to go via PDx86 where the first (wow!) module user wants to use =
it.
>=20
>   lib/string.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/lib/string.c b/lib/string.c
> index a3778d5aab4a..cc8982a93afc 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -352,6 +352,7 @@ char *strnchrnul(const char *s, size_t count, int c)
>   		s++;
>   	return (char *)s;
>   }
> +EXPORT_SYMBOL(strnchrnul);
>  =20
>   #ifndef __HAVE_ARCH_STRRCHR
>   /**

