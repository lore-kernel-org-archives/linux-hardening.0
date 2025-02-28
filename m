Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50226D5D3
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751172; cv=none; b=rzi/u0eyGDOwy5aVVIAXuJwnEIw9xd/RaxP9IuKPmUeZc0PczM414c5v7mnJkIDDD1HQOFaiqXpfKuoYKmSJpGKDxc9TfIkIJkTb6iLM1GZpZB0hB7G1qWgR13eTtNVBgK0Cn5eyr7IdD0JUoxI7QbnauVGMNCaypd96L2RO/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751172; c=relaxed/simple;
	bh=px+x86aKSLPgbV52+S2WFBDfxcJqop/aXnFFgDBY9tU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCl/QvKly09ytNa/LiE4NMS9vKEOy8OzMi88l0iA2kdag1mRSE150R96nlmo7hcVkj0W+EnmzdbWY6aLZt45zjCvvPwsFyA8FWYZNkn4rDAANEAOp7JMLMrt16RN3LH+99sWEJUBje37Hy/C7FcgFA4ImxEuUEdnxYmwxURAN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grI+STAK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grI+STAK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390dc0a7605so1174655f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751168; x=1741355968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=px+x86aKSLPgbV52+S2WFBDfxcJqop/aXnFFgDBY9tU=;
        b=grI+STAKOAnH08bihdrVdSxnngP7J2jW3cKPR/2Y5MaVL0evvPR0W3GzgzXLLYwR02
         u5AvChKCZpyDKfHvyh6wqJNJ3iR3PeAdDruTVVJLAsMt3fk8zc8rQQ183v+hwwhk7HLz
         /Pmr+qtoqG8NlpXVL9dbiPdgqVu2iVcmT39SkEJd8TraGr5jgVoj0+3fXwT/jXVnCU+3
         ly9xKRuwG397WPW8o5uX63mYDvTpS/1gVgWd7Km2ciUy2hZi8pvmTKOlz11IHDhehorp
         gdfLMBHpQw1JttRu1/RG0yCHKsf52m5VoUPXXWa+OtM1GgDDu/ArHT2ioYrFvwyK/QJl
         iWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751168; x=1741355968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=px+x86aKSLPgbV52+S2WFBDfxcJqop/aXnFFgDBY9tU=;
        b=vjtZgcRlcM33NABK9yxaqkfVyv1SNfraJm0/DF7FzCMaYvzoLPhhdrsCRsHKVdEK9h
         +UYeD7LZTlbjusWUoz3fm49PK4o10qCWix5cfjRmE3Fh3i2VKUXV7BCQVFxq0R+3U8Ee
         TMWrEp5S37Vais2jJDQishw7WhcaWkJZqpqKQW+v9sP/OHIpdETks8zWjWptXfZrqoKS
         Pp8tYB/nQvPPOnz2otHB/Q2OIATQl+BxsqylENSsODgDNxIUqwWrGNd7cj2Dno4/bBgV
         zBBlzG5oyQyRA6OwANBeMjUCKOJR2czKhKFW2TjStNOt5bwj61zmQ2tS6V7GAKGsB/NA
         gxLA==
X-Forwarded-Encrypted: i=1; AJvYcCVueNQIEK7FreE3QdVAG2kjg5Z1poOhU64eoc4+F5DBPGRPY4XtpmCG/2nKPLVLychvA/62XNGQWxeGs393Bvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QcbW8vERz6Nic/AWWtOkSZYOPjYMOXrrjI2J1LqFxESIJ99C
	We8rIh2z9UY97s15C/CnMCVCd91vIdwP/LTUC9bqoayyPj92TOFJhI+uRz7PUt8=
X-Gm-Gg: ASbGncu5TZghOAPdSJTYczvPXJoWjX2osQK2/FBKd9pWNdYtuIEREnn+doZ642un8bl
	wDw1nysBnrcYeUJubscrXshAp5tCaj7nfyNhfcjYfnlXB6v5IRpVxvb0WS6Qdv1njdHKuBN8tso
	q1UtmdcWw4+P5z7OSvpv07wgnsX215zHDKjLCfX1GgaUzJvJ5x7qXNaEuWVeCafuydB2QmCEUww
	b4wGssos+xyB38de+OQjeSXSJ+7rYTV2AqpT7y7pkLgPCgFRqgqB5z65H8jghU+q3KrFt6Pn1Ek
	UCvhWS3fDFUm4xy25HRNeOOdUHvDPQ==
X-Google-Smtp-Source: AGHT+IECpo32ALWrFa1cNaiDX3uH6CqXkFCNWGuhJmwvZ0p1RSpM7dQPjKfV2CnvU0hTwmPQDg65lg==
X-Received: by 2002:a05:6000:2a4:b0:38f:2990:c074 with SMTP id ffacd0b85a97d-390ec7cfe62mr4082089f8f.16.1740751168393;
        Fri, 28 Feb 2025 05:59:28 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485df22sm5389786f8f.97.2025.02.28.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:59:28 -0800 (PST)
Message-ID: <e355ce38815760e69f40ec6d9d27fb6cab8f9894.camel@linaro.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: mfd: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski	 <brgl@bgdev.pl>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hardening@vger.kernel.org
Date: Fri, 28 Feb 2025 13:59:26 +0000
In-Reply-To: <CAL_JsqK-_rPZqt_vRv75dSWDLUAyZ-LB=qz5J=Kse=7bO4q8sA@mail.gmail.com>
References: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org>
	 <20250226-max77759-mfd-v2-3-a65ebe2bc0a9@linaro.org>
	 <20250227130451.GA1783593-robh@kernel.org>
	 <503e105b71fa4271f40a2d3ca18ba13ed7d45a65.camel@linaro.org>
	 <CAL_JsqK-_rPZqt_vRv75dSWDLUAyZ-LB=qz5J=Kse=7bO4q8sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 07:01 -0600, Rob Herring wrote:
> On Thu, Feb 27, 2025 at 7:14=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
> >=20
> > On Thu, 2025-02-27 at 07:04 -0600, Rob Herring wrote:
> > >
> > >=20
> > > Why do you have GPIO properties here and in the child node? Either wo=
uld
> > > be valid, but both probably not. Putting them here is actually
> > > preferred.
> >=20
> > That's an oversight, I meant to put them into the child only, not here,
> > since the child is the one providing the gpio functionality.
> >=20
> > What's the reason to have it preferred inside this parent node?
>=20
> It really depends whether the GPIO block is a separate sub-block which
> is going to get reused or has its own resources or not. It's the same
> thing in system controllers which are often just a collection of
> leftover control bits.
>=20
> We just don't want child nodes created just for the ease of
> instantiating drivers in Linux. While it's nice if drivers and nodes
> are 1 to 1, but that's specific to an OS.
>=20
> You already need other child nodes here, so I don't care too much in this=
 case.

Thanks Rob for taking the time and for the explanation! I'll keep
that in mind for the future.

Cheers,
Andre'


