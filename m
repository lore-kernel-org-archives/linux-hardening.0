Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F81E9915;
	Tue, 28 Oct 2025 06:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632499; cv=none; b=dNBwtAlgdXeZ0ceFcKg+rwZLp1P4M4n7avUsjNb6aH0pQSzO9D5dTB7ccCWHkXpMgw+F7pMlGRJvJRWAp06NXuAnwcqR8E5ZN7LMuhbVY+GhIMVC5jOCvNelodW8OBbqlyyDRMuWamJI1UKnmDqCn5ZLyUFOEGlzwlYMnIiMYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632499; c=relaxed/simple;
	bh=cBb99/Rk/YrwDvp4oXeogz9Ml7yvcmAlg5Zf25ML1MM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ByB8QUcTmyaL7gh7oO83QoSNLUeEcUxas+SQ5eqKxbHNV/vVUtKOaOf8RwfYlByCru0QLEs8JVTW9s7lG1RjjwsE3Nm7GPTlM7+g3jTYoKSsdJyIqfF6e7dutjafhkiKYGDNqtC6vfzdvG3bVzxJ0rySGXLUljZwLRZmw8hqL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmHiXQ/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmHiXQ/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22400C4CEE7;
	Tue, 28 Oct 2025 06:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761632499;
	bh=cBb99/Rk/YrwDvp4oXeogz9Ml7yvcmAlg5Zf25ML1MM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JmHiXQ/ljBFCx9GEA9sDwjA4WxE8Hb8Ui9zHWjkhnkj6SSgP8J6xqAV6u7RTeLIDQ
	 PHAA45UCwq0lF4pzca245V8nfnXtQex3kwJTU/HhrGHeNBabj6Sl2A5NaMdQDtHnxo
	 D0Vt5Ty20SVdQB1iFONXfPKUOd8VF/7R89peWeR47ZQ0GXyI1P8zOwC8RNefjraooC
	 WlapMYEUHZ63G3CRwzF5+r2VBhyQtbhhM8DKxtStPLZdXkiaFJRFn5PaN4Kfy7MfRX
	 phQIqfk61NQkjlS9SFaTQEG3sJ+PEssNGeNtbqxfy/0oFOWa3HkbQCeFm7ok1wdyKQ
	 ndSOG9eQsW8ZA==
Date: Tue, 28 Oct 2025 00:21:34 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    WangYuli <wangyuli@uniontech.com>, Huacai Chen <chenhuacai@kernel.org>, 
    linux-hardening@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: KGDB: Replace deprecated strcpy in
 kgdb_arch_handle_qxfer_pkt
In-Reply-To: <20251011004750.461954-1-thorsten.blum@linux.dev>
Message-ID: <e5c98ef4-40a0-433f-b4e5-3f1bc62a0c21@kernel.org>
References: <20251011004750.461954-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 11 Oct 2025, Thorsten Blum wrote:

> strcpy() is deprecated because it can cause a buffer overflow when the
> sizes of the source and the destination are not known at compile time.
> Use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks, queued for v6.18-rc fixes.

- Paul
