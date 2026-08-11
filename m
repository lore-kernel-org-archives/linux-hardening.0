Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140934A3BF
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444986; cv=pass; b=UkvDJzN1852ruQMR8sdprUn81A6963FLDDP152Pn5rNiqcNPXB+DUF1jKKY0XmqaAPHPZhW2FJD2hDFHtFv/gzfz99VU762qVSmLUawkG3XhVA3BSg6hIgTcsEO6GCdA1e+4oIESRGrwr6V78uwV6stiGi5IukuKZtrVEtcoZYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444986; c=relaxed/simple;
	bh=LVflf2UgyfSsYweHU9p7zjfUSbq+FvCgsrym1Xz/zsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbWcfvVtyCseMqOFFOeNmsHcEgZaa9bdxgi3vM2Ho8E8PkxfuC7qjjyZU53RomcfPAC6smbbTfeCZINpj32OxK0lXHbak/IBKvjDnab3tGK3J6ZIQf4BdhWu+A11a08tCR9RnAR3RAL3yYPQYpO3oxvZNDs9PDM0k+Gyl3OMxe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XhTDhSJr; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XhTDhSJr"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6682259cb3dso1499920d50.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 03:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786444984; cv=none;
        d=google.com; s=arc-20260327;
        b=hZF5J8QkCq3iseit+ftf7I43zHm1flkWy0Zc42vAJLxxrQ5qmsblsb9nKhD+zqX/E0
         dskJ9tK7FbrcjcGD55zE7VYBoD80HPbNZS/xNOhC6h3N/biqRox5cZS7iBUz6zT3qMFd
         yWWZUh8c6tKHvBXiNjRGp5K2dj2bv2aOyzJEj6UvXTK5iYJsTnHldP0K4RuxgyfSWgiE
         mWA3yVo+it6uPWa086m9k5sZbEz2cC9oTKrdFhYp61U4l3jVAyrDIu9OLDqrpsY7+LMH
         3xnOob0rZrZFgqQUJBJs+kiwOF6XbebFji7mVKSwajXOxQr2/+GwRDZVbS5XtAeB8ltS
         wTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Oz6X1R8GckZtlbq2KDQgd4vDbT801uXejGt0Y0BU0c=;
        fh=WHCNdLkfWRa6/Q38ts+aESrGpw3ko4XaytR1BPsWico=;
        b=Td7rl9dyHPBlNg+5dwhmNl8yf25wIZU12B6KHBYaCkOQbWMVhhyzLDcdhLa2IWlsVv
         ol81lfr5gkDkKPktojHk19tmrmQnCYa0pRzFvIa/2ALbYMHo1ecGKZHkWKprlbAHTGO9
         KiP4TMmL1V0u12gOnjKeVO3R9VLdKCHLZRsoge5t8a0Atd60u/50wpoexYMKWKGM8VlL
         naIor4fcNeeojBZTBJOI4rwbBm6KN9n64KPzsS2JZZPJGo8tHvFYd/mxJfpoZgHdWJQS
         J8V0eiY7qMQqpgGVRT5NlXNWOfkXF2cWY2dALZuRfzjC6e8jFBrE15VYMSOeEUvUQOqG
         JFew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786444984; x=1787049784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Oz6X1R8GckZtlbq2KDQgd4vDbT801uXejGt0Y0BU0c=;
        b=XhTDhSJrNyszXt0p3eu4sr9LjhqBXuXMmbbyMOX42PcJlwJjn5IXb/NKODR51jd6pa
         mFhwih5iQ6NGfhSr0uctRhQhLCQre6m+SPZfhiHrGo0x8hoJEjelqRB65grSIPBwAMh4
         6igdgfWa3OrdAIgZjDVQQ7kD5BZk7YzWpSHq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444984; x=1787049784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Oz6X1R8GckZtlbq2KDQgd4vDbT801uXejGt0Y0BU0c=;
        b=eXR1EpM2YHfr5UCoYCmlP3m25QgFEKg7ZYpF6/80n0AJ1B5cwzH5ab/bt+hejd8Xhc
         kD8Q19Gn9y1Ii9bsVw3uyfRn5Q9kiaVgObFdQfAhXmClwLxYgYgI0SiKQTtzoP5Uf2N7
         qSc+Ubjqz3CgB0308ktI7AhVaoAgF+AlhNds1YxLMkNyREEPgypxvXVjyblcnZ403egS
         qTlCHmghMpE5CuyUbM5qZ3nlJNrmwoow8Aa1WGYFm1DVygLYXXj0fgJlS35Cu9Tqj8PS
         bzo+Hz0DGpx05D6Miwo45+Q8zvh0DG6iYYPMnOxiwAVta/a5yN68aniBlLAjQaxk7TaD
         QxJA==
