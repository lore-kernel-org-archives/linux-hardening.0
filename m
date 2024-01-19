Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950259173
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jan 2024 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705708804; cv=none; b=GrJQiUgk6k5zFp5jf7o9/QTJbqzy2kcDbhGsm4PnmlkU66hRjdT9XY4TvI16W2vbBISRQI9PmA5C3X+I7h1WfL26V3akCBhQVzbtFmhirt1GieEBkwc4xVC5MHIpOjsLfi/oK9BSyef88/My1ymf7mJsoSWky+0n3TwR6qhjilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705708804; c=relaxed/simple;
	bh=2Q6PXCNZrdoKAZHFLazUfCoSdXno+GFbgX4A6oP8KSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoGUSA5JY8LdLKfyTNDDXgSkdJkpFGYpPhStkxe4G+eSBkYpl+0ZeHlQomG41TRBoWOqYTk9YOB8BsIAZXW6XlBOxjCaC9CojBtXgnKKn+ZM4Vkmja/ChJpzc4653ipTNqaFurLwUEHnJsIetfmalkN9TMU8ErksnowIYg9jnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZlTm3ICR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZlTm3ICR"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2fbb646eb4so26675466b.3
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705708801; x=1706313601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOFYb/RTZy8MO7nlFfaeJozsL+6Jsio6dI6byv2M1AM=;
        b=ZlTm3ICR3ZRy0BgfySAy6axvWXSQt5OZO5B9Ol118+A9siYwKnWX9mSZBp0lJQYN1u
         gdKmE8BpVMknKVWR7HwutEGPUGCvwkrgjdO1g+XtNmV44XC6hsrWavTRRVA+wFhokcbx
         80tY0AyvD/6WbcFCLH/LhmUWjvWdo6B1bIpYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705708801; x=1706313601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOFYb/RTZy8MO7nlFfaeJozsL+6Jsio6dI6byv2M1AM=;
        b=HIrJtbF5aHXlPHuP+WkqYPJdVITbGPriN/CmOvQiQkOCyOqcxFD+Zq1DIGptR5PCXS
         l4Iq1v4pwAbrPvPfrZIq04YRkblQFyTzAwwTLOewuhpt9fH0OUxmBR9iFpv8Y6XRMuaV
         kn30fK1+GMNxHTjdbU26l84f43zgg+kqrYhvldwnBpex/eN+NXUVo9FNXRaWMXoCsCo7
         +bzumKun3lYWe/XgND5VzbkaRBj+I19i5jcsZzM8LigogteROhBGcAHgSRgZJgj6vKcw
         WNHXO6G4484cdld7S87pzW7WfkB1i07g4kbnxG21XGjBSFP7TMxnad+H8mMCaZMuwFGE
         JGnw==
X-Gm-Message-State: AOJu0YwoSbnByfbPYhRKfzI5wxFOacXm8Syc4pxCv1/7kxLqTqC0qYJ1
	vZOq918kJrMjnZuZDp4ZXcmJ+AhEGAxDxV4p4KQE42DNJL0dFeujLphRGbH99yqhdwfryP64o5n
	Hxl5tfA==
X-Google-Smtp-Source: AGHT+IGAzxs4UzYYUGSJ8DsVOjPrSwdLPw6DddhIvl5JveBT1NM/0opdaukrLNcnl67br+oBi1Eq+g==
X-Received: by 2002:a17:907:320b:b0:a2c:c51a:b291 with SMTP id xg11-20020a170907320b00b00a2cc51ab291mr323210ejb.109.1705708801343;
        Fri, 19 Jan 2024 16:00:01 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906298f00b00a27e4d34455sm10757234eje.183.2024.01.19.15.59.59
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 16:00:00 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a44bb66d3so1518169a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 15:59:59 -0800 (PST)
X-Received: by 2002:a05:6402:228a:b0:559:b648:b954 with SMTP id
 cw10-20020a056402228a00b00559b648b954mr243986edb.47.1705708799556; Fri, 19
 Jan 2024 15:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401191311.B6AA79D@keescook> <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>
 <202401191450.CAF805687A@keescook>
In-Reply-To: <202401191450.CAF805687A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Jan 2024 15:59:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whu2k-PwHVZS4uKj3kksVUF_Fqzap-YXwnVKeC6S9pBNg@mail.gmail.com>
Message-ID: <CAHk-=whu2k-PwHVZS4uKj3kksVUF_Fqzap-YXwnVKeC6S9pBNg@mail.gmail.com>
Subject: Re: [GIT PULL] strlcpy removal for v6.8-rc1
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Whitcroft <apw@canonical.com>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Brian Foster <bfoster@redhat.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 14:53, Kees Cook <keescook@chromium.org> wrote:
>
> Sorry, I should have called that out in the PR, but the commit itself
> had my rationale for intentionally leaving those in:
>
>     Leave mentions in Documentation (about its deprecation), and in
>     checkpatch.pl (to help migrate host-only tools/ usage).

Hmm. Yeah, I guess the host tooling is an issue, although there
strlcpy makes a lot more sense since I think it exists in various user
space libraries (while strscpy() is kernel-only).

> If you feel like that's not right, I can either respin or send a
> follow-up patch?

Oh, I already took the pull request, I was just reacting to leftovers.
This is not a big deal.

              Linus
