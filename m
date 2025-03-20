Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AF1BE251;
	Thu, 20 Mar 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457481; cv=none; b=tbXX78WRxNgujduXJ9DBNJEUNuE+3PFbyH/Jsqigv+FNbEckkt6JTzmqgnEwnyLa52zbil+UfpTAKApihoUlJS4cI3+ezUcmUdSHnMyVhKzOzkuDYKEg4bQVo5/deiZFww6hLLFxKObd8lk3sSfUGGrADk8UXRE3wRSbzTlp2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457481; c=relaxed/simple;
	bh=Ess/GFiXQnY/TJf5j8pZaKg+a4s6VGT+FXoCIdtSljY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZeUtnN/zX6wzXyox2NOjyk0NZCRB/p+ngWfaEHZC93mJhZq7Lc9HKAJjotj8RDgM56Bwfxl7P7TjixiRv3n7OUMi98ZZIxppvsfC8UOv0eq0NX/xtWJaJNaLWYTKwfe4yxIWlbK4uP/NDQ8uUGSdvcTaPaBW77PH9PMaPKqkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTvARj4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTvARj4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBFCC4CEEC;
	Thu, 20 Mar 2025 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742457480;
	bh=Ess/GFiXQnY/TJf5j8pZaKg+a4s6VGT+FXoCIdtSljY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LTvARj4Ns2d9QyrT1ya7RPJ0WCyjrQ2F+ebTYcZzc3PQh4FZwUFJg+iYm8PXWvzVi
	 /wSZ3RywOLddXzanBd2Qij0dRnUWs7EAzB03L+8B5JlX+n6eiTJ+lg5T/H0uXDRaLF
	 obhdhDfNtSR+1BsAlkJnf8YKFTE7X6gint44dg5IRhwuRabbg6PN5PFnTXdqENJS6/
	 95wmNBccSi04IyWQEnrj+rwlkpSICO/dn8s4w213IXdEVxcn31MVXbU5c1NW57UHUa
	 aaLx39jeLV3/Z8gSVxcHqzJT5THrbuGcYYI5CxB6oy1ADb0KSrS83/jLygoSKu+cg8
	 2mfJUJUH5PUVQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549946c5346so616131e87.2;
        Thu, 20 Mar 2025 00:58:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzYHUJo4eCMBklIXGyYw9i75JdvL2LdSTaNm/M3zfdDnA+WyS5yPw7JP83shTmXNb+/Kk1qSbAl36ARCXr@vger.kernel.org, AJvYcCXpi8QQSdBUlEv/pk+bDVOiFwQLqnoc/TfopdDm49EROE9I5SQA9Yd1E+/BRq8aIlszBzAPTdKfH5yisHSC8Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9w03hcn2ShbJK4m5HIcQMIFTlcStBhp2RWac+sbc4LxvgUEe
	6lWlzJd+bV3++JLRKJ3LM9yRso87oCZhrJBkmwCeX23gG1KKhIL74+PDcOm2etZxet3Nr/zmaVm
	SSSWQDn9QLrc0nm1eGYvP6nAc04M=
X-Google-Smtp-Source: AGHT+IHxMPNnW3ahoF6dyr61q+mJ5mQKb0REzmKIWVM/WDF7dR9vMAw2jTe0SRluNBmN6Nesu4NshFyCdDUXlanegeA=
X-Received: by 2002:a05:6512:3ca8:b0:549:8fd0:bad8 with SMTP id
 2adb3069b0e04-54acb1b83f6mr1925566e87.21.1742457478970; Thu, 20 Mar 2025
 00:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318134949.3194334-2-ardb+git@google.com>
In-Reply-To: <20250318134949.3194334-2-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Mar 2025 08:57:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHXAYt0xLnx4=+qiCbnuF5U+9dzwnds1yd+vhTtpP5v3Q@mail.gmail.com>
X-Gm-Features: AQ5f1JruVvX2NW9k2AtKWjmGfECveHlfhMO7faRJZ8Td6Fub8xUy3jUEpJHaXeo
Message-ID: <CAMj1kXHXAYt0xLnx4=+qiCbnuF5U+9dzwnds1yd+vhTtpP5v3Q@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64/mm: Remove randomization of the linear map
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 14:50, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Since commit
>
>   97d6786e0669 ("arm64: mm: account for hotplug memory when randomizing the linear region")
>
> the decision whether or not to randomize the placement of the system's
> DRAM inside the linear map is based on the capabilities of the CPU
> rather than how much memory is present at boot time. This change was
> necessary because memory hotplug may result in DRAM appearing in places
> that are not covered by the linear region at all (and therefore
> unusable) if the decision is solely based on the memory map at boot.
>
> In the Android GKI kernel, which requires support for memory hotplug,
> and is built with a reduced virtual address space of only 39 bits wide,
> randomization of the linear map never happens in practice as a result.
> And even on arm64 kernels built with support for 48 bit virtual
> addressing, the wider PArange of recent CPUs means that linear map
> randomization is slowly becoming a feature that only works on systems
> that will soon be obsolete.
>
> So let's just remove this feature. We can always bring it back in an
> improved form if there is a real need for it.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kees Cook <kees@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Additional note based on an off-list discussion with Kees and the KSPP team:

Initially, the randomization of the linear map was considered to be a
layer of defense against the abuse of writable linear aliases of
read-only mappings in the vmalloc range, such as module text and
rodata. This has been addressed in the meantime, by mapping the linear
region down to pages by default, and mapping linear aliases read-only
if the vmalloc mapping is read-only.

So considering that, and the fact that randomization of the linear map
occurs rarely if at all on recent CPUs, I think we should go ahead and
remove this feature.
