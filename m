Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737E24B4A;
	Fri, 31 May 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188399; cv=none; b=aZO2ncjuAulC2pgubdkpzDSEOkwBSFC7SClnwcuYqUjZv+I74u5WUEOhZFJCflwcJCgSO3b3FnQeWf6nMsvsmaYc5cxLkGU8SX2BzR1CIJc+ZwwjQY49akpEplUmMqaoCkfToPXpdFqQP4w8S0nxZPwVDLKeEtY9cODCkm2l1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188399; c=relaxed/simple;
	bh=5v6WEVFSG+niPJT/ta0D1bzUViAOVqkrK/1t7rXf4ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/ssJcxb0tmnKKXze/gWzyr/gqqQ+/he17EUfYvvT4yaOmHgr82J3mjnMNJnm2rVGlYT/ybWnqw590PEJJdU7/Gq1vgiya2HzjvbpZ+eHxwIEpOieOSuLLsLnVxsULzMrjvlVSDHquXOPIR3NgktwshDZkwDnooEuOpjtZGWyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqZqYxRo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqZqYxRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23B2C116B1;
	Fri, 31 May 2024 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717188398;
	bh=5v6WEVFSG+niPJT/ta0D1bzUViAOVqkrK/1t7rXf4ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqZqYxRovnC0m4WQ8+Ca+THQmZ4x2MfUnPaxMot6GWx5nRptmI9lolz3Ex0YJiGtz
	 KRvmaCatWZ9eLaOK8I4yDkWZYoURfZthXL1tqgw9ElF4pIrzcIx229LnRDOGujvXtF
	 pZQpGfKBQpMj/wpcjfkWH+2BnD05/X8SAlrrzvMvsbyCln8JbRMcCcLP/z+mwbzhP9
	 h0ueQCrwwPXPmIw6WTCjwcr4JVh6TlKx5qiAjm6qywFuyVeCxEeHMXRmHmYHgBQkf5
	 buPXqnFFgKNo+2VFggMMGDZs20INQLwE1ymRs6BdI0BHwvHSnEy9qKDsCGSTZIRnn2
	 1BQoZNZX0MiKQ==
Date: Fri, 31 May 2024 13:46:37 -0700
From: Kees Cook <kees@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Message-ID: <202405311345.D91BF6E9@keescook>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
 <202405310951.56D9BD5C41@keescook>
 <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>

On Fri, May 31, 2024 at 09:08:16PM +0200, Borislav Petkov wrote:
> On Fri, May 31, 2024 at 09:53:28AM -0700, Kees Cook wrote:
> > Under CONFIG_FORTIFY_SOURCE, the boot code *does* still uses
> > fortify-string.h. It lets us both catch mistakes we can discover at
> > compile and will catch egregious runtime mistakes, though the reporting
> > is much simpler in the boot code.
> 
> From where I'm standing, we're not catching anything in the
> decompressor:
> 
> $  objdump -D arch/x86/boot/compressed/vmlinux | grep __fortify_panic
> 0000000001bec250 <__fortify_panic>:
> $
> 
> Sure, in vmlinux proper (allmodconfig) we do:
> 
> objdump -D vmlinux | grep __fortify_panic | wc -l
> 1417
> 
> but not in the decompressor which is special anyway.
> 
> So we can just as well disable CONFIG_FORTIFY_SOURCE in the decompressor
> and not do silly prototypes.

Please do not do this. It still benefits from compile-time sanity
checking.

-- 
Kees Cook
