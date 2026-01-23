Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6034EF0B
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153272; cv=none; b=jzHUmcHS13Q0PGeQJkhLZdSD2Ukn08STxd1Kt41IzLmqiyersIFBPnYyR4mkrjWDpVn1SbuHlxj1WLufkktZBmsceMUT0NrQeaHPAXTHaiBVMXSxYioCLqv3v9csXXuEWMsRJ+PVotftTPt/Rua5AJDU+S4fhhWvx54dr/XqLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153272; c=relaxed/simple;
	bh=RXGvfifUGGdbkeGMJB3zrIxoZOWdsw1/3iZd6E2rnU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xzb3qJzx7YqHSsPi+u4lewWY6LA+ni3NzN39z3lUiTiKBopLItgRCpGo5Bcmmv7573lNS4DKTzlTuNoyrwD4xv3+1LYVwykE0IeAOiFffsfdhzZOqPMJm8h7wt+2D7SW3QXlfa0ycpP58xWNqn3js1MLbTg5TpWRYOaivRW+MA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH1W40B6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH1W40B6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B77C2BCB0
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 07:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769153272;
	bh=RXGvfifUGGdbkeGMJB3zrIxoZOWdsw1/3iZd6E2rnU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rH1W40B6oidW9/oBs4Qo7S+7xiRwZ8afe73+jgLjvsPZ9qZeybrCQDrKPU1CBt8z9
	 0fFyfdouVALqznWFq4rzfIBhPIajl58WGepRkGU5bOKZ/0fJD83GfIeo5V5j/k1Y+N
	 FRB4RnzCIQfPpjr5f95ZEVRwYMCly54xPb4uvroIM5CclTihiAAojIrVp+LjhwF8Gb
	 pQLFc3yjktkzvMoGYfAiU8yJ24B4+TXoKoUTqdjv/6A8pQKe4c50fTFsiqOpA5+jP3
	 TcJTrtMO/fD0VMbNj20+7c27cKJsxxlYhQlqKypMCiI08s7liGn6X+ZjJ24JipKTmt
	 LXKJIRFC7ojtQ==
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8230f2140beso605807b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 23:27:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4XrY8Bjubu+Xu9Z1sknG7XTvRg6JAP3O/iUR5zhUeRK5REwlv22qiL96EcEVuE33pxiUiOR1KHI4Zw7OcAi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MrR6b9D4t/S/vmCvFH0x+L+MkSVkJ0cy3rf0HrhdM+mbzwks
	Nkk2LW6W6+qaOku2LPphR3N6XcHWdn2eWKCj2HNMvhcxQz7L1NwdFGI3j5XH6vooasiqcRZNzqo
	fnzc3UmpAb6WFTfODSBBzqlh0CMADf/c=
X-Received: by 2002:a05:6300:4049:b0:35d:d477:a7f9 with SMTP id
 adf61e73a8af0-38e6ffb5ba4mr2021429637.12.1769153271678; Thu, 22 Jan 2026
 23:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119164747.1402434-6-ardb+git@google.com> <20260119164747.1402434-10-ardb+git@google.com>
 <47fdacc6-1928-4d77-8024-28133daac0f4@arm.com>
In-Reply-To: <47fdacc6-1928-4d77-8024-28133daac0f4@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 23 Jan 2026 08:27:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEDXnf7RpXp4nf7fy-0=8f54q=7MgGJm7L4W3FQwnZfwg@mail.gmail.com>
X-Gm-Features: AZwV_QjJC3CioIVYzZbmreiPemXfBBTbJkHb4YiUEcuLZmtHTtkUxg_lwRec8ow
Message-ID: <CAMj1kXEDXnf7RpXp4nf7fy-0=8f54q=7MgGJm7L4W3FQwnZfwg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: Unmap kernel data/bss entirely from the linear map
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ryan Roberts <ryan.roberts@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 07:52, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 19/01/26 10:17 PM, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The linear aliases of the kernel text and rodata are mapped read-only as
> > well. Given that the contents of these regions are mostly identical to
> > the version in the loadable image, mapping them read-only is a
> > reasonable hardening measure.
> >
> > Data and bss, however, are now also mapped read-only but the contents of
> > these regions are more likely to contain data that we'd rather not leak.
> > So let's unmap these entirely in the linear map when the kernel is
> > running normally.
> >
> > Only when going into hibernation or waking up from it do these regions
> > need to be mapped, so take care of this using a PM notifier.
>
> Just curious - why do we need them mapped while going into or coming back
> from the hibernation ?
>

Because the kernel image is preserved/restored via the linear map. For
some reason, it appears to be sufficient for this mapping to be
read-only but unmapping it entirely results in failures to resume from
hibernation.
