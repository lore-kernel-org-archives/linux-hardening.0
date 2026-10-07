Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2047254C
	for <linux-hardening@vger.kernel.org>; Wed,  7 Oct 2026 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365599; cv=pass; b=Zy3rhNc+D/EdYgN6sLofRNzQkCjLX72awHJmg981qfJd4ptvrkvNbQzu2TNnDL5z5tlap79gXZvzN8iEUH19ra7TzDqIrwFaPGXPkeeYYugjUzNJ+ZttrTlYLFPAaXnvjyxr9FYhfnh49tbKRvFc/EvfIvsTHgTgHeEOwq3ct/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365599; c=relaxed/simple;
	bh=gChNhpPmIRzVuVd4Nx3kZHJx+TICbXpHZEw4CFKr3e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+Y4drFhqy0NADUujyfUMgpWXBk2bFPjfkBhwex+7jl8gDBxrWCAY7APcUbTKcBDyolUjr8b+Gh5OMCoCGkkc6Fe4pd1JqIYh0O39LtfxyupbKWZS0lnkJdDg5JfYB+RNOw5CxSEsBCFGEAR+RGEozDLWT3hYhVkaEPjzHVyvJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGxvz7F2; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGxvz7F2"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-78fb9d46f0aso860286137.0
        for <linux-hardening@vger.kernel.org>; Wed, 07 Oct 2026 02:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791365582; cv=none;
        d=google.com; s=arc-20260327;
        b=NP9gqib5f8+WQFZl4qKCM1HN0cPoPqAQmvXghdC9vfCkR8RlV7P0BR8bLKTA5lQKlY
         sDR7yOBFmEMIfuQJflVQ1d5nGIz0hb03YP/DsV81aX3QoGzZX+tlp9BGHv3e3f6J836+
         CiguO0SXmM6VaZ0vP5snfOPj2JXJS4qtyb1qgUVF/yYE7roiPGE7wreR5096MRhYEeIT
         W12TrZejNniQi+M3etE9vhaXOFp6VrsXbTH4xlXoB5zKbNJ4qQR5Umao0IFCshd2p8u8
         01D+9UdPC658rDhIfy7A4gVsfdOqpYRJVvhdSVNMT+uKaWwbScIYfB18T6fjxOA5eqUf
         tDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gChNhpPmIRzVuVd4Nx3kZHJx+TICbXpHZEw4CFKr3e8=;
        fh=Z85QWlMXQHG1TxoMKfSMbe5ZgJ5QLDOWQywDupHeB6Q=;
        b=Hw2OBRb87dZA7HCLvgWtqlk7uC46VxcM8opX6kATH+2HgYBBcwJBhVV2lB/3yXZSb8
         SJ9MwHFY0Z8Slh+dBQCMRXdOlDcLxVzXd2WN39tXb5hKvTd2kI8Z2UZZIzEtXp4K18yf
         mACkYobe9+cgRB/A/ejcW89IodN0RCg7UVnAyoh2JEYIBOeo245RGWHHQg1QjDLHxPOi
         O+AK/Xp0WzU0xHtbQZ9GL1oRThL7C3+EknYb7aumxGLai8vjOxVrNsn1exf6dEPs7i9g
         O3MW56eqD7Ex9IbRIsUAXrBHtuRmNTtMsKQ/4fSVzzx9lsfOLTS3bH224AUQPsPm1FPz
         K28A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791365582; x=1791970382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gChNhpPmIRzVuVd4Nx3kZHJx+TICbXpHZEw4CFKr3e8=;
        b=cGxvz7F2xsgewg+EkMIpJs5UZPbYtH8Xh2DwFZWj8Mjj1q5zcAoNrcM8IVYNSZEQhk
         xWI8ggQHyoa8gMJRkAfECPmsG5VJxolbooHscRh+jwwFbj1eV6pz33kOM3U+hQOtUAnJ
         pAhoo7BJnKL/k/Zm1nnmScEoa6AX0Q6oieeYbh4FIWxTy+3x0lHKU8E4w4XwxnvJdvgm
         bJ+1eLHoKg5Nl+q3s7s/wLl4oh3V3sZdkbAjS+K2VTeqtj0p0fhR+R7vimWSaN1KXFAS
         rFX2LlOPl7q+eU1EQG4VetT3s4/vG2SxX7laswtRNv65afq7oPfsmIbyqCOrDHhiVoFH
         nuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791365582; x=1791970382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gChNhpPmIRzVuVd4Nx3kZHJx+TICbXpHZEw4CFKr3e8=;
        b=qvvIvFjkQoXgpLW7eQ1IPMLCoreqxIR0G2KpdvwvXw9Ka0CMVoXPMepEZnWOLxV487
         5mEBkPS3I5gTnwhVnYFvjeRUCrK/zhspLU5DHcMiuqW/AR2Bi7t2KDFr2inJxLnDngTZ
         A8bN8yvlM3vJs4JywL2FtC+QG6Fym6u77SJr3xXKpcvfAijbiTmC3S7sQtApA6aZGW+5
         xbo95VyidvnqZkn/f8/AYybtEcOCPoiACCNICp6g+ix0YiWyCS03id9k4UcE2oNsyQoB
         49VEdxbKedeNK2WiM9ky+5Zchbc4FyjDXuK5OENnonk8XRz4SHfosTBsEdHWNZ4eqsMA
         DtSw==
