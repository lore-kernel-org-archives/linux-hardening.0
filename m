Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372922FE079
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767996466; cv=none; b=fQ0AU6qK+hs2TLGlm3/f3WW+Z6tqTmUDHN5kuaCiOLTNZ1BWiQKCXO8XTh0vCAyedMyAkuSJjn5ddGmG6OoOZr9NYJkMEzKDK4ZeeRomk0GRgdHCSxkZA0loKMUCI9iXvRvQvqWSxJH4sJu+i0BVY4+NBMn5S9a+sg+Exz8fcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767996466; c=relaxed/simple;
	bh=ajhldXhr26HjVWgSc+soIuZcmSUsriODz05iaiSPal8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqZPxxccS7dR3ilo+pTrULBzRVpBKlIC+Gg0uk27eE/YEROH7zQSDDNRz8VDntKcwxDTxopgN6K75xIrixroFiKs/ANQMNoEqa6ClY1wEZSfxlIN/3SgQF7JddUFdi55of6JRVP5+lfzQOmyGMi581rN0dVA5seXUktgOqBbKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW8sn9XY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW8sn9XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E28C16AAE
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767996465;
	bh=ajhldXhr26HjVWgSc+soIuZcmSUsriODz05iaiSPal8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BW8sn9XYHildgdeb6xfeL2mXGacxiSWcObWIWz9e1pMH77Gc/mF2m7PEHHSz5xGT8
	 cQ/MHYuAsNGuLN10iVtBdbz76RGO2/FWBnHlvmTp0YqhxKUK5pVadqLB7ajLzeTMAD
	 DrN08pyWWSuQTljO9bbyX8mshtLVIsLOYqpeOiWrlUX7l0F69w8FmusVoDwMpHf0Xs
	 PlxGRiAahvQhqokCVeBX7r0XyhRZlUF/iLv9A/bnp9UZZfTgZ26/f7tAmNbjmHg/0M
	 c34MgDsAXjm8Xcfqrj6DIu/4ukjlKB3EUOZvbHBVGnCgS2rum859IDkHV5ZAwktiHo
	 XUE7zHEFX3vgQ==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso3731379a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 14:07:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeRqm/dXMz1AypNQuZKDZN8BNFNwNjbgOQDCtCNrJtdVkqhY0mpQbl0UPMAa4FHbKfIuVUiaUzl7l2NIh1TCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtydpTjoMrmoIZ1Gw6E65YzjZ6XnFaIA8k18pcp1AImVWnE/wK
	AA5GggkxNp8w4TuygIrqGjg8NQNqci0iOnsw9KhVHDDqi9ptaJx+m5daRenE2DFh0zzpa1quqow
	gQ5Yhpw7dIEUcDAoaX+nKT+7k4EPNy88=
X-Google-Smtp-Source: AGHT+IH28yck9PslQ7o2hua93tiilXzuULzxzZRQveC4J4etJ+d5bAOQpVQ2aU5Kmp6x5FxvGSHH+P/E5cJzcL7SWxc=
X-Received: by 2002:a17:90b:560c:b0:32e:7bbc:bf13 with SMTP id
 98e67ed59e1d1-34f68d3b47bmr9818926a91.34.1767996465420; Fri, 09 Jan 2026
 14:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-29-ardb@kernel.org>
 <p64p8514-np9q-r4qp-6254-011r62nrr594@vanv.qr>
In-Reply-To: <p64p8514-np9q-r4qp-6254-011r62nrr594@vanv.qr>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Jan 2026 23:07:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFSGEURMJW0-4uVTBVvwV1YNzE9J8GMFrOtoYdCTu6r1g@mail.gmail.com>
X-Gm-Features: AQt7F2pY5D27yvdjJzmnUKZRaTJmmiHEDVGrAdJAeXch0iTXe22oXnSfZXJTmZI
Message-ID: <CAMj1kXFSGEURMJW0-4uVTBVvwV1YNzE9J8GMFrOtoYdCTu6r1g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 08/19] x86: Use PIE codegen for the relocatable
 64-bit kernel
To: Jan Engelhardt <ej@inai.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 22:34, Jan Engelhardt <ej@inai.de> wrote:
>
>
> On Thursday 2026-01-08 10:25, Ard Biesheuvel wrote:
> >
> >As an intermediate step towards enabling PIE linking for the x86_64
> >KASLR kernel, enable PIE codegen for all C and Rust objects that are
> >linked into the kernel proper. Add a Kconfig option RELOCATABLE_PIE for
> >this, depending on RELR support in the linker, as the relocation tables
> >will blow up the kernel image otherwise.
>
>
> > KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
> >...
> >+
> >+        pie-ccflags-$(CONFIG_CC_IS_GCC) += $(call cc-option.-mdirect-extern-access)
>
> I think that dot there next to -mdirect-extern-accesss should have been
> a comma.
>

Indeed, thanks for spotting that!
