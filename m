Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F11175D53;
	Mon, 28 Apr 2025 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745882840; cv=none; b=NCriGQnRO/dWlqwTSA/56IrEgEPETLn4WnauPCSbj6zH1nvBLDLt5O54ddTFzWDqK1QZKcu4x1XxsC2g05OSHM5fcGeMNH3J+Ryc9pYnrL4HWtc9BQPR1+Jm/GnNnlRES1Qyz8EfLADmlRfB8vyeVL6Eq3BJhQ7dLYgwQJKqVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745882840; c=relaxed/simple;
	bh=fp1fyhNEcH9C3+gNY6AqPrnomJnKr4nOCRlZZrxvRlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r26UP218aP2a+UF1wdLhoqWu7sovq7Vrk/nfLeVzsMO1ri2ZtshQ6IFjqdrQ7wdT00TlXRKKEislP3762F/fiQzpmnBUjSWdZxVcnbd2rdkdnKV7ih1vPq/U+J/dTFx4fKYaJytub8PA0HvL+qn0BbjMkUaHmb+/3aSmRZlQ130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sxTodg3t; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sxTodg3t"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DFB5B41060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1745882837; bh=71FJqd39YR5/emSke+WygmuKJTkl6XtVtGtAkhKOafk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sxTodg3tv9H0eES1DEvFDxhb2+Ts8f6yX4c+QsMUVDEF27SgEDGHe8uDfpPZyZBxw
	 wNgkfpsuQqczUXyczvgVPlohqEhVUT22xUh134bjf+ddWbd96eYXHemuCkAw+17Xuo
	 0j+TLmWxdiI4+4z57q+ZqdXLOSNl/Wd/Zxl4/tV1vpNRhbZOAUXTP230GmxdzKJ9al
	 dQSsV06G4wgXfXoO7gyu/yG4nBFiDKYUpiA9e9YS7VjiH0IoLlhe5doc2VQyX9ylHs
	 lXyGR6F3c244AsrRs/9KuN9oP7diab0VcHvnR5BdyF9JMfp+O3/eAXyepp10AA5w9b
	 TeWq60Qls6+PQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DFB5B41060;
	Mon, 28 Apr 2025 23:27:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Mike Rapoport <rppt@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, linux-doc@vger.kernel.org, linux-mm@kvack.org, Maxime
 Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, Natalie Vock
 <natalie.vock@gmx.de>, Xavier <xavier_qy@163.com>, Samuel Holland
 <samuel.holland@sifive.com>, Maarten Lankhorst <dev@lankhorst.se>, Dan
 Williams <dan.j.williams@intel.com>, Michael Kelley
 <mhklinux@outlook.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, Christian
 Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Add initial binfmt docs
In-Reply-To: <20250426000704.work.637-kees@kernel.org>
References: <20250426000704.work.637-kees@kernel.org>
Date: Mon, 28 Apr 2025 17:27:15 -0600
Message-ID: <87selrrhnw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <kees@kernel.org> writes:

> Adds a framework to hold the initial exec.c and binfmt_elf.c
> kernel-docs. Updates scripts/kernel-doc to allow leading whitespace so
> that embedded "DOC:" tags can be found that aren't at the start of a
> line so that in-function documentation can be found, like that recently
> marked up in binfmt_elf.c[1].

Just one tiny little problem ... when you weren't looking, Mauro snuck
in and replaced scripts/kernel-doc with a shiny new Python
implementation.  So that part of the patch won't apply to docs-next; if
you apply it somewhere else, the change will get lost.

I figured we were going to run into at least one of these ... sorry ...

jon
