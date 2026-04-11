Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21D75809;
	Sat, 11 Apr 2026 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890944; cv=none; b=eA44B9k4Euc9LbBti72arOZ/awor4QnG024t/ysRaXk3874TDpkpTEvupy7l0VoVsdxTMnO0HdPMup/DjgyL7MZ1WG8V/6Y30MThy1tgOxeiDxzv+rX+fufyBXyaoldvIe7smvzkKYl1vt19T+wtduGI+oeilc8hnj6zEcOG4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890944; c=relaxed/simple;
	bh=WRGe0j0ffZi6yjlerZduWE9itvW5WplyHl9ISLYIzN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHpGTqCHJkZV7lfxa/4pusamFfXk37OR2UqMwtcplvfZ5y12VgAkG71Th1dZLemHbsfQSkhbefsTZ5kvndxemVJAd2hOiMHQsyzqg54kNkvTrNWiZfAIrnSQ91VjGKIJXPl9bIwduNpqehQ/CEmh7ihEkT12qHKsFrgQ22mc0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1x8wwJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1x8wwJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66042C4CEF7;
	Sat, 11 Apr 2026 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775890944;
	bh=WRGe0j0ffZi6yjlerZduWE9itvW5WplyHl9ISLYIzN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1x8wwJElHCvznOhWoR//Rx1IyDAde6rVKSnzfRb2dTfmhYbmu2XP47nHZH+B5cTG
	 5pfNesHf3kCkbJRU8PVPGrTpe3oDK5K0zrKXgMrhNkbSQ/8Rz6Kb5rt+6Ev1R/9lau
	 5tXwLo1swIeT8uSbyV4T6LqfgA5t9LpoOLYobkBGKxbBNIS+YLdbh7oxUrBRz7gRBW
	 P5NGZh9H62c0BrAav1vnC+tBCL6aaDDDBUV6ZJAHlKcdxU7aXcZA39I7pdLTkSqx4O
	 UkkmiM9JfQ6oe4Ywhw2EoxEriD87kg7vUccxTPMfpn6m3IKhBhnviVEYvcvOZ1riKc
	 AGmexojIDduwQ==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	rostedt@goodmis.org
Subject: Re: [PATCH V3] pstore/ftrace: Factor KASLR offset in the core kernel instruction addresses
Date: Sat, 11 Apr 2026 00:02:22 -0700
Message-Id: <177589094192.669373.2351128293282510739.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410205848.2607169-1-gpiccoli@igalia.com>
References: <20260410205848.2607169-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 10 Apr 2026 17:49:26 -0300, Guilherme G. Piccoli wrote:
> The pstore ftrace frontend works by purely collecting the
> instruction address, saving it on the persistent area through
> the backend and when the log is read, on next boot for example,
> the address is then resolved by using the regular printk symbol
> lookup (%pS for example).
> 
> Problem: if we are running a relocatable kernel with KASLR enabled,
> this is a recipe for failure in the symbol resolution on next boots,
> since the addresses are offset'ed by the KASLR address. So, naturally
> the way to go is factor the KASLR address out of instruction address
> collection, and adding the fresh offset when resolving the symbol
> on future boots.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/ftrace: Factor KASLR offset in the core kernel instruction addresses
      https://git.kernel.org/kees/c/24b8f8dcb9a1

Take care,

-- 
Kees Cook

