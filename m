Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217632E62AC;
	Thu,  9 Apr 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752281; cv=none; b=Q5VgyGpwZy21yhTnAtTwh3HIIdyFmZRMvq/gjRFVChIGZ2iel4uxHhnO/iiLkTun8ZqV8CAEULkJ4mNrEOzSHCbPY5og/WH+iJWgohW5oLMueSTqK6pZPDB7IQbqE7Fevu6X2P02zfxXjY7HcxpRbCvmIiqOm+Y7cxHgtINWQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752281; c=relaxed/simple;
	bh=9v3K/00k39ER7Bz4cHZovH9UNOaM47c3Ho2QRVeAeWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBXJjJIIOlwSnuE/tAXyRya6jhoMIxBzN/x4r2L0wmkMEnjWB6kQ2KkUpGqyHEIPPB1lWa/OjaLbNJ+L3EEOLKPzeje7nEIWqHNvwJUItD/ODqO2oEKQV5n+sKQcAsJwu20POl/+C2o7Ta4VsepapD/TfbxFoz2bhwBfWq1fjqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndE0XkTj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndE0XkTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C46C116C6;
	Thu,  9 Apr 2026 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775752280;
	bh=9v3K/00k39ER7Bz4cHZovH9UNOaM47c3Ho2QRVeAeWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndE0XkTj6z361I9W+uE8f9mAy6cbzfVCz80Uoc2+3GMzM+4/+zYf0Nz+suz1HVy7t
	 MBTXS89CFzR/ID9ihGyG0lYrjMI5nHvDBD0WuXO50q9uTHo6gkRVNn6vjtkGlfMWb5
	 VDXGepQ0I1txXAFbQTNCF41oehfDrU1QZZr6BEevZ8zpTRPt74odoELLSwwuVToB/8
	 xBI0q4hfM1IgAb7QBeXFz99OMNOmj2r8j97csm2c6p+nnGDJVug9sLFSVkTL4sXXOq
	 ecOXzQ5uPmtev3zM8KLAfuWkhtgWUHk1SDqAh1SBcfBEaDy82b2cjcIxfbSDohNzcQ
	 5Jz4qT8h4ckvw==
Date: Thu, 9 Apr 2026 09:31:20 -0700
From: Kees Cook <kees@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kernel test robot <lkp@intel.com>, linux-hardening@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, kernel-dev@igalia.com, kernel@gpiccoli.net,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Message-ID: <202604090930.6FAF3E5A@keescook>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
 <202604051301.skV8JLnH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202604051301.skV8JLnH-lkp@intel.com>

On Tue, Apr 07, 2026 at 11:58:56AM +0800, kernel test robot wrote:
> Hi Guilherme,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on kees/for-next/pstore]
> [also build test ERROR on kees/for-next/kspp linus/master v7.0-rc6 next-20260403]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Guilherme-G-Piccoli/pstore-ftrace-Factor-KASLR-offset-in-the-core-kernel-instruction-addresses/20260315-152241
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
> patch link:    https://lore.kernel.org/r/20260313201010.1622406-3-gpiccoli%40igalia.com
> patch subject: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel instruction addresses
> config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260405/202604051301.skV8JLnH-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260405/202604051301.skV8JLnH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604051301.skV8JLnH-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "core_kernel_text" [fs/pstore/pstore.ko] undefined!

Oops, doing a modular PSTORE build shows this error even with v2. I've dropped the
patch from the tree for now.

-Kees

-- 
Kees Cook
