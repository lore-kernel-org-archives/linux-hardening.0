Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F833ADB1
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977861; cv=none; b=S5SV1c7twtKjDsv//C1TG3g+KzD7OSXRFNzrGrZrx6C/JGhjvTOysAd307xX0Vx5QFrnKw/My174spLhUZDz1mOx4ObMYuJIfWvy7gxKGEG1MCjDCBmrmxaPeYE/aSNs6D41tQMMKu8g3mkQrlE/n9iBKjTbJoxOEJeFOKSaAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977861; c=relaxed/simple;
	bh=X8mgB91EilmZX84/+DAl/QEGzBiT68+EQBIZrGj6ois=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8geH9rE38nMJ6pPe0dOvxPDlvSMowC4biVVBTqzQeittc1ZNr+YLTUuf4tfq4cRtYS9fG857A00TiUs8EiAyf0UHvnYhdt9uf4x/WtYWrXq1CvYRQSYahpvNaeoV1/UIZ959XO2HFFPjP4XwFb64Hc9UkExvdHOAZZJfXwcpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=boq5vpzg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="boq5vpzg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so11265324a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774977858; x=1775582658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RzhkbeYcTn/pueZLzsl1uKI6wC45DhSkVKoC+DMZrjs=;
        b=boq5vpzgmokr9CCfqX5G08GmYNiD3jf5Fm1fvtqGavEkTYd8isUDP1L6aiSWMCDx9h
         Sz54Jc4OXNrWCd15zLOIn/8GpRU3hDBHyjqkqaioM7oAI2ubUp8fpmZsTDV7oNS1t8/A
         DeV0ppRXLlBSnvqyUHlJl2tmWXH/W6r1RtTic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977858; x=1775582658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzhkbeYcTn/pueZLzsl1uKI6wC45DhSkVKoC+DMZrjs=;
        b=KO2m3wrNqXiT4eBSEphvMeg7jQg2RNJ0HUDb+heDpqJPzvABELsakyhIuB6kaBWn60
         EkaZfglwdPkrpqnq0LMOJRkSSqV9AgRSbqwwkoU3Il4fUIWrZZhOJCsj2TydtDgrFTK/
         MyIKwf5ZzpzUHRRS1rnquJlhQkq3BGKbojNJ13nmH2nMH58e90FP+919Gc5Jk7aVY8vs
         0gLhfeYGSuor/KAb+T9Iuy/EEGGQQFzzJ3y2/pdSoj0my/+rt78P3Gy1w3ZvwKwpQX3T
         0T9h4MoNIGmp8JsXa2Pum04qyNDDCmVK42KCMvk1m+gAR4g4MNK7n/uxgHMzrYSkm6Pw
         RaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqIsx4Yp2Wz1hAVmky3I171ZPA3ewg9zLVeyxgW2qzD5fIhif/XwEoFCOi/wqFQ7Y2Kcr0fKTz+NNILfAbziY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHq2jdhpOcUWqNkoyqAlJ/f+j1cxCD/96aRdHz/cq+uAWmbZ2Q
	qnz061Ygyy3c4sNyITJCWxhu8DLzTAjShfDe2+pJGhZ61FqTUyjS3hH5y8SaZmqjoRPfV2vGfkN
	RTjgVSAu1TQ==
X-Gm-Gg: ATEYQzzzUO6h9pazy9FWkuj5efD461lKGEnXtTboPQexG2OVSL/KdnkTUyUpl/i/EWe
	9Lz/XZrv8Tuca05Gw5W8gj3p9ierj+6wYD00X9lmv9T7Cjz8unIoaisuwebl3EYOeVHMK5orbbI
	DpYTWrEWfYQWhUELTZcMROm6OkHk2KPlsov97P13DcElryU7e7CgQrup8Kw0XNqv6P+0URirINV
	dx3jlZfkSeJjvRv0j63jxcNscQjaIbhgpdOuYXk2CQlrzlth2jLjWqS0y1TOJhcu0NdQ1NYdXQN
	GdcUdkbTz9cu8FIyvvBK8JVawvydhiYEaIy1JSXlTe7O1evbtFIGuLibTld/G/uT8dccpSIGNXz
	FUsMsnnnUkiqKj8VvJR31G/BtXM203edluSlaZTke7hMHsa0A98v7VkKcGkPQvpPWv77GQnlbcZ
	4UCAWAc+Mw+9W9kKzy4zRPHQiKz7SlYaNZbk3reAm8JacIikDasLHdcve4g52NFqmFTmkt4HJi
X-Received: by 2002:a17:906:6bd6:b0:b97:aba7:1969 with SMTP id a640c23a62f3a-b9c13cb1a18mr24322266b.45.1774977857437;
        Tue, 31 Mar 2026 10:24:17 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae7371asm437392366b.27.2026.03.31.10.24.17
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 10:24:17 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9382e59c0eso961059666b.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:24:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfkUan+k5aAH8iK3DmCTcNPzzO1MTnNSxVKbZRG/cJHjdGFUrGpC1zrPfqpG3uDkc1o68Asc33fwnIA7ZiShY=@vger.kernel.org
X-Received: by 2002:a17:907:a604:b0:b97:b9d5:4ae4 with SMTP id
 a640c23a62f3a-b9c138e5f3bmr33991866b.20.1774977427566; Tue, 31 Mar 2026
 10:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-3-kees@kernel.org>
In-Reply-To: <20260331163725.2765789-3-kees@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 10:16:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=q7ptcMyUAqPGDbX_DKHivJVppc8bP0zpQqzOky_avA@mail.gmail.com>
X-Gm-Features: AQROBzBItZBmx5_N-ynlPw8E_7o3PG43Wcm0ba7e3I2MR7-9HUZsFelf3Nv9M7s
Message-ID: <CAHk-=wg=q7ptcMyUAqPGDbX_DKHivJVppc8bP0zpQqzOky_avA@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Justin Stitt <justinstitt@google.com>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 09:37, Kees Cook <kees@kernel.org> wrote:
>> +
> +  typedef unsigned int __attribute__((overflow_behavior(trap))) safe_uint;
> +  typedef unsigned int __attribute__((overflow_behavior(wrap))) wrapping_uint;

This is fundamentally broken sh*t.

Stop thinking that trapping is "safe".

It damn well isn't. A dead machine is not a safe machine.

Any patches that call trapping behavior safe will ne NAK'ed by me.,

We have decades of peoiple using BUG_ON() as a safety measure, and it
has been a HUGE PROBLEM.

There is no way in hell that we are ever adding implicit BUG_ON()
things that are this hidden, this easy to use, and then mislabeled as
being "safe".

Guys, that's the same logic as having a airbag in your car that just
shoots you in the head. You're certainly "safe" from the vagaries of
bad healthcare. But dammit, if anybody thinks that a "bullet to the
head" should be called "safe", then that person damn well shouldn't be
involved with kernel development.

So NAK NAK NAK NAK.

The only safe trapping behavior is something that has a clear an
unambiguous and simple to use way to *HANDLE* it. Not just "mark it
trapping".

              Linus
