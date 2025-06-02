Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8D224B05;
	Mon,  2 Jun 2025 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887627; cv=none; b=gkfwj2pzNjigk+XJBtMT4KYEm0OUVn3AVrA9A+2TuDLP4NOjeBKhzT0kkoF0kkyg6a2DeljWnCws0IepqzWrebdY1/CQ1AZPsE5pVkxIbZhNAjr+Pj3Cipm07MABdkjhMFinq+mcvstYEedplqMhbhm8ObjUJLM8bWGcuXoyCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887627; c=relaxed/simple;
	bh=ZRZQYlirI0clKlwHpTQZVj1tgZlhftb/v17r4cRxfTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4sXF0Q/YiB/wdH3kPOgq827N+7hdkXbR8z0oWB5Z3/NTJdSxqdljeTjU/I/I8HH/janjL/aTU+HV5tfsAouvRvViP5myhXe6X5NyzfQqjHcBl4EG/OPUUlci2NIVZLeO2W8oQWAuU2VFj7FT3csenYNDHYe3gEdZQT1esRV3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbHsuyGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbHsuyGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5B1C4CEEB;
	Mon,  2 Jun 2025 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748887626;
	bh=ZRZQYlirI0clKlwHpTQZVj1tgZlhftb/v17r4cRxfTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbHsuyGYiQY3x/axAOIdvVIJj2W0XVZ9/plUY2TTbLtriTcLyAL2/ii6zLJlG0hog
	 dWDJdusKiGcaE7ERlrHBAk85ceL9ARBFTjtLotIwxf0k9RLaOiIr56OVs7l8zwTeo+
	 tmm8t/s7C9a8+Eta9Ma8oCBBQnq3aECq0+xKZQIR6gaZAAQZ99Dwu4oOaTbENOfAj3
	 QF7FxqRKcFkmvWW1KKFhT8Ej1aINyTV93nJmnS3LfNN7CH5h7+BZ20vEhwjISalBhY
	 5BputfFKAEWC5lp0xo9jqML+35mk0XNsRkQf4L2v9eIyvMYcKTiP62Ty5KJayFgFBs
	 Oo75/mFn7PM1w==
From: Kees Cook <kees@kernel.org>
To: Junhui Pei <paradoxskin233@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	elver@google.com,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: Fix incorrect hand-side used in handle
Date: Mon,  2 Jun 2025 11:06:27 -0700
Message-Id: <174888758557.4018560.13578751882908437370.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602153841.62935-1-paradoxskin233@gmail.com>
References: <20250602153841.62935-1-paradoxskin233@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Jun 2025 23:38:41 +0800, Junhui Pei wrote:
> __ubsan_handle_divrem_overflow() incorrectly uses the RHS to report.
> It always reports the same log: division of -1 by -1. But it should
> report division of LHS by -1.

Oops, this has been wrong for a long time! :) I've added the appropriate
Fixes tag.

Applied to for-linus/hardening, thanks!

[1/1] ubsan: Fix incorrect hand-side used in handle
      https://git.kernel.org/kees/c/c50b612bef51

Take care,

-- 
Kees Cook