X-Gm-Message-State: AOJu0Yw2Up+vXLcbDgKHb2zCNwdWP5cldUdvfo2rzys3/CLM+4dDi+rp
	UqNQKIs4mLdjUAWe53s8LyKdTn5MyCmsvX8UfJXDWbWxnBAwCP4xkbsjiSWzZfxJxBwfkEuB10G
	V3OVrpIKr0qi28YF32MSd1RhGn/zc4lOP7qeZmCW2
X-Gm-Gg: AR+sD10DZBjkRFmI4Ci4hTAuyHyqmAQ0rWClizh7aujSnt0zkB7CM3ndOtFpzxCbawo
	GRXWbBGaEIJAqIxHtRnwTcWn37X7so9LuG25P/GEkHQftQevfmXnqEG0FIB5EMTb2RoYzBvrxRy
	UCyStKeuU/caNFtG0br4UbTHBcoHRjXSTjQ3I7lN+T50aMxL7/2OhczysKOpWDypfXMGvxSOqk1
	EjNo0QGt5IES0UXDHpN1g6BIiEBJWo4B4Mwk1XlzhbmiVH1QOsi+pppl/QQMDadFTi4ZPYn9wrc
	Lri02Y6s8qcJpGWDlA0hdMHzQXLZwx3kM2iAXYY998L8gVKfKz0UuDYpPDA40CJM7OfngIvWl5s
	=
X-Received: by 2002:a05:690e:4287:10b0:664:a8fa:19db with SMTP id
 956f58d0204a3-66b23261c52mr1028056d50.5.1786444983969; Tue, 11 Aug 2026
 03:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811071319.1352016-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260811071319.1352016-1-andriy.shevchenko@linux.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 11 Aug 2026 18:42:51 +0800
X-Gm-Features: AUfX_mw2zVb_vFGPx3jyH7jSGnH2x7oo39c07MI0A6WmTWV6N9h72WrxmNE_5ng
Message-ID: <CAGXv+5EKtcEy29oy=8Qah=1=PXXMds3BvR08u7DQ656FB2u95Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] string: Introduce __free(kfree_const)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 3:13=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> __free(kfree_const) may be used in the cases when one part of the code
> relies on the constant string literals, while the other uses a heap
> (via kasprintf(), for example).
>
> Requested-by: Chen-Yu Tsai <wenst@chromium.org>
> Link: https://lore.kernel.org/r/CAGXv+5HGZwAKpGpyV4=3DQHfg7yBQPx-syc1Gma2=
qad_tzW_RLog@mail.gmail.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/string.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 75bfc194ad20..6f3501b56c11 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -294,8 +294,11 @@ static inline bool mem_is_zero(const void *s, size_t=
 n)
>         return !memchr_inv(s, 0, n);
>  }
>
> +/* mm/util.c */
>  extern void kfree_const(const void *x);
>
> +DEFINE_FREE(kfree_const, void *, if (!IS_ERR_OR_NULL(_T)) kfree_const(_T=
))
> +

Matches what we already have for kfree(), so

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

>  extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
>  extern const char *kstrdup_const(const char *s, gfp_t gfp);
>  extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
> --
> 2.50.1
>
