Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DE3F44DB
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194364; cv=none; b=FBiv11HgSyfueeh8nWpWTLHNrECNYmuwO8qbUC6X5qqrTM877L9eJimpJsiSgYOGZW1OXc5zpxEO3st2s+RsC3sHBUpxIF+112ScFI3h7bmnk8QdDn4VJpzr+JeG8nRiA8CDnHYkpxLTVcvNb3RILZI8DZ6ZTb+9+3/5HzjHtBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194364; c=relaxed/simple;
	bh=cPmpmx+T5sAWycdpqF364kuymZ/P1B9n9CUUBg6crMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhsO1rMfX84EtrcWP8B5M0B9aVZ2U8QOvaUo26werag+5U6dKQnlehwSK7WfJmcb9w7ajO1s+zdldXnEIgEfho7jzOPcC/lp2a3b6i6P6aPooQbGYsNmYbVfr5JvbV3av/eQDLzdpLRB+5+yUNHFOrkAfvaTndrcBh8WMd8h04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/y3csxw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/y3csxw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c7902f47so50935405e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784194359; x=1784799159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMCp06Fn7LM1KbKjNDRyvgq+gIPkw0ShH7Q56EFQy0E=;
        b=K/y3csxwNu4Fd3RqfPYeUBRGDZFXvvuEx2hKSB8qibeBokcxFISgRcIb5LB075dCW6
         YIwSBVFxgLRokj4VbeS1y6s08JefvE2btKkwvT2dlWtdOqi4wwruVFd6GsTbVHZWrw6c
         d7VR0cnHBejI2XuPiDBvWM3qr8z3AEEmj0lxNviGaMj9/BSy6eOGhSf7VPbQFaBvX9Yi
         9UHEp8CtF+/a2cfectVTJ8qVZ9OjGB9HbtjNNoJRIPJJmAASPPmQNy6GcQPQdClAnSjj
         +jBNL7eTSAQaOMCdozRdaYwssyXZs00a7yAZQ7TJ2HyRRrjQjwU05z39HRQlrWblFv3q
         dr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194359; x=1784799159;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMCp06Fn7LM1KbKjNDRyvgq+gIPkw0ShH7Q56EFQy0E=;
        b=WEtoCV/O99Eb+AN9S9loATBhO3T+I3U3RLCW8rL6BjAVJXSNeDhZkBiL1HpXMlqzKc
         adNrdTsx0nQDLUzl489BnjqlxsVyC9usrkNUpD6LlCifyQeE/L7QVCp6ux/lci2boS/d
         4B3djQI+8TEy8k8hBL9vvLTlnTaNyCm/vBwpAEdPlrDVRoX1Mdb8MLN2yF1uAYI6WSea
         yowZdYoxEocikitww4eR5I00QW8AzjApSyHWneoo9V+1CTUwff+SrgmhTWzGuXAsN7FS
         9qEYeLhQIgaLwK9y3U9nrNn59VVQqTevub3RarcSVGRmBCFVx2xNsvYOb+MK2vUeYYj0
         an7w==
X-Forwarded-Encrypted: i=1; AHgh+RoyCZsnCJoOfgVxuFmI2L+zfJlLhW26uxn+iflM9m8BHZGg0I0EJAjgWzq0LRxBWECOpDbpKABtMtQHXptsFdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3gK9Inb62IPGXRkNy0mn2odgVWxLQQKWaoO56Eh0zLExdREC3
	w5lPNv7EzGWWW1oMxYqb5VTQPdLSYLkcDGqNf+othE2PT9Hnu+zgpm7i
X-Gm-Gg: AfdE7ckwh1TZ0Xi7ZWLFOw/cmNGBMidIwvD3mfT1I3pAlJcT00JcGl9vtqFaDnGVWrJ
	UkZDovIP5D6sQV/5YjhSqWA98y1rorToQQwmhh4AeJw2vklVpf7G4jlQnWJ0LXbN/+Mdc9CbRcE
	m6me6YjP4Qj/W724FTkwRTGoGCHBHc2vkvoHmbORC9ti9tO8OOqS0Bx6rZMdvgOZYQyqzrGo89q
	UwD9ScgDNqDViy0388l94i+keOHTQqYEFpcKp+Xe5kpmz/YBQHB+onzwbNDKs1t7pwMfxfDcliY
	HvRRhZECuMxpbIW95hIM8wxtgQ2L6mT/yH4TiSgnnbkXe36Kh76tjg6One3VQuJJ4xjH/Vd5HFo
	qKgY2KLqnMLPLG9D1vfjEwq7s02v7q6E4RxIisBhnS/3xypbob+CxZaOI0i9hAxt8j5Ha0h1ae0
	bc+eg96eZH9iV77ToM8acwM5imqvPqTR4xWQqw7NGZ/TJG6TS89g==
X-Received: by 2002:a05:600c:1e0f:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-4953c280b8amr61833475e9.19.1784194358954;
        Thu, 16 Jul 2026 02:32:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm40799655e9.6.2026.07.16.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:32:38 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:32:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: wacom_w8001 - replace strlcat() with a strscpy()
 helper
Message-ID: <20260716103236.28c1b5bb@pumpkin>
In-Reply-To: <albg4Rv7QxvLJD05@dev>
References: <albg4Rv7QxvLJD05@dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 20:22:41 -0500
Ian Bridges <icb@fastmail.org> wrote:

> In preparation for removing the strlcat() API[1], replace its five
> uses with a small append helper built on strnlen() and strscpy().
> 
> The five calls append device name fragments to a basename buffer
> that grows in place across the setup functions. The helper takes
> the same arguments as strlcat() and writes the same bytes, including
> when a fragment is truncated.

You can do much better than that...

Change w8001_setup_touch/pen() to return the 'const char *' name,
then put everything together in the final snprintf().

	David