X-Forwarded-Encrypted: i=1; AKwUvBxldyB0hnhNKDQ6wg+eI2D6/+VVs0/AF+utF7DUzpjrHhuxaFxjksye+6ez0zHnoSX3Yo5FaV8cIiTc1I6BRw4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX6vj0kHf4q8SdL6SROpH6oQpdhElBYPdamU9HEjloDJDl+UVd
	N8Q7A4mZi97qCzhUFFslRyximd2hv1u7yZ9iwYtDYhhlRduTzkpNSeiR6xT99qK4Q+C2WuJl0mK
	ltnFlYbNXJX0zTd1Qh+I2wNUWV+gES7PppPOh7f8=
X-Gm-Gg: AYBFou15EToKhOBWBpgvq76k1HHxi3cgqBb4B65F7xOy3mLVr8ZIuphmCRYPS6mMpNF
	pBe4/DHb1A7bahYOM2otcAzE0pVnwOcLF2YxL54hX8mzlwsrX1b4sLga3TxHysh81fMJb0SDVeG
	8uc0JyZwgc8iaaM5h9ENJyENtaY/SRTEosSuoj+kVOabH2LJzguPBO+AZ9hHdt3Tv0s6W5jdDMh
	h/8ACkPyu1eaWxIqIPfHpvQ6rz+/iQrm7JaKu1K+e9fYCQp07WAqpqT6ZKlIIx024bNc01WGCjZ
	6ze87/JWyopwSVyFwwR53/oq+eMzi1hLGjRq2gixK7WNm+rmC1xL91HYAqIK84uv2fahOq1NiNu
	PEWpz37IXBpCJAujFWmi6
X-Received: by 2002:a05:6102:808e:b0:7a1:88cc:6787 with SMTP id
 ada2fe7eead31-7ca38912387mr457577137.12.1791365581501; Wed, 07 Oct 2026
 02:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com> <20261006094358.2948476-1-morbo@google.com>
 <202610060642.7C4125F@keescook> <20261007090915.GA1504630@ax162>
In-Reply-To: <20261007090915.GA1504630@ax162>
From: Bill Wendling <morbo@google.com>
Date: Wed, 7 Oct 2026 02:32:45 -0700
X-Gm-Features: AclHuK_Xc-2s-IDXfEqf9QTUl62NLNcyE0G5JoWqRVUXRHBcaDN1yyh_K1ccOqQ
Message-ID: <CAGG=3QXPAa-i4r3Vv6-q25A6EvsxGb5RDLn02z1=a5zo7W-7Vw@mail.gmail.com>
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, ardb@kernel.org, gustavoars@kernel.org, 
	ndesaulniers@google.com, justinstitt@google.com, broonie@kernel.org, 
	elver@google.com, alan.maguire@oracle.com, namjain@linux.microsoft.com, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 2:09=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Tue, Oct 06, 2026 at 07:12:07AM -0700, Kees Cook wrote:
> > And other architectures solve this problem by not wiping KBUILD_CFLAGS =
in
> > the first place. :P So if we want to continue to accept the x86 excepti=
on
> > (which I would argue is the actual problem), we likely need to, instead=
,
> > construct an explicit export that is used to collect parsing control
> > options so that it can be re-included here. Today, I can think of
> > -fms-extensions besides -fexperimental-late-parse-attributes.
> >
> > KBUILD_PARSE_CFLAGS +=3D -fms-extensions
> > ...
> > KBUILD_PARSE_CFLAGS +=3D -fexperimental-late-parse-attributes
> > ...
> > export KBUILD_PARSE_CFLAGS
> > KBUILD_CFLAGS +=3D $(KBUILD_PARSE_CFLAGS)
> > ...
> >
> > We already do something like this for CLANG_FLAGS, which, given
> > -fexperimental-late-parse-attributes being Clang-specific, perhaps we
> > ignore my -fms-extensions future-proofing, and just add it there, but
> > it doesn't look like that is how scripts/Makefile.clang was intended to
> > be used.
>
> I agree that fixing the x86 efistub to mirror other architectures is the
> right fix for this particular instance of the problem (as you note this
> is not the first time this has bitten us). However, we may want to
> consider adding '-fexperimental-late-parse-attributes' to
> CC_FLAGS_DIALECT as well so that the many other places in the kernel
> that blow away KBUILD_CFLAGS won't have similar problems if
> __counted_by_ptr happens to be used there, as this type of solution
> might not always be possible. We could rename it to CC_FLAGS_PARSE or
> something like that but I am not sure it is strictly necessary.
>
Ard,

What's the reason why x86 doesn't need the KBUILD_CFLAGS flags? Is
there something that breaks things?

-bw
