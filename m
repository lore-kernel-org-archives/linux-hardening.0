Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7987B1F16B
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YIWtd2+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZCwT7J2"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E819109;
	Wed, 18 Oct 2023 12:16:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 854EA5C0212;
	Wed, 18 Oct 2023 15:16:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 15:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697656596; x=1697742996; bh=K/
	ku8TZjOFbooB2tiwC83GIeKKI9O4iyB6/fSyXMu8Q=; b=YIWtd2+18x6TD4SpJk
	ol8iIwgGAR38beCTTdzo/mUNBUk05/UlfbsDURfo9060Q4eU9Km1H6WG3O410jsU
	jj2CELtuscAQy9BowIogSiBNp2814ar4+apr1VqnR/ELb5Tn4eJY+dMaTZbc+nL4
	4K5wzo6meTjg4QV8EMrIVy3p/I8ZMT8xi3oTcDV5ojxBbDTz/e5uVT+t7cxQvLQ5
	SS2YrsTDld9k1OJy9+oQauLp8yIWSnsR2wz8E45HJ7YkH87PKPNJ9RYDkRakA6DR
	IOoSEHalJhd33Dmj/3MsOWflWRpCIZGdiyMF9syFPfSrGpo/RLwk9B5EHU8AW2YR
	W5Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697656596; x=1697742996; bh=K/ku8TZjOFboo
	B2tiwC83GIeKKI9O4iyB6/fSyXMu8Q=; b=WZCwT7J2HRNpNbboZKIJZt9FNKdpS
	R0+dZTdXmNrmrrXSfmPdqhnhcyUDcb40Cgk5XMfo4Zhqtwwf5e+sEMsixoAe4+Gf
	TuLgv4pZ0B0XAnAm7D2cUSzVDamCJaQbki9ia5Pj2FyaZj3lPAAheu5BlJ6AgZNA
	cM5gjkQ/sTEshfOcdXkkxAHY056zGg1Ja3Qm+t+EFGvwqlEE77udETnc7gBA+/W5
	Ho4JfxRbRSriPiWFtJ6jpJN5sMt7sh+EG1Ld7bQ0PNZNiihy+9k46M7MU6VxMkNr
	0PAu5KH7m+5tgQcic9GN2E3LdkEY2eBFTQdgyZ+APUJ1VNb6++EiNq9BQ==
X-ME-Sender: <xms:FC8wZYAIXwbiw0P7SH7k2IcmEgEJg0K-ybyrW3YKNx6d_PIUUb2r9Q>
    <xme:FC8wZai6DzYb2jRNKetXtLLskS_dGU5MN1IvBwvdIAf2bV1D3zPoahG2OPJRPnSEp
    l-W1P0dcHDlafpqefA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FC8wZbnBpeDDu-c7gmgs0x-lXY9ZQpj1WKR4dQE2TAYfTWC-3lCXbw>
    <xmx:FC8wZewdD9wpLkxfs86jGy5XIgB64tPpFJ0jIRiuQ4TnIUpIc4R2KQ>
    <xmx:FC8wZdSJJcEu4pgJGR7yzRZXS6Hp1fkaaal4vprtRD-3RFhCHYGEaw>
    <xmx:FC8wZcJ6-8NQReuJdHGivNxJIncRzdlYBohZ8LlraqIj7heI2LIYNQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3FCF5B60089; Wed, 18 Oct 2023 15:16:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <136b4130-8ba4-43f1-8ef7-2bf2a8fcb71b@app.fastmail.com>
In-Reply-To: <20231018180709.work.293-kees@kernel.org>
References: <20231018180709.work.293-kees@kernel.org>
Date: Wed, 18 Oct 2023 21:16:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <keescook@chromium.org>, "Andy Shevchenko" <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string: Adjust strtomem_pad() logic to allow for smaller sources
Content-Type: text/plain

On Wed, Oct 18, 2023, at 20:07, Kees Cook wrote:
> Arnd noticed we have a case where a shorter source string is being copied
> into a destination byte array, but this results in a strnlen() call that
> exceeds the size of the source. This is seen with -Wstringop-overread:
>
> In file included from ../include/linux/uuid.h:11,
>                  from ../include/linux/mod_devicetable.h:14,
>                  from ../include/linux/cpufeature.h:12,
>                  from ../arch/x86/coco/tdx/tdx.c:7:
> ../arch/x86/coco/tdx/tdx.c: In function 'tdx_panic.constprop':
> ../include/linux/string.h:284:9: error: 'strnlen' specified bound 64 
> exceeds source size 60 [-Werror=stringop-overread]
>   284 |         memcpy_and_pad(dest, _dest_len, src, strnlen(src, 
> _dest_len), pad); \
>       |         
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/x86/coco/tdx/tdx.c:124:9: note: in expansion of macro 
> 'strtomem_pad'
>   124 |         strtomem_pad(message.str, msg, '\0');
>       |         ^~~~~~~~~~~~
>
> Use the smaller of the two buffer sizes when calling strnlen(). When
> src length is unknown (SIZE_MAX), it will use dest length, which is what
> the original code did.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: dfbafa70bde2 ("string: Introduce strtomem() and strtomem_pad()")
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for addressing this, looks good

Tested-by: Arnd Bergmann <arnd@arndb.de>
