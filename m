Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B53C73EA
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287092; cv=none; b=RGzChLaCERO0L7rjj8yh18+32vwE4VjPDYCxeNkzkzSdGWIpuldG42P/BTjYAqcQSnFU/lQLuAEITVJSh7k4Da8ChZuA2Wt+RfZnpDfQh8x5lI32maqeU9WV4CO8c3a7N/ZAAMb3+g27PZwoNoAMKQ/HF9gjOxBMdEo9YCsLmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287092; c=relaxed/simple;
	bh=WMEzb+z2R/Ebv7MXNRyRYB90UYi3mUjM/WddVtrOgL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM1KmjpCHMrtu9NCaFtZK0ywcFep7EYCqjXd45+ysx9M2bOkpPSfifIGfdD7vFHd1EQTu6JZiGSzUi6bQkNI/hvK8lTARLD9vlmPCbiA1uAoEdlWDWO7++KwWvfsS8xB611nhrHcl9qykfis1Voo7Dm2bEm/9Q/8jmjSOZpe5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+iHA3wO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+iHA3wO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4789CC2BCB7
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774287092;
	bh=WMEzb+z2R/Ebv7MXNRyRYB90UYi3mUjM/WddVtrOgL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W+iHA3wOhujsyJbs6w4RQDse5hzE1e56gEVbVJ5vSdN3JtI6aOpg82idSQDr/jsXe
	 LKJD3E3zN0FbSz8TkDP86zFWQ3T77kQDh8uffZzPOexlckwmuFu4BCMNmx4y6IvvYs
	 mZM5lMU8aqEu5e8Y4A8SS0BWUb3t3eaFko8O2tN2UJRRpzilYyuZHqOOG4TrPZqJKF
	 XOEVLhVU1/e/ol9MraHs7YgYAlKMgVc+BVStEgazktW5l6EM1Pj7tuaDbN+DOwKvq1
	 /UzaofdeYeX/kKxS4Z/FqlTZe15t2M3nsgxkCoftFwdkcnGlJc4HeE8e4N82Jhdoyr
	 QONC57t1jE/Og==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67c641dfaceso574893eaf.3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 10:31:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhWjnl3sJiSzycvkHtn4W09momfEU18S09aejUhzGP8sgMjEQg17RumuRAfRRzLugCdDyi/mxuy2ujXqnlTUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeyY0bCRjjuCS1DJjVJuo1pgHB5Xj5a3xVzBBIZ9jYSDsTBrcU
	lJJXybHDunlDU79gPn9Zt4UHuTFeYnALhixL/YoJCocJmXGK5rHUOfcNZh8hSc20+OAAjzPnvGV
	R7fnFLa7pXbwjPZByUwNBf/YXuw/Iu48=
X-Received: by 2002:a05:6820:c8b:b0:67b:a667:f523 with SMTP id
 006d021491bc7-67c22bc846bmr8961081eaf.11.1774287091260; Mon, 23 Mar 2026
 10:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323172451.work.079-kees@kernel.org>
In-Reply-To: <20260323172451.work.079-kees@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Mar 2026 18:31:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOS7j2f-wkmvarULCS-1+Zio2hOz2ExMvFXN61OPv_tQ@mail.gmail.com>
X-Gm-Features: AaiRm511fQ8LgwTtKLDfC_39JGtLn36t1l4E1AjL1fUpHGTp1bx2ft8EAv4Abw0
Message-ID: <CAJZ5v0hOS7j2f-wkmvarULCS-1+Zio2hOz2ExMvFXN61OPv_tQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()
To: Kees Cook <kees@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 6:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Replace the deprecated[1] strncpy() with strscpy_pad() in
> acpi_ut_safe_strncpy().
>
> The function is a "safe strncpy" wrapper that does
> strncpy(dest, source, dest_size) followed by manual NUL-termination
> at dest[dest_size - 1]. strscpy_pad() is a direct replacement: it
> NUL-terminates, zero-pads the remainder, and the manual termination
> is no longer needed.
>
> All callers pass NUL-terminated source strings (C string literals,
> __FILE__ via ACPI_MODULE_NAME, or user-provided filenames that have
> already been validated). The destinations are fixed-size char arrays
> in ACPICA internal structures (allocation->module, aml_op_name,
> acpi_gbl_db_debug_filename), all consumed as C strings.
>
> No behavioral change: strscpy_pad() produces identical output to
> strncpy() + manual NUL-termination for NUL-terminated sources that
> are shorter than dest_size. For sources longer than dest_size,
> strncpy() wrote dest_size non-NUL bytes then the manual termination
> overwrote the last byte with NUL; strscpy_pad() writes dest_size-1
> bytes plus NUL: same result.
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> This touches the ACPICA component shared with the upstream ACPICA
> project (https://github.com/acpica/acpica), where the function
> is named AcpiUtSafeStrncpy(). The upstream codebase uses its own
> platform abstraction layer (acenv.h/acgcc.h) where I've mapped various
> kernel APIs before like ACPI_FLEX_ARRAY and similar helpers. However,
> acpi_ut_safe_strncpy() is an explicit function implementation rather
> than a macro mapping, so the approach for upstreaming this change to
> ACPICA is not clear. What's the best way to land this?

I can apply this directly, it shouldn't be a major problem for porting
patches from the upstream.

> (This is one of the last users of strncpy in the kernel.)
> ---
>  drivers/acpi/acpica/utnonansi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnona=
nsi.c
> index ff0802ace19b..3a7952be6545 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, a=
cpi_size dest_size)
>  {
>         /* Always terminate destination string */
>
> -       strncpy(dest, source, dest_size);
> -       dest[dest_size - 1] =3D 0;
> +       strscpy_pad(dest, source, dest_size);
>  }
>
>  #endif
> --
