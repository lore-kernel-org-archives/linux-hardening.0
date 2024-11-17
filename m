Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604013A24A;
	Sun, 17 Nov 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846317; cv=none; b=sENFe3tVG8sXQIHd0f8bKy853xTNnNAwgCl7MKEGxIgwatWCWncch4YByux17JjfTUXMFahxS68yV+LM6BIoBl+SmCpGgA2ySbmUQQ6ljoW/RgjwaPJ0GlFRnXp26j6o3ZU8JkNJ+x4y5huMJIQzULIuIbaEpYHnBW6/b8FLsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846317; c=relaxed/simple;
	bh=N/P+v+MMv7iFCZsNSIVblmRk4iYG9/VOGvLNzCUrVuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E2hh8r1cXHefdQuDfM4DCDkchopKjkp6GuVYCs4IYO++mxVx0Gc6xxUYkdlb9+8zstFniL5ko750ZBFsZ/BPrx71rpr5QOOjIWlDrFpX8RE8pu3mZgV+in3yS0GfH4UNPPcfLjnyhEDzxbvqENVGxpdWDQVdY0eKd8+aXU4hobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=KA9OlNcH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KA9OlNcH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846309;
	bh=qF2IDG5jDaK6lbCWpF3L9oneS42KDrLsFyhw6rcafTc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KA9OlNcHEDgUXSda7Y3LLmEkqpD0Bnm8E+qF4zoGGTaaVrKn/ACi3HGGDqAHDxJr0
	 eo5kpgLKLV76wvSM4WF0O1PwOVqyUQz4trx598ovCRKNnpXK8njPxrEOwMGVEMX3q+
	 Rojd2afOi5B1UgdkkiXtH2Vv2gJZqhg28rD0QL3af2bxneQz0ANLKq2FaInGHPG13v
	 zrKy+1JJ2Bn+UUEzXt8lJ92tZB5QX7JiEEJ7ISXViN5uYrXgOMn9Y1yYCkCD+VDTcg
	 6ZfHrh0WWlgVjncHQ8r3L9K8mnVbwx0pEVYXR7W1+4/hMmRljdnCi9+8RhRdCnAOTm
	 MQlPuTypNSblg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhj658dz4xdg;
	Sun, 17 Nov 2024 23:25:09 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <775dae48064a661554802ed24ed5bdffe1784724.1725723351.git.christophe.leroy@csgroup.eu>
References: <775dae48064a661554802ed24ed5bdffe1784724.1725723351.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Add __must_check to set_memory_...()
Message-Id: <173184539745.890800.1324374267982130078.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sat, 07 Sep 2024 17:40:41 +0200, Christophe Leroy wrote:
> After the following powerpc commits, all calls to set_memory_...()
> functions check returned value.
> - Commit 8f17bd2f4196 ("powerpc: Handle error in mark_rodata_ro() and
> mark_initmem_nx()")
> - Commit f7f18e30b468 ("powerpc/kprobes: Handle error returned by
> set_memory_rox()")
> - Commit 009cf11d4aab ("powerpc: Don't ignore errors from
> set_memory_{n}p() in __kernel_map_pages()")
> - Commit 9cbacb834b4a ("powerpc: Don't ignore errors from
> set_memory_{n}p() in __kernel_map_pages()")
> - Commit 78cb0945f714 ("powerpc: Handle error in mark_rodata_ro() and
> mark_initmem_nx()")
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Add __must_check to set_memory_...()
      https://git.kernel.org/powerpc/c/2abbd6d5fbe0eae3752b44c963248e19292e5104

cheers
