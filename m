Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EAC5464D;
	Wed, 22 Jul 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724521; cv=none; b=Y6fz+w//ik0evLzcBdwYcXUr4TzJbDTPPfMjncD9F+sT+Eqm/3VYPOnfDGWfDyV/KWvUh/18DmFys31LBw4mAk17ZvUWu9h8Viniz09cL+pYlxJvGOyqfCt7abi/2OS9tsRs1pwDCS/tsR+fsLsOBLDhYlFOCE/2jBepHd8JthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724521; c=relaxed/simple;
	bh=mUdWEQVd5RI2oIjBRnFQWMqUVi86nQ7OlGRBF4ujok4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AdYKwLuBgbWf6fOHzGNLoRS6zeYEOqaW4yuPTBYT0EbK0hLp1UFSQ1UGX7jFMDwe9PPv2MtHaWW+5VnUHmJC+XT/yvizys8GEuqgc8TwS6x5I3c1CGGjCeCQsVcqFFOWHrnwzcX4txDxQk7pDtZOKeW4A5yF+h8XSidaJLsBrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=R9upcpzK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="R9upcpzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784724517;
	bh=vIKqOF0CXddp2THXSgq1DAjEmO1R0dy2OSrDEgdTcbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=R9upcpzKFwjE3zypvDbDNyhzISJKXUqpL5pqjiZIt7xyNwYP6KqwEGDnJhZqMYW8L
	 BTYDMLVHSxPVJNyN64VY4wgQMzjFYtBT3Zn48cAvjDjszCI1mZD6FYkndKLxNrHS5N
	 HpfJkpQRxFKox61fswDA0BAry2c3fuytzrfn4lPtnGNowZdtiVC/k6DpBF8VjdNZyj
	 1UyMEw3sq6nKoRQyIqXrfIvLqphPmNcaSmHBhfMZBj9juums+YKqhhMJxHp6ODLEij
	 htlprRN+JSIqPz6q8IuUe/sKpE+MbqC1j7LjZ/EnbqwgYVVMyjtfI721uNC3GnrxDI
	 5ZD9Rh3Edw+Jg==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 58590662E1;
	Wed, 22 Jul 2026 20:48:36 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260612190744.172638-1-karthiproffesional@gmail.com>
References: <20260612190744.172638-1-karthiproffesional@gmail.com>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
Message-Id: <178472451625.1415280.9493751198445442679.b4-ty@b4>
Date: Wed, 22 Jul 2026 22:18:36 +0930
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 12 Jun 2026 19:07:43 +0000, Karthikeyan KS wrote:
> put_fifo_with_discard() acts as both producer and consumer on the kfifo:
> it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
> the IRQ handler without synchronizing with snoop_file_read(), which also
> consumes via kfifo_to_user(). On SMP systems this concurrent access can
> leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clamp
> to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
> copy_to_user() past the kmalloc-2k backing store:
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

