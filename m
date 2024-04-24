Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73C156999
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995077; cv=none; b=s+aRtgh+qPnEC8D44/yAS99VO+Td+IGqIsweafEEk4+0A3OLKO6YqEjxOGv0JPsabU/KAKHnZzHp4/QqNssXfo/PTPKMbseGxYNYVdZjKoPn3vwYHcOYYgVT+gSRQoCatp7g1rPaMJogDl55m0D9PM2NnVsodhsZDrhkDtvQs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995077; c=relaxed/simple;
	bh=OZzQkoDyfS/g02WWRwDMj0BwYKXTWglUCgHk5r7lLoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8SjDxS0D2Qu+fcTHB+fVV+4P008d+CX0IMWf40sAwxsE+6cyVgNriL9qWbwebyiguNnarSKT60mh5Q48ZXFZvQNg6a9IiR3AJrvKEYe7/d6HStaD+0zQLWOu8UkX42b/RC1vTBccBcGsNej6J8ykTRGEvB8oYJB5Qc+qshX/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIHrY/65; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIHrY/65"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-479dc603962so129926137.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713995074; x=1714599874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YP575gq/gmDMB9w/VjeltQDFfmbUMJx+bMv5C2CUKNs=;
        b=eIHrY/6598V1V4YZve336IxuqoRrYr15u3Yr7eOymfIl81s0xC5icrh8zHFVrR4H2l
         ed+hqoGGMxp3vkVxa3mUq8LF6j24vvB8GqZir06jsrgFAEwD5kL4BBXxbTzpUsR+SGzN
         WfAfGQ+7OVNsVam6cITJGobv5VkgNBS4kBPyeGb2bbM4DlOfiAzLayWhodk7XI3SvSKG
         w+VSDWWwsmEUkmN+Dq8d9xAVkFqzMLmcc7DZLf6NPGM54LYF8gukZfjEOUtXSHPG09ZF
         qkRmMUqIKI7kdau0+z9eowqD/pxKMM667HODDUEYZkdUZxR7WH1qtTI2ZLKVNa30d2ma
         0fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713995074; x=1714599874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YP575gq/gmDMB9w/VjeltQDFfmbUMJx+bMv5C2CUKNs=;
        b=wuWzF/BmoERJXRcHPWuqDa2Ytw01JTW+ZzQgM82gkEuPjwuxpXzn5dUJqHYXMrrMwr
         Y7t10N+DUgJ4FzUi5gbOKhq9gy7LkS0fkoTlubnTWSwc/tjGIxVy74MXzU1xqdkzmWtL
         fKiP1dbcxdfQ1tk8vF7Ug8pJZKn4L8EdOI3dZwvmNE+ewzVa2aiorO4bu9stqqjY2jZu
         wDrSw9TelIpW+ptur7Z0SoWmfaF3rI7HFr5vpdK9SEmsyLX3xDOHfXIaBzcd24zMer8q
         pMRx0iJsAwl0tFO98iBEjNgao6XnH1IWSmiknC8OyqlcTsOIb85ZiwIytaCQmaNVkZ6k
         hOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGSo3LeJZLb76f8/lMKeNoc4dNAdKTpRh6ZJuB91Cfi977Li7mcrUfHqHD88BvEk/REQT4gucJf0rMa3VWG7ALXRxXuNhMRXthWZd5BpIN
X-Gm-Message-State: AOJu0YzS/THoGPiUxSXPF/ept7rgMZPDyGhyRzJ5THekErimd3rL0Vl9
	5s7CRPlu4+UF+z5LoPumYs7j5/FF5VT3Uj1zOlkJjAcIlCgI9p1+rox9BG1Zf3wU8/CeSVM+/Xa
	Ockka5q6IqGaJAjJtKe8p3FpGE3hj5dJlCM19
X-Google-Smtp-Source: AGHT+IGibJG1QixHqLqkUPSGmCxwUM9AsgORVqD4w9KCwYrcsWkqM4k9cyi+ROsBfqAKiZsbvvF0RMG/Itxk3zQcbno=
X-Received: by 2002:a67:f8cc:0:b0:47b:b94e:9162 with SMTP id
 c12-20020a67f8cc000000b0047bb94e9162mr4484501vsp.4.1713995074217; Wed, 24 Apr
 2024 14:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424162722.work.576-kees@kernel.org>
In-Reply-To: <20240424162722.work.576-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 24 Apr 2024 23:43:54 +0200
Message-ID: <CANpmjNN1+bZdQJSdc4o0EY4Kpe_L5s3JyT9smAEx4O_w08GaXg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add ubsan.h to the UBSAN section
To: Kees Cook <keescook@chromium.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 18:27, Kees Cook <keescook@chromium.org> wrote:
>
> The "ubsan.h" file was missed in the creation of the UBSAN section. Add
> it.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Marco Elver <elver@google.com>

> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c121493f43d..5acac5887889 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22653,6 +22653,7 @@ F:      include/linux/ubsan.h
>  F:     lib/Kconfig.ubsan
>  F:     lib/test_ubsan.c
>  F:     lib/ubsan.c
> +F:     lib/ubsan.h
>  F:     scripts/Makefile.ubsan
>  K:     \bARCH_HAS_UBSAN\b
>
> --
> 2.34.1
>
