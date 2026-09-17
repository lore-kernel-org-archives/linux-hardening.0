Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D524B0E30;
	Thu, 17 Sep 2026 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687882; cv=none; b=ALLgPzqU69sXXNkS5cwGp6ISdaoqZ7rKgI17E6CsvLcIgpiQvWkg4k9PcmWrH+rCM/Pl0UJTjHF2Tl/vYSLZOpR488zasYhGG3INY6hGDDSq3pb+DCiF/hFlnJ9gQ2TFqGXHgQBCqQgXnKp3VvTxs5vlszJmIPoxyHDnRDwm8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687882; c=relaxed/simple;
	bh=0G/PIEP/l9omSDqF7u8t4rXpDqew3GmCzq5R0iq35tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTL/OnrGjnxxTa0Kkg6CygCJ3H3MNgPPdqOXKXy7vItSWMNsbA5LahV5aZD2Br9cZ+7xmoUV5Z8i8OdPD6wWm3WnN3320Q0wD5W00RzKSDtDDksCfBCOT6RbB22X6Fkw5An7vMCLWHg/GyxWzB9BPnuvuDuKzjamVO+klrMLpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=cD9HbUME; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="cD9HbUME"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9881514C2D6;
	Fri, 18 Sep 2026 01:31:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789687871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=olgecxNwQIiJLSqpSufA+UG7AWbCncv7+1VvZkK/E6A=;
	b=cD9HbUMEqEP0U0v4+FOpKAxCwNuz4FfDdtofl8RTmWCEH6GDdzgxlQG2J23fR7jMiKWpsa
	MESdEVtk3adV+otvczAsHTdFC9wzfhLRzn5JygTdpsLpWr2O+/+s1wtsSGgY5BXCCdGZ54
	vspo3FAdA/TlNcwXBQSB5LIR4tw5AJ2v4fN/ctQNis8vzXkfVFNDdvg1H0K7l650ZijJXM
	Pe9R4PAyZXFKYqsMixRdDfaW34CoKqTyq6ckoK3A+IcLkT1UTd1WsERIIvlbZ6n/BVu2y2
	pOUAcOZxKb0LtKe0hdkzFa1BXRdHyUwPKawKKjHNr7Qhhgh9tqBL3mbs9tiJDg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id afdd1e86;
	Thu, 17 Sep 2026 23:31:06 +0000 (UTC)
Date: Fri, 18 Sep 2026 08:30:51 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Kees Cook <kees@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] 9p: Add const and unsigned to wnames allocation type
Message-ID: <aqx4K8kE1rcTxjmC@codewreck.org>
References: <20260917211158.i.129-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917211158.i.129-kees@kernel.org>

Kees Cook wrote on Thu, Sep 17, 2026 at 02:11:59PM -0700:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> The assigned type is "const unsigned char **", but the converted
> allocation type would be "char **", which differs in both the const
> qualifier and the signedness of the character type. Take the size from
> the assignment target instead. No change in allocation size results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> fs/9p/fid.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Ack, will pick up this weekend for 7.4

-- 
Dominique
