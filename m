Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E49414A2F;
	Mon, 19 Oct 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415770; cv=none; b=dmpHMwvsPe0kkuCS9FmkZMxAAbQRhhlx/1C+M8TATBbFnkI8/jlKs/JJaK8M8gdee0MvwN2BITcjhQbqEWDvcUUt8P+tsCZWiJ0/Jych+6UkX9sUJFcRzIi/EDNz/qaW9fRvG6pkqOlr1PfyJngNx81cRRkCxib+NMdRI5Ftbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415770; c=relaxed/simple;
	bh=uoGPW64q8zkmiOW08LjD2ij9Gbvwf/GLdhvrdJbbFwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne7QThyICUl/yX+75xiRs8KONnEgnMV+EnHwMn7Djpd9z1WyEWGKaBQU7PnEZj/OXyelrY/T5UVb0z/wyKKwaZ/EZXmMuh56uzvLJ9/wiFrkDXySLtdofwIU/QrUVfVth/RMqirrNZ302sCcNqMEufuvi6+bHZUr9TSv+/P65kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOgNfRM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOgNfRM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB2E1F000C4;
	Mon, 19 Oct 2026 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415769;
	bh=uoGPW64q8zkmiOW08LjD2ij9Gbvwf/GLdhvrdJbbFwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOgNfRM29QuvDOm//FuKIV1VqPJpxd82wNAI0y5iWBLmDaNUZh1/kEIGMRbInbD7J
	 GTeq3q2feAPz3sfeZgnXCNdlt1b3NxfAWN4o4ic9/QUJ44OBc3+LQ10xhjzWQk5/lJ
	 SawDxPBzEbsBSsI3n+2Gsm+Do5mnl6YbwKNvxijVEdPZVQnb4kLB0fLLHXLtWiYx/H
	 t4ZrG4QiM0+8xXXGbrL4I2fytQ8pIbf7bxigOx+7WiBKUxtmaVuVeCb8WOz9wVOyPl
	 dTKDoVwGopmOzely/ASi5XsI+YqodiLhcYMqh7VEOChGrDElhRKiHxkazoAHFFBM7n
	 3lOeZR0mG3lOQ==
Date: Mon, 19 Oct 2026 14:16:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Manuel Ebner <manuelebnerli@mailbox.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Nicolas Schier <n.schier@fritz.com>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kbuild: Give jobserver-exec recipes the jobserver
Message-ID: <atYX730oIZ-3KAgT@gremlin>
References: <20261010081910.stay.092-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010081910.stay.092-kees@kernel.org>

Sorry I meant to review this but my inbox is as usual a disasterzone.

So instead I'll just say thank you for it :)

--
Cheers, Lorenzo
