Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420671A0706;
	Wed,  8 Jan 2025 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375940; cv=none; b=qjDDJvmCd5OXd4Fcen7Au2ekPbvJEUeMsM7wJzwXGKTRwq85IaG2KWJSy3s+79lkd46tJJL0TQv6KD2WZOX+N8Jt9JjZuUnCaKfo2+/dDk7itjskWjltTGnraWyu19UGqTVSHnvGFKO9n//U8cRNmqC3+EbxgjAacsC/BwQdUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375940; c=relaxed/simple;
	bh=wa3rD5USkxv1IyzSYO7tqon1n9Gvgu2Ef2qO8OuBf1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9E9Q7qh0RBg3r93j6/N2z79vFrfeXiY7jo2QfVT3O+C3U0lnbpeGGd2ojV38wOdWJIWopbjgX85qey7LYHK5eguy9bF+co++8KAQfGDlZySQ4k7WTj5lhYjYyoKNSeGEfzphOFdgHVdXVAssGFxca1tEGcFRis1M9qwCT5lU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibff+Y2H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibff+Y2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCECEC4CEDF;
	Wed,  8 Jan 2025 22:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736375938;
	bh=wa3rD5USkxv1IyzSYO7tqon1n9Gvgu2Ef2qO8OuBf1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ibff+Y2HxUH7zPsA6EHx8BEUW9QF0Jm/9CYpgnPiNhmkZl/ebR939ER0OwbOy31jh
	 hZwSmuaju61QyeoOOpRi/mlJmpvUTNlugtSjkXx1eqm0ppB6EZbXCmGqHZfKGBaHpc
	 Z/z/nH+IkQwoyXgcvv3AuRWdabKZX7gaFAdn394fNdbWeeUz8qHYf4if+Cj9hjs6X2
	 n0zlEFuig6fnSM5HNg0+MeA2tYvAXmtIXsWdl9fMTRUIzNqF0bpVkqh3JetIDABJgj
	 izkqMFSOu9ARLXzAUab6nYgIANQGCkSquD+UCXjkViKGzlbqeNQsUCcAmV3KfR4ezs
	 gRux8Wez2qxbQ==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: trivial typo fixes
Date: Wed,  8 Jan 2025 14:38:55 -0800
Message-Id: <173637593436.1708102.3999488886256953343.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101111921.850406-1-eugen.hristev@linaro.org>
References: <20250101111921.850406-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 01 Jan 2025 13:19:21 +0200, Eugen Hristev wrote:
> Fix trivial typos in comments.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/blk: trivial typo fixes
      https://git.kernel.org/kees/c/542243af7182

Take care,

-- 
Kees Cook

