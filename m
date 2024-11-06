Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCC1F942D;
	Wed,  6 Nov 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897278; cv=none; b=YCBSiX6bb3aPdXc4B6mjJ4nHNGdRzOiDgLj0IzNfAZ7qEAycvu1h046d8P2HiWp/WNG4Jb/Kg+cLdm9QlmoOE2iH3XRIfz4i1H9Gms5v1hJAjn5gFoNbAcuz7tP8eGnHua9pEpQMxZwExiMjdbfRaph2uxS7KlxlkvZQnplSFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897278; c=relaxed/simple;
	bh=981Ze0DKOmXjkUk8kCXWX2bpG0/1x+Oq3RX3cw7yz64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nl8Hd9bs5pCYk4EZZ4uhm59DXQc8TLrRySFwflQp7HTR2cTph65adhB1SHsH0FTbF4IBJWV6V4YzQJhS5jnYB3E/V7rm7hdBr+iRF2Mj7Mhkz/re1sViPCWKUbj8YDBhUu8ZQMMDDn3J8J+lKifYs3weE8Vdyrx1Wz0+Y5axexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Mpd5GGl6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Mpd5GGl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730897266;
	bh=KaOyQ0C4hIjkB+fA1jHuDTauRfGbneabx4L3UBFxt6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mpd5GGl6RtPsXNNiXI4HEMbNdahUrqL/89ft95jp8odhuLfVTYFPGkFBuTWUCDdb5
	 fbHtlwpzoSC1yPWX9nYUs+xGdbvWjpvNmq739KKog08P6ooDyVwQHMK/F+qp+xUT5x
	 M4Vax74nYlJ9YTfgtsgDWOz8TEJXUdBj7WCFY6rLZ2sccLhp2NBMpSvvD7tzKTgmtU
	 I6j5kDS23EhYFEBOhmIspGrNGgv5Yw8la6SkDtsDw3lPiOIyllmOlu7cy+SslEa5Bw
	 j2VUzD/hLDxVg42lADGIRkqnQX/esoCT09ylzBL8Uu0K7wPxcOoCOwdJ/0+vjS9AHx
	 j9cjRevhU4itA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xk4js6wVbz4wyh;
	Wed,  6 Nov 2024 23:47:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Naveen N
 Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Kees Cook
 <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] powerpc: Add __must_check to set_memory_...()
In-Reply-To: <8dcc739a-3fd4-434c-995c-1dce33cefe6f@csgroup.eu>
References: <775dae48064a661554802ed24ed5bdffe1784724.1725723351.git.christophe.leroy@csgroup.eu>
 <8dcc739a-3fd4-434c-995c-1dce33cefe6f@csgroup.eu>
Date: Wed, 06 Nov 2024 23:47:44 +1100
Message-ID: <874j4klea7.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi Michael,
>
> Le 07/09/2024 =C3=A0 17:40, Christophe Leroy a =C3=A9crit=C2=A0:
>> After the following powerpc commits, all calls to set_memory_...()
>> functions check returned value.
>> - Commit 8f17bd2f4196 ("powerpc: Handle error in mark_rodata_ro() and
>> mark_initmem_nx()")
>> - Commit f7f18e30b468 ("powerpc/kprobes: Handle error returned by
>> set_memory_rox()")
>> - Commit 009cf11d4aab ("powerpc: Don't ignore errors from
>> set_memory_{n}p() in __kernel_map_pages()")
>> - Commit 9cbacb834b4a ("powerpc: Don't ignore errors from
>> set_memory_{n}p() in __kernel_map_pages()")
>> - Commit 78cb0945f714 ("powerpc: Handle error in mark_rodata_ro() and
>> mark_initmem_nx()")
>>=20
>> All calls in core parts of the kernel also always check returned value,
>> can be looked at with following query:
>>=20
>>    $ git grep -w -e set_memory_ro -e set_memory_rw -e set_memory_x -e se=
t_memory_nx -e set_memory_rox `find . -maxdepth 1 -type d | grep -v arch | =
grep /`
>>=20
>> It is now possible to flag those functions with __must_check to make
>> sure no new unchecked call it added.
>>=20
>> Link: https://github.com/KSPP/linux/issues/7
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> Do you plan to take this patch anytime soon ?
>
> The generic part of the same was already applied in previous cycle, see=20
> https://github.com/torvalds/linux/commit/82ce8e2f31a1eb05b1527c3d807bea40=
031df913

I was waiting for the generic part to land, sorry I missed it.

Will put this in next now.

cheers
