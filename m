Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F51B7E9
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942771; cv=none; b=e7yqzwA5d94yu2SYyXnVWuYsuGdru+NMcuxHJW1iUJGe+TSGY8IHb+e9R7iuzqSzlobY5qTYZ60IM5FBQQp7Pmk/H1XfpWKyEAwurZZ6el2Cvn9w0was5Ak2RzSSckFtbFQ+HNfqWSnzmXuBKbInJuyts1GU3RNY5w2B6iLEkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942771; c=relaxed/simple;
	bh=WdScwWSRZMYNWo7qq85UIdpjQhQNKPC+IHDSE2KFxWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNoYRCg1zrS97s4VEdZVPupspuBLq+x9Dgg5V/CncGIllyMMJOMoAeQAEzqv/W3cOEJtdjfebfQp/YXvg9n6Zi1HOLG1OS6ng254VKESfp9w/AssdvvSVq75Q8AflOz1q5ipYLy083Rnsctfe35MLKbD8QM6TUiMmThaV/e09JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lz1S0X2q; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lz1S0X2q"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2777cbbcedeso93802fac.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724942768; x=1725547568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCN3u5a8S33nBFxuXGEHGtvmcxNmqd72t1VtdnAXjS4=;
        b=Lz1S0X2qIwffRqccXX5IMz4YcVbItXr9Uul19bfo1d0h7gtjBfMQ1HhemHWne/iCQH
         /MjkAUDcfJOP99PRd50Bk+lLSj3zKa6dhLbHOy8lg/KvCsEWVMLDKiqlfoNfSh+N82QU
         nner8vH+d93BkZPu/jpVAPmKR0xUo20y/d9xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942768; x=1725547568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCN3u5a8S33nBFxuXGEHGtvmcxNmqd72t1VtdnAXjS4=;
        b=P+tPOWX/DiC9SsuqmYvSgU54zohdMe0Xuh+MGJBsvpL0PpqOH3K5PHF5uAKz+SyaiW
         imgxJVWvL+EvxveT9qWjBI99aUAoGubknAI7elpb6VfkOfaU1otCEYD4txXps0V9H3KR
         /AeVGR+iy/iwbjr+zGZJJ38s7ULYpbwMavkMsbyq/bzskbi8vJ7NRv82P8TUT9x1CzNK
         DSZhjOJcsdeTcq5ZGEgAObG+tKitVBlrfhq1cVy13h55OzB1wxZiMo2hDyQ+hV3BPXT1
         uVwGmTb8iz5+6iuWNSVkFCkgyhAf/WdsY3YuHzrGFdJXEbNvMyF0+JcK6ErhnLzCDzK7
         IcqA==
X-Forwarded-Encrypted: i=1; AJvYcCX3h3xp3NQOfJvo1qCORR1KaomOnOfWRplI2YDexFuymy5nVqL5QdEkUmdNN7PoYUkWQ7zWIEp3s8AtB9rZ51w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5hj4KnPQPz+2HlaZn8e1R+T9CY3uKwkU68/mE56KO7nlo6Wh
	dxcJd3mqN9EKfeb0NaOzysbiPXyVQndx5FotKj6sQbRRLx5mNq8i2KL0Vs98xRtVG7ctCP9goCR
	uqQM2aPUEjdR0kU9xtIZI/D4ZXUEwSB1lEMDT
X-Google-Smtp-Source: AGHT+IGSnXMxyJ5pdcjfudl0GOhu+trj+LwVbeI3RMw1yuYwl+wqVmSHr46eWWVKC1gi7bGtjX/ODI6VgTElteFKUbQ=
X-Received: by 2002:a05:6870:702b:b0:254:a7df:721b with SMTP id
 586e51a60fabf-277902c5ce4mr1741754fac.5.1724942768516; Thu, 29 Aug 2024
 07:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
In-Reply-To: <20240828225522.684774-2-jeffxu@chromium.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 07:45:56 -0700
Message-ID: <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, rientjes@google.com, 
	keescook@chromium.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Andrew

On Wed, Aug 28, 2024 at 3:55=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> Add more testcases and increase test coverage, e.g. add
> get_vma_size to check VMA size and prot bits.
>

Could you please pull the self-test part of this patch series to mm-unstabl=
e ?
It will help to prevent regression.

The first part ([PATCH v1 1/2] mseal: fix mmap(FIXED) error code) can
be ignored as Liam proposed to fix it differently.

Thanks
-Jeff

-Jeff

> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 826 ++++++++++++++++++++++--
>  1 file changed, 759 insertions(+), 67 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index e7991e5fdcf3..4b3f883aae17 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
