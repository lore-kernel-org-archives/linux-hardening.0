Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9302066C6
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744061643; cv=none; b=vE/uVQ2eyN50GOeP4I4harvqMJLQNr0AXuLZgVKylwQJX2izV64294RenxNwz06R4aldZivTYxZmleMjqMqoGlyLWec+L7QZSZh1gzZwFOOBNky3+rqwrcLe9AX8bP1AfVWzKtF6J3BrdX3XFS+5TEzlxOPcxBQ6IixZlGVecVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744061643; c=relaxed/simple;
	bh=c1iUpbhcrXzPl8Azbq+GjxoxxV7VV/BdFZJ0L+31bsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orITWiGZuqNQxeBgzCuO2+JU8eLJogppHu+AM3xgiFNDtlM79guSBy78KLTPQvCsiC4O2vMQN4DC6dXAEupcLZanOBDk2avYtmCwo0jDJifDIHfH+mj8bn5UBovp8a+jY7mJr7wZlu4eaxp3vN6gUh0harOrBL4iblIcRGHxeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aiejd4EI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aiejd4EI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so645923066b.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Apr 2025 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744061640; x=1744666440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ypbOCgQfA8w2KdlopYIWQGlt+OxpNY3XdMomop2Fvk4=;
        b=aiejd4EIP2nUYMWLlu/FO8SNlEGFpvGGwAnxvD86ktnj0dMjdZcU7fASMhyZEeX2KB
         +xCsmP0Bd93+lo3/XZ47E6Zm4nT7yMd11BSk0bH08zehYBNVlYPFIS4q85bLUVj/aI+z
         10cxeM2FyW/6sUDN6rqT5OYCTTYNQO6njg3xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061640; x=1744666440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypbOCgQfA8w2KdlopYIWQGlt+OxpNY3XdMomop2Fvk4=;
        b=WmOouCRQ/txScdm17IiLhRSltswhVQi3av0GT+X+UTsrB8sFMgl7PiZR2Enp88/ZB8
         kvi7IHQIM3kasQ3pF46GkoDo47QLqOtj1PCBVb4X02dEuYGluBe6Cf6gP+VNWWVca1zR
         HCFrOokYx8oxEqlZ3P8py9LfQYViqs0hBuY8upOh6nQs6SL8EMHtfubz34qMTO3BD/zS
         2ARh8k0risrNUTHi6LdVBInO3iGWAo0UX0FXodjN5g8RuERazuPOmhPV2+wFr096ekT/
         HLA4SwXowi0BceHimqzYl8hFQtNJgeAjsVHYOP7rBLxHikhgwvPw/k0+k9GenguC8luJ
         Hg/g==
X-Forwarded-Encrypted: i=1; AJvYcCXi7mcdSdYKvcLGgQOatbOU8o9P7LYeohw4cSWTZgLj4YnXJZVkn/2Hx3Z9SJ4+zhO2SHEzo1n3xYOH5Os8etg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxalOmqmFh/9ifC7HFA7FOC4ACIaKcqkuLCq6vIobjs2J6BP6f8
	a+mz3TGGc+5GdOD1mbtk/va6FG3QiP9ygvg5U9dK5w8xE6lHRx0errJ2XCW4v9OSezmKbKXj6FQ
	bBBk=
X-Gm-Gg: ASbGncvIsEMOwIY9hA8FyUYLejhEM+8rWC1QVfCllzmfru1spBV7jA31ShSIMhHpNK9
	WEswV6gZCBUuvQX+RvHETMywqe+ZkoF/IP+W0WYEnFekktLp57KW3GeZGfSOrt5rr5qetfhoqkq
	Z+Nb7x8utL3rGcTBvIFsT7UPOYADesyLbH174gHFcNwI70bqkYyIUJajq7gaDj1DE7LIeIDHwkV
	JeQ3XHCfmdjx3zsvmYitLQbBGjV4wU7geIyiXbeIHtkwWXhMM1p6gm3DHgainrYFRpfiHvXtUjB
	pNXmARILzawoLE4kq9+0vqiBNyFLJH/23Uei9mmbNj0xdh3fR4Oe+oiQryrswnCc7qFsAh8G9w1
	BC+o2Wbt9LFNJKWOx+BQ=
X-Google-Smtp-Source: AGHT+IFjFxf7dU4v66+f++dH7CYSoJzV4mQEK/c4kSE1di9xrSADismH1hUDAAFKUwTJv2sQVkxO0A==
X-Received: by 2002:a17:907:7e88:b0:ac7:738c:996f with SMTP id a640c23a62f3a-ac7d1755403mr1263330366b.15.1744061639658;
        Mon, 07 Apr 2025 14:33:59 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d3d8sm806415066b.31.2025.04.07.14.33.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 14:33:58 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2963dc379so801240866b.2
        for <linux-hardening@vger.kernel.org>; Mon, 07 Apr 2025 14:33:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUvFsBJmHR7nGIC0/akKasn5rV6MMySLCjQwMgJLWBB01BcuAwF3n6sFsPImaNW3wTHNGI2RpYP0tJaf4ImkI=@vger.kernel.org
X-Received: by 2002:a17:907:3d87:b0:abf:6aa4:924c with SMTP id
 a640c23a62f3a-ac7d17747cfmr1256778866b.17.1744061636768; Mon, 07 Apr 2025
 14:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
In-Reply-To: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Apr 2025 14:33:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com>
X-Gm-Features: ATxdqUGKkDY0PVxsE-mkdFJ1IAX_JWpY62Qh1ZEnaMl7fepQQaa7Zys4sYl5c8g
Message-ID: <CAHk-=wjTbWiYwfj2wF9iP8SSVk2A_cZFDr5hu1bgU_PfxhyiiA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 14:10, Mark Brown <broonie@kernel.org> wrote:
>
> Arnd bisected this to c56f649646ec ("landlock: Log mount-related
> denials") but that commit is fairly obviously not really at fault here,
> most likely this is an issue in the plugin.  Given how disruptive having
> key configs like this failing let's disable the plugins for compile test
> builds until a fix is found.

I'm not against this, but I do want to bring up the "are the plugins
worth having at all" discussion again.

They've been a pain before. Afaik, the actual useful cases are now
done by actual real compiler support (and by clang, at that).

Who actually *uses* the gcc plugins? They just worry me in general,
and this is not the first time they have caused ICE problems.

            Linus
