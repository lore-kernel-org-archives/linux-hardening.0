Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC91CB309;
	Thu, 10 Oct 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582630; cv=none; b=j2tp+OCItrWVzPl1Rqv2tJkjogxVNWT1mAZMiSGS5kLiDGhnwGReQzGzyQ+PFtgmRFNd5IwQRxJz4IYCOP1LQ94x2suRQtL0/n5zN9Fk5tW8o9Vc6NXBSGTg7ZLY2pj48Y69H2y4+O+Ew8wHxQj7pJLe1HXwFyQUTAhHTu0gAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582630; c=relaxed/simple;
	bh=pUYajRi2n7G5qCJnnhPRK13bQLGsrt6/If8BJH4VHnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJV4JDItYyZAyvJmS9F3wHNIr6P3nemYww0pHqlrOzNeOqXSsnOk0IFu5bZJJvwJzKVqv4eGIeVe4SM3TsfWfaukepaDKZ+kGyZvG91jsIu4QXeLDyI7vy9FSHs6aWnCU/acVfgqmeeFszRE/dqXkLl0AzyzBw+ZdFNfM0T8pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk5GwsY0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk5GwsY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FEEC4CED9;
	Thu, 10 Oct 2024 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728582630;
	bh=pUYajRi2n7G5qCJnnhPRK13bQLGsrt6/If8BJH4VHnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rk5GwsY0gjDOfZ/aX/F+VXm66fr68aUu9s3pll1w/1De7ltQV8O/BetYhH9pqitHZ
	 QGmbNA6SK9EYvoOLNTd06CPA6QmL5QyXTLSClbPMjZ5kQUA1CZZO5NYyaY47fGMxlE
	 MxnG+uBIcuf7pKqRXQEIzIq1R7EvEksVfNLTXdDazTjXw+WuXI9zactmzS4lThMaC6
	 afmOaYxJT/xVEqDbQ+MKFu9k06kvLV7D+LFlNDt2vB7rM0Qgyn4TEKeC0GnA2tTVXx
	 JGY9232aoIHWcJ9Vmaplu59IXe5vh1B2Eds3uUdWTzFFqpSsMIePMQu3lSH9y7dawU
	 3xE8zvR/IQmFA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fadc95ccfcso12920371fa.1;
        Thu, 10 Oct 2024 10:50:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiDlW0Uk6oyS8mLWnB+OFppQ+shjcSgoRodoS38xdioqtrZlqjfNHepbH8PRhYrcuGr4fWv+WfhJ4eIwhzpqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmJPIG0M9jh+a1LzHJ4cx//+IO6EBGBCu5P1SLco9HaVZPzT3
	rMXwr34zf155iv26cqmcyrbz9oSet8CUsv/igZ+N3nm610aw2RLX0R70eHpRNkRAPi+EG5zsnc2
	Vti5sQr2aHYqYi3IjLIhuCzGmiH8=
X-Google-Smtp-Source: AGHT+IETNbIV3bLEGPXj15vBbg83kY3qeg53JDA0AhiK/RXoGkPNvxclnUD5zi6uuyXBN7BiOyaiI3ISEcsp4cPhvE0=
X-Received: by 2002:a05:651c:1548:b0:2f6:9787:5fc0 with SMTP id
 38308e7fff4ca-2fb187f7ca5mr47115911fa.40.1728582628460; Thu, 10 Oct 2024
 10:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com>
In-Reply-To: <20241010122801.1321976-7-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Oct 2024 19:50:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE_ZQG0B5fTTxQUWB5wUQPYVgP3TE5Z4ouEXZtyhs=CQQ@mail.gmail.com>
Message-ID: <CAMj1kXE_ZQG0B5fTTxQUWB5wUQPYVgP3TE5Z4ouEXZtyhs=CQQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Improve objtool jump table handling
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jan Beulich <jbeulich@suse.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 14:28, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Jump table handling has faded into the background a little due to the
> fact that jump tables are [currently] disabled when enabling retpoline
> mitigations and/or IBT on x86.
>
> However, this is likely to come back and bite us later, so it still
> needs to be addressed. Given the difficulty in identifying jump tables
> from .rodata references and indirect jump instructions that often have
> no obvious correlation, it would be better to do this in the compiler.
>
> This series implements [on the objtool side] the suggestion made at GNU
> Cauldron this year to annotate the indirect jump with a R_X86_64_NONE
> relocation that refers to the jump table, and ensure that it is covered
> by a STT_OBJECT symbol whose size accurately reflects the size of the
> jump table.
>

For the adventurous, I have a branch [0] that implements the first
part of this in Clang.

Getting the jump table emitted as a STT_OBJECT with a proper size
shouldn't be too hard either, but I'll look into that later.


[0] https://github.com/ardbiesheuvel/llvm-project/tree/jump-table-annotations
