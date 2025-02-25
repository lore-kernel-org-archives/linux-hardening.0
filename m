Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925624E4DA;
	Tue, 25 Feb 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454199; cv=none; b=I98LycMwGnWaMQAEcGjezwgRbJjVF8wnYc17EUd2VErmx6ULRHNqXqFMDiT3QsvRZ+KTv+BLEK16m8V8e3Viku6v0qMRZfL+sgaG7piDtuGozWA2b82lUN58Mxl1y8FnqVMmQnZO/2pgsGMyNrsXCuha4p7lhLKgf40Td+NlIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454199; c=relaxed/simple;
	bh=6kpiP7kqsYMWQ6REPZdybzCnHuw1We9QZPb4XAOE3vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr6Dh2X/S4CHn0sH/J1Dwi6E/gx+CNdjK9FvqXOASHxLPeUn8aMY+7hN8aWGPMWHiwbPbsRqZ4wkbkjQbmPfe39yx1OmDIvJ32czx5PkjHGnZShYQ0hjwfOsGzLmmeQ5pOF+QP2nXzlOBoXnUIRa4sxg5j8j7Q5i6APM+AfwqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6vbgrm1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6vbgrm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7179CC4CEE2;
	Tue, 25 Feb 2025 03:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740454198;
	bh=6kpiP7kqsYMWQ6REPZdybzCnHuw1We9QZPb4XAOE3vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6vbgrm1iQPfnswuNnbjnf8uS6yGAUJh3ukZyVvhyTvI5bWYts7Lo0DkAludg7DPN
	 lLnYLr6uBVlWMXquBkS9a1r+L+0C1++fYpc/G1x+cXE1NF9TI45ajV5G78blFiez8H
	 EOmI0N6Ycf9oXSJKlsqySg1yfueHCN3tGmmbbqu1HHQmqgp9JJsoVaI2E/nGA54FFP
	 PFcTn+rhizLa0gmSyBM/vGa/HOe8Z+oOO4JZc3ZGYAfAxbwnaBVCOKHYpDlptk0KiC
	 WaJvZea7cHAb71j6q5VtjE8ja9FTkxs86hFlUmtq0ws1A+n6PsrbP+Cjt4JHdhx81J
	 r9l57LcryKD3g==
Date: Mon, 24 Feb 2025 19:29:55 -0800
From: Kees Cook <kees@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Question about strings of string_choices.h
Message-ID: <202502241928.4405326B13@keescook>
References: <87eczmssrp.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eczmssrp.wl-kuninori.morimoto.gx@renesas.com>

On Tue, Feb 25, 2025 at 01:43:55AM +0000, Kuninori Morimoto wrote:
> 
> Hi Kees, Andy
> 
> I would like to use string_choices helper, and want to add well used
> but not yet supported strings. But before that I would like to ask one
> thing about it.
> 
> I wonder is it guaranteed that the strings were persist after the
> function returned ? In normally, function local variable will disappear
> when it returns from the function. But I'm not sure in case of
> static inline const, etc.
> 
> If it is guaranteed, I'm very happy.

Yes, the compiler puts them in the .rodata section, so they will always
be present.

-Kees

-- 
Kees Cook
