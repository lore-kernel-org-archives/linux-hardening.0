Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794233681;
	b=PHr+LDznAEK7U5cRztmM+r+mBngrt7GzLbA+x7TvYQZmTM+S2wKGiI1XXIYM0Sn5eEsv
	 Xs9s5XQf02bzCucyV2DjZ7NThwamykYAtoxG5pHmjrFOODm05AFHqMKQmujRD41cmpAic
	 +KyMlbtIbjVUmW/B+qsBuirg4TsrdKcsHIlSDzxwU7d88mBq7YmlTIfJlrwqFqFebooFy
	 9M6Edt5uKBJBcCadK87Fvui4SpfazCQ5aPwldgwNZuoZe0ARosolxN5lE6EseXAbvDXdk
	 XSmmJijSH4tDGky0+7kTOyq3z4dG+s/0UjC/NweS+Jxpgv7xeqflepGWct9oKB6qKzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C9mUjzXalHv94qx96P0J3reYmh+gRnmsVzt8eaOGm78=;
	b=zE8j0oSAahe9J//tIRUobzbdhtpKg1wiJ2sNQkTdD1sw0+LHOXWNNdE9GQl9WcfNIWV0
	 qpxOdg2/m3ewnaVirPnAndSpPab4GAHQ+Cu5vwEiXhrDNpuTQqiopuJ02xcaZkXRhYFhh
	 /I0mZgdhgiqbG8ulpQh5ijsUXht82MqZBkoOnWvjRJh8Rx1kqwta9sEkazcpOC26UtBCb
	 AJHHXVqngjaExKJxnmLtxuZr9gyl63sg8Rpw+odkdAtu0EKmOvXiR8CxhEfPeBdi1l5x4
	 lO5yQBn0DYSXxiQJu35XgUu7DcnqPuS7Iud7j27K8ZTL3+xyxS/7M09oRkReDfa93sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W1FZi+2c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4A606A337
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 14:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16B4A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W1FZi+2c
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ece6c1d1cbso253144e0c.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Nov 2026 06:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794233679; cv=none;
        d=google.com; s=arc-20260327;
        b=DA7fOJ3bAQV2+0QOajkUDbBVJYLp1TwVhRIMtnAxoDVcdzAQviG+DequWs9E7+8VQ7
         bk5XwwTbdqujEuxRe/xKiRrfUdFGa6x0tOOcN65CFecWZZnBaPdHVLmYIzxEZh1lMDts
         DtSzeYGoIbhsXIRJLQc234SDVh3895323OoC7AT2WiCMEGUaWXdKDacec2HkXidYFc4b
         u6yQ5xaHaFTbPIHsI7Dhye0ryGwNt/wbYN0Awsb7Rdx34ps1KNZcl01rIXwHww4jOr6R
         7jzeHTSNuKgSenFGpcgkUhYLli6pVM05PQLel/kt7BABYlH3ylkEWooVEPUFTa3j5nkm
         7DEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9mUjzXalHv94qx96P0J3reYmh+gRnmsVzt8eaOGm78=;
        fh=5GiLNMnC43tGgxxq8JPHnH8i2ZKCy+SyphqsqMZKyM8=;
        b=P6ZzIsT9uryD39ywZTjbAMOe+5SYD1AcMdNDPuW0OLLSp9VVnT6NidIKO5b8FEyiNz
         gkqxIu2EqKwvF3ZPdpuWt8+8lhrgJDylpGNTXx4wqVRe/qvd88QcaPP44o38pKArhznF
         /FfV4tZg6pxWwPBfjZrblgWuW1o334901giSHiBOpqQGSEfTOcrfwJIXmmvrAc/QaeFr
         Ls6SLKTecRGTFi1wVbTmXdmYvnHnpKKAyqjRdaK4UaQMmnM4V7EBqHRQmfkmnUaqNjhd
         ckJtneA/SMchXrB+L+51mVqMEmPYn8+gxSMwqzL/5Gbvci+RSyGAjSKWZz2ezmuUlkrY
         N4EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794233679; x=1794838479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9mUjzXalHv94qx96P0J3reYmh+gRnmsVzt8eaOGm78=;
        b=W1FZi+2cjuJ/Pd5UY7IKO1Q2TxqG6+Wimax/h1l7sNRrlCVEqwNPHbl8D/GreBLxU6
         /v9GOPr60u+hW2mo9LBUmFNVLSUC4tKj0E3UCldtVynb3rtpfoImhFCbCJJCCFSvaNCm
         3ycJwOCfXjuy35io4Y5gAXXa+/DH1w6XAgtTqbNrLuOlrwxy023k/ZG2GgIYD6jjxmfh
         9d43WO+UNJ2n4dyEqsQlcDCt5CPhTISBP0G+J9HpaI58Drjw9tHvPX7zzGNETTF+FZPR
         5PVnzRi+Id6uR9XjSfimvZDbqFIB2/jgvV0Dfd+sZRAh35KWVtWjPJIY1spbfSkcqJFb
         Jrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233679; x=1794838479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9mUjzXalHv94qx96P0J3reYmh+gRnmsVzt8eaOGm78=;
        b=q7hraVx/XNpaf758TOjezezTvjf4tbkl4Ed1R2qirSWbJmJo82Jxad1fPTl4iCahny
         aMxtpVP+nWDWKaRFTl2WoXyNuM1odvfhPH5TbltSygrnWduTPy7xesMan9CBexoujQUA
         I5to8JfQff0jVl2LglIQxyuz/gop1Pivd9GARx+7rH4OInzBwuMuwy27nktk2nZVs3NP
         hgg96Qvob5AwIA20hWuUt89gc1DRyigf8h9ZRSwZLm5PQ64uWsvDWBRi34fUxFlXKfZH
         Gys0BUITby45ZT9Dat40NU9gzsqrZJHoYf8A6oYCk7oZW/4QYnFcCfW1c59jYtiOBjiI
         KKLA==
