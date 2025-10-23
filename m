Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1530BB81
	for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219693; cv=none; b=fWRu9OpC7f/yJjkziOzQEULxdYHUZ6kxQ57hgdAzaeScyPbL2BjXkLfQSWpDaT6598nGQwfuHna3cIIcX1j/A6jb7GtR/RmXydK5B52ACEswaGWkv+FPfcLmFoaCpN+4hXHGgp1wcKWiApeaPUO/c18FE4gVx65nen3Qxi83Rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219693; c=relaxed/simple;
	bh=tCWB8eZl8/ULIrv/Lv1JyFMJF12YEm+OEzrPMhTM5Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iO6IJgYSy97JT+4+6oQd/CRrexKnfjBqvhj8T5X9/M5vTkbRxJMrfDqecuAeuNv0enMp5iPC+prU39stqhfBYRzpow5MttT8Sx7YZyS4CNHUq6eGYRrsGP+B22gi5VbnRNZ+mqBcWH1Pm3kjlPmko1kqASTGFdO5xd68JVuwLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSHez1p4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSHez1p4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710022571cso7235265e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761219690; x=1761824490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZyKD383bQoqOxFZk5G6Ho+/pzc/ouF37MPGyirm0sM=;
        b=BSHez1p47gwsvywGYwab2fMcPReF/+6/m4kG6H0EFEUxqVLLRQ9cBsfLenW1TUbqFf
         1NcchsVjjDBJEZI087dXzIGviz1a2lBSznlVU4EzYPvJ8dp5xj6Ra6icAZ+1aSPxzbmE
         tG1Zg5OSPQpabLlH6Pud40I3fqKZxBHkE2OGEXVIgvx4u3eL5LZkn0xBD1YYa1ES0/bu
         8wLkKQREkHRzkIithzfB7rZyuSsBos+liyBKGYqxbPjQZ/wGGu2soxTfTpJGz4kJ+65E
         qr4CP+2J5R1jnPvO3nSTts94zEemIQisAzVjE7oSi7TDo7XxFVRMkwduluaEM4/KH79J
         QnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219690; x=1761824490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZyKD383bQoqOxFZk5G6Ho+/pzc/ouF37MPGyirm0sM=;
        b=YI8vvyYUz6MVBfxNQZ83uxn088rCspBwftHrkrunYQ2oQxK1mJo8N2r/He2LUaf5tO
         4GkLwbkeZTnZi4Ds4rRmtSU/rgnJDAxaGby20CNErSWmhc/hbOan/osTWTjXcuTxfi47
         Yy+50mt2cN22sk2xc4m2f3Lac4aTdC5h1SHXewRQytAsyliHi6xXLNHUhhvsI12fE0k8
         Q5mXOWLXHDFRZgOVX3r2tF69OSaQF6Xt0uQRvRYLukzRNm44sZ61va1u8vMisgZYvpz6
         Sp5pzialy5gdL3AMg9/xg8aV9ee4iCs9tAX1HEz9KQ2P/cqrkE3REEMMBZC33dj2ztPF
         UGww==
X-Forwarded-Encrypted: i=1; AJvYcCVNYe7s81U7M09h0NwDOqm26taIXPjoi2mk2N8MUD/rfYdr1PDKuIhOtploRwI7z+2dAqTtJyeA6QCzJH/6DvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsegWh9Qf2b26W8XYo4i9vYfh4fH1TfrIv+0CQQNu+fqKw0gS5
	MBXdT6nimwi2Zj+fWti1zyppOiyVaJ61OSnCF0maHriwjz3rxmI1nmJf
X-Gm-Gg: ASbGnctdyBnnPgZ9iZ1UA2gVa5qpzRTLaBdup9tsz4zypQkmmiOwtshnZcvGPMF47Pj
	nD7r8PAq//lq8feZq8qlxfGBE8h5OURpqEt/n1BxQF/Yd2yixEn6VsPRKNdRNTSn0eWirvCp9z8
	vluuCNTaLFmOkRXnkfMD/Rk5/FzpY9/9G+KYf9mkCxetGpFJqquETjq8K2tSk35t82ny3K2/oAz
	pH3N/JSA/kPoA6enNSQ7wMrMB4GwuJMLuxlWqp6HP+pmQ+LJLkJXJAqyum2+1CmqwZ9mekfl/ag
	RzPkOHD3oUWM8PQXohI468QFtuJsnm+BfwkYeke570eO+BbT30a/m4VRdBRNKgAgjI6FiWKisNu
	UlGLsUUfVYABvkBRI5ezp3Ax27z8KzMpnwMUV1iTFYLJnt4ecHUbZj7Zm+3MeRxBevffJlNzrvT
	OI5OAQ7KIQbYFW7KQ+w2h1Gtat0Nig5HAyxFnTjYNKJg==
X-Google-Smtp-Source: AGHT+IGlUn2L6ygzDQsBh/Eml4gQWf9e/nvZjjW9f4ITDsLcyuehhyiV2w5QA4lrO4ML01ofHt+lFA==
X-Received: by 2002:a05:600c:3ba1:b0:46e:47cc:a17e with SMTP id 5b1f17b1804b1-47117870544mr196707655e9.1.1761219689367;
        Thu, 23 Oct 2025 04:41:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4378cbesm89230435e9.16.2025.10.23.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:41:29 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:40:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Gustavo
 A. R. Silva" <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <20251023124043.3dab5646@pumpkin>
In-Reply-To: <268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
References: <20251020212125.make.115-kees@kernel.org>
	<20251020212639.1223484-1-kees@kernel.org>
	<268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 12:43:06 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 10/20/25 11:26 PM, Kees Cook wrote:
> > Add flexible sockaddr structure to support addresses longer than the
> > traditional 14-byte struct sockaddr::sa_data limitation without
> > requiring the full 128-byte sa_data of struct sockaddr_storage. This
> > allows the network APIs to pass around a pointer to an object that
> > isn't lying to the compiler about how big it is, but must be accompanied
> > by its actual size as an additional parameter.
> > 
> > It's possible we may way to migrate to including the size with the
> > struct in the future, e.g.:
> > 
> > struct sockaddr_unspec {
> > 	u16 sa_data_len;
> > 	u16 sa_family;
> > 	u8  sa_data[] __counted_by(sa_data_len);
> > };  
> 
> Side note: sockaddr_unspec is possibly not the optimal name, as
> AF_UNSPEC has a specific meaning/semantic.
> 
> Name-wise, I think 'sockaddr_sized' would be better,

Or even sockaddr_unsized ?

> but I agree with David the struct may cause unaligned access problems.

It probably also wants the 'sized_by' attribute rather than 'counted_by'.
So wherever the length is saved it is the length the user supplied
for the structure (or the sizeof the protocol-specific one).

	David


> 
> /P
> 
> 

