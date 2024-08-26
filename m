Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F274C1B;
	Mon, 26 Aug 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704460; cv=none; b=X5ofZ526OVdH/HeRJfJ5/B+2j2tZYpignXjecgE6Zqb084eMR5nYL/Yit91YT7lNwT2wDcc0USJ4Iq99cOl0dw73mOiUU+osyJJY2NuEVOIBBgpQ0x1d9juCDHjxW/6TbhO70AMGVtbgI1pyn+0JKoxFzLR2xgcDaFYZ9tNBYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704460; c=relaxed/simple;
	bh=wuPo3kRQj8FfUmGnwgmSG7R2ndV7ZyokQSyJ4uU4X7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAUmkzKcLFL6SSl2omll+2fc8VoPo6hfV/Y0076Y+9sf5EWkdU6bTJizCFjFAEPthxReR3Vqut6A2GrAARd4CwK8iWraY3V2WxXCoKchxwQdQfA+ZHTR9GpWBmOMLmUoebEfmmZO8cYwc+F21ZGqy+6xzvo2hY+iEmfAjE//nhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT1hnZtO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT1hnZtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0FBC8B7B8;
	Mon, 26 Aug 2024 20:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724704459;
	bh=wuPo3kRQj8FfUmGnwgmSG7R2ndV7ZyokQSyJ4uU4X7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HT1hnZtOMeNxHopz7TlDblBoLnAc2b+4ni9n/ScKqQ4Xd+6ZyUXuKHNuVobNMVkp3
	 BXK9H5gKXjU5xshi+/jI9ANyIT4Ez9UvgW5BW2/k8O3FrXpXAI85xuPyQCYcjjU14+
	 4VPtJKUgpCn+ias7rYRtgqJ67jvaQb3vd56ak02vK1d+W3z8zw8uMvbwrHHLgnhKct
	 xxLV4e4QR4C64Z38dAXdHV8MEtevzaIRASqQvannzEaL1/xmgZhfAb5KuGguqwIJcS
	 TjgnpZcWo6NbdUsU7qOWWj4mo9ZwSnOszkozZe8+5adk/2312zhBKlL32jaw7eajeS
	 aQ1Pzfem+ghmg==
From: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Wen Yang <wen.yang@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: replace spinlock_t by raw_spinlock_t
Date: Mon, 26 Aug 2024 13:34:16 -0700
Message-Id: <172470445402.1124964.5756101166185708381.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819145945.61274-1-wen.yang@linux.dev>
References: <20240819145945.61274-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 19 Aug 2024 22:59:45 +0800, Wen Yang wrote:
> pstore_dump() is called when both preemption and local IRQ are disabled,
> and a spinlock is obtained, which is problematic for the RT kernel because
> in this configuration, spinlocks are sleep locks.
> 
> Replace the spinlock_t with raw_spinlock_t to avoid sleeping in atomic context.
> 
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: replace spinlock_t by raw_spinlock_t
      https://git.kernel.org/kees/c/1bf8012fc699

Take care,

-- 
Kees Cook