X-Forwarded-Encrypted: i=1; AL+hErFLV1zDoiN/agSvhcHYjKVMUng3FKEAkYHDEngvsYlJ2JGvRgeFFptNCEqzjGW0KrKUlSLcxcAqvWECtJl24Oc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YtP7PKBMAkmsrov1yjyf1DDp+Nb3tBb2vZgx/YhbZusZrGXa0
	uzN+qAcaCu42TUj0zdE5JsOXs0HqZPq44W096m8ybDp9tO2GxVRMPsLgOtJtafe4ICBCPqFbjHB
	pY4Ay11IZQBztG6VZJ0V7aVW8rjbSGhiEOYlBNQA=
X-Gm-Gg: AYBFou3soyXamkMb+KvojC87hmIbls6r63IeHXjSBham+z7O+oVkx/ojuB+DVN9zuyO
	fcw/Q0ozG12s7ROBsvNQnU/IPIdTw2F+pA3Uvs4lg6XDr8Mgvxk44T2XlZJm5FBWw46DKcxhLla
	16jDMejSBGoZ07H0RC9aC0KTUbELQ9SIvgg8kLLK2T5anqr3rOfpGgGht5AMdZX1MiwGqqHezC1
	Xpd7PbyqqTHL+sWOQuxX5FE5E+Z/KvFSmHbspoZ9dF7kIBtNwGHaUHJocCx95zmlei/pq6RjcDP
	xi4lwaDnrw7k74QEFfH0wB5npvsL5g0KrpxG4FNqdUQiQj0rLhMAHd8oQEJoX58fjjaUbuvOleq
	UE607HM1RVCNSauvr8HTNIWohugZcRRgW3l60b6WPWk92HF28MAZ8nTz7mwpwpHF3emh7sEfLrW
	6v8zWMgOhRfoXNAP16N0vP7ZY=
X-Received: by 2002:a05:6122:20a9:b0:5ec:b4ec:e93f with SMTP id
 71dfb90a1353d-5ece7248b4bmr1176604e0c.10.1794233678355; Mon, 09 Nov 2026
 06:14:38 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <20261002124226.435265-1-morbo@google.com>
 <kcqbiis4m7zqlm6nzpacx6fkbycyy5gjz5nnhtlxlhzxn3tklb@d7j7ciafnpew>
In-Reply-To: <kcqbiis4m7zqlm6nzpacx6fkbycyy5gjz5nnhtlxlhzxn3tklb@d7j7ciafnpew>
From: Bill Wendling <morbo@google.com>
Date: Mon, 9 Nov 2026 06:14:22 -0800
X-Gm-Features: AclHuK_MqeRDtoqTOgbcQ-UKaELZDMLvDZbLcqrG79GD9Nb9csHUyVNFVw5OyLA
Message-ID: <CAGG=3QXfNQtgp1CqD-56x-nvnqZumcejBKqcgeaNZAj=ftz1Dg@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 1:21=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, Oct 02, 2026 at 12:42:25PM +0000, Bill Wendling wrote:
> > The 'data' pointer field in 'struct acpi_gpio_mapping' is associated
> > with the 'size' field, which represents the number of elements of
> > type 'struct acpi_gpio_params' allocated for 'data'.
> >
> > To improve bounds checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
> > attribute.
> >
> > Analysis of allocation, assignment, and access points shows that the
> > pointer is never accessed before the count is set, which guarantees tha=
t
> > this annotation is safe and will not cause runtime panics or
> > false-positive bounds checks.
> >
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
>
> This can be dropped now.
>
Okay. Do you need me to send a new version?

> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > v2: Undefine "__counted_by" and "__counted_by_ptr" in the EFI stub
> >     library as it doesn't need it and Clang is missing a flag to
> >     enable them.
> > ---
>
> Plase, don't send new versions of patches as replies to previous
> threads, this confuses tools (and maintainers).
>
The "v2" is NOT the version that should be integrated. I said the
original patch. "v2" was sent as part of the discussion we were having
how to solve the issue that cropped up, and not meant to be the
defacto version.

-bw
