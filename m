Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBC32E136
	for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014725; cv=none; b=kS+7C6E2TgfSXLjJ4H0LKC9cUmNiwKmI8y7xx7rwbAb1fMBfyPlP5PDkxJIMICHZbnWbDRuKOpWG7HTkUvYg5ZSBF4eGCR7j10AAL25ZkDJlYfVkqoaX5FJ8FWpvzq7wpNBP6mKbIm0GTXSpK0m8y5K2axZd4dSez//fTLD8Lis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014725; c=relaxed/simple;
	bh=yoo8TL0UmC0rSkYJxN+UPZMH8vOivVZOVzAfgiZbncQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4E8ibjPVVFt6bw9Tlm2oL5Lgdv9CMVydK/RubpTfSNVn7cFAvUR150oxEjdXQJeiIjREmZfppabTok7Kpe9paafD0r9wIjcktqpjedJjJ7qzaxzhx85/eByCM088UyhDJaVPu32tapnwRP6ojLEl5DPG/p15cSkipPgywLD6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xs4qQXnZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xs4qQXnZ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b73a9592fb8so444171166b.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764014722; x=1764619522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDatnVohjV93iMI1f1dsChXQ08m+P0L1QodGnDzNIIo=;
        b=Xs4qQXnZGflBhxdYMOeX6cDQxXcZwnTKLPwGDM3vo+XyyexoTnIeDeZj0RuqTksK5O
         2D1R6ossqyH/3LWS12CC9i0PYGMHZBtB5KBzdrekvGpr7fuoWcWpt4tPlQJewOlilFJF
         wQsRr914FLMKy8+X6DxeRpNy7PWhFxtt+FB1gnzgSfppaOntZMzWQHg4aR9LZFKYQGUs
         wczNJ55kVjrhUKJcQhv8OQoLxbPBxKN1YRUbzwlR1Ez4rKuUkYl17VU/mSZGx7l+E1hq
         iV6B9FXw3pENOHDQK0rw8NktuQh9q8q7ImhtvrNAEdOHbXTWPbv2/yQqyQtdCm3FJTgd
         wQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014722; x=1764619522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDatnVohjV93iMI1f1dsChXQ08m+P0L1QodGnDzNIIo=;
        b=ky7U2rskllQEQzd17NfdRHF2I3f9WQcX7NvqqhbsEVD6rcQClkWeLh3OjPberDQYC7
         A8zUd6qi4QP7T59M53mXcOKCKcbVFABr3tEbz/VluHGqQWBgzdjEuMB2SsxHzRuxq88c
         Hlz9MGYUvjXA7kp37wm9kbZ7Q5o634L2R20NfAm4+R5wFG5Il2/KRI8hhXpXX/g+94dl
         u6uYUw9aOwRv5xdT97jO/kfoa+w+wv/jxJBVzaosZ3fND5ExYy2hWxXCORbILVIX2paw
         W8jrEQq014x4a1ux/6j4C5tGOxSJAx0/WxMLWsdWHpJV8NK9XHrEe6r6nNmKIEu3XGLU
         2zTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUThOI3OkKWLgRwcS9S6hwR7saEbvZtqSm4Bdhf5Nkb+FhIBYtwZHM8gFJToy4vZvZ8ibZM0t9OYgU+HaERafM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1q/zbYbcEzGr71vQskJ0V6oHhC0NZA+eMFiKIlRlgkw69pJJ6
	H83jPqZt+9LAjy/XH7G0AiDHIGknDYCWq6i0DtM6wyT7pSv6w4cVBx5TAs8t+LwuVlr4TTp+UPZ
	29YJ06TsDTaaT48kAFFSFqNeHBOWR8qpoz8ih3A8=
X-Gm-Gg: ASbGnct/FZpmVgTaTONKTyjP7iYVz5XsFDJaJ0dUBTBPQ8ixHOWowl5MroNQa9DUL/J
	/q3ZkZN8dymCHx4/MN0wjVLHns+vL2WtIQsiOHyzEJAVFAZ21zNYbjn9VWkXCg6SSRmGe6D/LJX
	J94aeokYHPY08dIyKh7Tq6PnV/D230yVDMzR4ueP05UiU8znZl6CLu5b7JNGCS+IiOe4RWyKe2/
	7fV+UP4O+05uyfqEJfXkAD9eRTnAA1yrpKAeY6KkDojd7xZ+NyGArkFDANDHbjBGXX3Fh2xCW4h
	6pw=
X-Google-Smtp-Source: AGHT+IFUf9dyCXHjYnD79GQAeciONLMUwzjqFKX0yRYT9LAjFM7+zLXDNGR6+qos3nnnuSGbrx3NaXS3PlreKRiwl6k=
X-Received: by 2002:a17:907:7204:b0:b73:7e63:2027 with SMTP id
 a640c23a62f3a-b76572f554dmr2029886466b.28.1764014721673; Mon, 24 Nov 2025
 12:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-1-morbo@google.com> <202511211517.539CD58@keescook>
In-Reply-To: <202511211517.539CD58@keescook>
From: Bill Wendling <morbo@google.com>
Date: Mon, 24 Nov 2025 12:05:03 -0800
X-Gm-Features: AWmQ_blyNsMsZzv61KoykCAil7jHYbSewSF_04qxNlQz-3AD1q_UAmkY3Djq8XY
Message-ID: <CAGG=3QWMrs0j59Zt1BEh=8YOx_yeJA4n6v2yJFoxuHBq3COPRg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add __counted_by_ptr macro
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Fri, Nov 21, 2025 at 07:39:42PM +0000, Bill Wendling wrote:
> > These patches add the __counted_by_ptr macro and then uses it in
> > mm/memblock.h. The name of the __counted_by_ptr attribute is the same a=
s
> > __counted_by, but two different macros are needed, because of feature
> > skew in GCC and clang. Once the minmum versions of the compilers suppor=
t
> > 'counted_by' on both flexible array members and pointers in structs,
> > this macro will become obsolete.
> >
> > Bill Wendling (2):
> >   Compiler Attributes: Add __counted_by_ptr macro
> >   memblock: annotate struct memblock_type with __counted_by_ptr
>
> Based on this[1] thread, I think we'll need to wait for GCC and Clang to
> release with the "void *" support first, and then push the counted_by up
> to that version to cover flexible arrays, pointers, and void *.
>
> [1] https://lore.kernel.org/lkml/20251021095447.GL3245006@noisy.programmi=
ng.kicks-ass.net/
>
Would it make sense to add it with the expected compiler version
releases so that (1) we'll be ready when the compilers are released,
and (2) people could test the new features with compiler RCs?

-bw
