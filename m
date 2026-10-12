Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74046EF6B;
	Mon, 12 Oct 2026 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796579; cv=none; b=NURZNGLBpmSrnQ60qTXo/xsczjJtwNrbJcHGLHf1qhdjpPuYVh8tmU+sMS7il3yOc0vOehttZJAGlqYR+jCZKfznQuya11CKcdusn+FcyE26ii8glI+A28ejkr236ddSGRBSVAKkrXupnExL7I+wUyKqOx10CuabC0Mun+HGF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796579; c=relaxed/simple;
	bh=4ZM8We04j/ZAuwBC4UcD19sKjRpDgRm8HNFks9pZKkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzKqIUeBytDZrbfW4+wFSMWg9HUVGpYf+Pno1yeWj3vkXI7yqaAbXKze1j0V1+zUqjq/rUygMgh+BJJLoEp9N2zMpOlHH4NFfQE+3l8wD/3eLtRZncQvEN0HFewCcAG3ZoOw5yHf+cORhcKqp7PjlmqRNevzxogGuurUTnXBApk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZCcBTiDE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZCcBTiDE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FQ50Dt1VxVbS6FOI5MYyL9mmyJE/4nL6OgtNMM1nqMk=; b=ZCcBTiDExWS0tM4/h68o6limu0
	dSLo29FP6+gSBO0VgP3PFrjT0eQ/dbItrCsNqTiPiJt2jgvh/S/DpFwpSOpbbb1E1wsNJFJh/VvqO
	hUEdAnwa1zrGZxpqNPK0jpg+8zaLzd7o4FcVUVzcGzBSsYRmp9eigWf/8djE87bv84opczRhbMigf
	jmZ20+0tQRMwIqB+btWe71a4kWeIvS7rcgcKW8QpjX7o/Tl6pLm4RenaR1DNeW56GWK7F1mvhJ5YA
	6DvrxIrpanDwZoVzNt8LgIv9Ye3LmpGKePctdiZBJuVj/Nv9g5cVkc/xIeJcIGdjTATkHDf2C0mzn
	dSdcctAQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGC8Y-00000003zgH-0kNo;
	Mon, 12 Oct 2026 09:16:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC58930063F; Mon, 12 Oct 2026 11:16:01 +0200 (CEST)
Date: Mon, 12 Oct 2026 11:16:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, x86@kernel.org,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/kcfi: Emit the FineIBT paranoid "cs" prefix as a
 byte
Message-ID: <20261012091601.GN4121339@noisy.programming.kicks-ass.net>
References: <20261012090424.i.497-kees@kernel.org>
 <20261012090436.1676525-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012090436.1676525-2-kees@kernel.org>

On Mon, Oct 12, 2026 at 02:04:25AM -0700, Kees Cook wrote:
> The "cs" prefix on the LEA in the FineIBT paranoid caller template is
> padding: it places the LEA's 0xf0 immediate byte where it doubles as the
> LOCK prefix that makes the failing Jcc raise #UD. GNU as warns about it
> in every CONFIG_FINEIBT=y build:
> 
>   Warning: segment override on `lea' is ineffectual

Shees...
